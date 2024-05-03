//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController, PlaylistMoveDeleteModelDelegate {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        model.delegate = self
        model.loadData()

        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.dragDelegate = self
        contentView.tableView.dragInteractionEnabled = true

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped(_:))
        )
    }
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        let mover = model.playlist.remove(at: sourceIndexPath.row)
        model.playlist.insert(mover, at: destinationIndexPath.row)
    }
}

extension PlaylistMoveDeleteViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = model.playlist[indexPath.row]
        return [dragItem]
    }
}
