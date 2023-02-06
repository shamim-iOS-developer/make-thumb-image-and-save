//
//  TodoInsertUpdateView.swift
//  Todo app with Custom Daleget
//
//  Created by Appnotrix on 18/1/23.
//

import UIKit
import CoreData

protocol DelegateUpdate: AnyObject{
    func updateTodoData(todoDataModel: TodoList)
}

class TodoInsertUpdateView: UIViewController {

    var buttonTitleText: String?
    var todoDataModel: TodoList?
    var isInsert : Bool?
    
    weak var updateDelegate: DelegateUpdate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var todoTitleTxtField: UITextField!
    @IBOutlet weak var todoDescriptionTxtView: UITextView!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var todoInsertUpdateButton: UIButton!{
        didSet{
            todoInsertUpdateButton.setTitle(buttonTitleText, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todoListData = todoDataModel{
            todoTitleTxtField.text = todoListData.todoTitle
            todoDescriptionTxtView.text = todoListData.todoDescription
        }
    }
    
    @IBAction func todoChoseImage(_ sender: UIButton){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func todoInsertUpdateButtonAction(_ sender: UIButton) {
        if isInsert!{
            let todoData = TodoList(context: context)
            todoData.todoTitle = todoTitleTxtField.text
            todoData.todoDescription = todoDescriptionTxtView.text
            do{
                try context.save()
            }catch{
                
            }
            self.updateDelegate?.updateTodoData(todoDataModel: todoData)
        }
        else{
            if let todoTitleText = todoTitleTxtField.text{
                todoDataModel?.todoTitle = todoTitleText
            }
            if let todoDescriptionText = todoDescriptionTxtView.text{
                todoDataModel?.todoDescription = todoDescriptionText
            }
            do{
                try context.save()
            }catch{
                
            }
            if let todoDataModel = todoDataModel {
                self.updateDelegate?.updateTodoData(todoDataModel: todoDataModel)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension TodoInsertUpdateView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        todoImageView.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
}

