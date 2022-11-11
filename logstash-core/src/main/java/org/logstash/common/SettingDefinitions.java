package org.logstash.common;

/**
 * A class to contain Logstash setting definitions broadly used in the Java scope.
 */
public class SettingDefinitions {

    public static final String PIPELINE_ID = "pipeline.id";

    public static final String PIPELINE_WORKERS = "pipeline.workers";

    public static final String PIPELINE_BATCH_SIZE = "pipeline.batch.size";

    public static final String PATH_QUEUE = "path.queue";

    public static final String QUEUE_PAGE_CAPACITY = "queue.page_capacity";

    public static final String QUEUE_MAX_EVENTS = "queue.max_events";

    public static final String QUEUE_CHECKPOINT_WRITES = "queue.checkpoint.writes";

    public static final String QUEUE_CHECKPOINT_ACKS = "queue.checkpoint.acks";

    public static final String QUEUE_CHECKPOINT_INTERVAL = "queue.checkpoint.interval";

    public static final String QUEUE_CHECKPOINT_RETRY = "queue.checkpoint.retry";

    public static final String QUEUE_MAX_BYTES = "queue.max_bytes";
}
