//
//  ShareButtonView.swift
//  SwiftUIImageDownloader
//
//  Created by Mrunalini Khushal Kumbhalkar on 12/31/20.
//

import SwiftUI


struct ShareButtonView: View {

  let itemsToShare = ["https://itunes.apple.com/app/id1234"]

  var body: some View {
    Button(action: { showShareSheet(with: itemsToShare) }) {
      Image(systemName: "square.and.arrow.up")
        .font(.title2)
        .foregroundColor(.blue)
    }
  }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView()
    }
}


extension View {
  func showShareSheet(with activityItems: [Any]) {
    guard let source = UIApplication.shared.windows.last?.rootViewController else {
      return
    }

    let activityVC = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: nil)

    if let popoverController = activityVC.popoverPresentationController {
      popoverController.sourceView = source.view
      popoverController.sourceRect = CGRect(x: source.view.bounds.midX,
                                            y: source.view.bounds.midY,
                                            width: .zero, height: .zero)
      popoverController.permittedArrowDirections = []
    }
    source.present(activityVC, animated: true)
  }
}
