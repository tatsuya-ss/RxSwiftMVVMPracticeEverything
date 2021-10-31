//
//  CountUpViewController.swift
//  RxSwiftMVVMPracticeEverything
//
//  Created by 坂本龍哉 on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

// オブザーバがObservableを購読する

final class CountUpViewController: UIViewController {

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var countUpButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var count = 0
    private let numbers = Observable.just(0..<20).map { $0 }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setupTableView()
    }

    private func setButton() {
        // rx.tapはボタンがタップされたということを通知するObservable
        // .subscribeは対象に変化があった場合に呼ばれる
        // onNextはイベントが通常通りである度に通知
        // .disposedで購読の解除をして、メモリリークを回避
        countUpButton.rx.tap
            .subscribe(onNext: {[unowned self] _ in
                self.count += 1
                self.numberLabel.text = String(self.count)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.dataSource = nil
        tableView.register(NumberTableViewCell.nib, forCellReuseIdentifier: NumberTableViewCell.identifier)
        numbers
            .bind(to: tableView.rx.items(
            cellIdentifier: NumberTableViewCell.identifier,
            cellType: NumberTableViewCell.self
        )) { row, element, cell in
            cell.configure(number: element)
        }
        .disposed(by: disposeBag)
    }
    
}
