//
//  NewListTableViewController.swift
//  HDTest
//
//  Created by Gun Lee on 2021/06/03.
//  Copyright © 2021 gun. All rights reserved.
//

import UIKit

// json 데이타를 담을 스트럭 객체
struct PaperList: Decodable {
    let articles: [Paper]
}

struct Paper: Decodable {
    let title: String?
    let description: String?
}

class NewListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    private var paperList: PaperList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // 셈플용 다른 URL
//        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-05-15&sortBy=publishedAt&apiKey=e9b514c39c5f456db8ed4ecb693b0040")
        
        // 1. 서버 URL 설정
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")
        // 2. 서버 통신 시작
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            // 3. 에러가 있는지 확인
            if let error = error {
                print(error.localizedDescription)
            }
            // 4. 에러가 없으면 데이타 처리
            else if let data = data {
                // 5. 받은 json 데이타를 스트럭 구조에 담음
                let dataList = try? JSONDecoder().decode(PaperList.self, from: data)
                if let paperList = dataList {
                    // 6. 스트럭 구조에 잘 담겨졌으면 메인쓰레드에서 UI 갱신
                    self.paperList = paperList
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            // 7. 통신 종료
        }.resume()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 섹션은 기본으로 하나만
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 통신으로 받은 json 갯수 만큼 셀 생성
        return self.paperList?.articles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}
        
        // 통신으로 받은 json 값을 셀에 전달
        let articleVM = self.paperList?.articles[indexPath.row]
        cell.descriptionLabel?.text = articleVM?.description
        cell.titleLabel?.text = articleVM?.title
        return cell
    }
}
