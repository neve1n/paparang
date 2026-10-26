//
//  RecommendedPlayCard.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

import SwiftUI

/// 완료 화면의 추천 놀이 카드. Figma: 249:1266 › recommendCarousel
/// Design System 페이지에는 아직 없는 모양이라 이 화면 폴더에 둔다.
/// 다른 화면에서도 쓰게 되면 DesignSystem/Components로 옮긴다.
struct RecommendedPlayCard: View {
    let play: PlayGuide

    var body: some View {
        HStack(spacing: 16) {
            PlayPhoto(play.image, cornerRadius: 12)
                .frame(width: 128, height: 128)

            VStack(alignment: .leading, spacing: 0) {
                Text(play.title)
                    .font(.headline)
                    .foregroundStyle(.textPrimary)
                    .lineLimit(1)

                FlowLayout(spacing: 4) {
                    ForEach(play.developmentAreas, id: \.self) { area in
                        PlayTag(area, style: .developEnabled)
                    }
                }
                .padding(.top, 8)

                Spacer(minLength: 8)

                Text(play.summary)
                    .font(.footnote)
                    .foregroundStyle(.textSecondary)
            }
            .frame(maxWidth: .infinity, maxHeight: 108, alignment: .leading)
        }
        .padding(16)
        .frame(width: 324, height: 160)
        .background(.surfacePrimary, in: .rect(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.strokeSecondary, lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
    }
}
