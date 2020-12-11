//
//  LabelView.swift
//  AutoLayoutLabels
//
//  Created by Makeeyaf on 2020/12/11.
//

import UIKit

import SnapKit

class LabelView: UIView {

    // MARK: Views

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .darkText
        view.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        return view
    }()

    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .lightGray
        view.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        return view
    }()

    lazy var labelStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
        ])
        view.axis = .vertical
        return view
    }()

    // MARK: Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func addViews() {
        addSubview(labelStack)
    }

    private func setConstraints() {
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)
        labelStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
