//
//  MyViewController.swift
//  Navigation
//
//  Created by Светлана on 3.10.22.
//

import UIKit

class MyViewController: UIViewController {
    
    // MARK: - Privet properties
    private let squareView = UIView()
    
    private var squareSize: CGFloat = 0
    private var defaultSpacing: CGFloat = 0
    
    private var isFirstLoad = true
    
    private var squareLocation: Location = .center {
        willSet (newLocation) {
            layoutSquare(at: newLocation)
        }
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillLayoutSubviews() {
        if isFirstLoad {
            squareSize = view.frame.width / 4
            defaultSpacing = squareSize / 4
            
            setupSquare()
            view.addSubview(squareView)
            layoutSquare(at: .center)
                
            isFirstLoad = false
        }
    }
    
    // MARK: - Private methods
    private func setupSquare() {
        squareView.backgroundColor = .systemBlue
        squareView.frame = CGRect(
            x: getOriginX(for: .center),
            y: (view.frame.size.height - squareSize) / 2,
            width: squareSize,
            height: squareSize
        )
        
        addSwipeGesture(to: squareView, direction: .left)
        addSwipeGesture(to: squareView, direction: .right)
    }
    
    private func layoutSquare(at location: Location) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.squareView.frame.origin.x = self.getOriginX(for: location)
        }
    }
    
    private func getOriginX(for location: Location) -> CGFloat {
        switch location {
        case .left:
            return defaultSpacing
        case .center:
            return defaultSpacing * 2 + squareSize
        case .right:
            return defaultSpacing * 3 + squareSize * 2
        }
    }
    
    private func addSwipeGesture(to view: UIView, direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveSquare))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private
    func moveSquare(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        switch gestureRecognizer.direction {
        case .left:
            if squareLocation == .center { squareLocation = .left }
            if squareLocation == .right { squareLocation = .center}
        case .right:
            if squareLocation == .center { squareLocation = .right }
            if squareLocation == .left { squareLocation = .center}
        default:
            return
        }
    }
}
