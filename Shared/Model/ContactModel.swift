//
//  ContactModel.swift
//  iOSEksamen
//
//  Created by Ole Jørgen Bakken on 26/02/2022.
//

import Contacts

struct Contact: Identifiable {
    var id: String {contact.identifier }
    
    //Basics
    var fornavn: String {contact.givenName }
    var mellomnavn: String {contact.middleName}
    var etternavn: String {contact.familyName }
    var alder: Int? {
        if(contact.birthday?.year != nil) {
            return Calendar.current.dateComponents([.year], from: contact.birthday?.date ?? Date.now, to: Date()).year
        } else {
            return nil
        }
    }
    var bursdag: DateComponents? { contact.birthday }
    
    // Kontaktinformasjon
    var mail: [String]? {contact.emailAddresses.map{$0.value.description}}
    var mobilnummer: [String]? {contact.phoneNumbers.map{$0.value.stringValue}}
    
    // Adresse
    var adresser: [CNLabeledValue<CNPostalAddress>]? {contact.postalAddresses}
    
    // Annet
    var nettsider: [String]? {contact.urlAddresses.map{$0.value.description}}
    var isFavorite: Bool = false
    
    var contact: CNContact
    
    static func fetchAll(_ completion: @escaping(Result<[Contact], Error>) -> Void) {
        let containerID = CNContactStore().defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerID)
        let descriptior =
            [
                CNContactIdentifierKey,
                CNContactGivenNameKey,
                CNContactMiddleNameKey,
                CNContactFamilyNameKey,
                CNContactBirthdayKey,
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey,
                CNContactPostalAddressesKey,
                CNContactUrlAddressesKey,
            ]
        as [CNKeyDescriptor]
        do {
            let rawContacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: descriptior)
            completion(.success(rawContacts.map{.init(contact: $0)}))
        } catch {
            completion(.failure(error))
        }
    }
}

enum PermissionError: Identifiable {
    var id: String {UUID().uuidString}
    case userError
    case fetchError(_: Error)
    var description: String {
        switch self {
        case .userError:
            return "Gi tilgang til kontakter i iPhone innstillinger"
        case .fetchError(let error):
            return error.localizedDescription
        }
    }
    
}
