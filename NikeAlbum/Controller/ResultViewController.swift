//
//  ResultViewController.swift
//  NikeAlbum
//
//  Created by sahin raj on 2/21/20.
//  Copyright © 2020 sahin raj. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var userSelectedRowIndex:Int?
    var albumData:Album?
    
    //View elements declaration
    var albumImageView:UIImageView = UIImageView()
    var albumName:UILabel = UILabel()
    var albumArtistLabel:UILabel = UILabel()
    var albumGenreLabel:UILabel = UILabel()
    var releasedDateLabel:UILabel = UILabel()
    var copyRightInfoLabel:UILabel = UILabel()
    var iTunesButton:UIButton = UIButton()
    var mainStackView:UIStackView = UIStackView()
    var bottomStackView:UIStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        // Do any additional setup after loading the view.
        
        setupAutoLayoutView()
        
        if let data = albumData
        {
            if let userselect = userSelectedRowIndex {
                
                bindViewWithData(data: data,userSelect:  userselect)
            }
        }
    }
    
    //MARK: - Binding view with Data
    func bindViewWithData(data: Album, userSelect: Int) {
        
        albumImageView.imageFromServerURL(urlString: data.feed.results[userSelect].artworkUrl100)
        albumImageView.contentMode = .scaleAspectFit
        
        albumName.text = "Name: \(data.feed.results[userSelect].name)"
        albumName.numberOfLines = 0
        
        albumArtistLabel.text = "Artist: \(data.feed.results[userSelect].artistName)"
      
        albumGenreLabel.text = "Genre: \(convertGenreToCommaSeperatedString(genres: data.feed.results[userSelect].genres))"
        
        releasedDateLabel.text = "Release: \(data.feed.results[userSelect].releaseDate)"
        
        copyRightInfoLabel.text = "Copyright: \(data.feed.results[userSelect].copyright)"
        copyRightInfoLabel.numberOfLines = 0
        
        iTunesButton.addTarget(self, action: #selector(redirectToiTunesStore), for: .touchUpInside)
        
        
    }
    
    func convertGenreToCommaSeperatedString(genres: [Genre]) -> String{
        var myGenre: [String] = []
        for genre in genres {
            myGenre.append(genre.name)
        }
        return myGenre.joined(separator: ", ")
    }
    
    @objc func redirectToiTunesStore() {
        print("Button clicked")
        if let data = albumData
        {
            if let userselect = userSelectedRowIndex {
                
                if let url = URL(string: data.feed.results[userselect].url) {
                    UIApplication.shared.open(url)
                }
            }
        }
        
        
    }
    
    
    //MARK: - Setting Up Auto Layout
    func setupAutoLayoutView() {
        
        self.view.addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        mainStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        self.mainStackView.addArrangedSubview(albumImageView)
        albumImageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.mainStackView.addArrangedSubview(bottomStackView)
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.addBackground(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        self.bottomStackView.addArrangedSubview(albumName)
        albumName.leadingAnchor.constraint(equalTo: self.bottomStackView.leadingAnchor, constant: 20).isActive = true
        albumName.trailingAnchor.constraint(equalTo: self.bottomStackView.trailingAnchor, constant: -20).isActive = true
        
        albumName.text = "Album Name"
        
        self.bottomStackView.addArrangedSubview(albumArtistLabel)
        albumArtistLabel.leadingAnchor.constraint(equalTo: self.bottomStackView.leadingAnchor, constant: 20).isActive = true
        albumArtistLabel.trailingAnchor.constraint(equalTo: self.bottomStackView.trailingAnchor, constant: -20).isActive = true
        
        albumArtistLabel.text = "Album Artist"
        
        self.bottomStackView.addArrangedSubview(albumGenreLabel)
        albumGenreLabel.leadingAnchor.constraint(equalTo: self.bottomStackView.leadingAnchor, constant: 20).isActive = true
        albumGenreLabel.trailingAnchor.constraint(equalTo: self.bottomStackView.trailingAnchor, constant: -20).isActive = true
        
        albumGenreLabel.text = "Album Genre"
        
        self.bottomStackView.addArrangedSubview(releasedDateLabel)
        releasedDateLabel.leadingAnchor.constraint(equalTo: self.bottomStackView.leadingAnchor, constant: 20).isActive = true
        releasedDateLabel.trailingAnchor.constraint(equalTo: self.bottomStackView.trailingAnchor, constant: -20).isActive = true
        
        releasedDateLabel.text = "Released Date"
        
        self.bottomStackView.addArrangedSubview(copyRightInfoLabel)
        copyRightInfoLabel.leadingAnchor.constraint(equalTo: self.bottomStackView.leadingAnchor, constant: 20).isActive = true
        copyRightInfoLabel.trailingAnchor.constraint(equalTo: self.bottomStackView.trailingAnchor, constant: -20).isActive = true
        
        copyRightInfoLabel.text = "Copy Right Info"
        
        self.bottomStackView.addArrangedSubview(iTunesButton)
        
        //pinned 20 points from the bottom of the view and 20 points from the leading and trailing edges of the view.
        iTunesButton.translatesAutoresizingMaskIntoConstraints = false
        iTunesButton.leadingAnchor.constraint(equalTo: self.bottomStackView.leadingAnchor, constant: 20).isActive = true
        iTunesButton.trailingAnchor.constraint(equalTo: self.bottomStackView.trailingAnchor, constant: -20).isActive = true
        iTunesButton.bottomAnchor.constraint(equalTo: self.bottomStackView.bottomAnchor, constant: -20).isActive = true
        
        
        iTunesButton.setTitle("View on iTunes Store", for: .normal)
        iTunesButton.setTitleColor(#colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), for: .normal)
        
    }
    
    deinit {
        print("Result ViewController deinit")
    }
    
}

//MARK: - StackView extension for setting background color
extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
