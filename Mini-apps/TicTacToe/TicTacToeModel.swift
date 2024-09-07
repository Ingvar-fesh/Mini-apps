import UIKit

protocol TicTacToeModelDelegate: AnyObject {
    func gameDidEnd(with winner: Player?)
}

final class TicTacToeModel {
    private(set) var currentPlayer: Player = .playerX
    private var boardState: [Player?] = Array(repeating: nil, count: 9)
    
    weak var delegate: TicTacToeModelDelegate?
    
    func resetGame() {
        currentPlayer = .playerX
        boardState = Array(repeating: nil, count: 9)
    }
    
    func makeMove(at index: Int) -> Bool {
        guard boardState[index] == nil else { return false }
        boardState[index] = currentPlayer
        return true
    }
    
    func checkWinCondition() -> Bool {
        let winningCombinations: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]
        
        for combination in winningCombinations {
            if combination.allSatisfy({ boardState[$0] == currentPlayer }) {
                return true
            }
        }
        
        return false
    }
    
    func checkDrawCondition() -> Bool {
        return boardState.allSatisfy({ $0 != nil })
    }
    
    func switchPlayer() {
        currentPlayer = (currentPlayer == .playerX) ? .playerO : .playerX
    }
    
    func evaluateGameState() {
        if checkWinCondition() {
            delegate?.gameDidEnd(with: currentPlayer)
        } else if checkDrawCondition() {
            delegate?.gameDidEnd(with: nil)
        } else {
            switchPlayer()
        }
    }
}
