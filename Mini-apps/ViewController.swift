import UIKit

struct App {
    let title: String
    let coverImage: UIImage?
}

class ViewController: UIViewController {
    
    private let games: [App] = [
        App(title: "Крестики-нолики", coverImage: UIImage(named: "TicTacToe")),
        App(title: "Погода", coverImage: UIImage(named: "Weather")),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil),
        App(title: "В разработке", coverImage: nil)
    ]
    
    private lazy var gameList: UITableView = {
        let list = UITableView()
        list.dataSource = self
        list.delegate = self
        list.rowHeight = view.bounds.height / 8
        list.register(AppListCell.self, forCellReuseIdentifier: "AppCell")
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Мини приложения"
        
        addAllSubviews()
        setConstraints()
    }

    func addAllSubviews() {
        view.addSubview(gameList)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            gameList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        let cell = gameList.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppListCell
        let game = games[indexPath.row]
        cell.configure(with: game)
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = games[indexPath.row]

        if selectedGame.title == "Крестики-нолики" {
            let ticTacToeVC = TicTacToeViewController()
            navigationController?.pushViewController(ticTacToeVC, animated: true)
        } else if selectedGame.title == "Погода" {
            let weatherVC = WeatherViewController()
            navigationController?.pushViewController(weatherVC, animated: true)
        }

        // Делаем deselect выбранной ячейки, чтобы убрать выделение
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
