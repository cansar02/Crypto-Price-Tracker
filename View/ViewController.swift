//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Can on 10.10.2025.
//

import UIKit
//Rxswift ile RxCocoa import etme gerekli fonksiyonlar için
import RxSwift
import RxCocoa
// Tableview için gerekli olan protokoller
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView! // activity Indicator koa tanımlama
    @IBOutlet weak var Tableview: UITableView! // Tableview'u koda bağlama
    
    let cryptoVM = CryptoViewModel() // CryptoViewModel sınıfından bi obje
    let disposeBag = DisposeBag() // Rxswift ile geliyo hafızada yer tutan şeyleri hafızadan silme
    
    var cryptoList = [Crypto]() // Crypto dizisi tanımlama tableview'da kullanmak için
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableview delegate ve dataSource'u viewcontrollera verme
        Tableview.delegate = self
        Tableview.dataSource = self
        setupBindings() // bi değişiklik olduğunda görebilmek için
        cryptoVM.requestData() // CryptoViewModel objesinde requestData func çağırma
       
    }
    
    private func setupBindings(){
        // manuel yapmayalım diye datayı görünüme bağlama bind to
        cryptoVM.loading.bind(to:
            self.indicatorView.rx.isAnimating).disposed(by: disposeBag) // Indicatorview'u çağırma animating ile eğer true ve işlem bitince silme
        // hata mesajından başlama bu işlemi main threadde yapıyoruz .subscribe yapıyoruz bu bize error string dönüyo
        cryptoVM.error.observe(on: MainScheduler.asyncInstance).subscribe { error in
                print(error) // hatayı print etme
        }.disposed(by: disposeBag) // memory'den objeleri silmek için en son disposed/by:)
        // bu sefer de cryptoList için bi observer koyuyoruz main threadde yine
        cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance).subscribe { cryptos in
            self.cryptoList = cryptos // cryptosList'i oluşan cryptos'a eşitleme
            self.Tableview.reloadData() // tableview veri güncellemesi
        } .disposed(by: disposeBag)
        /*
         tableview'u bind etmek için
         cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance).bind(to: tableview.rx.items(cellIdentifier: cryptocell,celltype:Cryptotableviewcell) { row,item,cell
                cell.item = item
         }disposed(by: disposeBag)
         table view cell yapmak gerekiyor prototype sonra cocoa touch class tableviewcell oluştur identifier'a cryptocell de sonra sınıfını seç cryptocell
         sonra o dosyas içinde public var item: Crypto {
            didSet {
         self.namelabel.text = item.currency
         self.pricelabel.text = item.price
         }
         }
         data source sil fonksiyonları da sil
         tableview.rx.setDelegate(self).disposed(by:disposebag)
         */
    }
    // table view için kaç tane row olucak fonksiyonu
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count // cryptoList'te kaç tane eleman varsa o kadar row
    }
    // her bir Cell'de ne gösterilicek onun fonksiyonu
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() // bir Cell oluşturma
        var content = cell.defaultContentConfiguration() // o Cell'e yazı yazmak için Content verme
        content.text = cryptoList[indexPath.row].currency // Content'e bir tane text verme(currency değeri) CryptoList arrayinden index ile(indexpath)
        content.secondaryText = cryptoList[indexPath.row].price // Content'e bir tane alt başlık verme(price ile) cryptoList arrayinden index ile(indexpath)
        cell.contentConfiguration = content // cell'in contenti oluşturduğumuz contenti verme
        return cell
    }


}

