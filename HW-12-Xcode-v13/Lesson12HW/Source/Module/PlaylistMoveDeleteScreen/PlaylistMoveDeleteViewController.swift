//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController {
    
  
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        contentView.tableView.dataSource = self
        contentView.tableView.dataSource = self
        
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        contentView.tableView.isEditing = !contentView.tableView.isEditing
    }
    
}
// Розширення для протоколу UITableViewDataSource
extension PlaylistMoveDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.playlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Повертає налаштовану комірку таблиці з інформацією про пісню
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell")
        else {
            assertionFailure()
            return UITableViewCell()
        }
        cell.textLabel?.text = model.playlist[indexPath.row].songTitle

       return cell
    }
}

// Розширення для протоколу UITableViewDelegate
extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    // якщо редагування рядка дозволено
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Видалення пісні
        if editingStyle == .delete {
            model.playlist.remove(at: indexPath.row)
            // Видалення рядка
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

