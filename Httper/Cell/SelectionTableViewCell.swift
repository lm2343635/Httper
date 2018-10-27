//
//  SelectionTableViewCell.swift
//  Httper
//
//  Created by Meng Li on 2018/10/25.
//  Copyright © 2018 limeng. All rights reserved.
//

import UIKit
import Reusable

fileprivate struct Const {
    static let margin = 17
}

struct Selection {
    var icon: UIImage?
    var title: String
}

class SelectionTableViewCell: UITableViewCell, Reusable {
    
    private lazy var iconImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createConstraints() {
        iconImageView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(Const.margin)
            $0.bottom.equalToSuperview().offset(-Const.margin)
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconImageView.snp.right).offset(Const.margin)
            $0.right.equalToSuperview().offset(-Const.margin)
        }
    }

    var selection: Selection? {
        didSet {
            guard let selection = selection else {
                return
            }
            iconImageView.image = selection.icon
            titleLabel.text = selection.title
        }
    }
    
}