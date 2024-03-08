Return-Path: <stable+bounces-27153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E790876729
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35A7281E96
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAB1DA2E;
	Fri,  8 Mar 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJymMoF4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C91DFE8
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911013; cv=none; b=FqzGcY0Lwknx5HdCJebS1+Tvol75Y5F2RVMp5SFUTalY3AuDzo5i4bVagIV3k/WUnD9ClZgYgWyYwNi/xZOAHmrqf9J62qNkYN8KM7nd7shaNJffudJcWwoExivxZOr6ehqCTFZGHvKncKrb4V08HNgJaWxQRKnVQvcqKvWp0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911013; c=relaxed/simple;
	bh=5L7LindMAqXUEzH7rFD8FM22NFgiOGewMEZVVgVM7Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoOcn5fQQRAgqSesNsMH7S+ZaTNXp/HDf71fpgvMCJlUStk0G7a66AyVXo2qtNrUTBr6P0vm+jX4bS6pWMo8Vd+1WOYrHdscn3VKKGbkTZloWTpf3Iwfx3cvX89i8RUkCy9FWYqHMdmEVQwhmIEwQfbLeiVOQYU/aSLVUvyWJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJymMoF4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709911011; x=1741447011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5L7LindMAqXUEzH7rFD8FM22NFgiOGewMEZVVgVM7Kk=;
  b=NJymMoF4HbeoPO8rKBVjcmZu7jJRFi++iTzi72nbpGFhjlCXSY4anxvA
   5dq7d1+L4L5dDIhgUD28p3Na4AcrbhhxV3lGUDEtAf1E4ynkSZZbBSM6w
   5b5cdU7qno0OUtrdET8VBr1w8NvbMYbk5b6JCQMv8g2/v2kiIwT93fE2w
   QhIC+0Mi3/aJj6XGcCMG2ot4uPBM02FjZ8BfCt+rVzPBL9uwjEFHoes5J
   rvn77K/8IpASbDNH6hELMRzLJHm3URpGTRVniv4JR2j1Cn2s84h1pg3TC
   +V1nm7RNpbiAX5W1zrfQ+9COvsjvd1Vd7/FHn65MLTuPLm+OUU+F4yAzt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="5233286"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="5233286"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="47948794"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 08 Mar 2024 07:13:35 -0800
From: kan.liang@linux.intel.com
To: stable@vger.kernel.org
Cc: andrew.brown@intel.com,
	dave.hansen@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH stable 6.6 and 6.7 2/2] perf top: Uniform the event name for the hybrid machine
Date: Fri,  8 Mar 2024 07:12:39 -0800
Message-Id: <20240308151239.2414774-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240308151239.2414774-1-kan.liang@linux.intel.com>
References: <20240308151239.2414774-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[The patch set is to fix the perf top failure on all Intel hybrid
machines. Without the patch, the default perf top command is broken.

I have verified that the patches on both stable 6.6 and 6.7. They can
be applied to stable 6.6 and 6.7 tree without any modification as well.

Please consider to apply them to stable 6.6 and 6.7. Thanks]

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit a61f89bf76ef6f87ec48dd90dbc73a6cf9952edc ]

It's hard to distinguish the default cycles events among hybrid PMUs.
For example,

  $ perf top
  Available samples
  385 cycles:P
  903 cycles:P

The other tool, e.g., perf record, uniforms the event name and adds the
hybrid PMU name before opening the event. So the events can be easily
distinguished. Apply the same methodology for the perf top as well.

The evlist__uniquify_name() will be invoked by both record and top.
Move it to util/evlist.c

With the patch:

  $ perf top
  Available samples
  148 cpu_atom/cycles:P/
  1K cpu_core/cycles:P/

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20231214144612.1092028-2-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 28 +---------------------------
 tools/perf/builtin-top.c    |  1 +
 tools/perf/util/evlist.c    | 25 +++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 34bb31f08bb5..ad0e4dbe4e86 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2184,32 +2184,6 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
-static void record__uniquify_name(struct record *rec)
-{
-	struct evsel *pos;
-	struct evlist *evlist = rec->evlist;
-	char *new_name;
-	int ret;
-
-	if (perf_pmus__num_core_pmus() == 1)
-		return;
-
-	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_hybrid(pos))
-			continue;
-
-		if (strchr(pos->name, '/'))
-			continue;
-
-		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
-		if (ret) {
-			free(pos->name);
-			pos->name = new_name;
-		}
-	}
-}
-
 static int record__terminate_thread(struct record_thread *thread_data)
 {
 	int err;
@@ -2443,7 +2417,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->core.nr_entries == 1)
 		rec->opts.sample_id = true;
 
-	record__uniquify_name(rec);
+	evlist__uniquify_name(rec->evlist);
 
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index cce9350177e2..cd64ae44ccbd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1299,6 +1299,7 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	evlist__uniquify_name(top->evlist);
 	ret = perf_top__start_counters(top);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8a8fe1fa0d38..8bf537a29809 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2507,3 +2507,28 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 	}
 	perf_cpu_map__put(user_requested_cpus);
 }
+
+void evlist__uniquify_name(struct evlist *evlist)
+{
+	struct evsel *pos;
+	char *new_name;
+	int ret;
+
+	if (perf_pmus__num_core_pmus() == 1)
+		return;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!evsel__is_hybrid(pos))
+			continue;
+
+		if (strchr(pos->name, '/'))
+			continue;
+
+		ret = asprintf(&new_name, "%s/%s/",
+			       pos->pmu_name, pos->name);
+		if (ret) {
+			free(pos->name);
+			pos->name = new_name;
+		}
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 664c6bf7b3e0..d63486261fd2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -441,5 +441,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
+void evlist__uniquify_name(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
-- 
2.34.1


