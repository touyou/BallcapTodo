//
//  Task.swift
//  
//
//  Created by 藤井陽介 on 2020/05/19.
//

import SwiftUI
import Ballcap
import FirebaseFirestore

final class Task: Object, DataRepresentable, DataListenable, ObservableObject, Identifiable {
    typealias ID = String

    override class var name: String { "tasks" }

    // Taskのデータ構造
    struct Model: Codable, Modelable {
        var title: String = ""
        var due: ServerTimestamp?
    }

    // Cloud FirestoreのField dataを保持
    @Published var data: Task.Model?
    // Cloud FirestoreのField dataの変更を監視
    var listener: ListenerRegistration?
}
