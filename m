Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B247034F4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbjEOQy1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243141AbjEOQyL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF34C3D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADB8629BD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A544C433EF;
        Mon, 15 May 2023 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169621;
        bh=mA5Af+3HT9Wflv+pWq1SnJ1P4qY8NLhpPM0eIDceUi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzHBstvN8hyVG6YnGUJaoPfnsShdt3YG5LzlQZApcCIgawnL2lTt46yOZ8o5ux6G/
         JhwggdjfD8TMiyMf6qXuMlgoN6PoWNT80VJsxlMcf+SRQtTELG18AHZt55Cgj1kkw2
         Ca5t2t0kSk7FNJrwIydla5qjyf2RId7otEPg1CAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Shi <shy828301@gmail.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, coresight@lists.linaro.org,
        denik@google.com, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 115/246] perf cs-etm: Fix timeless decode mode detection
Date:   Mon, 15 May 2023 18:25:27 +0200
Message-Id: <20230515161726.023499152@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: James Clark <james.clark@arm.com>

[ Upstream commit 449067f3fc9f340da54e383738286881e6634d0b ]

In this context, timeless refers to the trace data rather than the perf
event data. But when detecting whether there are timestamps in the trace
data or not, the presence of a timestamp flag on any perf event is used.

Since commit f42c0ce573df ("perf record: Always get text_poke events
with --kcore option") timestamps were added to a tracking event when
--kcore is used which breaks this detection mechanism. Fix it by
detecting if trace timestamps exist by looking at the ETM config flags.
This would have always been a more accurate way of doing it anyway.

This fixes the following error message when using --kcore with
Coresight:

  $ perf record --kcore -e cs_etm// --per-thread
  $ perf report
  The perf.data/data data has no samples!

Fixes: f42c0ce573df79d1 ("perf record: Always get text_poke events with --kcore option")
Reported-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: coresight@lists.linaro.org
Cc: denik@google.com
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/lkml/CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com/
Link: https://lore.kernel.org/r/20230424134748.228137-2-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cs-etm.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f65bac5ddbdb6..e43bc9eea3087 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2517,26 +2517,29 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
+static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
 {
 	struct evsel *evsel;
 	struct evlist *evlist = etm->session->evlist;
-	bool timeless_decoding = true;
 
 	/* Override timeless mode with user input from --itrace=Z */
-	if (etm->synth_opts.timeless_decoding)
-		return true;
+	if (etm->synth_opts.timeless_decoding) {
+		etm->timeless_decoding = true;
+		return 0;
+	}
 
 	/*
-	 * Circle through the list of event and complain if we find one
-	 * with the time bit set.
+	 * Find the cs_etm evsel and look at what its timestamp setting was
 	 */
-	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
-			timeless_decoding = false;
-	}
+	evlist__for_each_entry(evlist, evsel)
+		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
+			etm->timeless_decoding =
+				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
+			return 0;
+		}
 
-	return timeless_decoding;
+	pr_err("CS ETM: Couldn't find ETM evsel\n");
+	return -EINVAL;
 }
 
 /*
@@ -2943,7 +2946,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
-	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
 	/* Use virtual timestamps if all ETMs report ts_source = 1 */
 	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
@@ -2960,6 +2962,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
+	err = cs_etm__setup_timeless_decoding(etm);
+	if (err)
+		return err;
+
 	etm->unknown_thread = thread__new(999999999, 999999999);
 	if (!etm->unknown_thread) {
 		err = -ENOMEM;
-- 
2.39.2



