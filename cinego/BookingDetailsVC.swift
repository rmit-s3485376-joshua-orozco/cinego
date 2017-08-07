//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class BookingDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableViewCellID = "SelectedSeatsTableViewCell"
    
    var movie: Movie = Movie(title: "Atomic Blonde", releaseDate: "2017", duration: 140, sessions: [], images: [])
    var movieSession: MovieSession? = nil
    var numTickets = 0
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    
    @IBOutlet weak var cinemaLocationLabel: UILabel!
    @IBOutlet weak var cinemaAddressLabel: UILabel!
    @IBOutlet weak var movieSessionStartLabel: UILabel!
    
    @IBOutlet weak var ticketQuantityLabel: UILabel!
    @IBOutlet weak var ticketQuantityStepper: UIStepper!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = "Seats"
        cell.detailTextLabel?.text = "1/1 seats selected"
        return cell
    }
    
    
    func setupMovieInformation(movie: Movie? = nil){
        if let _movie = movie {
            self.movie = _movie
        }
        movieTitleLabel?.text = self.movie.title
        movieReleaseDateLabel?.text = "Released: \(self.movie.releaseDate)"
        movieBannerImageView?.image = #imageLiteral(resourceName: "olive-160x240")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}