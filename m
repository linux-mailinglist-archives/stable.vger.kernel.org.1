Return-Path: <stable+bounces-96942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB919E2244
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E0168BEE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9A1F75A0;
	Tue,  3 Dec 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyHz5r8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C01D9341;
	Tue,  3 Dec 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239045; cv=none; b=DvXXac65jQl0PUs4CEQkljiGOOahQKDfacd9TAENvzFqbagJ/dYeDyQ/8AobHG+e6YXI3AYYBuY0BbnIl1CqLSftkzaT5SM8cT2oRUh0eLn0ssN3esD6XCUz9khElXt8wMo0MGmsHJbXBz6GtDki+uVVolaXUf6mzzLyE4DrKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239045; c=relaxed/simple;
	bh=EF4xBJvDmICYpURJnWySEzsRhbId8eDhxP+tp8kHEeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JW3UfsLAQXebv7Kc1prP7zoAXTUVKtsluAJ0ulUhHoOhXsxXIs/L/DovlWQam8OcEbGCwbQ4Yj0Ebyf4yBw/BVCVs6bblDaEmkUdin3MoAFIVcis2/6dfe38l0khMfgGvkJxNrs9o6Md5tjsM6X45TbEOGFrsSpgiWvSoHYBkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyHz5r8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0369C4CED8;
	Tue,  3 Dec 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239045;
	bh=EF4xBJvDmICYpURJnWySEzsRhbId8eDhxP+tp8kHEeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyHz5r8IEjMtaIrGNgJM3FnF3PnljAxABhWOLs8Ob2qmgMNl4LdqHDGgDyp2tgwkY
	 maEnNSpzsgL6yyEA3STbMraWx/Ax89Dmi72sECfiHOqcBPs3M0MxGMxF6Buu7anHO/
	 c/TJuD03lJCq9ayY9oYC+4ajn+weCXtHs5617/9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Leo Yan <leo.yan@linux.dev>,
	ak@linux.intel.com,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	John Garry <john.g.garry@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 486/817] perf stat: Uniquify event name improvements
Date: Tue,  3 Dec 2024 15:40:58 +0100
Message-ID: <20241203144014.842031727@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 057f8bfc6f7070577523d1e3081081bbf4229c1c ]

Without aggregation on Intel:
```
$ perf stat -e instructions,cycles ...
```
Will use "cycles" for the name of the legacy cycles event but as
"instructions" has a sysfs name it will and a "[cpu]" PMU suffix. This
often breaks things as the space between the event and the PMU name
look like an extra column. The existing uniquify logic was also
uniquifying in cases when all events are core and not with uncore
events, it was not correctly handling modifiers, etc.

Change the logic so that an initial pass that can disable
uniquification is run. For individual counters, disable uniquification
in more cases such as for consistency with legacy events or for
libpfm4 events. Don't use the "[pmu]" style suffix in uniquification,
always use "pmu/.../". Change how modifiers/terms are handled in the
uniquification so that they look like parse-able events.

This fixes "102: perf stat metrics (shadow stat) test:" that has been
failing due to "instructions [cpu]" breaking its column/awk logic when
values aren't aggregated. This started happening when instructions
could match a sysfs rather than a legacy event, so the fixes tag
reflects this.

Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
[ Fix Intel TPEBS counting mode test ]
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
Cc: Yang Jihong <yangjihong@bytedance.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ze Gao <zegao2021@gmail.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Weilin Wang <weilin.wang@intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: ak@linux.intel.com
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Sun Haiyong <sunhaiyong@loongson.cn>
Cc: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20240926144851.245903-3-james.clark@linaro.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/stat-display.c                | 101 ++++++++++++++----
 2 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index c60b29add9801..9a11f42d153ca 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -8,12 +8,15 @@ grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
 # Use this event for testing because it should exist in all platforms
 event=cache-misses:R
 
+# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
+alt_name=/cache-misses/R
+
 # Without this cmd option, default value or zero is returned
