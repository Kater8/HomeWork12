//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistByGenreViewController: UIViewController, UITableViewDelegate, PlaylistByGenreViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistByGenreModel()
        model.delegate = self
        contentView.delegate = self

        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}
extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}
extension PlaylistByGenreViewController: UITableViewDataSource {
    
//    Ця функція повертає кількість секцій у таблиці. викликає метод numberOfSections() у моделі, який повинен повертати кількість різних жанрів
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return model.numberOfSections()
        
    }
//    повертає заголовок для кожної секції у таблиці. повертає назву жанру для даної секції.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.titleForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "ByGenrePlaylistCell")
        else
        {
//            assertionFailure()
            return UITableViewCell()
        }
        cell.textLabel?.text = model.titleForRowAtIndexPath(indexPath)
        return cell
    }
    
}
