//
//  TaskListView.swift
//  BallcapTodo
//
//  Created by 藤井陽介 on 2020/05/19.
//  Copyright © 2020 touyou. All rights reserved.
//

import SwiftUI
import Ballcap
import FirebaseFirestore

struct TaskListView: View {

    enum Presentation: View, Hashable, Identifiable {
        typealias ID = Presentation

        case new
        case edit(task: Task)
        var body: some View {
            switch self {
            case .new: return AnyView(EditTaskView(task: Task()))
            case .edit(let task): return AnyView(EditTaskView(task: task))
            }
        }

        var id: Presentation { self }
    }

    @State var presentation: Presentation?

    @State var tasks: [Task] = []

    let dataSource: DataSource<Task> = Task
        .order(by: "updatedAt")
        .limit(to: 30)
        .dataSource()

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.id) { task in
                    VStack {
                        Text(task[\.title])
                    }
                    .contextMenu {
                        Button("完了") {
                            task[\.isCompleted] = true
                            task.update()
                        }
                        Button("編集") {
                            self.presentation = .edit(task: task.copy())
                        }
                        Button("削除") {
                            task.delete()
                        }
                    }
                }
            }
            .onAppear {
                self.dataSource
                    .retrieve(from: { (_, snapshot, done) in
                        let task: Task = try! Task(snapshot: snapshot)
                        done(task)
                    })
                    .onChanged({(_, snapshot) in
                        self.tasks = snapshot.after
                    })
                    .listen()
            }
            .sheet(item: self.$presentation) { $0 }
            .navigationBarTitle("Todo")
            .navigationBarItems(trailing: Button("追加") {
                self.presentation = .new
            })
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