-echo "Testing without --record-tpebs"
-result=$(perf stat -e "$event" true 2>&1)
-[[ "$result" =~ $event ]] || exit 1
+#echo "Testing without --record-tpebs"
+#result=$(perf stat -e "$event" true 2>&1)
+#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
 
 # In platforms that do not support TPEBS, it should execute without error.
 echo "Testing with --record-tpebs"
 result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
-[[ "$result" =~ "perf record" && "$result" =~ $event ]] || exit 1
+[[ "$result" =~ "perf record" && "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea96e4ebad8c8..cbff43ff8d0fb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -871,38 +871,66 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 static void uniquify_event_name(struct evsel *counter)
 {
-	char *new_name;
-	char *config;
-	int ret = 0;
+	const char *name, *pmu_name;
+	char *new_name, *config;
+	int ret;
 
-	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
-					   strlen(counter->pmu_name)))
+	/* The evsel was already uniquified. */
+	if (counter->uniquified_name)
 		return;
 
-	config = strchr(counter->name, '/');
+	/* Avoid checking to uniquify twice. */
+	counter->uniquified_name = true;
+
+	/* The evsel has a "name=" config term or is from libpfm. */
+	if (counter->use_config_name || counter->is_libpfm_event)
+		return;
+
+	/* Legacy no PMU event, don't uniquify. */
+	if  (!counter->pmu ||
+	     (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW))
+		return;
+
+	/* A sysfs or json event replacing a legacy event, don't uniquify. */
+	if (counter->pmu->is_core && counter->alternate_hw_config != PERF_COUNT_HW_MAX)
+		return;
+
+	name = evsel__name(counter);
+	pmu_name = counter->pmu->name;
+	/* Already prefixed by the PMU name. */
+	if (!strncmp(name, pmu_name, strlen(pmu_name)))
+		return;
+
+	config = strchr(name, '/');
 	if (config) {
-		if (asprintf(&new_name,
-			     "%s%s", counter->pmu_name, config) > 0) {
-			free(counter->name);
-			counter->name = new_name;
-		}
-	} else {
-		if (evsel__is_hybrid(counter)) {
-			ret = asprintf(&new_name, "%s/%s/",
-				       counter->pmu_name, counter->name);
+		int len = config - name;
+
+		if (config[1] == '/') {
+			/* case: event// */
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
 		} else {
-			ret = asprintf(&new_name, "%s [%s]",
-				       counter->name, counter->pmu_name);
+			/* case: event/.../ */
+			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
 		}
+	} else {
+		config = strchr(name, ':');
+		if (config) {
+			/* case: event:.. */
+			int len = config - name;
 
-		if (ret) {
-			free(counter->name);
-			counter->name = new_name;
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
+		} else {
+			/* case: event */
+			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
 		}
 	}
-
-	counter->uniquified_name = true;
+	if (ret > 0) {
+		free(counter->name);
+		counter->name = new_name;
+	} else {
+		/* ENOMEM from asprintf. */
+		counter->uniquified_name = false;
+	}
 }
 
 static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
@@ -1559,6 +1587,31 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
+static void disable_uniquify(struct evlist *evlist)
+{
+	struct evsel *counter;
+	struct perf_pmu *last_pmu = NULL;
+	bool first = true;
+
+	evlist__for_each_entry(evlist, counter) {
+		/* If PMUs vary then uniquify can be useful. */
+		if (!first && counter->pmu != last_pmu)
+			return;
+		first = false;
+		if (counter->pmu) {
+			/* Allow uniquify for uncore PMUs. */
+			if (!counter->pmu->is_core)
+				return;
+			/* Keep hybrid event names uniquified for clarity. */
+			if (perf_pmus__num_core_pmus() > 1)
+				return;
+		}
+	}
+	evlist__for_each_entry_continue(evlist, counter) {
+		counter->uniquified_name = true;
+	}
+}
+
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts,
 			    int argc, const char **argv)
@@ -1572,6 +1625,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
+	disable_uniquify(evlist);
+
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
-- 
2.43.0




