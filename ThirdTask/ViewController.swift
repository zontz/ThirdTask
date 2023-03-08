
import UIKit
import SnapKit

class ViewController: UIViewController {

    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)

    private lazy var squareView: UIView = {
        let squareView = UIView()
        let side = view.frame.width * 0.2
        squareView.frame = CGRect(x: view.layoutMargins.left,
                                  y: 100,
                                  width: side,
                                  height: side)
        squareView.backgroundColor = .systemIndigo
        squareView.layer.cornerRadius = 8
        let endPoint = CGRect(x: view.frame.width - squareView.frame.width * 1.5,
                              y: squareView.frame.origin.y,
                              width: squareView.frame.width,
                              height: squareView.frame.height)

        animator.pausesOnCompletion = true
        animator.addAnimations {
            squareView.frame = endPoint
            squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
        return squareView
    }()

    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: view.layoutMargins.left,
                              y: squareView.frame.width * 1.5 + 120,
                              width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right,
                              height: 20)
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(valueDidChange), for: .valueChanged)
        slider.addTarget(self, action: #selector(touched), for: .touchUpInside)
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                leading: 16,
                                                                bottom: 16,
                                                                trailing: 16)
        view.addSubview(squareView)
        view.addSubview(slider)
        view.backgroundColor = .white
    }


    @objc
    private func valueDidChange(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }

    @objc
    private func touched() {
        if animator.isRunning {
            slider.value = Float(animator.fractionComplete)
        }
        slider.setValue(slider.maximumValue, animated: true)
        animator.startAnimation()
    }
}

