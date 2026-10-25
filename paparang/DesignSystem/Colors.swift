//
//  Colors.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

import SwiftUI

// Figma 변수 → 색 토큰. Figma 경로를 camelCase로 옮겼다 (Text/primary → textPrimary).
// 사용: .foregroundStyle(.textPrimary), .background(.surfaceSecondary), Color.interactiveCTA
// Assets.xcassets에 같은 이름의 컬러셋을 만들면 자동 생성 이름과 겹치니 만들지 않는다.
// TODO(마치): 라이트 값만 있다. 다크 모드 여부 — DesignSystem.swift 7번

extension ShapeStyle where Self == Color {

    // MARK: Text

    /// Text/primary #0F1215 — 제목, 본문
    static var textPrimary: Color { Color(hex: 0x0F1215) }

    /// Text/secondary #7A8F9F — 보조 글자, 비활성 버튼 글자
    /// TODO(마치): 옛 값 #999999와 섞여 있다 — DesignSystem.swift 1번
    static var textSecondary: Color { Color(hex: 0x7A8F9F) }

    /// Text/tertiary #E6F9FE — 채운 버튼·태그 위의 밝은 글자
    static var textTertiary: Color { Color(hex: 0xE6F9FE) }

    /// Text/forth #0A97C2 — 강조 글자 (발달 태그, 선택된 필터). "forth"는 Figma 표기 그대로
    static var textForth: Color { Color(hex: 0x0A97C2) }

    // MARK: Background · Surface

    /// Bg/primary #F6F8F9 — 화면 배경
    /// TODO(마치): 옛 값 #F5F5F5와 섞여 있다 — DesignSystem.swift 1번
    static var bgPrimary: Color { Color(hex: 0xF6F8F9) }

    /// Surface/primary #FFFFFF — 카드
    static var surfacePrimary: Color { Color(hex: 0xFFFFFF) }

    /// Surface/secondary #F6F8F9 — 회색 태그, secondary 버튼, 주의사항 박스
    static var surfaceSecondary: Color { Color(hex: 0xF6F8F9) }

    /// Surface/enabled #E6F9FE — 선택·강조된 면
    static var surfaceEnabled: Color { Color(hex: 0xE6F9FE) }

    // MARK: Interactive · Button

    /// Interactive/CTA #0DBDF2 — 가장 중요한 행동 (CTA 버튼, 선택된 필터 테두리)
    static var interactiveCTA: Color { Color(hex: 0x0DBDF2) }

    /// Button/primary #0F1215 — 검정 버튼
    static var buttonPrimary: Color { Color(hex: 0x0F1215) }

    /// Button/disabled #E1E6EA — 비활성 버튼
    static var buttonDisabled: Color { Color(hex: 0xE1E6EA) }

    /// Button/tertiary #FFFFFF — 선택 안 된 필터 칩
    static var buttonTertiary: Color { Color(hex: 0xFFFFFF) }

    /// Button/enabled #E6F9FE — 선택된 필터 칩
    static var buttonEnabled: Color { Color(hex: 0xE6F9FE) }

    // MARK: Stroke

    /// Stroke/secondary #E1E6EA — 테두리, 구분선
    static var strokeSecondary: Color { Color(hex: 0xE1E6EA) }

    // MARK: Palette — 컴포넌트에서는 위의 의미 있는 이름을 먼저 쓴다

    /// Baby Blue/200 #CEF2FD — 완료 화면 제목 밑 강조
    static var babyBlue200: Color { Color(hex: 0xCEF2FD) }

    /// Blue Grey/3 #D3DADF
    static var blueGrey3: Color { Color(hex: 0xD3DADF) }

    // MARK: Decoration — 완료 화면 꽃가루 장식
    // TODO(마치): C4 때 발달 영역 4개 이름이다. 장식용 이름으로 바꿀지 — DesignSystem.swift 3번

    /// theme/visual #FFDBDC
    static var themeVisual: Color { Color(hex: 0xFFDBDC) }

    /// theme/sensory #D7F8D3
    static var themeSensory: Color { Color(hex: 0xD7F8D3) }

    /// theme/auditory #DBEAFF
    static var themeAuditory: Color { Color(hex: 0xDBEAFF) }

    /// theme/physical #FCF5B6
    static var themePhysical: Color { Color(hex: 0xFCF5B6) }
}

private extension Color {
    /// 0xRRGGBB 형식의 sRGB 색
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}
