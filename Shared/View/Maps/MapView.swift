//
//  MapView.swift
//  iOSEksamen
//
//  Created by Ole Jørgen Bakken on 26/02/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    let gate: String?
    let fylke: String?
    let postnummer: String?
    let land: String?
    
    @State private var goToNewView: Bool = false
    
    @State var coordString = ""
    
    // Jeg skjønner ikke hvordan jeg får hentet latitude og longitude fra getCoordinates(), men jeg ville hvertfall hentet de ut og ertsattet placeholderkoordinatene
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
    )
    
    var body: some View {
        NavigationLink(destination: MapDetailView(gate: gate, fylke: fylke, postnummer: postnummer, land: land), isActive: self.$goToNewView) { EmptyView() }
        ZStack  {
            Map(coordinateRegion: $region, interactionModes: .zoom)
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    HStack(spacing: 0) {
                        if(gate != ""){
                            Text(gate!)
                        }
                        
                        if(postnummer != ""){
                            Text(", \(postnummer!)")
                        }
                        
                        if(fylke != ""){
                            Text(fylke!)
                        }
                        
                        if(land != ""){
                            Text(land!)
                        }
                    }
                    
                    Text(coordString).onAppear {
                        getCoordinates() { coords in
                            coordString = "\(coords.latitude), \(coords.longitude)"
                        }
                    }
                }
                
                
                
                Spacer()
                
                Button(action: {
                    openMap(Address: "\(gate ?? "") \(postnummer ?? "") \(fylke ?? "") \(land ?? "")".replacingOccurrences(of: " ", with: ","))
                }) {
                    Text("Se på kart").bold()
                        .padding(12.0)
                        .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.systemBackground))
                .foregroundColor(Color(UIColor.label))
                .cornerRadius(8.0)
            }
            .padding(12.0)
        }
        .ignoresSafeArea(.all)
        .onTapGesture{
            self.goToNewView.toggle()
        }
        .frame(height: 200.0)
    }
    
    
    func getCoordinates(handler: @escaping ((CLLocationCoordinate2D) -> Void)) {
        if let gate = gate, let postnummer = postnummer, let fylke = fylke, let land = land {
            let fullAdresse = "\(gate), \(fylke) \(postnummer) \(land)"
            CLGeocoder().geocodeAddressString(fullAdresse) { ( placemark, error ) in
                handler(placemark?.first?.location?.coordinate ?? CLLocationCoordinate2D())
            }
        }
    }
    
    func openMap(Address: String) {
        UIApplication.shared.open(NSURL(string: "http://maps.apple.com?address=\(Address)")! as URL)
    }
}
