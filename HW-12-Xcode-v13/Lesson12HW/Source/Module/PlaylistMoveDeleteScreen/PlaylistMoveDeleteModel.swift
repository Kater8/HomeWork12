//
//  PlaylistMoveDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistMoveDeleteModelDelegate: AnyObject {
    // Оголосіть методи, які необхідно реалізувати делегатом
    func dataDidLoad()
}

class PlaylistMoveDeleteModel {
    
    weak var delegate: PlaylistMoveDeleteModelDelegate?
  
    private let dataLoader = DataLoaderService()
   
    var playlist: [Song] = []
    
    func loadData() {
        
        dataLoader.loadPlaylist { playlist in
            
            self.playlist = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
}
