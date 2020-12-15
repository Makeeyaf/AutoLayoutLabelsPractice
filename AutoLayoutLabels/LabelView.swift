//
//  LabelView.swift
//  AutoLayoutLabels
//
//  Created by Makeeyaf on 2020/12/11.
//

import UIKit

import SnapKit

struct LabelData {
    var text: String?
    var font: UIFont
    var textColor: UIColor
}

protocol LabelViewData {
    var titleLabelData: LabelData { get }
    var subtitleLabelData: LabelData { get }
}

class LabelView: UIView {

    var heightConstraint: Constraint?

    // MARK: Views

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        return view
    }()

    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.1)
        return view
    }()

    private lazy var labelStack: UIStackView = {
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
            heightConstraint = $0.height.lessThanOrEqualTo(0).constraint
        }
    }

    func render(with data: LabelViewData) {
        titleLabel.text = data.titleLabelData.text
        titleLabel.font = data.titleLabelData.font
        titleLabel.textColor = data.titleLabelData.textColor

        subtitleLabel.text = data.subtitleLabelData.text
        subtitleLabel.font = data.subtitleLabelData.font
        subtitleLabel.textColor = data.subtitleLabelData.textColor

        let t = titleLabel.font.lineHeight
        let s = subtitleLabel.font.lineHeight

        let offset = max(2 * t + s, t + 2 * s)

        heightConstraint?.update(offset: offset)
    }
}
