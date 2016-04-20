//
//  Pokemon.swift
//  CompDex
//
//  Created by Angel Avila on 4/14/16.
//  Copyright © 2016 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _type1: String!
    private var _type2: String!
    private var _desc: String!
    private var _height: String!
    private var _weight: String!
    private var _pokemonUrl: String!
    private var _nextEvoId: String!
    private var _nextEvoName: String!
    private var _nextEvoLvl: String!
    private var _nextEvoMethod: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var type1: String {
        if _type1 == nil {
            _type1 = ""
        }
        return _type1
    }
    
    var type2: String {
        if _type2 == nil {
            _type2 = ""
        }
        return _type2
    }
    
    var desc: String {
        if _desc == nil {
            _desc = ""
        }
        return _desc.stringByReplacingOccurrencesOfString("POKMON", withString: "pokemon")
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        } else {
            if let h = Double(_height) {
                _height = "\(h / 10)m"
            }
        }
        
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        } else {
            if let w = Double(_weight) {
                _weight = "\(w / 10)kg"
            }
        }
        
        return _weight
    }
    
    var pokemonUrl: String {
        if _pokemonUrl == nil {
            _pokemonUrl = ""
        }
        return _pokemonUrl
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    var nextEvoMethod: String {
        if _nextEvoMethod == nil {
            _nextEvoMethod = ""
        }
        return _nextEvoMethod
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func setType1(type1: String) {
        _type1 = type1
    }
    
    func setType2(type2: String) {
        _type2 = type2
    }
    
    func downloadPokemonInfo(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
            
                // MARK: - Weight and height
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                // MARK: - Pokemon types
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    
                    self._type1 = types[0]["name"]
                    
                    if types.count > 1 {
                        self._type2 = types[1]["name"]
                    }
                }
                
                // MARK: - Description
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] {
                    
                    if let url = descArr[descArr.count - 1]["resource_uri"] {
                        let descUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, descUrl).responseJSON { response in
                            
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._desc = description
                                }
                            }
                            completed()
                        }
                    }
                }
                
                // MARK: - Evolutions
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String where to.rangeOfString("mega") == nil {
                        
                        if let url = evolutions[0]["resource_uri"] as? String {
                            
                            let evoId = url.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString: "")
                            
                            self._nextEvoId = evoId.stringByReplacingOccurrencesOfString("/", withString: "")
                            
                            self._nextEvoName = to
                            
                            if let lvl = evolutions[0]["level"] as? Int {
                                self._nextEvoLvl = "\(lvl)"
                            }
                        }
                        
                        if let method = evolutions[0]["method"] as? String {
                            self._nextEvoMethod = method
                        }
                    }
                }
            }
            completed()
        }
    }
}