# pod-babashka-malli

WARNING: this is currently a proof of concept, not something you should be using
due to its experimental nature.

## API

For malli's documentation, go [here](https://github.com/metosin/malli).

Available namespaces:

- `pod.babashka.malli`
- `pod.babashka.malli.error`

If you are missing functionality, please create an issue.

## Status

Very experimental, don't use this yet.

## Differences with malli

- Function names in schemas must be quoted: `int?` => `'int?`. This is because
  arguments and return values to and from pods must be serializable.
- The `humanize` function has the same signature as `validate`: instead of
  accepting an error object, it accepts a schema and input. The reason for this
  is that the output of `s/explain` is not serializable as transit yet.

## Example

This is a future example once the pod is in the pod registry.

``` clojure
(require '[babashka.pods :as pods])

(pods/load-pod 'org.babashka/malli "0.0.1")

(require '[pod.babashka.malli :as m]
         '[pod.babashka.malli.error :as me])

(prn (m/validate [:cat 'int? 'int?] [1 1]))
;; => true

(prn (me/humanize [:cat 'int? 'int?] [1 :foo]))
;; => [nil ["should be an int"]]
```

## Build

Run `script/compile`. This requires `GRAALVM_HOME` to be set.

## Test

To test the pod code with JVM clojure, run `clojure -M test.clj`.

To test the native image with bb, run `bb test.clj`.

## License

Copyright © 2021 Michiel Borkent

Distributed under the Apache 2.0 License. See LICENSE.
