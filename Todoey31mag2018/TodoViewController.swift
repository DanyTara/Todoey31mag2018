//
//  ViewController.swift
//  Todoey31mag2018
//
//  Created by Daniela Tarantini on 31/05/18.
//  Copyright © 2018 Daniela Tarantini. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = ["Pippo", "Peperino", "Topolino"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark
            {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
        
        //per evitare di vedere il grigio nelle righe
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Aggiungi Nuovi Elementi
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //creo una variabile locale che sarà raggiungibile da tutta l'azione per metterci il testo che scriverà l'utente
        var textfield = UITextField()
        
        //creo un Alert con i messaggi prestampati
        let alert = UIAlertController(title: "Aggiungi un nuovo giocatore", message: "", preferredStyle: .alert)
        //creo l'azione che  verrà innescata quando l'utente preme l'alert
        let action = UIAlertAction(title: "Aggiungi giocatore", style: .default) { (action) in
            // aggiungo il nuovo giocatore al mio array principale
            //ricarico la tableview altrimenti non vedrò il nuovo giocatore
            self.itemArray.append(textfield.text!)
            self.tableView.reloadData()
        }
        //aggiungo un campo di testo all'alert
        alert.addTextField { (alertTextField) in
            //creo un placeholder all'alert con un testo prestampato
            alertTextField.placeholder = "Scrivi nuovo giocatore"
            //metto nella variabile locale raggiungibile da tutta la func il nuuovo campo di testo che altrimenti sarebbe raggiungibile solo all'interno di queste graffe
            textfield = alertTextField
        }
        //collego l'azione creata all'Alert
        alert.addAction(action)
        //questo permette all'alert di chiudersi
        present(alert, animated: true, completion: nil)
        
    }
    
}

