Return-Path: <stable+bounces-85371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3899E704
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0121C25E49
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369461D89F5;
	Tue, 15 Oct 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RekkqJPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BC1CFEA9;
	Tue, 15 Oct 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992888; cv=none; b=PgxVbHi98iTqwZ0jNJOxMKssAtBqyenXQyUu3PPFWx4t6S6aQv0VxTPg21cssYB6UetziLIvRM+Djgs//l6HSSIDYaQlGDSbS8JbYqxaGvl2y4jQ7xLaOvyW8Wi2Fem6zimnADUxgzTJCPUU7WdarR03imN5hmABBSr5CpgvQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992888; c=relaxed/simple;
	bh=yAIe1bru6unEFO7jfKwfldFvpImMcFxVmotYwKBtAuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DryDSQubEHSKTqhXJ6VL7EQvlAIzCce1WexdVbE1pkLGjYafxuIJXXqDlA/2PJ6mOpzQCgtMszydON6WTKrHPX18CsZ3nidgO0hJLogI4kKBB4183ddA2hQdHwyWjLnrrO5Td/hblTZjCaQyndMcCYA8eftK9mPg6Xt9upTty3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RekkqJPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C3BC4CEC6;
	Tue, 15 Oct 2024 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992887;
	bh=yAIe1bru6unEFO7jfKwfldFvpImMcFxVmotYwKBtAuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RekkqJPTfaJ8GAB+XmYY6DSy50T803TyyyR4NhY0r+80scIlFMuPZVX0Mfq/GsARW
	 qCq9QfPNZvT46ySaJswVjveXQaTtdq0yEqiMdQgWWeEqQzeuykpWHyOT2YWfsrIZSQ
	 n0F1uq4w0ciRV6fmbiTsVWmvK4QfsUZraWrMzDd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
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
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	zhengjun.xing@intel.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 217/691] perf evsel: Rename variable cpu to index
Date: Tue, 15 Oct 2024 13:22:45 +0200
Message-ID: <20241015112448.970508717@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 6f844b1fdd3bc3a25995ff83edea32a73bfa72d9 ]

Make naming less error prone.

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
Link: https://lore.kernel.org/r/20220105061351.120843-40-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 79bcd34e0f3d ("perf inject: Fix leader sampling inserting additional samples")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel.c | 83 +++++++++++++++++++++--------------------
 tools/perf/util/evsel.h |  6 +--
 tools/perf/util/stat.c  |  4 +-
 tools/perf/util/stat.h  |  2 +-
 4 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b5b8f723e577b..4f4226f380d1c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1364,9 +1364,9 @@ int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 }
 
 /* Caller has to clear disabled after going through all CPUs. */
-int evsel__enable_cpu(struct evsel *evsel, int cpu)
+int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__enable_cpu(&evsel->core, cpu);
+	return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
 }
 
 int evsel__enable(struct evsel *evsel)
@@ -1379,9 +1379,9 @@ int evsel__enable(struct evsel *evsel)
 }
 
 /* Caller has to set disabled after going through all CPUs. */
-int evsel__disable_cpu(struct evsel *evsel, int cpu)
+int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__disable_cpu(&evsel->core, cpu);
+	return perf_evsel__disable_cpu(&evsel->core, cpu_map_idx);
 }
 
 int evsel__disable(struct evsel *evsel)
@@ -1445,7 +1445,7 @@ void evsel__delete(struct evsel *evsel)
 	free(evsel);
 }
 
-void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
+void evsel__compute_deltas(struct evsel *evsel, int cpu_map_idx, int thread,
 			   struct perf_counts_values *count)
 {
 	struct perf_counts_values tmp;
@@ -1453,12 +1453,12 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 	if (!evsel->prev_raw_counts)
 		return;
 
-	if (cpu == -1) {
+	if (cpu_map_idx == -1) {
 		tmp = evsel->prev_raw_counts->aggr;
 		evsel->prev_raw_counts->aggr = *count;
 	} else {
-		tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
-		*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
+		tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+		*perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
 	}
 
 	count->val = count->val - tmp.val;
@@ -1492,20 +1492,21 @@ static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
 	return perf_evsel__read(&evsel->core, cpu, thread, count);
 }
 
-static void evsel__set_count(struct evsel *counter, int cpu, int thread, u64 val, u64 ena, u64 run)
+static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
+			     u64 val, u64 ena, u64 run)
 {
 	struct perf_counts_values *count;
 
-	count = perf_counts(counter->counts, cpu, thread);
+	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
 
-	perf_counts__set_loaded(counter->counts, cpu, thread, true);
+	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 }
 
