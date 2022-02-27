//
//  ContactEditor.swift
//  iOSEksamen
//
//  Created by Ole Jørgen Bakken on 27/02/2022.
//

import SwiftUI

struct ContactEditorView: View {
    
    // Jeg får ikke til at redigeringen er persistent,
    // men her er noen eksempler på hvordan det kan gjøres for å kunne redigere.
    @Binding var fornavn: String
    @Binding var mellomnavn: String
    @Binding var etternavn: String
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 2.0) {
                Text("Fornavn").font(.caption).foregroundColor(.secondary)
                TextField("", text: $fornavn)
                .padding(.vertical, 2.0)
            }
            .padding(.vertical, 2.0)
            
            VStack(alignment: .leading, spacing: 2.0) {
                Text("Mellomnavn").font(.caption).foregroundColor(.secondary)
                TextField("", text: $mellomnavn)
                .padding(.vertical, 2.0)
            }
            .padding(.vertical, 2.0)
            
            VStack(alignment: .leading, spacing: 2.0) {
                Text("Etternavn").font(.caption).foregroundColor(.secondary)
                TextField("", text: $etternavn)
                    .padding(.vertical, 2.0)
            }
            .padding(.vertical, 2.0)
            
        }
    }
}
