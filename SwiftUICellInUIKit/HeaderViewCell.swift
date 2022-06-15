import UIKit

/*
 A cell using UIKit that is used to display the collection view supplementary view (Header)
 This displays the section title
 */
final class HeaderViewCell: UICollectionReusableView {
    static let reuseIdentifier = "ui-kit-cell"
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    lazy var containerView: UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(baseView)
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            baseView.topAnchor.constraint(equalTo: self.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        baseView.addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            title.topAnchor.constraint(equalTo: baseView.topAnchor)
        ])

        return baseView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func configure() {
        _ = containerView
    }
}
