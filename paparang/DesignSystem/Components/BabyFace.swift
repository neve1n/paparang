//
//  BabyFace.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

import SwiftUI

/// 놀이를 마친 뒤 아이 반응을 고를 때 쓰는 얼굴. 고르면 살구색, 아니면 회색.
/// Figma: Section 1 › baby-s-happy (249:2763), baby-s-indifferent (249:2792)
/// Figma의 enabled/disabled가 여기서는 isSelected true/false다.
///
///     BabyFace(.happy, isSelected: true)
///
/// 10/20 회의: 반응 체크 결과를 놀이 추천에 반영한다. 반응 값을 저장하는 모델은 화면·데이터 쪽에서
/// 정하고, 이 컴포넌트는 그림만 맡는다.
struct BabyFace: View {

    enum Reaction {
        /// "아이가 좋아했어요"
        case happy
        /// "아이가 무관심했어요"
        case indifferent
    }

    let reaction: Reaction
    var isSelected: Bool

    init(_ reaction: Reaction, isSelected: Bool) {
        self.reaction = reaction
        self.isSelected = isSelected
    }

    var body: some View {
        Image(imageResource)
            // 얼굴 옆에 글자 라벨이 있으니 VoiceOver는 라벨만 읽게 한다
            .accessibilityHidden(true)
    }

    private var imageResource: ImageResource {
        switch (reaction, isSelected) {
        case (.happy, true): .babyHappyOn
        case (.happy, false): .babyHappyOff
        case (.indifferent, true): .babyIndifferentOn
        case (.indifferent, false): .babyIndifferentOff
        }
    }
}
