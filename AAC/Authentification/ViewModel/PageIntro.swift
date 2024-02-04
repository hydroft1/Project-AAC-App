//
//  PageIntro.swift
//  AAC
//
//  Created by Alexandre Marquet on 26/07/2023.
//

import SwiftUI

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var displayAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "first", title: "Enregistrez vos trajets en temps réels"),
    .init(introAssetImage: "second", title: "Consultez vos trajets et exportez les"),
    .init(introAssetImage: "connexion", title: "Connexion", displayAction: true),
]
