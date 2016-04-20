//
//  ViewController.swift
//  CompDex
//
//  Created by Angel Avila on 4/13/16.
//  Copyright © 2016 Angel Avila. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        searchBar.enablesReturnKeyAutomatically = false
        
        parsePokemonCSV()
    }
    
    // MARK : - Parse CSV
    
    func parsePokemonCSV() {
        let pathPoke = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        let pathPokeTypes = NSBundle.mainBundle().pathForResource("pokemon_types", ofType: "csv")!
        let pathTypes = NSBundle.mainBundle().pathForResource("types", ofType: "csv")!
        
        do {
            let csvPoke = try CSV(contentsOfURL: pathPoke)
            let csvPokeTypes = try CSV(contentsOfURL: pathPokeTypes)
            let csvTypes = try CSV(contentsOfURL: pathTypes)
            
            let rowsPoke = csvPoke.rows
            let rowsPokeTypes = csvPokeTypes.rows
            let rowsTypes = csvTypes.rows
            
            for rowPoke in rowsPoke {
                let pokeId = Int(rowPoke["id"]!)!
                let name = rowPoke["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
            for rowPokeType in rowsPokeTypes {
            
                let pokeId = Int(rowPokeType["pokemon_id"]!)!
                let slot = Int(rowPokeType["slot"]!)!
                let pokeTypeId = Int(rowPokeType["type_id"]!)!
                
                for rowType in rowsTypes {
                    
                    let typeId = Int(rowType["id"]!)!
                    
                    if typeId == pokeTypeId {
                        let type = rowType["identifier"]!
                        
                        if slot == 1 {
                            pokemon[pokeId - 1].setType1(type)
                        } else {
                            pokemon[pokeId - 1].setType2(type)
                        }
                    }
                }
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    // MARK : - Table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let pokemonCell = tableView.dequeueReusableCellWithIdentifier("PokemonCell") as? PokemonCell {
            let poke: Pokemon!
            
            if searching {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            pokemonCell.configureCell(poke)
            return pokemonCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    // MARK : - Segue
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let poke: Pokemon!
        
        if searching {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonInfoVC", sender: poke)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let identifier = segue.identifier {
            switch identifier {
            case "PokemonInfoVC":
                
                if let pokemonInfoVC = segue.destinationViewController as? PokemonInfoVC {
                    if let poke = sender as? Pokemon {
                        pokemonInfoVC.pokemon = poke
                    }
                }
  
            default:
                break
            }
        }
    }
    
    // MARK : - Search Bar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searching = false
            tableview.reloadData()
        } else {
            searching = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            tableview.reloadData()
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
}