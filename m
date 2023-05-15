Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1270386B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbjEORcU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbjEORbv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50CB1434B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9FD62083
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8586BC433D2;
        Mon, 15 May 2023 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171725;
        bh=bXiF8h9INwoJvPDUv5DyfhRSQ1mBibQdiosN2ax6iDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcBVncxHfKLHwPTRLFUyd8SxdDK8JRUSQJhwtPNwOeueq5YMXv+rdnxIa0wxiMP86
         1ben0Wkid5z5i64JW0ci6nc1Qp21hHGCacBhVkBjk5lrHCwjqgIpWxmAJ/R9v+H85P
         hvHHHXq6WizIxYMF0jjkb8iAI7b7uy/GTfLRDxPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Vineet Singh <vineet.singh@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        zhengjun.xing@intel.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/134] perf evlist: Refactor evlist__for_each_cpu()
Date:   Mon, 15 May 2023 18:28:56 +0200
Message-Id: <20230515161705.117427754@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit 472832d2c000b9611feaea66fe521055c3dbf17a ]

Previously evlist__for_each_cpu() needed to iterate over the evlist in
an inner loop and call "skip" routines. Refactor this so that the
iteratr is smarter and the next function can update both the current CPU
and evsel.

By using a cpu map index, fix apparent off-by-1 in __run_perf_stat's
call to perf_evsel__close_cpu().

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Vineet Singh <vineet.singh@intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: zhengjun.xing@intel.com
Link: https://lore.kernel.org/r/20220105061351.120843-35-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: ecc68ee216c6 ("perf stat: Separate bperf from bpf_profiler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 179 ++++++++++++++++++--------------------
 tools/perf/util/evlist.c  | 146 +++++++++++++++++--------------
 tools/perf/util/evlist.h  |  50 +++++++++--
 tools/perf/util/evsel.h   |   1 -
 4 files changed, 210 insertions(+), 166 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0b709e3ead2ac..4ccd0c7c13ea1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -405,36 +405,33 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 
 static int read_affinity_counters(struct timespec *rs)
 {
-	struct evsel *counter;
-	struct affinity affinity;
-	int i, ncpus, cpu;
+	struct evlist_cpu_iterator evlist_cpu_itr;
+	struct affinity saved_affinity, *affinity;
 
 	if (all_counters_use_bpf)
 		return 0;
 
-	if (affinity__setup(&affinity) < 0)
+	if (!target__has_cpu(&target) || target__has_per_thread(&target))
+		affinity = NULL;
+	else if (affinity__setup(&saved_affinity) < 0)
 		return -1;
+	else
+		affinity = &saved_affinity;
 
-	ncpus = perf_cpu_map__nr(evsel_list->core.all_cpus);
-	if (!target__has_cpu(&target) || target__has_per_thread(&target))
-		ncpus = 1;
-	evlist__for_each_cpu(evsel_list, i, cpu) {
-		if (i >= ncpus)
-			break;
-		affinity__set(&affinity, cpu);
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		struct evsel *counter = evlist_cpu_itr.evsel;
 
-		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
-				continue;
-			if (evsel__is_bpf(counter))
-				continue;
-			if (!counter->err) {
-				counter->err = read_counter_cpu(counter, rs,
-								counter->cpu_iter - 1);
-			}
+		if (evsel__is_bpf(counter))
+			continue;
+
+		if (!counter->err) {
+			counter->err = read_counter_cpu(counter, rs,
+							evlist_cpu_itr.cpu_map_idx);
 		}
 	}
-	affinity__cleanup(&affinity);
+	if (affinity)
+		affinity__cleanup(&saved_affinity);
+
 	return 0;
 }
 
@@ -771,8 +768,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int i, cpu, err;
+	int err;
 	bool second_pass = false;
 
 	if (forks) {
@@ -797,102 +795,97 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			all_counters_use_bpf = false;
 	}
 
