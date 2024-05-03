//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation

typealias DataSourceItem = (title: String, items: [Song])

protocol PlaylistByGenreModelDelegate: AnyObject {
  
    func dataDidLoad()
}

class PlaylistByGenreModel {
    
    weak var delegate: PlaylistByGenreModelDelegate?
    private let dataLoader = DataLoaderService()
        
    private var items = [DataSourceItem]()
    
    func loadData() {
        
        dataLoader.loadPlaylist { [weak self] playlist in
            guard let weakSelf = self else { return }
            let items = playlist?.songs ?? []
            let grouped = weakSelf.groupByGenre(playlist: items)
            weakSelf.items = weakSelf.convertToDataSource(groupedItems: grouped)
            weakSelf.delegate?.dataDidLoad()
        }
    }
    
    private func groupByGenre(playlist: [Song]) -> [String : [Song]] {
        var result = [String : [Song]]()
        for song in playlist {
            let key = song.genre
            var value = result[key] ?? [Song]()
            value.append(song)
            result[key] = value
        }
        return result
    }
    
    private func convertToDataSource(groupedItems: [String : [Song]]) -> [DataSourceItem] {
        var result = [DataSourceItem]()
        let sortedKeys = groupedItems.keys.sorted()
        
        for key in sortedKeys {
            let dataSourceItem = DataSourceItem(key, groupedItems[key] ?? [Song]())
            result.append(dataSourceItem)
        }
        return result
    }
    
    // MARK: - Public interface
    
    func numberOfSections() -> Int {
        return items.count
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        return items[section].title
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return items[section].items.count
    }
    
    func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        return items[indexPath.section].items[indexPath.row].songTitle
    }
}

