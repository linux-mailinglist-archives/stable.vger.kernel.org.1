Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73807A3967
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjIQTsu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbjIQTsi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:48:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02329C6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:48:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E7C433C9;
        Sun, 17 Sep 2023 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980106;
        bh=R4P+QAYZA8cVQSdWkPcrpFakoLzNiUhtTQK1L25r++Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Di7sQX3aDbQ8fWwHV8pEE4RjODYsXejzDZ6zhXyFK0+vzVhzzBz8JzxBkr1lUtR5w
         yY84oxaB5J5b+/NRnKPxS1v9U3rvekR/KofSs6ATcmIdSt+436Cd+zrasr24oJ89ww
         LCfVFrATobebkFNPCy0Ley2c/AWyp15GTKLGM47E=
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
Subject: [PATCH 6.5 072/285] perf parse-events: Move instances of YYABORT to YYNOMEM
Date:   Sun, 17 Sep 2023 21:11:12 +0200
Message-ID: <20230917191054.210193114@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 77cdd787fc45e3426b8e0b5038b85c276540dfb4 ]

Migration to improve error reporting as YYABORT cases should carry
event parsing errors.

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
Link: https://lore.kernel.org/r/20230627181030.95608-9-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: b30d4f0b6954 ("perf parse-events: Additional error reporting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 58 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6b996f22dee3a..78c1f49d8d7e4 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -455,7 +455,8 @@ value_sym '/' event_config '/'
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
 	parse_events_terms__delete($3);
 	if (err) {
@@ -473,7 +474,8 @@ value_sym sep_slash_slash_dc
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
 					  /*head_config=*/NULL, wildcard));
 	$$ = list;
@@ -484,7 +486,8 @@ PE_VALUE_SYM_TOOL sep_slash_slash_dc
 	struct list_head *list;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	ABORT_ON(parse_events_add_tool(_parse_state, list, $1));
 	$$ = list;
 }
@@ -497,7 +500,9 @@ PE_LEGACY_CACHE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
 
 	parse_events_terms__delete($2);
@@ -516,7 +521,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, $6, $4, $7);
 	parse_events_terms__delete($7);
@@ -534,7 +541,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, NULL, $4, $5);
 	parse_events_terms__delete($5);
@@ -551,7 +560,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, $4, 0, $5);
 	parse_events_terms__delete($5);
@@ -569,7 +580,8 @@ PE_PREFIX_MEM PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, NULL, 0, $3);
 	parse_events_terms__delete($3);
@@ -589,7 +601,8 @@ tracepoint_name opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	if (error)
 		error->idx = @1.first_column;
 
@@ -621,7 +634,8 @@ PE_VALUE ':' PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4,
 				       /*wildcard=*/false);
 	parse_events_terms__delete($4);
@@ -640,7 +654,8 @@ PE_RAW opt_event_config
 	u64 num;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	errno = 0;
 	num = strtoull($1 + 1, NULL, 16);
 	ABORT_ON(errno);
@@ -663,7 +678,8 @@ PE_BPF_OBJECT opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_load_bpf(parse_state, list, $1, false, $2);
 	parse_events_terms__delete($2);
 	free($1);
@@ -680,7 +696,8 @@ PE_BPF_SOURCE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_load_bpf(_parse_state, list, $1, true, $2);
 	parse_events_terms__delete($2);
 	if (err) {
@@ -745,7 +762,8 @@ event_term
 	struct list_head *head = malloc(sizeof(*head));
 	struct parse_events_term *term = $1;
 
-	ABORT_ON(!head);
+	if (!head)
+		YYNOMEM;
 	INIT_LIST_HEAD(head);
 	list_add_tail(&term->list, head);
 	$$ = head;
@@ -922,7 +940,8 @@ PE_DRV_CFG_TERM
 	struct parse_events_term *term;
 	char *config = strdup($1);
 
-	ABORT_ON(!config);
+	if (!config)
+		YYNOMEM;
 	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 					config, $1, &@1, NULL)) {
 		free($1);
@@ -953,7 +972,8 @@ array_terms ',' array_term
 	new_array.ranges = realloc($1.ranges,
 				sizeof(new_array.ranges[0]) *
 				new_array.nr_ranges);
-	ABORT_ON(!new_array.ranges);
+	if (!new_array.ranges)
+		YYNOMEM;
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
 	free($3.ranges);
@@ -969,7 +989,8 @@ PE_VALUE
 
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
+	if (!array.ranges)
+		YYNOMEM;
 	array.ranges[0].start = $1;
 	array.ranges[0].length = 1;
 	$$ = array;
@@ -982,7 +1003,8 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 	ABORT_ON($3 < $1);
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
+	if (!array.ranges)
+		YYNOMEM;
 	array.ranges[0].start = $1;
 	array.ranges[0].length = $3 - $1 + 1;
 	$$ = array;
-- 
2.40.1



