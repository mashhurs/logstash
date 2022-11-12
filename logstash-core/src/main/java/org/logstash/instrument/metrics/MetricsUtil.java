/*
 * Licensed to Elasticsearch B.V. under one or more contributor
 * license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright
 * ownership. Elasticsearch B.V. licenses this file to you under
 * the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *	http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.logstash.instrument.metrics;

import java.util.Map;
import java.util.stream.Collectors;

public class MetricsUtil {

    public static final Double ZERO = 0.0d;

    public static Map<String, Double> applyFraction(Map<String, Double> rates, Number fraction) {
        return rates.entrySet()
                .stream()
                .collect(Collectors.toMap(Map.Entry::getKey,
                        e -> multiply(fraction.doubleValue(), e.getValue())));
    }

    public static boolean isValueUndefined(Double value) {
        return value.isInfinite() || value.isNaN() || ZERO.equals(value);
    }

    private static Double multiply(Double nominator, Double denominator) {
        if (isValueUndefined(nominator) || isValueUndefined(denominator)) {
            return ZERO;
        }

        return nominator * denominator;
    }
}
