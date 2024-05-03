//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistModesViewController: UIViewController, PlaylistModesViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentView: PlaylistModesView!
    var model: PlaylistModesModel!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl)
    
    switch sender.selectedSegmentIndex {
    case 0:
//        Відображення всього списку
        model.mode = .all
    case 1:
//        згрупованого за жанрами
        model.mode = .genre
    case 2:
//        згрупованого за авторами
        model.mode = .author
    default:
        break
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistModesModel()
        model.delegate = self

        contentView.delegate = self

        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

extension PlaylistModesViewController: PlaylistModesModelDelegate  {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
   }
}

extension PlaylistModesViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModesPlaylistCell")
                else
        {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.textLabel[indexPath.row].songTitle
        
        return cell
    }
}
extension PlaylistModesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