-static int evsel__process_group_data(struct evsel *leader, int cpu, int thread, u64 *data)
+static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int thread, u64 *data)
 {
 	u64 read_format = leader->core.attr.read_format;
 	struct sample_read_value *v;
@@ -1524,7 +1525,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
 
 	v = (struct sample_read_value *) data;
 
-	evsel__set_count(leader, cpu, thread, v[0].value, ena, run);
+	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
 
 	for (i = 1; i < nr; i++) {
 		struct evsel *counter;
@@ -1533,7 +1534,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
 		if (!counter)
 			return -EINVAL;
 
-		evsel__set_count(counter, cpu, thread, v[i].value, ena, run);
+		evsel__set_count(counter, cpu_map_idx, thread, v[i].value, ena, run);
 	}
 
 	return 0;
@@ -1652,16 +1653,16 @@ static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int
 }
 
 static int update_fds(struct evsel *evsel,
-		      int nr_cpus, int cpu_idx,
+		      int nr_cpus, int cpu_map_idx,
 		      int nr_threads, int thread_idx)
 {
 	struct evsel *pos;
 
-	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
+	if (cpu_map_idx >= nr_cpus || thread_idx >= nr_threads)
 		return -EINVAL;
 
 	evlist__for_each_entry(evsel->evlist, pos) {
-		nr_cpus = pos != evsel ? nr_cpus : cpu_idx;
+		nr_cpus = pos != evsel ? nr_cpus : cpu_map_idx;
 
 		evsel__remove_fd(pos, nr_cpus, nr_threads, thread_idx);
 
@@ -1676,7 +1677,7 @@ static int update_fds(struct evsel *evsel,
 }
 
 static bool evsel__ignore_missing_thread(struct evsel *evsel,
-					 int nr_cpus, int cpu,
+					 int nr_cpus, int cpu_map_idx,
 					 struct perf_thread_map *threads,
 					 int thread, int err)
 {
@@ -1701,7 +1702,7 @@ static bool evsel__ignore_missing_thread(struct evsel *evsel,
 	 * We should remove fd for missing_thread first
 	 * because thread_map__remove() will decrease threads->nr.
 	 */
-	if (update_fds(evsel, nr_cpus, cpu, threads->nr, thread))
+	if (update_fds(evsel, nr_cpus, cpu_map_idx, threads->nr, thread))
 		return false;
 
 	if (thread_map__remove(threads, thread))
@@ -1966,9 +1967,9 @@ bool evsel__increase_rlimit(enum rlimit_action *set_rlimit)
 
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
-		int start_cpu, int end_cpu)
+		int start_cpu_map_idx, int end_cpu_map_idx)
 {
-	int cpu, thread, nthreads;
+	int idx, thread, nthreads;
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
@@ -1995,7 +1996,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	display_attr(&evsel->core.attr);
 
-	for (cpu = start_cpu; cpu < end_cpu; cpu++) {
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
@@ -2006,17 +2007,17 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-			group_fd = get_group_fd(evsel, cpu, thread);
+			group_fd = get_group_fd(evsel, idx, thread);
 
 			test_attr__ready();
 
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, cpus->map[cpu], group_fd, evsel->open_flags);
+				pid, cpus->map[idx], group_fd, evsel->open_flags);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
+			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[idx],
 						group_fd, evsel->open_flags);
 
-			FD(evsel, cpu, thread) = fd;
+			FD(evsel, idx, thread) = fd;
 
 			if (fd < 0) {
 				err = -errno;
@@ -2026,10 +2027,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 				goto try_fallback;
 			}
 
-			bpf_counter__install_pe(evsel, cpu, fd);
+			bpf_counter__install_pe(evsel, idx, fd);
 
 			if (unlikely(test_attr__enabled)) {
-				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
+				test_attr__open(&evsel->core.attr, pid, cpus->map[idx],
 						fd, group_fd, evsel->open_flags);
 			}
 
@@ -2070,7 +2071,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (evsel__precise_ip_fallback(evsel))
 		goto retry_open;
 
-	if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
+	if (evsel__ignore_missing_thread(evsel, cpus->nr, idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
 		nthreads--;
 
@@ -2085,7 +2086,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && evsel__increase_rlimit(&set_rlimit))
 		goto retry_open;
 
-	if (err != -EINVAL || cpu > 0 || thread > 0)
+	if (err != -EINVAL || idx > 0 || thread > 0)
 		goto out_close;
 
 	if (evsel__detect_missing_features(evsel))
@@ -2097,12 +2098,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	old_errno = errno;
 	do {
 		while (--thread >= 0) {
-			if (FD(evsel, cpu, thread) >= 0)
-				close(FD(evsel, cpu, thread));
-			FD(evsel, cpu, thread) = -1;
+			if (FD(evsel, idx, thread) >= 0)
+				close(FD(evsel, idx, thread));
+			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--cpu >= 0);
+	} while (--idx >= 0);
 	errno = old_errno;
 	return err;
 }
@@ -2119,13 +2120,13 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
-int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu)
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
 {
-	if (cpu == -1)
+	if (cpu_map_idx == -1)
 		return evsel__open_cpu(evsel, cpus, NULL, 0,
 					cpus ? cpus->nr : 1);
 
-	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
+	return evsel__open_cpu(evsel, cpus, NULL, cpu_map_idx, cpu_map_idx + 1);
 }
 
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
@@ -2872,15 +2873,15 @@ struct perf_env *evsel__env(struct evsel *evsel)
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
-	int cpu, thread;
+	int cpu_map_idx, thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++) {
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
 		     thread++) {
-			int fd = FD(evsel, cpu, thread);
+			int fd = FD(evsel, cpu_map_idx, thread);
 
 			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core,
-						   cpu, thread, fd) < 0)
+						   cpu_map_idx, thread, fd) < 0)
 				return -1;
 		}
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 461eb0feb5365..9e89dc02a116e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -285,12 +285,12 @@ void arch_evsel__set_sample_weight(struct evsel *evsel);
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
-int evsel__enable_cpu(struct evsel *evsel, int cpu);
+int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
-int evsel__disable_cpu(struct evsel *evsel, int cpu);
+int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx);
 
-int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5a0b3db1cab11..5f0e2ac91cea7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -531,7 +531,7 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target,
-			     int cpu)
+			     int cpu_map_idx)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel__leader(evsel);
@@ -581,7 +581,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
+		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu_map_idx);
 
 	return evsel__open_per_thread(evsel, evsel->core.threads);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 977616cf69e46..5b7a5aeee1c1c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -248,7 +248,7 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target,
-			     int cpu);
+			     int cpu_map_idx);
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts, int argc, const char **argv);
 
-- 
2.43.0




