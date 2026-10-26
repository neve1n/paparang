//
//  DesignSystemCatalog.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

#if DEBUG
import SwiftUI

/// 디자인 시스템 컴포넌트를 한 화면에 모은 미리보기. 마치와 Figma를 나란히 놓고 비교할 때 쓴다.
/// DEBUG 빌드에만 들어가고 출시 앱에는 포함되지 않는다.
struct DesignSystemCatalog: View {
    @State private var isGrossMotorOn = true
    @State private var isFineMotorOn = false
    @State private var isHappySelected = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                section("버튼") {
                    Button("놀아주러 가기") {}
                        .buttonStyle(.paparang(.cta))
                    Button("놀이 완료") {}
                        .buttonStyle(.paparang(.primary))
                    HStack {
                        Button("다음에") {}
                            .buttonStyle(.paparang(.secondary, size: .medium))
                        Button("놀아주러 가기") {}
                            .buttonStyle(.paparang(.primary, size: .small))
                    }
                    Button("다른 놀이하러 가기") {}
                        .buttonStyle(.paparang(.primary))
                        .disabled(true)
                }

                section("태그") {
                    HStack {
                        PlayTag("첫 놀이")
                        PlayTag("2회 반복", style: .repeated)
                        PlayTag("100-200일", style: .description)
                    }
                    HStack {
                        PlayTag("대근육", style: .develop)
                        PlayTag("사회정서", style: .developEnabled)
                    }
                }

                section("필터") {
                    HStack {
                        Toggle("대근육", isOn: $isGrossMotorOn)
                        Toggle("소근육", isOn: $isFineMotorOn)
                    }
                    .toggleStyle(.filterChip)
                }

                section("놀이 행") {
                    PlayRow(
                        title: "딸랑이 흔들기",
                        developmentAreas: ["소근육", "청각", "시각", "사회정서", "언어"],
                        detail: "10분 · 준비물 필요"
                    ) {
                        Color.bgPrimary
                            .overlay {
                                Image(systemName: "photo")
                                    .foregroundStyle(.textSecondary)
                            }
                    }
                }

                section("아이 반응") {
                    HStack(spacing: 56) {
                        Button { isHappySelected = true } label: {
                            BabyFace(.happy, isSelected: isHappySelected)
                        }
                        Button { isHappySelected = false } label: {
                            BabyFace(.indifferent, isSelected: !isHappySelected)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(.bgPrimary)
    }

    private func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.textPrimary)
            content()
        }
    }
}

#Preview {
    DesignSystemCatalog()
}
#endif
