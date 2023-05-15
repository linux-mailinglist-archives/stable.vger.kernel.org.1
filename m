Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF9703640
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbjEORIQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbjEORHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F07AB4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08FB262AA7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04B3C433EF;
        Mon, 15 May 2023 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170332;
        bh=MrpB9z0J6gO/McZWH9KQ5LiAs8arGJOOrHoF9cZXNEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jGKkFLYpZXH1kRuzg/z2JBxdYXABDMNZsoGOPaFRUBLm8UhuAuDtiBpSXwUde4xj
         dkXJB8TxnQ2zCiIvZpuejabQPbVh5avS8f/xgDrMrNhHT05Uzc4x2C9pHiXMsn6kiN
         v/4QyLw8fiB9Yg3/gHqbDh07uOinMGXPUIn/aD68=
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
Subject: [PATCH 6.1 098/239] perf cs-etm: Fix timeless decode mode detection
Date:   Mon, 15 May 2023 18:26:01 +0200
Message-Id: <20230515161724.617421950@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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
index 16db965ac995e..09e240e4477d0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2488,26 +2488,29 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
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
 
 static const char * const cs_etm_global_header_fmts[] = {
@@ -3051,7 +3054,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->snapshot_mode = (hdr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
-	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
@@ -3061,6 +3063,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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



