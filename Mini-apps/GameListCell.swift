import UIKit

final class AppListCell: UITableViewCell {
    private let appImageView = UIImageView()
    private let overlayView = UIView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setupOverlayView()
        setupTitleLabel()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        appImageView.contentMode = .scaleAspectFill
        appImageView.clipsToBounds = true
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(appImageView)
    }

    private func setupOverlayView() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overlayView)
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            appImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            appImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            appImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with app: App) {
        titleLabel.text = app.title
        if let coverImage = app.coverImage {
            appImageView.image = coverImage
        } else {
            appImageView.image = UIImage(named: "placeholder")
        }
    }
}
