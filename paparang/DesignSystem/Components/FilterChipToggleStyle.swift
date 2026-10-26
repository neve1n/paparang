//
//  FilterChipToggleStyle.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

import SwiftUI

/// 켜고 끄는 필터 칩. Figma: Design System › filter (249:2716)
///
///     Toggle("대근육", isOn: $isGrossMotorOn)
///         .toggleStyle(.filterChip)
struct FilterChipToggleStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn

        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(isOn ? Color.textForth : Color.textSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(isOn ? Color.buttonEnabled : Color.buttonTertiary, in: .capsule)
                .overlay {
                    Capsule()
                        .strokeBorder(isOn ? Color.interactiveCTA : Color.strokeSecondary, lineWidth: 1)
                }
        }
        // TODO(마치): 눌림 상태 디자인이 없다 — DesignSystem.swift 6번
        .buttonStyle(.plain)
        .accessibilityAddTraits(isOn ? .isSelected : [])
    }
}

extension ToggleStyle where Self == FilterChipToggleStyle {
    static var filterChip: Self { FilterChipToggleStyle() }
}
