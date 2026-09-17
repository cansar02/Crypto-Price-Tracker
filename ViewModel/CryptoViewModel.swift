//
//  CryptoViewModel.swift
//  CryptoCrazyRxMVVM
//
//  Created by Can on 10.10.2025.
//

import Foundation
import RxSwift
import RxCocoa
class CryptoViewModel {
    
    // Publish Subject oluşturma cryptos error ve loading için Rxswift'ten geliyo
    let cryptos: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject() // error mesajı için
    let loading : PublishSubject<Bool> = PublishSubject() // activity indicator için
    // request atmak için fonksiyon oluşturuyoruz
    func requestData() {
        self.loading.onNext(true) // bir sonraki loading değerini true yapma
        // request atacağımız linki tanımlama
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        WebService().downloadCurrencies(url: url!) { result in
            self.loading.onNext(false) // bi sonraki loading değerini false yapma çünkü veri geldi
            switch result {
            case .success(let cryptos): // eğer veriler geldiyse başarılı bi şekilde
                self.cryptos.onNext(cryptos) // benden bi crypto listesi isticek o yüzden bunu verebiliriz
            // eğer veriler yüklenirken hata olursa
            case .failure(let error): // hata case'i olursa
                switch error {
                case .parsingError: // eğer parsing Error'sa
                    self.error.onNext("Parsing Error") // ekranda onu gösterme
                case .serverError: // eğer Server Errorsa
                    self.error.onNext("Server Error") // ekranda onu gösterme
                }
            }
        }
    }
}
