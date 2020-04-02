//
//  AlbumTableViewCell.swift
//  NikeAlbum
//
//  Created by sahin raj on 2/19/20.
//  Copyright © 2020 sahin raj. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    lazy var albumArtImage: UIImageView = {
        
        let view = UIImageView()
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return view
    }()
    
    lazy var albumName: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    lazy var albumArtist: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.contentView.addSubview(albumArtImage)
        self.contentView.addSubview(albumName)
        self.contentView.addSubview(albumArtist)
        setAutolayoutConstraints()
    }
    
    //MARK: - AutoLayout constraints for cell view
    func setAutolayoutConstraints() {
        
        albumArtImage.translatesAutoresizingMaskIntoConstraints = false
        albumArtImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        albumArtImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        albumArtImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        albumArtImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        albumName.translatesAutoresizingMaskIntoConstraints = false
        albumName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        albumName.leadingAnchor.constraint(equalTo: self.albumArtImage.trailingAnchor, constant: 10).isActive = true
        albumName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        albumName.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        albumArtist.translatesAutoresizingMaskIntoConstraints = false
        albumArtist.topAnchor.constraint(equalTo: self.albumName.bottomAnchor, constant: 10).isActive = true
        albumArtist.leadingAnchor.constraint(equalTo: self.albumArtImage.trailingAnchor, constant: 10).isActive = true
        albumArtist.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        albumArtist.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
