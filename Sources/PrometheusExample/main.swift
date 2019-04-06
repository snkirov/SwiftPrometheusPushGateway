import Prometheus
import Foundation
import Metrics

let group = DispatchGroup()

let myProm = PrometheusClient()

MetricsSystem.bootstrap(PrometheusClient())

let c = Counter(label: "test")
c.increment()

let r = Recorder(label: "recorder")
for _ in 0...Int.random(in: 100...500_000) {
   r.record(Double.random(in: 0...20))
}

let g = Recorder(label: "non_agg_recorder", aggregate: false)
for _ in 0...Int.random(in: 100...500_000) {
    g.record(Double.random(in: 0...20))
}

let t = Timer(label: "timer")
for _ in 0...Int.random(in: 100...500_000) {
    t.recordMicroseconds(Double.random(in: 20...150))
}


//let x = myProm.makeCounter(label: "test", dimensions: [])
//x.increment(12)
//
//struct MyCodable: MetricLabels {
//   var thing: String = "*"
//}
//
//let codable1 = MyCodable(thing: "Thing1")
//let codable2 = MyCodable(thing: "Thing2")
//
//let counter = myProm.createCounter(forType: Int.self, named: "my_counter", helpText: "Just a counter", initialValue: 12, withLabelType: MyCodable.self)
//
//counter.inc(5)
//counter.inc(Int.random(in: 0...100), codable2)
//counter.inc(Int.random(in: 0...100), codable1)
//
//let gauge = myProm.createGauge(forType: Int.self, named: "my_gauge", helpText: "Just a gauge", initialValue: 12, withLabelType: MyCodable.self)
//
//gauge.inc(100)
//gauge.inc(Int.random(in: 0...100), codable2)
//gauge.inc(Int.random(in: 0...100), codable1)
//
//struct HistogramThing: HistogramLabels {
//   var le: String = ""
//   let route: String
//
//   init() {
//       self.route = "*"
//   }
//
//   init(_ route: String) {
//       self.route = route
//   }
//}
//
//let histogram = myProm.createHistogram(forType: Double.self, named: "my_histogram", helpText: "Just a histogram", labels: HistogramThing.self)
//
//for _ in 0...Int.random(in: 10...50) {
//   histogram.observe(Double.random(in: 0...1))
//}
//
//for _ in 0...Int.random(in: 10...50) {
//   histogram.observe(Double.random(in: 0...1), HistogramThing("/test"))
//}
//
//struct SummaryThing: SummaryLabels {
//   var quantile: String = ""
//   let route: String
//
//   init() {
//       self.route = "*"
//   }
//
//   init(_ route: String) {
//       self.route = route
//   }
//}
//
//let summary = myProm.createSummary(forType: Double.self, named: "my_summary", helpText: "Just a summary", labels: SummaryThing.self)
//
//for _ in 0...Int.random(in: 100...1000) {
//   summary.observe(Double.random(in: 0...10000))
//}
//
//for _ in 0...Int.random(in: 100...1000) {
//   summary.observe(Double.random(in: 0...10000), SummaryThing("/test"))
//}
//
//struct MyInfoStruct: MetricLabels {
//   let version: String
//   let major: String
//
//   init() {
//       self.version = "1.0.0"
//       self.major = "1"
//   }
//
//   init(_ v: String, _ m: String) {
//       self.version = v
//       self.major = m
//   }
//}
//
//let info = myProm.createInfo(named: "my_info", helpText: "Just some info", labelType: MyInfoStruct.self)
//
//info.info(MyInfoStruct("2.0.0", "2"))

let metrics = try! MetricsSystem.prometheus().getMetrics()
print(metrics)
