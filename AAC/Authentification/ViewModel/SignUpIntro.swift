//
//  SignUpIntro.swift
//  AAC
//
//  Created by Alexandre Marquet on 26/07/2023.
//

import SwiftUI

struct SignUpIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String?
    var textField: String?
    var confirmField: String?
    var passwordField: Bool = false
    var displayAction: Bool = false
}

var SignUpIntros: [SignUpIntro] = [
    .init(introAssetImage: "1", textField: "Votre Prénom", confirmField: "Votre Nom"),
    .init(introAssetImage: "2", textField: "Votre adresse mail", confirmField: "Confirmer Votre adresse mail"),
    .init(introAssetImage: "3", textField: "Votre mot de passe", confirmField: "Confirmer Votre mot de passe", passwordField: true),
    .init(introAssetImage: "4", title: "C'est Parfait pour Nous",displayAction: true),
]
