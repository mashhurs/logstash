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

package org.logstash.common.io;

import org.apache.commons.io.FileUtils;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Level;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Param;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.TearDown;
import org.openjdk.jmh.annotations.Warmup;
import org.openjdk.jmh.infra.Blackhole;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.concurrent.TimeUnit;

@Warmup(iterations = 3, time = 500, timeUnit = TimeUnit.MILLISECONDS)
@Measurement(iterations = 10, time = 1000, timeUnit = TimeUnit.MILLISECONDS)
@Fork(1)
@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.MILLISECONDS)
@State(Scope.Thread)
public class DeadLetterQueueUtilsBenchmark {

    @Param({"100", "1000", "10000", "20000"})
    public int segmentCount;

    private Path dlqDir;

    @Setup(Level.Trial)
    public void setUp() throws IOException {
        dlqDir = Files.createTempDirectory("dlq-bench");
        byte[] payload = new byte[1024];
        for (int i = 0; i < segmentCount; i++) {
            Files.write(dlqDir.resolve(i + ".log"), payload);
        }
    }

    @TearDown(Level.Trial)
    public void tearDown() throws IOException {
        FileUtils.deleteDirectory(new File(dlqDir.toString()));
    }

    @Benchmark
    public void maxSegmentId(Blackhole blackhole) throws IOException {
        blackhole.consume(DeadLetterQueueUtils.maxSegmentId(dlqDir));
    }

    @Benchmark
    public void oldestSegmentPathNoMinSize(Blackhole blackhole) throws IOException {
        blackhole.consume(DeadLetterQueueUtils.oldestSegmentPath(dlqDir, 0));
    }

    @Benchmark
    public void oldestSegmentPathWithMinSize(Blackhole blackhole) throws IOException {
        blackhole.consume(DeadLetterQueueUtils.oldestSegmentPath(dlqDir, 1));
    }
}
