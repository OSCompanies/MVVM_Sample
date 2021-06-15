//
//  MainViewController.swift
//  HDTest
//
//  Created by Gun Lee on 2021/06/04.
//  Copyright © 2021 gun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var articleListVM: MainArticleViewModel = MainArticleViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    private func fetchData() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        articleListVM.fetchData() {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.articleListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}
        // Configure the cell...
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.descriptionLabel?.text = articleVM.description
        cell.titleLabel?.text = articleVM.title
        return cell
    }
}
