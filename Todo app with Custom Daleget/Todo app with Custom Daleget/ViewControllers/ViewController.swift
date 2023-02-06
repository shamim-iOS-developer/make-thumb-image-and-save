//
//  ViewController.swift
//  Todo app with Custom Daleget
//
//  Created by Appnotrix on 18/1/23.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var todoListTableView: UITableView!
    
    var todoDataModel = [TodoList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        todoListTableView.dataSource = self
        todoListTableView.delegate = self
        todoRetriveData()
    }
    
    //MARK: - Todo Item Insert Button
    @IBAction func rightBarButtonAction(_ sender: Any) {
        if let todoInsertUpdateView = UIStoryboard(name: "TodoInsertDeleteView", bundle: nil).instantiateViewController(withIdentifier: "TodoInsertUpdateView") as? TodoInsertUpdateView{
            todoInsertUpdateView.isInsert = true
            todoInsertUpdateView.buttonTitleText = "Insert"
            todoInsertUpdateView.updateDelegate = self
            self.navigationController?.pushViewController(todoInsertUpdateView, animated: true)
        }
    }
}

//MARK: - Delegate Data
extension ViewController : DelegateUpdate{
    func updateTodoData(todoDataModel: TodoList) {
        todoRetriveData()
    }
}

//MARK: - Set Table View DataSoursce

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TodoListTableViewCell", owner: self, options: nil)?.first as! TodoListTableViewCell
        cell.todoTitleLbl.text = todoDataModel[indexPath.row].todoTitle
        cell.todoDescriptionLbl.text = todoDataModel[indexPath.row].todoDescription
        cell.editTodoButton.addTarget(self, action: #selector(editTodoButton(_:)), for: .touchUpInside)
        return cell
    }
    
    //MARK: - Edit Todo Single Cell Button Action
    
    @objc func editTodoButton(_ editButton: UIButton){
        
    }
}

//MARK: - Set Table View Delegate

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    //MARK: - Did Select row action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let updateView = UIStoryboard(name: "TodoInsertDeleteView", bundle: nil).instantiateViewController(withIdentifier: "TodoInsertUpdateView") as? TodoInsertUpdateView{
            updateView.buttonTitleText = "Update"
            updateView.todoDataModel = todoDataModel[indexPath.row]
            updateView.isInsert = false
//            updateView.todoTitleTxtField.text = todoDataModel[indexPath.row].todoTitle
//            updateView.todoDescriptionTxtView.text = todoDataModel[indexPath.row].todoDescription
            updateView.updateDelegate = self
            self.navigationController?.pushViewController(updateView, animated: true)
        }
    }
}

//MARK: - CORE DATA CRUD OPARETION

extension ViewController{
    func todoInsert(todoTitle: String, todoDescription: String){
        let todoData = TodoList(context: context)
        todoData.todoTitle = todoTitle
        todoData.todoDescription = todoDescription
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func todoRetriveData(){
        do{
            try todoDataModel = context.fetch(TodoList.fetchRequest())
            todoListTableView.reloadData()
        }catch{
            
        }
    }
    
    func todoDataUpdate(todoTitle: String, todoDescription: String, todoItem: TodoList){
        todoItem.todoTitle = todoTitle
        todoItem.todoDescription = todoDescription
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func todoDelete(todoItem: TodoList){
        context.delete(todoItem)
        do{
            try context.save()
        }catch{
            
        }
    }
}


