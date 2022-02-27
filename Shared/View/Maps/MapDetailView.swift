//
//  MapDetailView.swift
//  iOSEksamen
//
//  Created by Ole Jørgen Bakken on 27/02/2022.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    let gate: String?
    let fylke: String?
    let postnummer: String?
    let land: String?
    
    // Igjen har jeg lagt inn noen placeholder koordinater for å vise forskjell på viewsene,
    // men jeg skjønner som sagt ikke hvordan jeg oppdaterer de...
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.0, longitude: 10.0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Button(action: {
                    openMap(Address: "\(gate ?? "") \(postnummer ?? "") \(fylke ?? "") \(land ?? "")".replacingOccurrences(of: " ", with: ","))
                }) {
                    Text("Åpne i Apple Maps").bold()
                        .padding(14.0)
                        .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.systemBackground))
                .foregroundColor(Color(UIColor.label))
                .cornerRadius(8.0)
            }
            .padding(40.0)
        }
        .navigationTitle(Text("\(gate!)"))
    }
    
    func openMap(Address: String) {
        UIApplication.shared.open(NSURL(string: "http://maps.apple.com?address=\(Address)")! as URL)
    }
}

struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView(gate: "gate", fylke: "fylke", postnummer: "postnummer", land: "land")
    }
}
