//
//  LandmarkDetail.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by jugomo on 27/3/22.
//

import SwiftUI

struct LandmarkDetail: View {
    /// tie to the environment modelData
    @EnvironmentObject var modelData: ModelData

    var landmark: Landmark

    /// compute the index of the input landmark by comparing it with the model data
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            VStack {
                CircleImage(image: landmark.image.resizable())
                    .scaledToFit()

                Text(landmark.name)
                    .font(.headline)
                    .lineLimit(0)

                Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
                    Text("Favorite")
                }

                Divider()

                Text(landmark.park)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)

                Text(landmark.state)
                    .font(.caption)

                Divider()

                MapView(coordinate: landmark.locationCoordinate)
                    .scaledToFit()
            }
            .padding(16)
        }
        .navigationTitle("Landmarks")
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()

        return Group {
            LandmarkDetail(landmark: modelData.landmarks[0])
                .environmentObject(modelData)
                .previewDevice("Apple Watch Series 6 - 44mm")
                .previewDisplayName("Apple Watch Series 6 - 44mm")

            LandmarkDetail(landmark: modelData.landmarks[1])
                .environmentObject(modelData)
                .previewDevice("Apple Watch Series 6 - 40mm")
                .previewDisplayName("Apple Watch Series 6 - 40mm")
        }
    }
}
