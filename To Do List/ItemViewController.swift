//
//  ItemViewController.swift
//  To Do List
//
//  Created by Phammel on 11/28/16.
//  Copyright © 2016 Phammel. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController
{

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var priceLable: UILabel!
    
    @IBOutlet weak var notesLable: UILabel!
    
    var curItem: Item!
    var curRow: Int!
    
    override func viewDidLoad()
    {
        imageView.animationImages = [
            UIImage(named: "1")!,
            UIImage(named: "2")!,
            UIImage(named: "3")!,
            UIImage(named: "2")! ]
        
        imageView.animationDuration = 4
        imageView.startAnimating()

        nameLable.text = curItem.itemName
        priceLable.text = "\(curItem.price) "
        priceLable.text = curItem.url
        
        
        
        
        super.viewDidLoad()

    }
    
  
    
   

    
    
    
    
}
