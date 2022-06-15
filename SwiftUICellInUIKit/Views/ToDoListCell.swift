import SwiftUI

/*
 * A Swift UI view to display a todo list item row.
 * This is used inside of a UICollectionViewCell (UIKit)
 */
struct CellView: View {
    var toDoListItem: ToDoListItem
    
    var body: some View {
        Group {
            HStack (alignment: .center) {
                VStack(alignment: .leading) {
                    Text(toDoListItem.itemText)
                        .font(.headline)
                    Text(toDoListItem.notes ?? "")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
                Spacer()
                TaskStatus(toDoListItem: toDoListItem)
            }
            Divider()
        }
        .padding()
    }
}