-	evlist__for_each_cpu (evsel_list, i, cpu) {
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+		counter = evlist_cpu_itr.evsel;
+
 		/*
 		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
 		 * no need to call it again here.
 		 */
 		if (target.use_bpf)
 			break;
-		affinity__set(&affinity, cpu);
 
-		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
+		if (counter->reset_group || counter->errored)
+			continue;
+		if (evsel__is_bpf(counter))
+			continue;
+try_again:
+		if (create_perf_stat_counter(counter, &stat_config, &target,
+					     evlist_cpu_itr.cpu_map_idx) < 0) {
+
+			/*
+			 * Weak group failed. We cannot just undo this here
+			 * because earlier CPUs might be in group mode, and the kernel
+			 * doesn't support mixing group and non group reads. Defer
+			 * it to later.
+			 * Don't close here because we're in the wrong affinity.
+			 */
+			if ((errno == EINVAL || errno == EBADF) &&
+				evsel__leader(counter) != counter &&
+				counter->weak_group) {
+				evlist__reset_weak_group(evsel_list, counter, false);
+				assert(counter->reset_group);
+				second_pass = true;
 				continue;
-			if (counter->reset_group || counter->errored)
+			}
+
+			switch (stat_handle_error(counter)) {
+			case COUNTER_FATAL:
+				return -1;
+			case COUNTER_RETRY:
+				goto try_again;
+			case COUNTER_SKIP:
 				continue;
-			if (evsel__is_bpf(counter))
+			default:
+				break;
+			}
+
+		}
+		counter->supported = true;
+	}
+
+	if (second_pass) {
+		/*
+		 * Now redo all the weak group after closing them,
+		 * and also close errored counters.
+		 */
+
+		/* First close errored or weak retry */
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+			counter = evlist_cpu_itr.evsel;
+
+			if (!counter->reset_group && !counter->errored)
 				continue;
-try_again:
+
+			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
+		}
+		/* Now reopen weak */
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+			counter = evlist_cpu_itr.evsel;
+
+			if (!counter->reset_group && !counter->errored)
+				continue;
+			if (!counter->reset_group)
+				continue;
+try_again_reset:
+			pr_debug2("reopening weak %s\n", evsel__name(counter));
 			if (create_perf_stat_counter(counter, &stat_config, &target,
-						     counter->cpu_iter - 1) < 0) {
-
-				/*
-				 * Weak group failed. We cannot just undo this here
-				 * because earlier CPUs might be in group mode, and the kernel
-				 * doesn't support mixing group and non group reads. Defer
-				 * it to later.
-				 * Don't close here because we're in the wrong affinity.
-				 */
-				if ((errno == EINVAL || errno == EBADF) &&
-				    evsel__leader(counter) != counter &&
-				    counter->weak_group) {
-					evlist__reset_weak_group(evsel_list, counter, false);
-					assert(counter->reset_group);
-					second_pass = true;
-					continue;
-				}
+						     evlist_cpu_itr.cpu_map_idx) < 0) {
 
 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
 					return -1;
 				case COUNTER_RETRY:
-					goto try_again;
+					goto try_again_reset;
 				case COUNTER_SKIP:
 					continue;
 				default:
 					break;
 				}
-
 			}
 			counter->supported = true;
 		}
 	}
-
-	if (second_pass) {
-		/*
-		 * Now redo all the weak group after closing them,
-		 * and also close errored counters.
-		 */
-
-		evlist__for_each_cpu(evsel_list, i, cpu) {
-			affinity__set(&affinity, cpu);
-			/* First close errored or weak retry */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
-					continue;
-				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
-			}
-			/* Now reopen weak */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip(counter, cpu))
-					continue;
-				if (!counter->reset_group)
-					continue;
-try_again_reset:
-				pr_debug2("reopening weak %s\n", evsel__name(counter));
-				if (create_perf_stat_counter(counter, &stat_config, &target,
-							     counter->cpu_iter - 1) < 0) {
-
-					switch (stat_handle_error(counter)) {
-					case COUNTER_FATAL:
-						return -1;
-					case COUNTER_RETRY:
-						goto try_again_reset;
-					case COUNTER_SKIP:
-						continue;
-					default:
-						break;
-					}
-				}
-				counter->supported = true;
-			}
-		}
-	}
 	affinity__cleanup(&affinity);
 
 	evlist__for_each_entry(evsel_list, counter) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258d..39d294f6c3218 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,36 +342,65 @@ static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
