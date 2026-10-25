//
//  PlayTag.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

import SwiftUI

/// 놀이에 붙는 작은 이름표. Figma: Design System › tag (249:2723)
///
///     PlayTag("첫 놀이")
///     PlayTag("대근육", style: .develop)
struct PlayTag: View {

    /// 케이스 이름은 Figma variant 이름을 따른다 (default만 Swift 예약어라 basic)
    enum Style {
        /// default — "첫 놀이" 같은 상태 표시. 회색
        case basic
        /// repeated — "2회 반복". 하늘색으로 채움
        case repeated
        /// description — 놀이 정보. 옅은 하늘색
        case description
        /// develop — 발달 영역. 작은 크기
        case develop
        /// developEnabled — 강조된 발달 영역
        /// TODO(마치): "발달o"의 뜻과 Regular 굵기 확인 — DesignSystem.swift 4번
        case developEnabled
    }

    let title: String
    var style: Style = .basic

    init(_ title: String, style: Style = .basic) {
        self.title = title
        self.style = style
    }

    var body: some View {
        Text(title)
            .font(isSmall ? .caption : .footnote)
            .fontWeight(style == .developEnabled ? .regular : .semibold)
            .foregroundStyle(foreground)
            .lineLimit(1)
            .padding(.horizontal, isSmall ? 8 : 12)
            .padding(.vertical, 4)
            .background(background, in: .capsule)
    }

    private var isSmall: Bool {
        style == .develop || style == .developEnabled
    }

    private var foreground: Color {
        switch style {
        case .basic: .textSecondary
        case .repeated: .textTertiary
        case .description: .textPrimary
        case .develop, .developEnabled: .textForth
        }
    }

    private var background: Color {
        switch style {
        case .basic, .develop: .surfaceSecondary
        case .repeated: .interactiveCTA
        case .description, .developEnabled: .surfaceEnabled
        }
    }
}
