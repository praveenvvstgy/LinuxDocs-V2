//
//  DocsTableViewController.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/10/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit
import VegaScrollFlowLayout

final class DocsTableViewController<Doc, Cell: UITableViewCell>: UITableViewController, UISearchResultsUpdating {
    
    var docs: [String: [Doc]] = [:]
    private let reuseIdentifier = "Cell"
    let configure: (Cell, Doc) -> Void
    var didSelect: ((Doc) -> Void)?
    var filteredDocs: [Doc] = []
    var searchHandler: ((String, [String: [Doc]], (([Doc]) -> Void)?) -> Void)?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    init(docs: [String: [Doc]], configure: @escaping (Cell, Doc) -> Void) {
        self.configure = configure
        super.init(style: .plain)
        self.docs = docs
        self.filteredDocs = docs.flatMap { $0.1 }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        tableView.register(UINib(nibName: String(describing: Cell.self), bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDocs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        
        let doc = filteredDocs[indexPath.row]
        configure(cell, doc)
        
        return cell
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doc = filteredDocs[indexPath.row]
        didSelect?(doc)
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            searchHandler?(searchText, docs) { results in
                self.filteredDocs = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