-void evlist__cpu_iter_start(struct evlist *evlist)
-{
-	struct evsel *pos;
-
-	/*
-	 * Reset the per evsel cpu_iter. This is needed because
-	 * each evsel's cpumap may have a different index space,
-	 * and some operations need the index to modify
-	 * the FD xyarray (e.g. open, close)
-	 */
-	evlist__for_each_entry(evlist, pos)
-		pos->cpu_iter = 0;
-}
+struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
+{
+	struct evlist_cpu_iterator itr = {
+		.container = evlist,
+		.evsel = evlist__first(evlist),
+		.cpu_map_idx = 0,
+		.evlist_cpu_map_idx = 0,
+		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
+		.cpu = -1,
+		.affinity = affinity,
+	};
 
-bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
-{
-	if (ev->cpu_iter >= ev->core.cpus->nr)
-		return true;
-	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
-		return true;
-	return false;
+	if (itr.affinity) {
+		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+		affinity__set(itr.affinity, itr.cpu);
+		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
+		/*
+		 * If this CPU isn't in the evsel's cpu map then advance through
+		 * the list.
+		 */
+		if (itr.cpu_map_idx == -1)
+			evlist_cpu_iterator__next(&itr);
+	}
+	return itr;
+}
+
+void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
+{
+	while (evlist_cpu_itr->evsel != evlist__last(evlist_cpu_itr->container)) {
+		evlist_cpu_itr->evsel = evsel__next(evlist_cpu_itr->evsel);
+		evlist_cpu_itr->cpu_map_idx =
+			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
+					  evlist_cpu_itr->cpu);
+		if (evlist_cpu_itr->cpu_map_idx != -1)
+			return;
+	}
+	evlist_cpu_itr->evlist_cpu_map_idx++;
+	if (evlist_cpu_itr->evlist_cpu_map_idx < evlist_cpu_itr->evlist_cpu_map_nr) {
+		evlist_cpu_itr->evsel = evlist__first(evlist_cpu_itr->container);
+		evlist_cpu_itr->cpu =
+			perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
+					  evlist_cpu_itr->evlist_cpu_map_idx);
+		if (evlist_cpu_itr->affinity)
+			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu);
+		evlist_cpu_itr->cpu_map_idx =
+			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
+					  evlist_cpu_itr->cpu);
+		/*
+		 * If this CPU isn't in the evsel's cpu map then advance through
+		 * the list.
+		 */
+		if (evlist_cpu_itr->cpu_map_idx == -1)
+			evlist_cpu_iterator__next(evlist_cpu_itr);
+	}
 }
 
-bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
+bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr)
 {
-	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
-		ev->cpu_iter++;
-		return false;
-	}
-	return true;
+	return evlist_cpu_itr->evlist_cpu_map_idx >= evlist_cpu_itr->evlist_cpu_map_nr;
 }
 
 static int evsel__strcmp(struct evsel *pos, char *evsel_name)
@@ -400,31 +429,26 @@ static int evlist__is_enabled(struct evlist *evlist)
 static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i, imm = 0;
 	bool has_imm = false;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
 	/* Disable 'immediate' events last */
