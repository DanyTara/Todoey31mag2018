//
//  ViewController.swift
//  Todoey31mag2018
//
//  Created by Daniela Tarantini on 31/05/18.
//  Copyright © 2018 Daniela Tarantini. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var itemArray = [Item]()
    
    //creo la costante con il percorso per raggiungere il mio plist
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
       loadItems()
        
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
    
       
    
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
            
            self.saveItems()
            
    
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
        
        saveItems()
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        //creo il plist e aggiungo gli elementi del mio array nella scatola persistente
        // PropertyListENCODER: un oggetto che codifica le istanze dei tipi di dati in un elenco di proprietà
        //encode: metodo che restituisce un elenco di proprietà che rappresenta una versione codificata del valore fornito.Se si verifica un problema con la codifica del valore fornito, questo metodo genera un errore in base al tipo di problema
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
            
        }
    }
    
}

