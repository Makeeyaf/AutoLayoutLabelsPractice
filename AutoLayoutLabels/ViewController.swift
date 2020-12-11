//
//  ViewController.swift
//  AutoLayoutLabels
//
//  Created by Makeeyaf on 2020/12/11.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    var heightConstraint: Constraint?
    var widthConstraint: Constraint?

    lazy var labelView: LabelView = {
        let view = LabelView()
        view.titleLabel.text = "미스터 켄트 백의 77가지 구현 패턴"
        view.subtitleLabel.text = "읽기 쉬운 코드를 작성하는 77가지 자바 코딩 비법"
        return view
    }()

    lazy var heightSlider: UISlider = {
        let view = UISlider()
        view.isContinuous = true
        view.maximumValue = 100
        view.minimumValue = 0
        view.value = 100
        view.addTarget(self, action: #selector(heightSliderDidChange), for: .valueChanged)

        return view
    }()

    lazy var widthSlider: UISlider = {
        let view = UISlider()
        view.isContinuous = true
        view.maximumValue = 300
        view.minimumValue = 50
        view.value = 300
        view.addTarget(self, action: #selector(widthSliderDidChange), for: .valueChanged)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setConstraints()
    }

    private func addViews() {
        [labelView, heightSlider, widthSlider].forEach {
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        labelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            widthConstraint = $0.width.equalTo(0).constraint
            widthConstraint?.update(offset: widthSlider.value)
            heightConstraint = $0.height.lessThanOrEqualTo(0).constraint
            heightConstraint?.update(offset: heightSlider.value)
        }

        heightSlider.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.layoutMarginsGuide)
        }

        widthSlider.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.layoutMarginsGuide)
        }

    }

    // MARK: Actions

    @objc private func heightSliderDidChange() {
        heightConstraint?.update(offset: heightSlider.value)
    }

    @objc private func widthSliderDidChange() {
        widthConstraint?.update(offset: widthSlider.value)
    }
}

