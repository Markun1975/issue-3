//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Masaki on R 2/11/05.
//

import UIKit
import SegementSlide
import RxSwift

class NewsMenueViewController: SegementSlideDefaultViewController {
    
    
    @IBOutlet var reloadButton: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    
       override var titlesInSwitcher: [String] {
           return ["主要"]
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           defaultSelectedIndex = 0
           reloadData()
           reloadNews()
       }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return TopNewsTableViewController()
    }
    
    private func reloadNews(){
        reloadButton.rx.tap
            .subscribe { [unowned self] _ in
                // ボタンタップ時の処理
                reloadData()
               }
               .disposed(by: disposeBag)
    }
   }
