import SwiftUI
import CoreLocation
import MapKit

extension CLPlacemark {
    var adresse: String {
        let arr = [subThoroughfare, thoroughfare, locality, administrativeArea, country, postalCode]
        return arr.compactMap { $0 }.joined(separator: ", ")
    }
}

struct AeroportView: View {
    var aéroport: Aeroport
    
    let titreLargeur: CGFloat = 80
    
    @State private var adresse: String? = "Chargement de l'adresse..."
    
    var body: some View {
        Form {
            Section("Identification") {
                HStack {
                    VStack(alignment: .trailing) {
                        Text("Nom")
                        Text("Code IATA")
                    }
                    .foregroundColor(.accentColor)
                    .frame(width: titreLargeur, alignment: .trailing)
                    
                    VStack(alignment: .leading) {
                        Text(aéroport.nom)
                            .lineLimit(1)
                        Text(aéroport.code)
                    }
                }
            }
            
            Section("Localisation") {
                HStack {
                    VStack(alignment: .trailing) {
                        Text("Ville")
                        Text("Pays")
                    }
                    .foregroundColor(.accentColor)
                    .frame(width: titreLargeur, alignment: .trailing)
                    
                    VStack(alignment: .leading) {
                        Text(aéroport.ville)
                        Text(aéroport.pays)
                    }
                }
            }
            
            Section("Coordonnées") {
                HStack {
                    VStack(alignment: .trailing) {
                        Text("Latitude")
                        Text("Longitude")
                    }
                    .foregroundColor(.accentColor)
                    .frame(width: titreLargeur, alignment: .trailing)
                    
                    VStack(alignment: .leading) {
                        Text("\(aéroport.latitude)")
                        Text("\(aéroport.longitude)")
                    }
                }
            }

            Section("Adresse Postale") {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(adresse ?? "Adresse non disponible")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button("Ouvrir dans Apple Plan") {
                        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: aéroport.latitude, longitude: aéroport.longitude))
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = aéroport.nom
                        mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapTypeKey: MKMapType.satelliteFlyover.rawValue])
                    }
                }
            }
        }
        .onAppear {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(CLLocation(latitude: aéroport.latitude, longitude: aéroport.longitude)) { placemarks, error in
                if let _ = error {
                    adresse = "Impossible de récupérer l'adresse."
                    return
                }
                guard let placemark = placemarks?.first else {
                    adresse = "Adresse introuvable."
                    return
                }
                adresse = placemark.adresse
            }
        }
        .navigationTitle("Aéroport \(aéroport.code)")
    }
}

struct AeroportView_Previews: PreviewProvider {
    static var previews: some View {
        AeroportView(aéroport: Catalogue()[0])
    }
}
