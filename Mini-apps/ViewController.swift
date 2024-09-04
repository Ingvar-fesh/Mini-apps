import UIKit

struct Game {
    let title: String
    let coverImage: UIImage?
}

class ViewController: UIViewController {
    
    let games: [Game] = [
        Game(title: "Крестики-нолики", coverImage: UIImage(named: "TicTacToe")),
        Game(title: "Погода", coverImage: UIImage(named: "Weather")),
        Game(title: "Game 3", coverImage: nil),
        Game(title: "Game 4", coverImage: nil),  // Заглушка
        Game(title: "Game 5", coverImage: nil),  // Заглушка
        Game(title: "Game 6", coverImage: nil),  // Заглушка
        Game(title: "Game 7", coverImage: nil),  // Заглушка
        Game(title: "Game 8", coverImage: nil),  // Заглушка
        Game(title: "Game 9", coverImage: nil),  // Заглушка
        Game(title: "Game 10", coverImage: nil)  // Заглушка
    ]
    
    private lazy var upLabel: UILabel = {
        let label = UILabel()
        label.text = "Мини приложения"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gameList: UITableView = {
        let list = UITableView()
        list.dataSource = self
        list.delegate = self
        list.rowHeight = view.bounds.height / 8
        list.register(GameListCell.self, forCellReuseIdentifier: "GameCell")
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addAllSubviews()
        setConstraints()
    }

    func addAllSubviews() {
        view.addSubview(upLabel)
        view.addSubview(gameList)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            upLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            upLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            gameList.topAnchor.constraint(equalTo: upLabel.bottomAnchor, constant: 20),
            gameList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameList.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameListCell
        let game = games[indexPath.row]
        cell.configure(with: game)
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    
}
