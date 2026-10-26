//
//  PaparangButtonStyle.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

import SwiftUI

/// 채운 버튼. Figma: Design System › bottomButton (249:2749)
///
///     Button("놀이 완료") { }
///         .buttonStyle(.paparang(.primary))
///
/// 비활성(disabled-l)은 따로 고르지 않는다. `.disabled(true)`를 붙이면 자동으로 바뀐다.
struct PaparangButtonStyle: ButtonStyle {

    enum Kind {
        /// CTA — 하늘색. 화면에서 가장 중요한 행동
        case cta
        /// primary-s/m/l — 검정
        case primary
        /// secondary-m — 옅은 회색
        case secondary
    }

    enum Size {
        /// -l: 높이 52, 가로를 꽉 채운다 (화면 하단 버튼)
        case large
        /// -m: 높이 52. 너비는 쓰는 곳에서 정한다
        case medium
        /// -s: 높이 44, 글자 Subheadline
        case small
    }

    var kind: Kind
    var size: Size = .large

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size == .small ? .subheadline : .body)
            .fontWeight(.semibold)
            .foregroundStyle(foreground)
            .padding(.horizontal, 20)
            .frame(maxWidth: size == .large ? .infinity : nil)
            .frame(height: size == .small ? 44 : 52)
            .background(background, in: .rect(cornerRadius: 12))
            // TODO(마치): 눌림 상태 디자인이 없다 — DesignSystem.swift 6번
            .opacity(configuration.isPressed ? 0.8 : 1)
    }

    private var foreground: Color {
        guard isEnabled else { return .textSecondary }
        switch kind {
        case .cta, .primary: return .textTertiary
        case .secondary: return .textPrimary
        }
    }

    private var background: Color {
        guard isEnabled else { return .buttonDisabled }
        switch kind {
        case .cta: return .interactiveCTA
        // TODO(마치): Figma는 primary-m·l에 Text/primary를 쓴다 — DesignSystem.swift 2번
        case .primary: return .buttonPrimary
        case .secondary: return .surfaceSecondary
        }
    }
}

extension ButtonStyle where Self == PaparangButtonStyle {
    static func paparang(_ kind: PaparangButtonStyle.Kind, size: PaparangButtonStyle.Size = .large) -> Self {
        PaparangButtonStyle(kind: kind, size: size)
    }
}
