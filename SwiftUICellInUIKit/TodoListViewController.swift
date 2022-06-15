import UIKit
import SwiftUI

class TodoListViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
    var dataSource: UICollectionViewDiffableDataSource<ToDoListItemType, ToDoListItem>?
    var toDoList: [ToDoListItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCollectionViewDataSource()
        populateCollectionViewDataSource()
    }
    
    // Insert a collection view into the view controller and center it inside the view controller.
    // Register a cell of type HeaderViewCell to be used as a supplementary view in the collection view
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        collectionView.register(
            HeaderViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderViewCell.reuseIdentifier
        )
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    /// Modern collection view work with UICollectionViewDiffableDataSource that have a section and and items within those sections
    ///
    /// To connect a diffable data source to a collection view, you create the diffable data source using its
    /// init(collectionView:cellProvider:) initialiser, passing in the collection view you want to associate with that data source.
    /// You also pass in a cell provider, where you configure each of your cells to determine how to display your data in the UI.
    private func setupCollectionViewDataSource() {
        
        /// Create a cell registration of type UICollectionViewCell with `ToDoListItem` that will be used to provide the collection view cells.
        /// This will
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ToDoListItem> { cell, indexPath, item in
            cell.contentConfiguration = UIHostingConfiguration {
                CellView(toDoListItem: item)
            }
        }
        
        /// Create a datasource and connect it to  collection view `collectionView`
        dataSource = UICollectionViewDiffableDataSource<ToDoListItemType, ToDoListItem>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: ToDoListItem) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            
            return cell
        }
        
        /// provide a supplementary view provider for the collection view. This will serve the header view cell
        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader,
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as? HeaderViewCell {
                if kind == UICollectionView.elementKindSectionHeader {
                    headerView.title.text = indexPath.section == 0 ? "Home" : "Office"
                    return headerView
                }
            }
            return nil
        }
    }
    
    /// Apply snapshot to data source
    private func populateCollectionViewDataSource() {
        let toDoListHome: [ToDoListItem] = fetchHomeToDoList()
        let toDoListOffice: [ToDoListItem] = fetchOfficeToDoList()
        
        var snapshot = NSDiffableDataSourceSnapshot<ToDoListItemType, ToDoListItem>()
        snapshot.appendSections([.home, .office])
        snapshot.appendItems(toDoListHome, toSection: .home)
        snapshot.appendItems(toDoListOffice, toSection: .office)
        dataSource?.apply(snapshot)
    }
    
    /// set a layout for collection view section
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { _, environment -> NSCollectionLayoutSection? in
            
            /// Item spans the width and height of the group
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            /// Group spans the entire section and has an absolute height of 60
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            /// Set the section with the group
            let section = NSCollectionLayoutSection(group: group)

            
            /// Header size
            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60)
            )
            /// Header item
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0)
            
            /// Set header item
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
            
        }
        return layout
    }
}

extension TodoListViewController {
    func fetchHomeToDoList() -> [ToDoListItem] {
        return [
            ToDoListItem(id: 1, itemText: "Shopping", completed: false, type: .home, notes: "Milk, Salt, Eggs"),
            ToDoListItem(id: 2, itemText: "Gardening", completed: true, type: .home, notes: "Water plants, weeding, prune"),
            ToDoListItem(id: 3, itemText: "Kids Homework", completed: false, type: .home, notes: "Maths"),
            ToDoListItem(id: 4, itemText: "Prepare Barbeque", completed: false, type: .home, notes: "Corn, Pepper, Chicken"),
            ToDoListItem(id: 5, itemText: "Holidays", completed: false, type: .home, notes: "Tickets, packing"),
            ToDoListItem(id: 6, itemText: "Birthday", completed: false, type: .home, notes: "Cake, Guest list")
        ]
    }
    
    func fetchOfficeToDoList() -> [ToDoListItem] {
        return [
            ToDoListItem(id: 11, itemText: "Clean desk", completed: true, type: .office, notes: "Covid safe desk !"),
            ToDoListItem(id: 12, itemText: "Complete Spreadsheet", completed: false, type: .office, notes: "Section 1,4 need recalculation"),
            ToDoListItem(id: 13, itemText: "Print report", completed: false, type: .office, notes: "A4 sheets"),
            ToDoListItem(id: 14, itemText: "Meeting", completed: true, type: .office, notes: "Room 4.1 with Matt"),
            ToDoListItem(id: 15, itemText: "Place order", completed: true, type: .office, notes: "Note pads, pens, markers"),
            ToDoListItem(id: 16, itemText: "Team day out", completed: true, type: .office, notes: "Organise, find place"),
            ToDoListItem(id: 17, itemText: "Release test", completed: true, type: .office, notes: "Release notes")
        ]
    }
}

