//
//  ContentView.swift
//  Shared
//
//  Created by Ole Jørgen Bakken on 26/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showFavoritesOnly = false
    
    @StateObject
    private var contactsVM = ContactsViewModel()
    
    var filteredContacts: [Contact] {
        contactsVM.contacts.filter { contact in
            (!showFavoritesOnly || contact.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Vis kun favoritter")
                }
                
                // Hele denne seksjonen med favoritter er jo litt tenkt siden jeg ikke får til å redigere kontakter,
                // men om jeg hadde fått swipeactions til å endre det ville de endt opp her!
                favoriteContactsView(contacts: filteredContacts)
                
                // Her kommer alle kontakter.
                allContactsView(contacts: contactsVM.contacts)
            }
            .navigationTitle("Kontakter")
            
            // Jeg får ikke til å legge til kontakter til mobilen. Jeg får read-only problemer på samme måte som
            // når jeg prøver å redigere. Jeg har googlet og googlet og jeg syns dokumentasjonen til Apple om emnet,
            // som er lagt ved, jeg veldig lite informativ dessverre. Her er hvertfall hvor det skulle kommet et view
            // hvor man legger til informasjonen.
            .navigationBarItems(trailing:
                Button(action: {
                    print("Legg til kontakt")
                }) {
                    Image(systemName: "plus").imageScale(.large)
                    Text("Ny kontakt")
                    
                }
            )
        }
        .alert(item: $contactsVM.permissionsError) { _ in
            Alert(
                title: Text("Har ikke tilgang til kontakter"),
                message: Text(contactsVM.permissionsError?.description ?? "ukjent feil"),
                dismissButton:
                        .default(Text("OK"),
                                 action: {contactsVM.openSettings()})
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct favoriteContactsView: View {
    var contacts: [Contact]
    
    var body: some View {
        Section(header: Text("Favoritter")) {
            ForEach(contacts) { contact in
                if(contact.isFavorite) {
                    contactListItemView(contact: contact)
                }
            }
        }
    }
}

struct allContactsView: View {
    var contacts: [Contact]
    
    var body: some View {
        Section(header: Text("Alle kontakter")) {
            ForEach(contacts) { contact in
                contactListItemView(contact: contact)
            }
        }
    }
}

struct contactListItemView: View {
    var contact: Contact
    
    var body: some View {
        NavigationLink(destination: ContactDetailView(contact: contact)) {
            HStack{
                VStack(alignment: .leading) {
                    Text("\(contact.fornavn) \(contact.etternavn)").bold()
                    
                    if(contact.alder != nil) {
                        Text("Alder: \(contact.alder!)").foregroundColor(.secondary)
                    }
                    
                    if(contact.mobilnummer != nil && contact.mobilnummer!.count > 0) {
                        Text("Mobilnummer: \(contact.mobilnummer!.first!)")
                    }
                }
                if(contact.isFavorite) {
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.vertical, 8.0)
        }
        
        .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
            Button {
                print("Gjør til favoritt")
            } label: {
                Label("Favoritt", systemImage: "star.fill")
                
            }.tint(.yellow)
        })
    }
}
