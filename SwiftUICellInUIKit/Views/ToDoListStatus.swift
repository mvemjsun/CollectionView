import SwiftUI

/*
 * An image that is displayed based on the status of a todo list item
 */
struct TaskStatus: View {
    var toDoListItem: ToDoListItem
    var body: some View {
        
        if toDoListItem.completed == true {
            Image(systemName: "checkmark.circle")
                .foregroundColor(.green)
        } else {
            Image(systemName: "tray")
                .foregroundColor(.red)
        }
    }
}
