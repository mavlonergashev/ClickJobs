//
//  VacanciesVC.swift
//  ClickJobs - Page 2
//
//  Created by MIrmuxammad on 25/03/22.
//

import UIKit

class VacanciesVC: UIViewController {
    

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "EmployessTVC", bundle: nil), forCellReuseIdentifier: "EmployessTVC")
        }
    }
    
    
    var vacancies: [Vacancy] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Fire.shared.getVacancyies { newVacs in
            self.vacancies = newVacs
            self.tableView.reloadData()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()

    }
    
    @objc func filterTapped(sender: UIBarButtonItem) {
        
    }

}
//MARK: -Table View-
extension VacanciesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vacancies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployessTVC", for: indexPath) as? EmployessTVC else { return UITableViewCell() }
        cell.update(data: self.vacancies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VacanciesDesVC(nibName: "VacanciesDesVC", bundle: nil)
        vc.urlString = vacancies[indexPath.row].infoUrl
        vc.category = vacancies[indexPath.row].category
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.navigationBar.barTintColor = .defaultGray
    }
    
}
//MARK: -UINavigationControllerBar methodos-
extension VacanciesVC {
    func setNavBar() {
        
        view.backgroundColor = .defaultGray
        
        title = "Vacancies"
        
        searchController.searchBar.placeholder = "Search vacancies"
        
        let offset = -(searchController.searchBar.frame.height)
        tableView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .btnRed
        navigationItem.backBarButtonItem?.tintColor = .btnRed
    }
}
