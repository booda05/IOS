//
//  Catalogue.swift
//  AéroportsDuMonde
//
//  Classe chargeant les données d'aéroports du fichier de données airports.txt
//  et transformant chaque ligne de ce fichier en une instance de Aéroport.
//
//  Created by Marco Lavoie on 2015-09-28.
//  Copyright (c) 2015 Marco Lavoie. All rights reserved.
//

import Foundation

// Classe chargeant les données d'aéroports du fichier de données airports.txt
// et transformant chaque ligne de ce fichier en une instance de Aéroport.
public class Catalogue {
    // Liste des aéroports chargée du fichier airports.txt
    private var _aéroports = [Aeroport]()
    
    // Getter indexé permettant d'accéder au contenu de _aéroports
    public subscript(index: Int) -> Aeroport {
        get {
            return _aéroports[index]
        }
    }
    
    // Getter retournant le nombre d'aéroports dans _aéroports
    public var compte: Int {
        get {
            return _aéroports.count
        }
    }
    
    // Initialiseur utilisant le fichier airports.txt pour initialiser son attribut
    // _aéroports à un tableau d'instances de Aéroport
    init() {
        // Déterminer le chemin complet au fichier de données
        if let fileRoot = Bundle.main.path(forResource: "airports", ofType: "txt") {
            // Lire le contenu du fichier de données dans un NSString
            if let contenu = try? String(contentsOfFile: fileRoot) {
                // Splitter la grande chaîne en lignes, une par aéroport
                let lignes = contenu.components(separatedBy: "\r\n")
                
                // Pour chaque ligne du fichier, créer une instance de Aéroport initialisée
                for ligne in lignes {
                    _aéroports.append(Aeroport(ligne: ligne))
                }
            }
        }
        
        // Éliminer tous les aéroports sans code attribué.
        _aéroports.removeAll(where: {$0.code == ""})
        
        // Trier les aéroports par code.
        _aéroports.sort {
            $0.code < $1.code
        }
    }
    
    // Supprime de self l'aéroport dont le numéro OpenFlights correspond à celui fourni en paramètre
    public func supprimerAéroport(identification: Int) {
        // Premièrement, trouver l'index de l'aéroport dans self, selon le numéro d'identification
        var idx = 0, cibleIdx = -1
        for aéroport in _aéroports {
            if aéroport.identification == identification {
                cibleIdx = idx
                break;
            }
            idx += 1
        }
        
        // Si on a trouvé la cible dans le catalogue, on l'y retire
        if cibleIdx >= 0 {
            _aéroports.remove(at: cibleIdx)
        }
    }
}

