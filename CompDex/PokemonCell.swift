//
//  PokemonCell.swift
//  CompDex
//
//  Created by Angel Avila on 4/14/16.
//  Copyright © 2016 Angel Avila. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var type1Lbl: UILabel!
    @IBOutlet weak var type2Lbl: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        type1Lbl.layer.cornerRadius = 2.0
        type2Lbl.layer.cornerRadius = 2.0
        type1Lbl.clipsToBounds = true
        type2Lbl.clipsToBounds = true
    }

    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        type1Lbl.text = pokemon.type1.uppercaseString
        type2Lbl.text = pokemon.type2.uppercaseString
        nameLbl.text = pokemon.name.capitalizedString
        
        let color = Colors()
        
        if(type1Lbl.text != "") {
            type1Lbl.hidden = false
            type1Lbl.backgroundColor = color.getLabelColorForType(type1Lbl.text!)
        } else {
            type1Lbl.hidden = true
        }
        
        if(type2Lbl.text != "") {
            type2Lbl.hidden = false
            type2Lbl.backgroundColor = color.getLabelColorForType(type2Lbl.text!)
        } else {
            type2Lbl.hidden = true
        }
        
        pokemonImg.image = UIImage(named: "\(pokemon.name.lowercaseString)")
    }

}