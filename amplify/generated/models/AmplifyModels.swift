// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "5cd5f8b7a39699b44de30e6b50c5ad0c"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: DateTimeTest.self)
  }
}