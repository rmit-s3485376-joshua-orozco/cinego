//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol BookingDetailsVCDelegate: class {
    func didBook(_ cartItem: CartItem)
}

class BookingDetailsVC: UIViewController {
    
    let tableViewCellID = "SelectedSeatsTableViewCell"
    
    weak var delegate: BookingDetailsVCDelegate?
    var cartRepository: ICartRepository!
    var cartItem: CartItem?
    
    var movie: Movie!
    var movieSession: MovieSession!
    var numTickets = 0
    var maxNumberOfTickets = 40
    var selectedSeats: [Seat] = []
    
    var fromCart = false
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var bookToSessionButton: UIButton!
    
    @IBOutlet weak var cinemaLocationLabel: UILabel!
    @IBOutlet weak var cinemaAddressLabel: UILabel!
    @IBOutlet weak var movieSessionStartLabel: UILabel!
    
    @IBOutlet weak var ticketQuantityLabel: UILabel!
    @IBOutlet weak var ticketQuantityStepper: UIStepper!
    
    @IBOutlet weak var numSeatsTableView: UITableView!
    
    @IBAction func ticketQuantityStepperDidValueChanged(_ sender: UIStepper) {
        let val = Int(sender.value)
        changeNumTickets(to: val)
        updateSeatsSelectedLabel(to: val)
    }
    
    
    @IBAction func bookToSessionButtonDidTap(_ sender: Any) {
        book(toSession: movieSession!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupMovieInformation()
        setupMovieSessionInformation()
        setupTickets()
        setupButton()
    }
    
    private func updateSeatsSelectedLabel(to: Int){
        numSeatsTableView.reloadData()
    }
    
    // MARK: Helper Methods
    private func setupData(){
        if let cartItem = cartItem {
            movie = cartItem.movie
            movieSession = cartItem.movieSession
            numTickets = cartItem.numTickets
        }
    }
    
    
    private func setupMovieInformation(){
        movieTitleLabel.text = movie?.title
        movieReleaseDateLabel.text = "Released: \(movie.releaseDate )"
        movieBannerImageView.image = UIImage(imageLiteralResourceName: (movie?.images[0])!)
    }
    
    
    private func setupMovieSessionInformation(){
        cinemaLocationLabel.text = movieSession.cinema?.name ?? ""
        cinemaAddressLabel.text = movieSession.cinema?.address ?? ""
        movieSessionStartLabel.text = humaniseTime((movieSession?.startTime)!)
    }
    
    
    private func setupTickets(){
        ticketQuantityStepper.stepValue = Double(1)
        ticketQuantityStepper.minimumValue = Double(0)
        ticketQuantityStepper.maximumValue = Double(maxNumberOfTickets)
        ticketQuantityStepper.value = Double(numTickets)
        ticketQuantityLabel.text = String(Int(ticketQuantityStepper.value))
    }
    
    
    private func setupButton(){
        if cartItem != nil {
            bookToSessionButton.titleLabel?.text = "Update"
        }
        
        if numTickets > 0 {
            bookToSessionButton.isEnabled = true
            bookToSessionButton.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0)
        } else {
            bookToSessionButton.isEnabled = false
            bookToSessionButton.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5)
        }
    }
    
    
    private func humaniseTime(_ timeStr: String, _ format: String = "dd-MM-yyyy HH:mm:ss") -> String {
        var returnStr = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let date = formatter.date(from: timeStr) {
            formatter.dateFormat = "EEE dd MMM hh:mm aa"
            returnStr = formatter.string(from: date)
        }
        
        return returnStr
    }
    
    
    
}

extension BookingDetailsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = "Seats"
        cell.detailTextLabel?.text = "\(String(selectedSeats.count))/\(String(numTickets)) seats selected"
        cell.imageView?.image = #imageLiteral(resourceName: "cinema-seat")
        return cell
    }
    
}

extension BookingDetailsVC: SeatCollectionVCDelegate {
    
    func didSelectSeats(_ seats: [Seat]) {
        print("Did select seats")
        selectedSeats = seats
        numSeatsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openSeatCollectionVCFromBookingDetailsVC" {
            let destinationVC = segue.destination as! SeatsCollectionVC
            destinationVC.delegate = self
            destinationVC.selectedSeats = selectedSeats
            destinationVC.numTickets = numTickets
        }
    }
}


extension BookingDetailsVC {

    func book(toSession session: MovieSession) {
        let cartItem = CartItem(movie: movie!, movieSession: movieSession!, numTickets: numTickets, seatNumbers: [1,2,3])
        cartRepository.addToCart(cartItem: cartItem)
        delegate?.didBook(cartItem)
        goBack()
    }
    
    func changeNumTickets(to qty: Int){
        numTickets = qty
        ticketQuantityLabel.text = String(numTickets)
        
        if numTickets > 0 && numTickets <= maxNumberOfTickets {
            bookToSessionButton.isEnabled = true
            bookToSessionButton.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0)
        } else {
            bookToSessionButton.isEnabled = false
            bookToSessionButton.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5)
        }
    }
    
    func goBack(){
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
