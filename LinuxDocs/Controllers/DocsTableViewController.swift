//
//  DocsTableViewController.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/10/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

final class DocsTableViewController<Doc, Cell: UITableViewCell>: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var docs: [String: [Doc]] = [:]
    private let reuseIdentifier = "Cell"
    let configure: (Cell, Doc) -> Void
    var didSelect: ((Doc) -> Void)?
    var filteredDocs: [Doc] = []
    var searchHandler: ((String, String, [String: [Doc]], (([Doc]) -> Void)?) -> Void)?
    
    let searchController = UISearchController(searchResultsController: nil)
    var segmentedControl: UISegmentedControl!
    
    var segments: [String] = []
    
    init(docs: [String: [Doc]], configure: @escaping (Cell, Doc) -> Void) {
        self.configure = configure
        super.init(nibName: nil, bundle: nil)
        self.docs = docs
        self.filteredDocs = docs.flatMap { $0.1 }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        segments = docs.flatMap{ $0.0 }.sorted(by: { (segment1, segment2) -> Bool in
            if segment1.elementsEqual("All") {
                return true
            } else if segment2.elementsEqual("All") {
                return false
            } else {
                return segment1 < segment2
            }
        })
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.apportionsSegmentWidthsByContent = true
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: segmentedControl.frame.height).isActive = true
        
        segmentedControl.addBottomBorder(activeColor: UIColor(red:0.31, green:0.43, blue:0.96, alpha:1.00), inActiveColor: UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00))
        
        self.segmentedControl = segmentedControl
        
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 4).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView = tableView

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        segmentedControl.changeActiveBorderPosition()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { (context) in
            if self.segmentedControl != nil {
                self.segmentedControl.changeActiveBorderPosition()
            }
        }
    }
    
    func updateSearchResults() {
        if let searchText = searchController.searchBar.text {
            let selectedScope = segments[segmentedControl.selectedSegmentIndex]
            searchHandler?(searchText, selectedScope,  docs) { results in
                self.filteredDocs = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func segmentDidChange(_ sender: UISegmentedControl) {
        updateSearchResults()
        sender.changeActiveBorderPosition()
    }



    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDocs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        
        let doc = filteredDocs[indexPath.row]
        configure(cell, doc)
        
        return cell
    }

    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doc = filteredDocs[indexPath.row]
        didSelect?(doc)
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        updateSearchResults()
    }
}
