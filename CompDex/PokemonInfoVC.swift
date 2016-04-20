//
//  PokemonInfoVC.swift
//  CompDex
//
//  Created by Angel Avila on 4/14/16.
//  Copyright © 2016 Angel Avila. All rights reserved.
//

import UIKit

class PokemonInfoVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var type1Lbl: UILabel!
    @IBOutlet weak var type2Lbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var evolutionsLbl: UILabel!
    @IBOutlet weak var evo1Img: UIImageView!
    @IBOutlet weak var evo2Img: UIImageView!
    @IBOutlet weak var evo1Lbl: UILabel!
    @IBOutlet weak var evo2Lbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        evo1Img.image = img
        mainImg.image = img
        
        evo1Lbl.text = "Current evolution"
        
        pokemon.downloadPokemonInfo { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        descLbl.text = pokemon.desc
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        
        let color = Colors()
        
        if pokemon.type2 == "" {
            type1Lbl.hidden = true
        } else {
            type1Lbl.text = pokemon.type2.uppercaseString
            type1Lbl.backgroundColor = color.getLabelColorForType(type1Lbl.text!)
        }
        
        type2Lbl.text = pokemon.type1.uppercaseString
        type2Lbl.backgroundColor = color.getLabelColorForType(type2Lbl.text!)
        pokeIdLbl.text = formatDexNo("\(pokemon.pokedexId)")
        
        if pokemon.nextEvoId == "" {
            evo2Img.hidden = true
            evo2Lbl.hidden = true
            evolutionsLbl.text = "No evolutions"
        } else {
            evo2Img.hidden = false
            evo2Lbl.hidden = false
            evo2Img.image = UIImage(named: pokemon.nextEvoId)
            
            if pokemon.nextEvoMethod != "" {
                evo2Lbl.text = pokemon.nextEvoMethod.capitalizedString
            }
            
            if pokemon.nextEvoLvl != "" {
                evo2Lbl.text = "Level \(pokemon.nextEvoLvl)"
            }
        }
    }
    
    func formatDexNo(dexNo: String) -> String{
        if dexNo.characters.count == 1 {
            return "#00\(dexNo)"
        } else if dexNo.characters.count == 2 {
            return "#0\(dexNo)"
        }
        
        return "#\(dexNo)"
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}