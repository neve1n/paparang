//
//  PlayRow.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

import SwiftUI

/// 놀이 목록의 한 줄. Figma: Design System › playElement (249:2734)
/// 썸네일, 제목, 발달 태그, 소요 시간·준비물, 오른쪽 화살표로 이뤄진다.
///
///     PlayRow(title: "딸랑이 흔들기",
///             developmentAreas: ["소근육", "청각"],
///             detail: "10분 · 준비물 필요") {
///         PlayPhoto(play.image)
///     }
///
/// 아래 구분선은 그리지 않는다. List가 그려주고, ScrollView에서는 쓰는 곳에서 Divider를 넣는다.
/// List의 NavigationLink 안에 넣으면 시스템 화살표가 따로 생기니 showsChevron을 false로 둔다.
struct PlayRow<Thumbnail: View>: View {

    let title: String
    /// 발달 카테고리 이름 (10/20 결정 8개: 대근육·소근육·인지·청각·촉각·시각·언어·사회정서)
    let developmentAreas: [String]
    /// 소요 시간·준비물 한 줄. 예: "10분 · 준비물 필요"
    let detail: String
    /// TODO(마치): 태그를 몇 개까지 보여줄지 — DesignSystem.swift 5번
    var maxVisibleTags: Int
    var showsChevron: Bool
    let thumbnail: Thumbnail

    init(
        title: String,
        developmentAreas: [String],
        detail: String,
        maxVisibleTags: Int = 3,
        showsChevron: Bool = true,
        @ViewBuilder thumbnail: () -> Thumbnail
    ) {
        self.title = title
        self.developmentAreas = developmentAreas
        self.detail = detail
        self.maxVisibleTags = maxVisibleTags
        self.showsChevron = showsChevron
        self.thumbnail = thumbnail()
    }

    var body: some View {
        HStack(spacing: 16) {
            thumbnail
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.textPrimary)

                HStack(spacing: 4) {
                    ForEach(developmentAreas.prefix(maxVisibleTags), id: \.self) { area in
                        PlayTag(area, style: .develop)
                    }
                    if hiddenTagCount > 0 {
                        Text("+\(hiddenTagCount)")
                            .font(.footnote)
                            .foregroundStyle(.textSecondary)
                    }
                }

                Text(detail)
                    .font(.footnote)
                    .foregroundStyle(.textSecondary)
            }

            Spacer(minLength: 0)

            if showsChevron {
                Image(systemName: "chevron.forward")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textSecondary)
            }
        }
        .padding(.vertical, 16)
        // 버튼 안에 넣었을 때 글자 사이 빈 곳을 눌러도 반응하게 한다
        .contentShape(.rect)
    }

    private var hiddenTagCount: Int {
        max(developmentAreas.count - maxVisibleTags, 0)
    }
}
