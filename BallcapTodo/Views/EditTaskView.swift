//
//  EditTaskView.swift
//  BallcapTodo
//
//  Created by 藤井陽介 on 2020/05/19.
//  Copyright © 2020 touyou. All rights reserved.
//

import SwiftUI

struct EditTaskView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var task: Task

    var body: some View {
        NavigationView {
            TextField("新しいタスク", text: self.$task[\.title])
                .navigationBarTitle("新しいタスク")
                .navigationBarItems(trailing: Button("保存") {
                    self.task.save()
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(task: Task())
    }
}
