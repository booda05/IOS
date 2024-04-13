//
//  Aéroport.swift
//  AéroportsDuMonde
//
//  Classe stockant les données relatives à un aéroport.
//
//  Created by Marco Lavoie on 2015-09-28.
//  Copyright (c) 2015 Marco Lavoie. All rights reserved.
//

import Foundation
import CoreLocation

// Fonction étendant la classe String en lui ajoutant une fonction membre permettant
// de remplacer toutes les occurrences d'une chaîne par une autre dans celle-ci
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: .literal, range: nil)
    }
}

// Classe stockant les données relatives à un aéroport.
public class Aeroport {
    // Numéro d'identification OpenFlights
    private var _identification: Int
    public var identification: Int {
        get {
            return _identification
        }
    }
    
    // Nom de l'aéroport
    private var _nom: String
    public var nom: String {
        get {
            return _nom
        }
    }
    
    // Code IATA ou FAA
    private var _code: String
    public var code: String {
        get {
            return _code
        }
    }
    
    // Ville où est située l'aéroport
    private var _ville: String
    public var ville: String {
        get {
            return _ville
        }
    }
    
    // Pays où est située l'aéroport
    private var _pays: String
    public var pays: String {
        get {
            return _pays
        }
    }
    
    // Longitude de géolocalisation de l'aéroport
    private var _longitude: Double
    public var longitude: Double {
        get {
            return _longitude
        }
    }
    
    // Latitude de géolocalisation de l'aéroport
    private var _latitude: Double
    public var latitude: Double {
        get {
            return _latitude
        }
    }
    
    public var location: CLLocation {
        get {
            return CLLocation(latitude: _latitude, longitude: _longitude)
        }
    }
    
    // Initialiseur paramétré avec la ligne de données contenant toutes les données relatives
    // à un aéroport. Notez que l'initialiseur exploite une fonction d'extension de String
    // car plusieurs champs sont englobés dans des guillemets doubles (voir le fichier d'où
    // sont obtenues ces données).
    init (ligne: String) {
        // Décomposer la ligne de données en champs (un champ par donnée)
        let champs = ligne.components(separatedBy: ",")
        
        // Extraire le numéro d'identification OpenFlights
        _identification = Int(champs[0])!
        
        // Extraire le code IATA/FAA. Si aucun code n'est fourni, essayer le code ICAO
        _code = champs[4].replace(target: "\"", withString: "")
        if _code.isEmpty {
            _code = champs[5].replace(target: "\"", withString: "")
        }
        
        // Extraire les données générales
        _nom = champs[1].replace(target: "\"", withString: "")
        _ville = champs[2].replace(target: "\"", withString: "")
        _pays = champs[3].replace(target: "\"", withString: "")
        
        // Extraire les données de géolocalisation
        _latitude = (champs[6] as NSString).doubleValue
        _longitude = (champs[7] as NSString).doubleValue
    }
}

