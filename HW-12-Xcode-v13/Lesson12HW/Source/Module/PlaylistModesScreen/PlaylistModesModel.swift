//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//

import Foundation
import UIKit

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad()
    func modeDidChange()
}

class PlaylistModesModel {
    
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()
    private var allItems = [DataSourceItem]()
    private var genreItems = [DataSourceItem]()
    private var authorItems = [DataSourceItem]()
    
    var mode = Mode.all {
        didSet {
            delegate?.modeDidChange()
        }
    }
    
    
    func loadData() {
        
        dataLoader.loadPlaylist { [weak self] playlist in
            guard let weakSelf = self else { return }
            weakSelf.createDataSource(playlist: playlist)
            weakSelf.delegate?.dataDidLoad()
        }
    }
    
    
    // MARK: - Private methods
    
    private func dataSourceForSelectedMode() -> [DataSourceItem] {
        switch mode {
        case .all:
            return allItems
        case .genre:
            return genreItems
        case .author:
            return authorItems
        }
    }
    
    private func createDataSource(playlist: Playlist?) {
        let allSongs = playlist?.songs ?? []
        // method for all
        allItems = allItems(playlist: allSongs)
        // method for genre
        genreItems = genreItems(playlist: allSongs)
        // method for author
        authorItems = authorItems(playlist: allSongs)
        
    }
    
    private func allItems(playlist:[Song]) -> [DataSourceItem] {
        let result = DataSourceItem(nil, playlist)
        return [result]
    }
    
    private func genreItems(playlist:[Song]) -> [DataSourceItem] {
        let grouped = groupByGenre(playlist: playlist)
        return self.convertToDataSource(groupedItems: grouped)
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
    
    private func authorItems(playlist:[Song]) -> [DataSourceItem] {
        let grouped = groupByAuthor(playlist: playlist)
        return self.convertToDataSource(groupedItems: grouped)
    }
    
    private func groupByAuthor(playlist: [Song]) -> [String : [Song]] {
        var result = [String : [Song]]()
        for song in playlist {
            let key = song.author
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
        return dataSourceForSelectedMode().count
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        return dataSourceForSelectedMode()[section].title
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return dataSourceForSelectedMode()[section].items.count
    }
    
    func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        let itemSong = dataSourceForSelectedMode()[indexPath.section].items[indexPath.row]
        let title = "\(itemSong.author) - \(itemSong.songTitle)"
        return title
    }
}

extension PlaylistModesModel {
    
    typealias DataSourceItem = (title: String?, items: [Song])
    
    enum Mode {
        case all
        case genre
        case author
    }
}
