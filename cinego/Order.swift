//
//  Order.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class Order {
    
    private let _gstRate: Double = 0.1
    private let _shippingRate: Double = 0.05
    
    public let id: String
    public let bookings: [Booking]
    
    public let address: String
    public let telephoneNumber: String
    public let email: String
    
    public let paymentMethod: PaymentMethod
    
    
    public init(id: String, bookings: [Booking], paymentMethod: PaymentMethod, address: String = "", telephoneNumber: String = "", email: String = ""){
        self.id = id
        self.bookings = bookings
        self.address = address
        self.telephoneNumber = telephoneNumber
        self.email = email
        self.paymentMethod = paymentMethod
    }
    
    
    public func calculateTotalPrice() -> Double {
        var total = 0.0
        for booking in self.bookings {
            total += booking.calculateTotalPrice()
        }
        return total
    }
    
    
    
}