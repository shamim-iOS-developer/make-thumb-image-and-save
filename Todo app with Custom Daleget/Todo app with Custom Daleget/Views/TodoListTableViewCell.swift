//
//  TodoListTableViewCell.swift
//  Todo app with Custom Daleget
//
//  Created by Appnotrix on 18/1/23.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet weak var todoTitleLbl: UILabel!
    @IBOutlet weak var todoDescriptionLbl: UILabel!
    @IBOutlet weak var editTodoButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
