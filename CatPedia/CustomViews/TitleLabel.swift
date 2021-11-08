

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment:NSTextAlignment,fontsSize:CGFloat,fontWeight:UIFont.Weight) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont(name:"LuxoraGrotesk-Medium", size: fontsSize)
        configure()
    }
    
    private func configure () {
        textColor                 = .black
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.90
        numberOfLines             = 3
        lineBreakMode             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}