-	for (imm = 0; imm <= 1; imm++) {
-		evlist__for_each_cpu(evlist, i, cpu) {
-			affinity__set(&affinity, cpu);
-
-			evlist__for_each_entry(evlist, pos) {
-				if (evsel__strcmp(pos, evsel_name))
-					continue;
-				if (evsel__cpu_iter_skip(pos, cpu))
-					continue;
-				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
-					continue;
-				if (pos->immediate)
-					has_imm = true;
-				if (pos->immediate != imm)
-					continue;
-				evsel__disable_cpu(pos, pos->cpu_iter - 1);
-			}
+	for (int imm = 0; imm <= 1; imm++) {
+		evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+			pos = evlist_cpu_itr.evsel;
+			if (evsel__strcmp(pos, evsel_name))
+				continue;
+			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			if (pos->immediate)
+				has_imm = true;
+			if (pos->immediate != imm)
+				continue;
+			evsel__disable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 		}
 		if (!has_imm)
 			break;
@@ -462,24 +486,19 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
-
-		evlist__for_each_entry(evlist, pos) {
-			if (evsel__strcmp(pos, evsel_name))
-				continue;
-			if (evsel__cpu_iter_skip(pos, cpu))
-				continue;
-			if (!evsel__is_group_leader(pos) || !pos->core.fd)
-				continue;
-			evsel__enable_cpu(pos, pos->cpu_iter - 1);
-		}
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		pos = evlist_cpu_itr.evsel;
+		if (evsel__strcmp(pos, evsel_name))
+			continue;
+		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
@@ -1264,8 +1283,8 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel)
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i;
 
 	/*
 	 * With perf record core.cpus is usually NULL.
@@ -1279,15 +1298,12 @@ void evlist__close(struct evlist *evlist)
 
 	if (affinity__setup(&affinity) < 0)
 		return;
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
 
-		evlist__for_each_entry_reverse(evlist, evsel) {
-			if (evsel__cpu_iter_skip(evsel, cpu))
-			    continue;
-			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
-		}
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
+				      evlist_cpu_itr.cpu_map_idx);
 	}
+
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__free_fd(&evsel->core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f0..ec177f783ee67 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -325,17 +325,53 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
-#define evlist__for_each_cpu(evlist, index, cpu)	\
-	evlist__cpu_iter_start(evlist);			\
-	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
+/** Iterator state for evlist__for_each_cpu */
+struct evlist_cpu_iterator {
+	/** The list being iterated through. */
+	struct evlist *container;
+	/** The current evsel of the iterator. */
+	struct evsel *evsel;
+	/** The CPU map index corresponding to the evsel->core.cpus for the current CPU. */
+	int cpu_map_idx;
+	/**
+	 * The CPU map index corresponding to evlist->core.all_cpus for the
+	 * current CPU.  Distinct from cpu_map_idx as the evsel's cpu map may
+	 * contain fewer entries.
+	 */
+	int evlist_cpu_map_idx;
+	/** The number of CPU map entries in evlist->core.all_cpus. */
+	int evlist_cpu_map_nr;
+	/** The current CPU of the iterator. */
+	int cpu;
+	/** If present, used to set the affinity when switching between CPUs. */
+	struct affinity *affinity;
+};
+
+/**
+ * evlist__for_each_cpu - without affinity, iterate over the evlist. With
+ *                        affinity, iterate over all CPUs and then the evlist
+ *                        for each evsel on that CPU. When switching between
+ *                        CPUs the affinity is set to the CPU to avoid IPIs
+ *                        during syscalls.
+ * @evlist_cpu_itr: the iterator instance.
+ * @evlist: evlist instance to iterate.
+ * @affinity: NULL or used to set the affinity to the current CPU.
+ */
+#define evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity)		\
+	for ((evlist_cpu_itr) = evlist__cpu_begin(evlist, affinity);	\
+	     !evlist_cpu_iterator__end(&evlist_cpu_itr);		\
+	     evlist_cpu_iterator__next(&evlist_cpu_itr))
+
+/** Returns an iterator set to the first CPU/evsel of evlist. */
+struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity);
+/** Move to next element in iterator, updating CPU, evsel and the affinity. */
+void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr);
+/** Returns true when iterator is at the end of the CPUs and evlist. */
+bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
 
 struct evsel *evlist__get_tracking_event(struct evlist *evlist);
 void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
 
-void evlist__cpu_iter_start(struct evlist *evlist);
-bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
-bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
-
 struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
 struct evsel *evlist__event2evsel(struct evlist *evlist, union perf_event *event);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a6..9372ddd369ef4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,7 +119,6 @@ struct evsel {
 	bool			errored;
 	struct hashmap		*per_pkg_mask;
 	int			err;
-	int			cpu_iter;
 	struct {
 		evsel__sb_cb_t	*cb;
 		void		*data;
-- 
2.39.2



