//
//  ContentView.swift
//  MapVirtualTurist
//
//  Created by Elisangela Pethke on 10.07.24.
//

import SwiftUI
import MapKit
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = LocationViewModel()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var selectedLatitude: Double?
    @State private var selectedLongitude: Double?
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    var body: some View {
        VStack {
            HStack {
                Button("Add Pin") {
                   
                     let currentLocation = viewModel.region.center 
                        selectedLatitude = currentLocation.latitude
                        selectedLongitude = currentLocation.longitude
                        showingImagePicker = true
                    
                }
                .foregroundColor(.blue)
                .padding()
                .font(.system(size: 18))
                
                Spacer()
                
                Text("Virtual Tourist")
                    .font(.title2)
                    .padding()
                
                Spacer()
                
                Button("Delete Pins") {
                    if let location = viewModel.selectedLocation {
                        viewModel.deleteLocation(location: location)
                    }
                }
                .foregroundColor(.blue)
                .padding()
                .font(.system(size: 18))
            }
            .padding()
            
            Map(coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    if let photoData = location.photo, let uiImage = UIImage(data: photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.red, lineWidth: 2))
                    } else {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                    }
                }
            }
                .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        .onAppear {
          
            viewModel.fetchLocations()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        guard let latitude = selectedLatitude, let longitude = selectedLongitude else { return }
        if let imageData = inputImage.jpegData(compressionQuality: 0.8) {
            viewModel.addLocation(latitude: latitude, longitude: longitude, photo: imageData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
