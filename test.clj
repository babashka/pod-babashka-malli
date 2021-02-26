#!/usr/bin/env bb

(require '[babashka.pods :as pods])

(if (= "executable" (System/getProperty "org.graalvm.nativeimage.kind"))
  (pods/load-pod "./pod-babashka-malli")
  (pods/load-pod ["clojure" "-M" "-m" "pod.babashka.malli"]))

(require '[pod.babashka.malli :as m]
         '[pod.babashka.malli.error :as me])

(prn (m/validate [:cat 'int? 'int?] [1 1]))
;; => true

;; this doesn't work
;; (prn (m/explain [:cat 'int? 'int?] [1 :foo]))

(prn (me/humanize [:cat 'int? 'int?] [1 :foo]))
;; => [nil ["should be an int"]]

(when-not (= "executable" (System/getProperty "org.graalvm.nativeimage.kind"))
  (shutdown-agents)
  (System/exit 0))
