//
//  StudentTableViewCell.swift
//  CoreDataiOS
//
//  Created by Touhid on 7/23/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setDataToView(name: String, phone: String, address: String) {
        self.labelName.text = name
        self.labelPhone.text = phone
        self.labelAddress.text = address
    }

}
