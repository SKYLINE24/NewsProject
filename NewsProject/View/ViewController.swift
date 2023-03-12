//
//  ViewController.swift
//  NewsProject
//
//  Created by Erbil Can on 15.02.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var newsTableViewModel : NewsTableViewModel!  // bağlantıyı kurduk
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //label boyutlarını otomatikleştirmek için aşşağıdaki işlemleri gerçekleştiriyoruz ve hightForRowAt fonksiyonunu çağırıyoruz
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        veriAl()
        
        
    }
    
    func veriAl(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/BTK-iOSDataSet/master/dataset.json")
        Webservice().haberleriIndir(url: url!) { (haberler) in
            if let haberler = haberler{
                self.newsTableViewModel = NewsTableViewModel(newList: haberler)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //A senkron bir şekilde çalışacak ve verileri güncel tutacak DispatchQueue.main.async = mainde asyncron bir şekilde çalış ;)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTableViewModel == nil ? 0 : self.newsTableViewModel.numberOfRowsInSection()// bunun ":" anlamı ... : =değilse ...(bunu yap)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        let newsViewModel = self.newsTableViewModel.newAtIndexPath(indexPath.row)
        cell.titleLabel.text = newsViewModel.title
        cell.storyLabel.text = newsViewModel.story
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//boyutların otomtik belirleneceğini söyledik
        //bunu yapmak yeterli olmayacak ve haber kısmında ki içeriği gösteren labelda da ayarlama yapmamız gerekiyor
        //ayarlanacak label mainde seçildikten sonra lines 0 olacak şekilde ayarlanıyor ve minimum yükseklik vermek için constrainslerden
        //yükseklik verdikten sonra sağ tarafta constraints i editleyebileceğimiz kısıma gelip edit butonuna basarak constantı >= yapıyoruz
        //bu işlemle minimum misal 34 ise daha da büyük olabilir diyoruz
    }

}

