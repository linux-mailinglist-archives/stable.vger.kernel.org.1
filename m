Return-Path: <stable+bounces-220108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCMmB2Aoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C51C4FF3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7ECE30B4486
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534EB47D954;
	Sat, 28 Feb 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz+GPP3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DB47DD6B;
	Sat, 28 Feb 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300018; cv=none; b=cVYiHzlbuGEwL7OiewkDVxbwHJs6t8erDQoPGLAlU9NmlrkFMfGb7yM6XGyMu9eTm+X8ONiiXM3o9L8+/DkWAcsM5S8hqkMXc2INcNsx5XuTY4HSv6ZostHL1y8knEnBlZVedkJ74dYHv5tmbVnUVaKCmauBIGrEvnwQrvhg5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300018; c=relaxed/simple;
	bh=bSaXqGvxkb3yGTMEVun/Oo/Uh6Aj9cUn7V6/DfCuGGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNMCNJSrYUVyuFjxjkuYrTxH8Rtm0J7TEn8qtZY6r1hJWPCQ8FXegTClutQa86M6FaKjMh1y6WeZZfT8AkrfNjx1UWHpf7kXTYzOklopDBbh+OTWtC2iyB8rKlcMmwSj8uoiyj0Owmt8PykDeNthG3uu8O32wknlwc0s7v2A/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz+GPP3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6653EC116D0;
	Sat, 28 Feb 2026 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300018;
	bh=bSaXqGvxkb3yGTMEVun/Oo/Uh6Aj9cUn7V6/DfCuGGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hz+GPP3f6RXBO7ChSYI7DdHyUr+SjyAoJpT0omE593nTpEuUfj7om+X58JCQ6VunS
	 36pck1LmA0/bCegxfTNo7XF5TgBcuZPvgMzkfuA42Sxp3mYA9ZJbpvp1/EhIf2uMVd
	 b+K/HKOJpQGTcEcMn9o1lByP1jT0tdgiJzz2k6QQ9cVDfkiOIv/jinrfjoMPI6NqIl
	 JuzHxox6yEgQegy4IfxaPUj8bgTijjWR7LMF2XvG5sACYwDPYKN5lXCfSp7K81VEKR
	 U/BsvYu1S/nUDbTcIp5xatdyfJt1R254ioQtCS0D0tABLk0F42zhOCCfQRaY2ySz8k
	 bwbS9WvPaO2Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 030/844] perf stat: Ensure metrics are displayed even with failed events
Date: Sat, 28 Feb 2026 12:19:03 -0500
Message-ID: <20260228173244.1509663-31-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220108-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,arm.com:email,linaro.org:email,infradead.org:email,alibaba.com:email]
X-Rspamd-Queue-Id: B50C51C4FF3
X-Rspamd-Action: no action

From: Chun-Tse Shao <ctshao@google.com>

[ Upstream commit bb5a920b9099127915706fdd23eb540c9a69c338 ]

Currently, `perf stat` skips or hides metrics when the underlying
hardware events cannot be counted (e.g., due to insufficient permissions
or unsupported events).

In `--metric-only` mode, this often results in missing columns or blank
spaces, making the output difficult to parse.

Modify the logic to ensure metrics are consistently displayed by
propagating NAN (Not a Number) through the expression evaluator.
Specifically:

1. Update `prepare_metric()` in stat-shadow.c to treat uncounted events
   (where `run == 0`) as NAN. This leverages the existing math in expr.y
   to propagate NAN through metric expressions.

2. Remove the early return in the display logic's `printout()` function
   that was previously skipping metrics in `--metric-only` mode for
   failed events.
l
3. Simplify `perf_stat__skip_metric_event()` to no longer depend on
   event runtime.

Tested:

1. `perf all metrics test` did not crash while paranoid is 2.

