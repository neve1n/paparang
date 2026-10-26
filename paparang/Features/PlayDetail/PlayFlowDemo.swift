//
//  PlayFlowDemo.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

#if DEBUG
import SwiftUI

/// 상세 → 완료 흐름을 시뮬레이터에서 눌러보기 위한 임시 연결. DEBUG 빌드에만 들어간다.
/// 실제 앱의 화면 이동은 개발팀장이 정할 구조에서 연결하고, 이 파일은 그때 지워도 된다.
struct PlayFlowDemo: View {
    private enum Route: Hashable {
        case detail(PlayGuide)
        case completion(PlayGuide)
    }

    @State private var path: [Route] = []
    private let plays: [PlayGuide] = [.sampleRattle, .sampleHandkerchief, .sampleMirror]

    var body: some View {
        NavigationStack(path: $path) {
            List(plays) { play in
                Button {
                    path.append(.detail(play))
                } label: {
                    PlayRow(title: play.title, developmentAreas: play.developmentAreas, detail: play.summary) {
                        PlayPhoto(play.image)
                    }
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
            .navigationTitle("놀이 (데모)")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let play):
                    PlayDetailView(play: play) {
                        path.append(.completion(play))
                    }
                case .completion(let play):
                    PlayCompletionView(
                        play: play,
                        recommendations: plays.filter { $0 != play },
                        onSelectRecommendation: { path = [.detail($0)] },
                        onFinish: { _ in path.removeAll() }
                    )
                }
            }
        }
    }
}

#Preview {
    PlayFlowDemo()
}
#endif
