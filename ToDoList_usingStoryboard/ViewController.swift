//
//  ViewController.swift
//  ToDoList_usingStoryboard
//
//  Created by TirthShah on 25/02/25.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var searcharray:[String] = []
    var is_searching = false
    var myarray:[String] = ["aaa"]
    @IBOutlet weak var txt_list: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_searching{
            return searcharray.count
        }else{
            return myarray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if is_searching{
            cell.textLabel?.text = searcharray[indexPath.row]
        }else{
            cell.textLabel?.text = myarray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myarray.remove(at:indexPath.row)
        UserDefaults.standard.set(myarray, forKey: "myarr")
        mytableview.reloadData()
    }

    @IBOutlet weak var mysearchbar: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searcharray = myarray.filter({$0.lowercased().contains(searchText.lowercased())})
        is_searching = true
        mytableview.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        is_searching = false
        searchBar.text = ""
        searcharray.removeAll()
        mytableview.reloadData()
    }
    
    @IBAction func btn_add(_ sender: Any) {
        
        if txt_list.text == ""{
         print("dfsdlfg")
        }else{
            let liststring = txt_list.text
            myarray.append(liststring!)
            mytableview.reloadData()
            txt_list.text = ""
            UserDefaults.standard.set(myarray, forKey: "myarr")
        }
        
    }
    
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mysearchbar.delegate = self
        self.mytableview.delegate = self
        self.mytableview.dataSource = self
        myarray = (UserDefaults.standard.array(forKey: "myarr") as? [String])!
        // Do any additional setup after loading the view.
    }


}

