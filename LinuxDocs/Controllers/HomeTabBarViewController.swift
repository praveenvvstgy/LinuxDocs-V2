//
//  HomeTabBarViewController.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/11/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    let decoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([manPagesVC, cheatsheetsVC], animated: true)
        selectedIndex = 0
    }
    
    private var manPagesVC: UIViewController {
        let manPages: [String: [ManPage]] = loadDoc(atPath: Constant.manPagesLocation)
        let manPagesVC = DocsTableViewController<ManPage, DocTableViewCell>(docs: manPages) { (cell, manPage) in
            cell.nameLabel.text = manPage.name
            cell.descriptionLabel.text = manPage.description
            cell.categoryLabel.text = "Section \(manPage.section)"
        }
        manPagesVC.tabBarItem = UITabBarItem(title: "ManPages", image: #imageLiteral(resourceName: "manpage"), tag: 1)
        manPagesVC.title = "ManPages"
        manPagesVC.didSelect = { manPage in
            if let location = Bundle.main.path(forResource: manPage.fileName, ofType: "html", inDirectory: "man\(manPage.section)") {
                let browser = DocBrowseViewController(nibName: "DocBrowseViewController", bundle: Bundle.main)
                browser.title = manPage.name
                browser.docLocation = URL(fileURLWithPath: location)
                manPagesVC.navigationController?.pushViewController(browser, animated: true)
            }
        }
        manPagesVC.searchHandler = { searchText, docIndex, completion in
            DispatchQueue.global(qos: .background).async {
                let results: [ManPage]
                if searchText.isEmpty {
                    results = docIndex.flatMap{ $0.1 }
                } else {
                    results = docIndex.flatMap{ $0.1 }.filter({ (manPage) -> Bool in
                        return manPage.name.lowercased().contains(searchText.lowercased())
                    })
                }
                completion?(results)
            }
        }
        
        let navigation = UINavigationController(rootViewController: manPagesVC)
        return navigation
    }
    
    private var cheatsheetsVC: UIViewController {
        let cheatsheets: [String: [Cheatsheet]] = loadDoc(atPath: Constant.cheatsheetsLocation)
        let cheatsheetsVC = DocsTableViewController<Cheatsheet, DocTableViewCell>(docs: cheatsheets) { (cell, cheatsheet) in
            cell.nameLabel.text = cheatsheet.name
            cell.descriptionLabel.text = cheatsheet.description
            cell.categoryLabel.text = cheatsheet.platform
        }
        cheatsheetsVC.tabBarItem = UITabBarItem(title: "Cheatsheets", image: #imageLiteral(resourceName: "cheatsheet"), tag: 1)
        cheatsheetsVC.title = "Cheatsheets"
        cheatsheetsVC.didSelect = { cheatsheet in
            if let location = Bundle.main.path(forResource: cheatsheet.fileName, ofType: "html", inDirectory: "cheatsheets") {
                let browser = DocBrowseViewController(nibName: "DocBrowseViewController", bundle: Bundle.main)
                browser.title = cheatsheet.name
                browser.docLocation = URL(fileURLWithPath: location)
                cheatsheetsVC.navigationController?.pushViewController(browser, animated: true)
            }
        }
        cheatsheetsVC.searchHandler = { searchText, docIndex, completion in
            DispatchQueue.global(qos: .background).async {
                let results: [Cheatsheet]
                if searchText.isEmpty {
                    results = docIndex.flatMap{ $0.1 }
                } else {
                    results = docIndex.flatMap{ $0.1 }.filter({ (manPage) -> Bool in
                        return manPage.name.lowercased().contains(searchText.lowercased())
                    })
                }
                completion?(results)
            }
        }
        
        let navigation = UINavigationController(rootViewController: cheatsheetsVC)
        return navigation
    }
    
    private func loadDoc<Doc>(atPath path: String?) -> [String: [Doc]] {
        if let path = path,
            let jsonString = try? String(contentsOfFile: path),
            let jsonData = jsonString.data(using: .utf8) {
            do {
                let docIndex = try decoder.decode([String: [Doc]].self, from: jsonData)
                return docIndex
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
