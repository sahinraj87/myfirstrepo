//
//  ViewController.swift
//  NikeAlbum
//
//  Created by sahin raj on 2/19/20.
//  Copyright © 2020 sahin raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var albumManager = AlbumManager()
    var albumTableView = UITableView()
    var albumDataLocal: Album?
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumManager.delegate = self
        addactivityIndicator()
        fetchDataForAlbum()
        configureAlbumTableView()
        
    }
    
    func addactivityIndicator() {
        
        activityIndicator.center = self.view.center
        
    }
    
    func configureAlbumTableView() {
        
        view.addSubview(albumTableView)
        view.addSubview(activityIndicator)
        
        albumTableView.translatesAutoresizingMaskIntoConstraints = false
        albumTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        albumTableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        albumTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        albumTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        
        albumTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
        
        // set delegate properties
        albumTableView.delegate = self
        albumTableView.dataSource = self
        
        // set row height for tableview
        albumTableView.rowHeight = UITableView.automaticDimension
        albumTableView.estimatedRowHeight = 110
    }
    
}
//MARK: - TableView Delegate / Protocols

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumTableViewCell
        
        if let data = albumDataLocal {
            
            cell.albumArtImage.imageFromServerURL(urlString:  data.feed.results[indexPath.item].artworkUrl100)
            cell.albumName.text = "Album: \(data.feed.results[indexPath.item].name)"
            cell.albumArtist.text = "Artist: \(data.feed.results[indexPath.item].artistName)"
            
        }else{
            print("Data is NIL")
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //How many rows does show, temp value
        if let data = albumDataLocal {
            return data.feed.results.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultViewController = ResultViewController()
        resultViewController.userSelectedRowIndex = indexPath.row
        if let data = albumDataLocal {
            resultViewController.albumData = data
            
        }
        resultViewController.modalTransitionStyle = .crossDissolve
        self.present(resultViewController, animated: false, completion: nil)
        
    }
}

//MARK: - AlbumManager Delegate

extension ViewController: AlbumManagerDelegate {
    func fetchDataForAlbum() {
        
        
        if Reachability.isConnectedToNetwork() == true {
            
            // Check for Internet Connection
            print("Internet connection OK")
            activityIndicator.startAnimating()
            albumTableView.isHidden = true
            // gitRepo Local
            albumManager.fetchAlbumDetails(rawURL: albumManager.albumURL)
            
        } else {
            
            print("Internet connection FAILED")
            //create the alert
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didUpdateAlbumData(albumManager: AlbumManager, albumData: Album) {
        
        self.activityIndicator.stopAnimating()
        albumTableView.isHidden = false
        self.albumManager = albumManager
        self.albumDataLocal = albumData
        albumTableView.reloadData()
    }
}


