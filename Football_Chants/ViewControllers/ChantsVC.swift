//
//  ChantsVC.swift
//  Football_Chants
//
//  Created by Sihan on 22/9/23.
//

import UIKit

class ChantsVC: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableVW = UITableView()
        tableVW.translatesAutoresizingMaskIntoConstraints = false
        tableVW.backgroundColor = .clear
        tableVW.rowHeight = UITableView.automaticDimension
        tableVW.estimatedRowHeight = 44
        tableVW.separatorStyle = .none
        tableVW.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableVW.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellId)
        return tableVW
    }()
    
    private lazy var teamsViewModel = TeamsViewModel()
    private lazy var audiomanagerViewModel = AudioManagerViewModel()
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        // Do any additional setup after loading the view.
    }
    

}

private extension ChantsVC{
    func setUp(){
        
        self.navigationController?.navigationBar.topItem?.title = "Football Chants"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        tableView.dataSource = self

        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension ChantsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamsViewModel.teams[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellId, for: indexPath) as! TeamTableViewCell
        cell.configure(with: team, delegate: self)
//        switch indexPath.row{
//        case 0:
//            cell.backgroundColor = .systemGreen
//        default:
//            break
//        }
        return cell
        
    }
    
    
}

extension ChantsVC:TeamTableViewDelegate {
    func didTapPlayBack(for team: Team) {
        audiomanagerViewModel.playBack(team)
        teamsViewModel.tooglePlayBack(for: team)
        tableView.reloadData()
    }
}

