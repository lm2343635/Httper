//
//  ProjectTableViewController.swift
//  Httper
//
//  Created by 李大爷的电脑 on 07/02/2017.
//  Copyright © 2017 limeng. All rights reserved.
//

import UIKit

let attributeImgaes = ["tab_project", "privilege"]

class ProjectTableViewController: UITableViewController {
    
    var project: Project!
    
    // The request will be added to the requests array.
    var request: Request!
    
    let dao = DaoManager.sharedInstance
    let sync = SyncManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = project.pname
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if request != nil {
            // Add request to this project.
            addRequest(request)
            
            // Set request to nil.
            request = nil
            
            // Update table view.
            tableView.reloadData()
        }
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 30))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return project.requests!.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "projectIdentifier", for: indexPath)
                let projectLabel = cell.viewWithTag(2) as! UILabel
                projectLabel.text = project.pname
            } else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "privilegeIdentifier", for: indexPath)
                let privilegeLabel = cell.viewWithTag(2) as! UILabel
                privilegeLabel.text = project.privilege
            }
            cell = UITableViewCell()
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "requestIdentifier", for: indexPath)
            let urlLabel = cell.viewWithTag(1) as! UILabel
            let methodLabel = cell.viewWithTag(2) as! UILabel
            let request = project.requests?[indexPath.row] as! Request
            urlLabel.text = request.url
            methodLabel.text = request.method
        default:
            cell = UITableViewCell()
        }
        return cell
    }

    
    // MARK: - Service
    func addRequest(_ request: Request) {
        // Add request to project at local persistent store.
        project.addToRequests(request)
        
        // Push this request to server.
        // Set this request's revision to 0 at first, only request with revision 0 can be pushed to remote server.
        request.revision = 0;
        // Save persistent store context.
        dao.saveContext()
        // User SyncManger to push request
        sync.pushLocalRequests(nil)
    }
}