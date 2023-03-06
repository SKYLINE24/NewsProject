//
//  WebService.swift
//  NewsProject
//
//  Created by Erbil Can on 6.03.2023.
//

import Foundation

class Webservice{
    func haberleriIndir(url : URL, completion: @escaping ([News]?) -> ()){
        //urlsession ağdan veri transferi kontrollerini sağlıyor
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let  error = error{
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                let haberlerDizisi = try? JSONDecoder().decode([News].self, from: data)
                if let haberlerDizisi = haberlerDizisi{
                    completion(haberlerDizisi)
                }
            }
        }.resume()
        //bütün işlemleri başlatmak için resume kullanıoruz
    }
}
