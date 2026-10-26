//
//  PlayCompletionView.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

import SwiftUI

/// 놀이 완료 화면. Figma: c4-개인용 › iPhone 17 - 12 (249:1266)
/// 아이 반응을 고르고, 비슷한 놀이를 추천받는다.
///
/// 이 화면도 직접 이동하지 않는다.
/// - 추천 카드를 누르면 onSelectRecommendation
/// - "다른 놀이하러 가기"를 누르면 고른 반응과 함께 onFinish
/// 반응을 저장하고 추천에 반영하는 일은 데이터 쪽에서 맡는다. (10/20 회의)
struct PlayCompletionView: View {
    let play: PlayGuide
    let recommendations: [PlayGuide]
    var onSelectRecommendation: (PlayGuide) -> Void
    var onFinish: (PlayReaction) -> Void

    @State private var reaction: PlayReaction?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                header
                    .padding(.top, 8)
                reactionCard
                    .padding(.top, 56)
                    .padding(.horizontal, 24)
                if !recommendations.isEmpty {
                    recommendSection
                        .padding(.top, 32)
                }
            }
            .padding(.bottom, 24)
        }
        .background(.bgPrimary)
        .navigationBarTitleDisplayMode(.inline)
        .bottomButtonBar {
            // Figma에는 반응을 고르기 전(비활성) 모습만 있다. 고른 뒤에는 검정 버튼으로 두었다.
            // TODO(마치): 반응을 고른 뒤 버튼 모습 — DesignSystem.swift 9번
            Button("다른 놀이하러 가기") {
                if let reaction { onFinish(reaction) }
            }
            .buttonStyle(.paparang(.primary))
            .disabled(reaction == nil)
        }
    }

    // MARK: 완료 축하

    private var header: some View {
        VStack(spacing: 16) {
            Text("놀이를 완료했어요!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(alignment: .bottom) {
                    Rectangle()
                        .fill(.babyBlue200)
                        .frame(height: 16)
                }

            Text(play.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        // 꽃가루 장식. 제목보다 61pt 위에서 시작한다 (Figma 기준)
        .background(alignment: .top) {
            Image(.panpare)
                .offset(y: -61)
                .accessibilityHidden(true)
        }
    }

    // MARK: 아이 반응

    private var reactionCard: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("아이의 반응이 어땠나요?")
                    .font(.title3)
                    .foregroundStyle(.textPrimary)
                Text("반응을 선택해주세요. 놀이 추천에 반영할게요.")
                    .font(.footnote)
                    .foregroundStyle(.textSecondary)
            }
            .multilineTextAlignment(.center)

            HStack(alignment: .top, spacing: 56) {
                reactionButton(.liked, face: .happy, label: "아이가\n좋아했어요")
                reactionButton(.indifferent, face: .indifferent, label: "아이가\n무관심했어요")
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.surfacePrimary, in: .rect(cornerRadius: 24))
    }

    private func reactionButton(_ value: PlayReaction, face: BabyFace.Reaction, label: String) -> some View {
        let isSelected = reaction == value

        return Button {
            reaction = value
        } label: {
            VStack(spacing: 8) {
                BabyFace(face, isSelected: isSelected)
                // TODO(마치): 고른 반응의 글자 모습이 따로 없다 — DesignSystem.swift 9번
                Text(label)
                    .font(.subheadline)
                    .foregroundStyle(.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize()
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label.replacingOccurrences(of: "\n", with: " "))
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: 비슷한 놀이 추천

    private var recommendSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("이 놀이는 어떠세요?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textPrimary)
                Text("\(play.title)\(play.title.andParticle) 비슷한 놀이들이에요")
                    .font(.subheadline)
                    .foregroundStyle(.textSecondary)
            }
            .padding(.horizontal, 24)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(recommendations) { recommendation in
                        Button {
                            onSelectRecommendation(recommendation)
                        } label: {
                            RecommendedPlayCard(play: recommendation)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 24, for: .scrollContent)
        }
    }
}

private extension String {
    /// 앞 글자 받침에 맞는 "와/과". 예: 딸랑이 흔들기와, 손수건 까꿍과
    var andParticle: String {
        guard let last = unicodeScalars.last, (0xAC00...0xD7A3).contains(last.value) else { return "와" }
        return (last.value - 0xAC00) % 28 == 0 ? "와" : "과"
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        PlayCompletionView(
            play: .sampleRattle,
            recommendations: [.sampleHandkerchief, .sampleMirror],
            onSelectRecommendation: { _ in },
            onFinish: { _ in }
        )
    }
}
#endif
