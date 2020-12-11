//
//  ViewController.swift
//  AutoLayoutLabels
//
//  Created by Makeeyaf on 2020/12/11.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    var manualHeightConstraint: Constraint?
    var manualWidthConstraint: Constraint?
    var autoWidthConstraint: Constraint?

    var titleTextIndex: Int = 0
    var subtitleTextIndex: Int = 0

    let testTitleTexts: [String] = [
        "미스터 켄트 백의 77가지 구현 패턴",
        "최신 선물을 구할 수 있는 마지막 기회.",
        "새로운 파워. 어마무시한 가능성 👍",
        "사운드 문제에 대한 AirPods Pro 서비스 프로그램",
    ]

    let testSubtitleTexts: [String] = [
        "읽기 쉬운 코드를 작성하는 77가지 자바 코딩 비법",
        "쇼핑 중에는 언제든지 스페셜리스트의 도움을 받을 수도 있죠.",
        "데스크탑의 능력을 완전히 새로운 차원으로 끌어올려줍니다.",
        "사운드 문제가 발생할 수 있음을 확인했습니다. 🤷‍♂️",
    ]

    // MARK: Views

    lazy var manualLabelView: LabelView = {
        let view = LabelView()
        view.titleLabel.text = testTitleTexts[titleTextIndex]
        view.subtitleLabel.text = testSubtitleTexts[subtitleTextIndex]
        return view
    }()

    lazy var autoLabelView: LabelView = {
        let view = LabelView()
        view.titleLabel.text = testTitleTexts[titleTextIndex]
        view.subtitleLabel.text = testSubtitleTexts[subtitleTextIndex]
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

    lazy var heightSliderLabel = UILabel()

    lazy var heightStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [heightSliderLabel, heightSlider])
        view.axis = .horizontal
        view.spacing = 10
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

    lazy var widthSliderLabel = UILabel()

    lazy var widthStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [widthSliderLabel, widthSlider])
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()

    lazy var changeTextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("텍스트 변경", for: .normal)
        view.addTarget(self, action: #selector(changeTextButtonDidTapped), for: .touchUpInside)
        return view
    }()

    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setConstraints()
    }

    private func addViews() {
        [manualLabelView, autoLabelView, heightStack, widthStack, changeTextButton].forEach {
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        manualLabelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            manualWidthConstraint = $0.width.equalTo(0).constraint
            manualHeightConstraint = $0.height.lessThanOrEqualTo(0).constraint
            manualWidthConstraint?.update(offset: widthSlider.value)
            manualHeightConstraint?.update(offset: heightSlider.value)
        }

        autoLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(manualLabelView.snp.bottom).offset(30)
            autoWidthConstraint = $0.width.equalTo(0).constraint
            autoWidthConstraint?.update(offset: widthSlider.value)
            let titleHeight: CGFloat = autoLabelView.titleLabel.font.lineHeight
            let subtitleHeight: CGFloat = autoLabelView.subtitleLabel.font.lineHeight

            $0.height.lessThanOrEqualTo(2 * titleHeight + subtitleHeight)
        }

        heightStack.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.layoutMarginsGuide)
        }

        widthStack.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.layoutMarginsGuide)
        }

        changeTextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(manualLabelView.snp.top).offset(-30)
        }
    }

    // MARK: Methods

    private func changeText() {
        titleTextIndex = (titleTextIndex < testTitleTexts.count) ? titleTextIndex + 1 : 0
        subtitleTextIndex = (subtitleTextIndex < testSubtitleTexts.count) ? subtitleTextIndex + 1 : 0

        [manualLabelView, autoLabelView].forEach {
            $0.titleLabel.text = testTitleTexts[titleTextIndex]
            $0.subtitleLabel.text = testSubtitleTexts[subtitleTextIndex]
        }
    }

    // MARK: Actions

    @objc private func heightSliderDidChange() {
        heightSliderLabel.text = "\(Int(heightSlider.value))"
        manualHeightConstraint?.update(offset: heightSlider.value)
    }

    @objc private func widthSliderDidChange() {
        widthSliderLabel.text = "\(Int(widthSlider.value))"
        manualWidthConstraint?.update(offset: widthSlider.value)
        autoWidthConstraint?.update(offset: widthSlider.value)
    }

    @objc private func changeTextButtonDidTapped() {
        changeText()
    }
}
