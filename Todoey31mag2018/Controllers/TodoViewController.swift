//
//  ViewController.swift
//  Todoey31mag2018
//
//  Created by Daniela Tarantini on 31/05/18.
//  Copyright © 2018 Daniela Tarantini. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // aggiungo una scatola persistente (un .plist in UserDefauls) dove saranno depositati i miei dati in modo  persistenti
    let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let nuovoGiocatore = Item()
        nuovoGiocatore.title = "Pippo"
        itemArray.append(nuovoGiocatore)
        
        let nuovoGiocatore1 = Item()
        nuovoGiocatore1.title = "Paperino"
        itemArray.append(nuovoGiocatore1)
        
        let nuovoGiocatore2 = Item()
        nuovoGiocatore2.title = "Gastone"
        itemArray.append(nuovoGiocatore2)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    //MARK - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIFtrue :(altrimenti) valueIFfalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //nel DIDSELECT scelgo la riga e metto se vero o falso - essendo un booleano con soli due stati con '!' diventa opposto
        
     // erroreee??? la devo mettere??? item[indexPath.row].done = !item[indexPath.row].false
       
    
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
            
            let newItem = Item()
            newItem.title = textfield.text!
            // aggiungo il nuovo giocatore al mio array principale
            self.itemArray.append(newItem)
            //aggiungo gli elementi del mio array nella scatola persistente
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //ricarico la tableview altrimenti non vedrò il nuovo giocatore
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

