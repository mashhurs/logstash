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

import java.util.Collections;
import java.util.Map;
import java.util.Objects;

public class ExtendedFracturedFlowMetric extends ExtendedFlowMetric {

    private final Number fraction;

    public ExtendedFracturedFlowMetric(String name, Metric<? extends Number> numeratorMetric, Metric<? extends Number> denominatorMetric, Number fraction) {
        super(name, numeratorMetric, denominatorMetric);
        this.fraction = fraction;

        LOGGER.warn("ExtendedFracturedFlowMetric initialization...");
    }

    @Override
    public Map<String, Double> getValue() {
        Map<String, Double> rates = super.getValue();

        // falling back to super class rates if fraction is N.A or ZERO
        if (Objects.isNull(this.fraction) || MetricsUtil.isValueUndefined(this.fraction.doubleValue())) {
            return rates;
        }

        LOGGER.warn("Non-fractured rates: {}", rates);
        LOGGER.warn("Fraction: {}", this.fraction);

        Map<String, Double> fracturedRates = MetricsUtil.applyFraction(rates, this.fraction);
        LOGGER.warn("Fractured rates: {}", fracturedRates);
        return Collections.unmodifiableMap(fracturedRates);
    }
}
