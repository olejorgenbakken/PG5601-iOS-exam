//
//  ContactDetailView.swift
//  iOSEksamen
//
//  Created by Ole Jørgen Bakken on 26/02/2022.
//

import SwiftUI
import Contacts

struct ContactDetailView: View {
    @Environment(\.editMode) var editMode
    
    var contact: Contact
    
    var body: some View {
        if editMode?.wrappedValue == .inactive {
            List {
                contactBasicInfoListView(fornavn: contact.fornavn, mellomnavn: contact.mellomnavn, etternavn: contact.etternavn, alder: contact.alder, bursdag: contact.bursdag)
                
                if((contact.mail) != nil && contact.mail!.count > 0) {
                    contactEmailListView(mailadresser: contact.mail!)
                }
                
                if((contact.mobilnummer) != nil && contact.mobilnummer!.count > 0) {
                    contactPhoneNumberListView(mobilnumre: contact.mobilnummer!)
                }
                
                if((contact.adresser) != nil && contact.adresser!.count > 0) {
                    contactAddressListView(adresser: contact.adresser!)
                }
                
                if((contact.nettsider) != nil && contact.nettsider!.count > 0) {
                    contactWebsiteListView(nettsider: contact.nettsider!)
                }
            }
            .navigationTitle(Text("\(contact.fornavn) \(contact.etternavn)"))
            .navigationBarItems(trailing: EditButton())
        } else {
            ContactEditorView(fornavn: Binding.constant(contact.fornavn), mellomnavn: Binding.constant(contact.mellomnavn), etternavn: Binding.constant(contact.etternavn))
                .navigationBarItems(trailing: EditButton())
        }
            
    }
}


struct contactBasicInfoListView: View {
    var fornavn: String?
    var mellomnavn: String?
    var etternavn: String?
    var alder: Int?
    var bursdag: DateComponents?
    
    var body: some View {
        Section(header: Text("Basisinformasjon")) {
            if(fornavn != nil) {
                VStack(alignment: .leading) {
                    Text("Fornavn").font(.caption).foregroundColor(.secondary)
                    Text("\(fornavn!)")
                }.padding(.vertical, 2.0)
            }
            
            if(mellomnavn!.count > 0) {
                VStack(alignment: .leading) {
                    Text("Mellomnavn").font(.caption).foregroundColor(.secondary)
                    Text("\(mellomnavn!)")
                }.padding(.vertical, 2.0)
            }
            
            if(etternavn!.count > 0) {
                VStack(alignment: .leading) {
                    Text("Etternavn").font(.caption).foregroundColor(.secondary)
                    Text("\(etternavn!)")
                }.padding(.vertical, 2.0)
            }
            
            if(alder != nil) {
                VStack(alignment: .leading) {
                    Text("Alder").font(.caption).foregroundColor(.secondary)
                    Text("\(alder!)")
                }.padding(.vertical, 2.0)
            }
            
            if(bursdag != nil) {
                VStack(alignment: .leading) {
                    Text("Bursdag").font(.caption).foregroundColor(.secondary)
                    HStack(spacing: 0.0){
                        Text("\(bursdag!.day!)")
                        Text(".\(bursdag!.month!)")
                        if(bursdag!.year != nil) {
                            Text(".\(bursdag!.year!)")
                        }
                    }
                    
                }.padding(.vertical, 2.0)
            }
        }
    }
}

struct contactEmailListView: View {
    var mailadresser: [String]
    
    var body: some View {
        Section(header: Text("Epost")) {
            ForEach(mailadresser, id: \.self){ adresse in
                Text(adresse).padding(.vertical, 2.0)
            }
        }
    }
}

struct contactPhoneNumberListView: View {
    var mobilnumre: [String]
    
    var body: some View {
        Section(header: Text("Mobil")) {
            ForEach(mobilnumre, id: \.self){ nummer in
                Text(nummer).padding(.vertical, 2.0)
            }
        }
    }
}

struct contactAddressListView: View {
    var adresser: [CNLabeledValue<CNPostalAddress>]
    
    var body: some View {
        Section(header: Text("Steder")) {
            ForEach(adresser, id: \.self){ adresse in
                VStack(alignment: .leading){
                    Text("\(adresse.label!)").font(.caption).foregroundColor(.secondary)
                    
                    MapView(gate: adresse.value.street, fylke: adresse.value.state, postnummer: adresse.value.postalCode, land: adresse.value.country)
                        .cornerRadius(8.0)
                }
                .padding(.vertical, 8.0)
            }
            
            
        }
    }
}

struct contactWebsiteListView: View {
    var nettsider: [String]
    
    var body: some View {
        Section(header: Text("Nettsider")) {
            ForEach(nettsider, id: \.self){ side in
                Text(side)
            }
        }
    }
}
