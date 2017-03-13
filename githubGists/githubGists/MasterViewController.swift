//
//  MasterViewController.swift
//  githubGists
//
//  Created by Danyal Aboobakar on 09/03/2017.
//  Copyright © 2017 Danyal Aboobakar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var gists = [Gist]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadGists()
    }
    
    func loadGists() {
//        let gist1 = Gist()
//        gist1.description = "The first gist"
//        gist1.ownerLogin = "gist1Owner"
//        let gist2 = Gist()
//        gist2.description = "The second gist"
//        gist2.ownerLogin = "gist2Owner"
//        let gist3 = Gist()
//        gist3.description = "The third gist"
//        gist3.ownerLogin = "gist3Owner"
//        gists = [gist1, gist2, gist3]
        GithubAPIManager.sharedInstance.fetchPublicGists() {
            result in
            guard result.error == nil else {
                self.handleLoadGistsError(result.error!)
                return
            }
            if let fetchedGists = result.value {
                self.gists = fetchedGists
            }
            self.tableView.reloadData()
        }

        
        self.tableView.reloadData()
    }
    
    func handleLoadGistsError(_ error: Error) {
        // TODO: show error
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        let alert = UIAlertController(title: "Not Implemented",
                                      message: "Can't create new gists yet, will implement later",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let gist = gists[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = gist
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let gist = gists[indexPath.row]
        cell.textLabel!.text = gist.description
        cell.detailTextLabel?.text = gist.ownerLogin
//        TODO: set cell.imageview to display image at gist.ownerAvatarURL
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

