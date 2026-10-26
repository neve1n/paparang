//
//  PlayDetailView.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

import SwiftUI

/// 놀이 상세·방법 화면. Figma: c4-개인용 › iPhone 17 - 3 (249:1339)
///
/// 이 화면은 다음 화면으로 직접 이동하지 않는다. "놀이 완료"를 누르면 onComplete만 부르고,
/// 이동은 이 화면을 띄운 쪽(개발팀장이 정할 앱 구조)에서 연결한다.
/// 뒤로 가기 버튼은 NavigationStack이 자동으로 그린다.
struct PlayDetailView: View {
    let play: PlayGuide
    var onComplete: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                hero
                howToPlay
            }
        }
        .background(.surfacePrimary)
        // 대표 사진이 상태 표시줄 뒤까지 이어지게 한다
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button("놀이 완료", action: onComplete)
                .buttonStyle(.paparang(.primary))
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.bgPrimary.ignoresSafeArea())
        }
    }

    // MARK: 대표 사진, 태그, 제목

    private var hero: some View {
        Color.bgPrimary
            .frame(height: 302)
            .overlay {
                Image(play.image)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.6)
            }
            .overlay(Color.black.opacity(0.3))
            .clipped()
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 16) {
                    FlowLayout(spacing: 8) {
                        PlayTag(play.dayRange)
                        ForEach(play.materials, id: \.self) { material in
                            PlayTag(material)
                        }
                        // TODO(마치): 발달 태그 모양이 화면마다 다르다 (여기 description,
                        // 추천 카드 developEnabled, 놀이 행 develop) — DesignSystem.swift 4번
                        ForEach(play.developmentAreas, id: \.self) { area in
                            PlayTag(area, style: .description)
                        }
                    }
                    Text(play.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.textTertiary)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
            .accessibilityElement(children: .combine)
    }

    // MARK: 주의사항과 놀이 방법

    private var howToPlay: some View {
        VStack(spacing: 32) {
            if !play.cautions.isEmpty {
                cautionBox
            }
            ForEach(Array(play.steps.enumerated()), id: \.offset) { index, step in
                stepView(number: index + 1, step: step)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 80)
        .frame(maxWidth: .infinity)
        .background(.surfacePrimary)
    }

    private var cautionBox: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("주의사항")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.textForth)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(play.cautions.enumerated()), id: \.offset) { index, caution in
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text("\(index + 1).")
                        Text(caution)
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(.surfaceSecondary, in: .rect(cornerRadius: 16))
    }

    private func stepView(number: Int, step: PlayGuide.Step) -> some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                // Figma Blue Grey/black·white 원
                Text("\(number)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(.black, in: .circle)
                    .accessibilityLabel("\(number)단계")

                Text(step.description)
                    .font(.title3)
                    .foregroundStyle(.textPrimary)
                    .multilineTextAlignment(.center)
            }

            Color.bgPrimary
                .frame(height: 266)
                .overlay {
                    Image(step.image)
                        .resizable()
                        .scaledToFill()
                }
                .clipShape(.rect(cornerRadius: 8))
                .accessibilityHidden(true)
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        PlayDetailView(play: .sampleRattle, onComplete: {})
    }
}
#endif
