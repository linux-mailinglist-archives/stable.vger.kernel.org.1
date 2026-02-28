Return-Path: <stable+bounces-220109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAQXI3Aoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4084A1C5009
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02D9730B6304
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211647DD7E;
	Sat, 28 Feb 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWB8LFIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509F47DD65;
	Sat, 28 Feb 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300020; cv=none; b=sIEA+lJqiU4MpiIlg6mBElFmhtKDvb3jMKSl321QZK+ttvkODDZP6SgQWOa02/lJxGLiyYZZefUHzqd66+lB2+n6XqrRGBOnDQh6iXs4CeLnax78Z1sQiNg31j3dyxjay1QCxg9y2eXn2FsQPxk8d8DydwR6gimThVttPaAtuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300020; c=relaxed/simple;
	bh=JR68V0AaPNuDBa1mHAvLSTn9vSVneWjfgN9rsMZwjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ph9CC20npcmW2feoXRYcWZbNiehHCcPEmtzb4HpB+QeIeODvl88yBMlXHLQX/uYQk1ffoPEY+zZo/h4F1fVTATHAcFYAVzG37RxXj1IqXfiuJrMpbrFuOWQIxVwixHrwSAsqO/6F9xOCfpTR/sn9RlxeKKBiMVZv3LwskG/LWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWB8LFIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4628FC116D0;
	Sat, 28 Feb 2026 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300020;
	bh=JR68V0AaPNuDBa1mHAvLSTn9vSVneWjfgN9rsMZwjUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWB8LFIQwdgl+Y1baiFe9YsxvpFpfiNBlsqdP5y83Bd6xZy2onPh/mcTG0++jqrJa
	 Nr3wV1jSUdXJIbZZy3/prGe3dybzNVMAKv72Cpec/f1+fSq6M3TAcWpTvo4aq+muRT
	 K0xCejO7O4SPZj6M3HzEh9G/H/bzZXAOTHDwbb8rz8mpjMKHUUrNnLgd4mMxZtR7nc
	 2GijrKVHqnjH8TH2E1LKlRCne/pwwyd0jT0CFsCgLzeiajhQ3hM8gFr98OUz/J+hQj
	 b908iv1zCfXq3OCVqMHt6Ozszv3DIhd+u+fq6DV7/MEm33sQRnViL9Lz5leRtqCh8j
	 yEJ2JiEfHZXbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Andres Freund <andres@anarazel.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 031/844] perf stat-shadow: In prepare_metric fix guard on reading NULL perf_stat_evsel
Date: Sat, 28 Feb 2026 12:19:04 -0500
Message-ID: <20260228173244.1509663-32-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220109-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4084A1C5009
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 63b320aaac08ba267268ec21a195ce3c82dcb8ab ]

The aggr value is setup to always be non-null creating a redundant
guard for reading from it. Switch to using the perf_stat_evsel (ps)
and narrow the scope of aggr so that it is known valid when used.

Fixes: 3d65f6445fd93e3e ("perf stat-shadow: Read tool events directly")
Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Dr. David Alan Gilbert <linux@treblig.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-shadow.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 5d8d09e0e6ae5..59d2cd4f2188d 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -57,7 +57,6 @@ static int prepare_metric(struct perf_stat_config *config,
 		bool is_tool_time =
 			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
 		struct perf_stat_evsel *ps = metric_events[i]->stats;
-		struct perf_stat_aggr *aggr;
 		char *n;
 		double val;
 
@@ -82,8 +81,7 @@ static int prepare_metric(struct perf_stat_config *config,
 			}
 		}
 		/* Time events are always on CPU0, the first aggregation index. */
-		aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
-		if (!aggr || !metric_events[i]->supported || aggr->counts.run == 0) {
+		if (!ps || !metric_events[i]->supported) {
 			/*
 			 * Not supported events will have a count of 0, which
 			 * can be confusing in a metric. Explicitly set the
@@ -93,11 +91,21 @@ static int prepare_metric(struct perf_stat_config *config,
 			val = NAN;
 			source_count = 0;
 		} else {
-			val = aggr->counts.val;
-			if (is_tool_time)
-				val *= 1e-9; /* Convert time event nanoseconds to seconds. */
-			if (!source_count)
-				source_count = evsel__source_count(metric_events[i]);
+			struct perf_stat_aggr *aggr =
+				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
+
+			if (aggr->counts.run == 0) {
+				val = NAN;
+				source_count = 0;
+			} else {
+				val = aggr->counts.val;
+				if (is_tool_time) {
+					/* Convert time event nanoseconds to seconds. */
+					val *= 1e-9;
+				}
+				if (!source_count)
+					source_count = evsel__source_count(metric_events[i]);
+			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.51.0


