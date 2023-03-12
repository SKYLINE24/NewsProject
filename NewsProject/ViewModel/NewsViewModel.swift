//
//  NewsViewModel.swift
//  NewsProject
//
//  Created by Erbil Can on 10.03.2023.
//

import Foundation
//GÖSTERİLECEK HABERLERİ HAZIRLIYORUZ BU MODEL DA 
struct NewsTableViewModel{
    let newList : [News]
}
extension NewsTableViewModel{
    func numberOfRowsInSection() -> Int{
        return self.newList.count
        //kaç haber gelicekse on kadarlık bir index belirliyoruz
    }
    func newAtIndexPath(_ index: Int) -> NewsViewModel{
        let news = self.newList[index]
        return NewsViewModel(news: news)//newslist içerinsende index olarak seçileni news a ata demiş olduk ve böylece diziden tekile döndürmeyi sağladık
    }
}


struct NewsViewModel{
    let news : News
    
}
extension NewsViewModel{
    var title : String{
        return self.news.title
    }
    var story : String{
        return self.news.story
    }
}
