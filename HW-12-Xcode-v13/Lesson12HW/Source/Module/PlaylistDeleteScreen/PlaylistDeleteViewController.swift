//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistDeleteViewController: UIViewController, UITableViewDelegate, PlaylistDeleteModelDelegate {
    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: PlaylistDeleteView!
    private var model: PlaylistDeleteModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model = PlaylistDeleteModel()
        model.delegate = self
        model.loadData()
    }
    func dataDidLoad() {
        tableView.reloadData()
    }
}


extension PlaylistDeleteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistDeleteCell")
        else {
//            assertionFailure()
            return UITableViewCell()
        }

        cell.textLabel?.text = model.items[indexPath.row].songTitle

        return cell
    }
}
