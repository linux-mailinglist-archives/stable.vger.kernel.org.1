Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118F87ECCC4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjKOTca (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjKOTc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5821B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05195C433C8;
        Wed, 15 Nov 2023 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076743;
        bh=EF7rVuSrJIJJ1FthvxSiZE5jAtJfgUgrH84hHDAz9mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ybcshk2yzTCwgYF7+NotXC/Xus4MvUpt7Gi9RTttGqn4/ldOmOPpE67mi536O4q4W
         TG+/8T0a3O9yaJNFdA7W8v37K7Wk7lk3+Psrh9zDx3jWyjYobHiV9LnI1gZW2+mFI+
         lREV7Pk9fB+2wtFSuR57ZJsC4y+I56IAlEgMTQfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 388/550] perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
Date:   Wed, 15 Nov 2023 14:16:12 -0500
Message-ID: <20231115191627.737078401@linuxfoundation.org>
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

[ Upstream commit bf7d46b3a088ccb8f8045c5902d5848bc23286f9 ]

Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
PMUs before parsing").

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230627181030.95608-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: ede72dca45b1 ("perf parse-events: Fix tracepoint name memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 43557f20d0989..1393c39ebf330 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -70,7 +70,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -88,7 +87,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -376,18 +374,6 @@ PE_NAME opt_pmu_config
 #undef CLEANUP
 }
 |
-PE_KERNEL_PMU_EVENT sep_dc
-{
-	struct list_head *list;
-	int err;
-
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
-|
 PE_NAME sep_dc
 {
 	struct list_head *list;
@@ -408,19 +394,6 @@ PE_NAME sep_dc
 	free($1);
 	$$ = list;
 }
-|
-PE_KERNEL_PMU_EVENT opt_pmu_config
-{
-	struct list_head *list;
-	int err;
-
-	/* frees $2 */
-	err = parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.42.0



