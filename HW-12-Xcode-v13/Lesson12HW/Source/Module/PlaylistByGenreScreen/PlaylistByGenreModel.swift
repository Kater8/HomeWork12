//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistByGenreModelDelegate: AnyObject {
  
    func dataDidLoad()
}

class PlaylistByGenreModel {
    
    weak var delegate: PlaylistByGenreModelDelegate?
    private let dataLoader = DataLoaderService()
    
    var items: [Song] = []
    
    func loadData() {
        
        dataLoader.loadPlaylist { playlist in
            
            self.items = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
}