2. Multiple combinations with `CPUs_utilized` while paranoid is 2.

  $ ./perf stat -M CPUs_utilized -a -- sleep 1

   Performance counter stats for 'system wide':

     <not supported> msec cpu-clock:u                      #      nan CPUs  CPUs_utilized
       1,006,356,120      duration_time

         1.004375550 seconds time elapsed

  $ ./perf stat -M CPUs_utilized -a -j -- sleep 1
  {"counter-value" : "<not supported>", "unit" : "msec", "event" : "cpu-clock:u", "event-runtime" : 0, "pcnt-running" : 100.00, "metric-value" : "nan", "metric-unit" : "CPUs  CPUs_utilized"}
  {"counter-value" : "1006642462.000000", "unit" : "", "event" : "duration_time", "event-runtime" : 1, "pcnt-running" : 100.00}

  $ ./perf stat -M CPUs_utilized -a --metric-only -- sleep 1

   Performance counter stats for 'system wide':

    CPUs  CPUs_utilized
                      nan

         1.004424652 seconds time elapsed

  $ ./perf stat -M CPUs_utilized -a --metric-only -j -- sleep 1
  {"CPUs  CPUs_utilized" : "none"}

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 63b320aaac08 ("perf stat-shadow: In prepare_metric fix guard on reading NULL perf_stat_evsel")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-display.c | 59 +++++++++++++++-------------------
 tools/perf/util/stat-shadow.c  |  8 ++---
 tools/perf/util/stat.h         |  2 +-
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d02f84c5691a..f4bd579908b43 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -820,12 +820,6 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
-		if (config->metric_only) {
-			pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL,
-			   /*unit=*/NULL, /*val=*/0);
-			return;
-		}
-
 		ok = false;
 
 		if (counter->supported) {
@@ -848,33 +842,32 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		print_running(config, os, run, ena, /*before_metric=*/true);
 	}
 
-	if (ok) {
-		if (!config->metric_only && counter->default_metricgroup && !counter->default_show_events) {
-			void *from = NULL;
-
-			aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
-			/* Print out all the metricgroup with the same metric event. */
-			do {
-				int num = 0;
-
-				/* Print out the new line for the next new metricgroup. */
-				if (from) {
-					if (config->json_output)
-						new_line_json(config, (void *)os);
-					else
-						__new_line_std_csv(config, os);
-				}
-
-				print_noise(config, os, counter, noise, /*before_metric=*/true);
-				print_running(config, os, run, ena, /*before_metric=*/true);
-				from = perf_stat__print_shadow_stats_metricgroup(config, counter, aggr_idx,
-										 &num, from, &out);
-			} while (from != NULL);
-		} else {
-			perf_stat__print_shadow_stats(config, counter, aggr_idx, &out);
-		}
+	if (!config->metric_only && counter->default_metricgroup &&
+	    !counter->default_show_events) {
+		void *from = NULL;
+
+		aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
+		/* Print out all the metricgroup with the same metric event. */
+		do {
+			int num = 0;
+
+			/* Print out the new line for the next new metricgroup. */
+			if (from) {
+				if (config->json_output)
+					new_line_json(config, (void *)os);
+				else
+					__new_line_std_csv(config, os);
+			}
+
+			print_noise(config, os, counter, noise,
+				    /*before_metric=*/true);
+			print_running(config, os, run, ena,
+				      /*before_metric=*/true);
+			from = perf_stat__print_shadow_stats_metricgroup(
+				config, counter, aggr_idx, &num, from, &out);
+		} while (from != NULL);
 	} else {
-		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/NULL, /*val=*/0);
+		perf_stat__print_shadow_stats(config, counter, aggr_idx, &out);
 	}
 
 	if (!config->metric_only) {
@@ -987,7 +980,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	if (perf_stat__skip_metric_event(counter, ena, run))
+	if (perf_stat__skip_metric_event(counter))
 		return;
 
 	if (val == 0 && should_skip_zero_counter(config, counter, &id))
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9c83f7d96caa4..5d8d09e0e6ae5 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -83,7 +83,7 @@ static int prepare_metric(struct perf_stat_config *config,
 		}
 		/* Time events are always on CPU0, the first aggregation index. */
 		aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
-		if (!aggr || !metric_events[i]->supported) {
+		if (!aggr || !metric_events[i]->supported || aggr->counts.run == 0) {
 			/*
 			 * Not supported events will have a count of 0, which
 			 * can be confusing in a metric. Explicitly set the
@@ -335,14 +335,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
  * perf_stat__skip_metric_event - Skip the evsel in the Default metricgroup,
  *				  if it's not running or not the metric event.
  */
-bool perf_stat__skip_metric_event(struct evsel *evsel,
-				  u64 ena, u64 run)
+bool perf_stat__skip_metric_event(struct evsel *evsel)
 {
 	if (!evsel->default_metricgroup)
 		return false;
 
-	if (!ena || !run)
-		return true;
-
 	return !metricgroup__lookup(&evsel->evlist->metric_events, evsel, false);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f986911c9296e..4bced233d2fc0 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -163,7 +163,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   int aggr_idx,
 				   struct perf_stat_output_ctx *out);
-bool perf_stat__skip_metric_event(struct evsel *evsel, u64 ena, u64 run);
+bool perf_stat__skip_metric_event(struct evsel *evsel);
 void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 						struct evsel *evsel,
 						int aggr_idx,
-- 
2.51.0


