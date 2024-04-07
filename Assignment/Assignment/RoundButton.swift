import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var corner: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = corner
        }
    }
    
    @IBInspectable var border: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = border
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
