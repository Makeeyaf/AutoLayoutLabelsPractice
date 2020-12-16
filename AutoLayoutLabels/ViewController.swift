//
//  ViewController.swift
//  AutoLayoutLabels
//
//  Created by Makeeyaf on 2020/12/11.
//

import UIKit

import SnapKit

struct TestLabelViewData: LabelViewData {
    var titleLabelData: LabelData
    var subtitleLabelData: LabelData
}

class ViewController: UIViewController {
    var widthConstraint: Constraint?

    var textIndex: Int = 0

    let testTexts: [TestLabelViewData] = [
        TestLabelViewData(
            titleLabelData: LabelData(
                text: "미스터 켄트 백의 77가지 구현 패턴",
                font: .systemFont(ofSize: 16, weight: .semibold),
                textColor: .black
            ),
            subtitleLabelData: LabelData(
                text: "읽기 쉬운 코드를 작성하는 77가지 자바 코딩 비법",
                font: .systemFont(ofSize: 14, weight: .regular),
                textColor: .gray
            )
        ),
        TestLabelViewData(
            titleLabelData: LabelData(
                text: "최신 선물을 구할 수 있는 마지막 기회.",
                font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)!,
                textColor: .black
            ),
            subtitleLabelData: LabelData(
                text: "쇼핑 중에는 언제든지 스페셜리스트의 도움을 받을 수도 있죠.",
                font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!,
                textColor: .gray
            )
        ),
        TestLabelViewData(
            titleLabelData: LabelData(
                text: "새로운 파워. 어마무시한 가능성 👍",
                font: .systemFont(ofSize: 16, weight: .semibold),
                textColor: .black
            ),
            subtitleLabelData: LabelData(
                text: "데스크탑의 능력을 완전히 새로운 차원으로 끌어올려줍니다.",
                font: .systemFont(ofSize: 14, weight: .regular),
                textColor: .gray
            )
        ),
        TestLabelViewData(
            titleLabelData: LabelData(
                text: "사운드 문제에 대한 AirPods Pro 서비스 프로그램",
                font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 10)!,
                textColor: .black
            ),
            subtitleLabelData: LabelData(
                text: "사운드 문제가 발생할 수 있음을 확인했습니다. 🤷‍♂️",
                font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!,
                textColor: .gray
            )
        ),
    ]

    // MARK: Views

    lazy var labelView: LabelView = {
        let view = LabelView()
        view.spacing = 2
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
        labelView.render(with: testTexts[textIndex])
    }

    private func addViews() {
        [labelView, widthStack, changeTextButton].forEach {
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        labelView.snp.makeConstraints {
            $0.center.equalToSuperview()
            widthConstraint = $0.width.equalTo(0).constraint
            widthConstraint?.update(offset: widthSlider.value)
        }

        widthStack.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.layoutMarginsGuide)
        }

        changeTextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(labelView.snp.top).offset(-30)
        }
    }

    // MARK: Methods

    private func changeText() {
        textIndex = (textIndex < testTexts.count - 1) ? textIndex + 1 : 0

        labelView.render(with: testTexts[textIndex])
    }

    // MARK: Actions

    @objc private func widthSliderDidChange() {
        widthSliderLabel.text = "\(Int(widthSlider.value))"
        widthConstraint?.update(offset: widthSlider.value)
    }

    @objc private func changeTextButtonDidTapped() {
        changeText()
    }
}
