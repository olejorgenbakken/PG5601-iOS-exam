# Eksamen i iOS
En relativt enkel oppgave i iOS gjort over en helg.

## Oppgaveliste
### Oppgave 1 - Vis kontakter
- [x] Be om tilgang til å vise kontakter som er lagret på telefonen.
- [x] Vis en liste med alle kontakter på telefonen.
- [x] Hvert listeelement skal inneholde fullt navn, telefonnummer og alder.
- [x] Hvis brukeren ikke godtar å gi tilgang til kontakter så skal det vises en infoside som
forteller hvordan brukeren kan gå til settings-appen for å gi tilgang. Om brukeren gir tilgang til kontakter så skal infosiden forsvinne og appen fungere som normalt.

### Oppgave 2 - Detaljvisning av en kontakt
- [x] Når bruker trykker på et av listeelementene så skal det åpnes en detaljvisning for den kontakten.
- [x] Detaljesiden skal vise fullt navn, eposter, adresse, bursdag, alder, nettsider.
- [x] Feltene skal markeres med tittel, slik at det for eksempel står E-post: [Brukerens epost]
- [x] Implementer en “vis på kart”-knapp som tar åpner en egen side i appen med et kart som
viser adressen til kontakten.


### Oppgave 3 - Legg til kontakt
- [ ] Legg til en knapp i navbar som åpner en ny side der en kan legge til en ny kontakt
- [ ] Bruker skal kunne fylle inn navn, epost, bursdag og bilde.
- [ ] Bildet skal kunne velges fra bilde-biblioteket på telefonen.
- [ ] Når en trykker lagre, skal denne brukeren lagres i kontaktlisten på mobilen, og dermed
også dukke opp i listevisningen i appen.


### Oppgave 4 - Seksjoner
- [ ] Lista med kontakter skal ha seksjoner basert på bokstav, slik at alle kontakter med etternavn som begynner på a er i a-seksjonen, etternavn som begynner på b er i b-seksjonen også videre.
- [x] Legg til mulighet for å sette en kontakt som favoritt. Kontakter som er favoritt skal ligge i en egen favoritter-seksjon øverst i lista.
- [ ] Hvilke kontakter som er favoritter skal persisteres sånn at de lagres mellom kjøringer av appen
