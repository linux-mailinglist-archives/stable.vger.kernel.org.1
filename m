Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9F7ECC94
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjKOTbU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjKOTbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD819D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E62C433C9;
        Wed, 15 Nov 2023 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076675;
        bh=CdTO9FzNr/iLjIRiu3FbHzxOqoIrwxdd0DDFtHZFtwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nx5VKV9fqyuXW0U+U+3mGlSCNGG31Spc1j5PrBYGU9MxIMdpIzCJzO7PONh3uxCyU
         JrzVMq4gN7ZnE2oH+2eoaMVe1X/rttqnXBG5EFH/f4BzuJWUvplTkArt8Q/QZA9Efb
         rQFXFQa/3Kut9K3MDxST6mqPgqeY8m692KT/+a2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 377/550] perf stat: Fix aggr mode initialization
Date:   Wed, 15 Nov 2023 14:16:01 -0500
Message-ID: <20231115191626.960956877@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit a84fbf205609313594b86065c67e823f09ebe29b ]

Generating metrics llc_code_read_mpi_demand_plus_prefetch,
llc_data_read_mpi_demand_plus_prefetch,
llc_miss_local_memory_bandwidth_read,
llc_miss_local_memory_bandwidth_write,
nllc_miss_remote_memory_bandwidth_read, memory_bandwidth_read,
memory_bandwidth_write, uncore_frequency, upi_data_transmit_bw,
C2_Pkg_Residency, C3_Core_Residency, C3_Pkg_Residency,
C6_Core_Residency, C6_Pkg_Residency, C7_Core_Residency,
C7_Pkg_Residency, UNCORE_FREQ and tma_info_system_socket_clks would
trigger an address sanitizer heap-buffer-overflows on a SkylakeX.

```
==2567752==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x5020003ed098 at pc 0x5621a816654e bp 0x7fffb55d4da0 sp 0x7fffb55d4d98
READ of size 4 at 0x5020003eee78 thread T0
    #0 0x558265d6654d in aggr_cpu_id__is_empty tools/perf/util/cpumap.c:694:12
    #1 0x558265c914da in perf_stat__get_aggr tools/perf/builtin-stat.c:1490:6
    #2 0x558265c914da in perf_stat__get_global_cached tools/perf/builtin-stat.c:1530:9
    #3 0x558265e53290 in should_skip_zero_counter tools/perf/util/stat-display.c:947:31
    #4 0x558265e53290 in print_counter_aggrdata tools/perf/util/stat-display.c:985:18
    #5 0x558265e51931 in print_counter tools/perf/util/stat-display.c:1110:3
    #6 0x558265e51931 in evlist__print_counters tools/perf/util/stat-display.c:1571:5
    #7 0x558265c8ec87 in print_counters tools/perf/builtin-stat.c:981:2
    #8 0x558265c8cc71 in cmd_stat tools/perf/builtin-stat.c:2837:3
    #9 0x558265bb9bd4 in run_builtin tools/perf/perf.c:323:11
    #10 0x558265bb98eb in handle_internal_command tools/perf/perf.c:377:8
    #11 0x558265bb9389 in run_argv tools/perf/perf.c:421:2
    #12 0x558265bb9389 in main tools/perf/perf.c:537:3
```

The issue was the use of testing a cpumap with NULL rather than using
empty, as a map containing the dummy value isn't NULL and the -1
results in an empty aggr map being allocated which legitimately
overflows when any member is accessed.

Fixes: 8a96f454f5668572 ("perf stat: Avoid SEGV if core.cpus isn't set")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230906003912.3317462-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 07b48f6df48eb..a3af805a1d572 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1622,7 +1622,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	if (evsel_list->core.user_requested_cpus)
+	if (!perf_cpu_map__empty(evsel_list->core.user_requested_cpus))
 		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
 	else
 		nr = 0;
-- 
2.42.0



