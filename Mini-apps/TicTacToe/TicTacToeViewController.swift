import UIKit

enum Player {
    case playerX
    case playerO
}

final class TicTacToeViewController: UIViewController, TicTacToeModelDelegate {
    private var model: TicTacToeModel = TicTacToeModel()
    private var board: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        model.delegate = self
        setUpBoard()
    }
    
    
    func setUpBoard() {
        let gridSize = 3
        let buttonSize: CGFloat = view.bounds.width / CGFloat(gridSize)
        
        for row in 0..<gridSize {
            for col in 0..<gridSize {
                let button = UIButton(type: .system)
                button.frame = CGRect(x: CGFloat(col) * buttonSize,
                                      y: CGFloat(CGFloat(row) * buttonSize) + 250,
                                      width: buttonSize, height: buttonSize)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.black.cgColor
                button.setTitle("", for: .normal)
                button.tag = row * gridSize + col
                
                button.addTarget(self, action: #selector(cellTapped(_:)), for: .touchUpInside)
                board.append(button)
                view.addSubview(button)
            }
        }
    }
    
    @objc func cellTapped(_ sender: UIButton) {
        let index = sender.tag
        
        if model.makeMove(at: index) {
            updateBoard(at: index)
            model.evaluateGameState()
        }
    }
    
    func updateBoard(at index: Int) {
        let currentPlayer = model.currentPlayer
        let button = board[index]
        
        if currentPlayer == .playerX {
            button.setTitle("X", for: .normal)
            button.tintColor = .blue
        } else {
            button.setTitle("O", for: .normal)
            button.tintColor = .red
        }
    }
    
    func gameDidEnd(with winner: Player?) {
        let message: String
        if let winner = winner {
            message = "\(winner == .playerX ? "1 игрок" : "2 игрок") выиграл!"
        } else {
            message = "Ничья!"
        }
        showAlert(message)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Новая игра", style: .default, handler: { _ in
            self.resetGame()
        }))
        present(alert, animated: true)
    }
    
    func resetGame() {
        model.resetGame()
        for button in board {
            button.setTitle("", for: .normal)
        }
    }
}
