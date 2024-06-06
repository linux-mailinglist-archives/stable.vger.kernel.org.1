Return-Path: <stable+bounces-49715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B58FEE8C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24F8B217F3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6031C538C;
	Thu,  6 Jun 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fu59dD/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E5196D90;
	Thu,  6 Jun 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683673; cv=none; b=Pd90d6E+ylVILOQ5lnhKS1szLfhLYZ+beczJ33k2EHV5Ke/pRmE1ybFBWCBQ+HYm3y/2mgm1sOoaEIaf9vzTjuSZvNuoykpPaL6M8dAzgkumziZrFrjNoCiG1U6qS8QC9t8mt9S37z5AXgfbBGQHIb2FFK0KWx7il20xvIQZvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683673; c=relaxed/simple;
	bh=uTbaq+RNaE89DRsq35IppZShW+xlSgzEbaaXvKBLk1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCj8b9eaU2mzf5xu+FuPRNc76PfSRcQhZn2qeIKPITfYNMfO3bYYPVAolsQOgTkX3Blj811XtKab4tfW2ENeD+rc0bqCnmIDYbAdr2Gc9N9BfnWo2aR8eaWzSTy53lcck6tpy/Ww4yVkZZKXMWaT8A/7c7ikXNwYUj2EPu59q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fu59dD/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342CEC2BD10;
	Thu,  6 Jun 2024 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683673;
	bh=uTbaq+RNaE89DRsq35IppZShW+xlSgzEbaaXvKBLk1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu59dD/7eSzEczhhCOG4VqDjuJbL7mtHQF6z/qVy6ksH9MoOYzpV5He88iEfslUNW
	 MHQgypTQlHD1CNpLLvhuz7fP2U1GJnjiI/KKxSuubTpl3wbgemViLaU54sYrKdl/tz
	 ZtIR48o9aPePKzUPlnvEzxxVXVmJLireeFZig4x8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kaige Ye <ye@kaige.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 524/744] perf stat: Dont display metric header for non-leader uncore events
Date: Thu,  6 Jun 2024 16:03:16 +0200
Message-ID: <20240606131749.251950240@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 193a9e30207f54777ff42d0d8be8389edc522277 ]

On an Intel tigerlake laptop a metric like:

    {
        "BriefDescription": "Test",
        "MetricExpr": "imc_free_running@data_read@ + imc_free_running@data_write@",
        "MetricGroup": "Test",
        "MetricName": "Test",
        "ScaleUnit": "6.103515625e-5MiB"
    },

Will have 4 events:

  uncore_imc_free_running_0/data_read/
  uncore_imc_free_running_0/data_write/
  uncore_imc_free_running_1/data_read/
  uncore_imc_free_running_1/data_write/

If aggregration is disabled with metric-only 2 column headers are
needed:

  $ perf stat -M test --metric-only -A -a sleep 1

   Performance counter stats for 'system wide':

                    MiB  Test            MiB  Test
  CPU0                 1821.0               1820.5

But when not, the counts aggregated in the metric leader and only 1
column should be shown:

  $ perf stat -M test --metric-only -a sleep 1
   Performance counter stats for 'system wide':

              MiB  Test
                5909.4

         1.001258915 seconds time elapsed

Achieve this by skipping events that aren't metric leaders when
printing column headers and aggregation isn't disabled.

The bug is long standing, the fixes tag is set to a refactor as that
is as far back as is reasonable to backport.

Fixes: 088519f318be3a41 ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kaige Ye <ye@kaige.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20240510051309.2452468-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 969ce40096330..0abe35388ab15 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1207,6 +1207,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
+		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+			continue;
+
 		os.evsel = counter;
 
 		perf_stat__print_shadow_stats(config, counter, 0,
-- 
2.43.0




