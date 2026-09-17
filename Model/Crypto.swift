//
//  Crypto.swift
//  CryptoCrazyRxMVVM
//
//  Created by Can on 10.10.2025.
//

import Foundation
// JSON'dan dönen veriyi her birini tek tek almamız gerektiği için bi struct oluşturuyoruz
// JSON.decoder() sınıfını kullanabilmemiz için Decodable protokolü ekliyoruz
// json beautifier'dan json dosyasını daha iyi şekilde görebilirsin
/*"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
 Link burada json dosyası için
 bazı websiteleri quicktypeio gibi sen json oluşturunca onun için struct yapıyo
 Codable hem decodable hem encodable Json verisini kendim okuyacağım şekilde decode ediyorum sadece Encodable da bi veriyi jsona çevirip sunucuya kaydetme
 */
struct Crypto: Decodable {
    let currency : String
    let price: String
}
