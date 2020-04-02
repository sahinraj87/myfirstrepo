//
//  AlbumManagerTest.swift
//  NikeAlbumTests
//
//  Created by sahin raj on 2/24/20.
//  Copyright © 2020 sahin raj. All rights reserved.
//

import Foundation
import XCTest
@testable import NikeAlbum

class AlbumManagerTest: XCTest {
    
    func testFetchAlbumDetails() {
        
        let apiData:String = "vdfdsfsf"
        
        let albumManager = AlbumManager()
        
        let result:Bool = albumManager.fetchAlbumDetails(rawURL: apiData)
        
        XCTAssertFalse(result)
        
    }
    
    
}
