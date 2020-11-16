//
//  NewsTableViewModel.swift
//  NewsApp
//
//  Created by Masaki on R 2/11/06.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class NewsTableViewModel {
  
      private let disposeBag = DisposeBag()
  
      var urlString = PublishRelay<String>()
    
    func subscribeUrl(){
        urlString.asObservable()
            .subscribe(onNext: { string in
                print("バインド成功!",string)
                //理想はここで先にWebページを読み込みたいです
            }).disposed(by: disposeBag)
      }
}
