import Foundation

/*
 * Data structures to hold a todo list item. To be used in a collection view the item needs to conform to Hashable
 * protocol which enables the collection view to differentiate between individual items.
 */
struct ToDoListItem: Hashable {
    let id: Int
    let itemText: String
    let completed: Bool
    let type: ToDoListItemType
    let notes: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// The todo list. Each todo list contains multiple todo list items
struct ToDoList {
    let items: [ToDoListItem]
}

enum ToDoListItemType: String {
    case home = "Home"
    case office = "Office"
}
