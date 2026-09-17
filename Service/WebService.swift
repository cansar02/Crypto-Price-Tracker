//
//  WebService.swift
//  CryptoCrazyRxMVVM
//
//  Created by Can on 10.10.2025.
//

import Foundation
// hata mesajı vermek için enum ile Failure case oluşturma 2 case var serverError ve parsingError
enum CryptoError: Error {
    case serverError // sunucu hatası
    case parsingError // veri geldi ben işleyemedim
}

class WebService {
    // Crypto paraları indirme fonksiyonu url alıyor parametre olarak ve completion handler oluşturuyoruz kendimiz @escaping ile closure oluşturma Result bir success bir de failure veriyo
    func downloadCurrencies(url: URL,completion: @escaping (Result<[Crypto],CryptoError>) -> ()) {
        // Bir url verip ona request atmaya çalışıyoruz bu bize bir data bir tane response bir de error veriyo completion handlera erişiyoruz requestten sonra bize gelecek cevaplara göre işlemlere devam ediyoruz URLSession.shared.dataTask
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error { // eğer error'ı optional olmaktan çıkarırsan yani hata mesajı varsa
                completion(.failure(.serverError)) // enum sınıfındaki serverHatası case'ine dön completion(.) diyip
            } else if let data = data { // eğer hata mesajı yoksa data'yı optional olmaktan çıkartabiliyorsak
                // JsonDecoder.decode() ile neye göre decode edicem [Crypto] objesi hangi datadan alıcak diye soruyo hata çıkartabilir diye try ile yapıyoruz
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                // eğer cryptoList optional olmaktan çıkarsa bu sefer vjson verisini döndürmüşüm demektir ve success case'ini döndürebiliriz demek
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList)) // success case'ini döndürme
                } else { // eğer veri gelmesine rağmen alamadıysak
                    completion(.failure(.parsingError)) // parsingError hatasını vermek
                }
            }
        }.resume() // bunu demezsek çalışmıyo işlem bittikten sonra devam etmesi için
    }
}
