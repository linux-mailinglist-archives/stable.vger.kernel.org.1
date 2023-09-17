Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4E7A3968
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjIQTst (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjIQTsb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:48:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70933188
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:48:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73475C433C8;
        Sun, 17 Sep 2023 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980103;
        bh=liSoS85Ki91JxZKWflQ2B3GR6U+TDH/OfF3NDZ2S7QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UV8BYqtaBYeRG0TvevLHWqFbrA6jzCBE2Qq482aY1QnoKqmrgsRtvinGsRDUBo99z
         /my9uhIC4z2fFW2JAhuzjJxbkSKBnXn99mPzt25BjwJ9MfuM0ScmqCO6qpP1Dew+vh
         +7EJSnmukiTAVVwJN5GLsyg60GrtM0HvHXf4SLlE=
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
Subject: [PATCH 6.5 071/285] perf parse-events: Separate YYABORT and YYNOMEM cases
Date:   Sun, 17 Sep 2023 21:11:11 +0200
Message-ID: <20230917191054.179104053@linuxfoundation.org>
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

[ Upstream commit a7a3252dad354a9e5c173156dab959e4019b9467 ]

Split cases in event_pmu for greater accuracy.

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
Link: https://lore.kernel.org/r/20230627181030.95608-8-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: b30d4f0b6954 ("perf parse-events: Additional error reporting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 45 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9f28d4b5502f1..6b996f22dee3a 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -285,37 +285,42 @@ event_pmu:
 PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
+	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
-#define CLEANUP_YYABORT					\
+#define CLEANUP						\
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
 		free(pattern);				\
-		YYABORT;				\
 	} while(0)
 
-	if (parse_events_copy_term_list($2, &orig_terms))
-		CLEANUP_YYABORT;
-
 	if (error)
 		error->idx = @1.first_column;
 
+	if (parse_events_copy_term_list($2, &orig_terms)) {
+		CLEANUP;
+		YYNOMEM;
+	}
+
 	list = alloc_list();
-	if (!list)
-		CLEANUP_YYABORT;
+	if (!list) {
+		CLEANUP;
+		YYNOMEM;
+	}
 	/* Attempt to add to list assuming $1 is a PMU name. */
 	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
 		/* Failure to add, try wildcard expansion of $1 as a PMU name. */
-		if (asprintf(&pattern, "%s*", $1) < 0)
-			CLEANUP_YYABORT;
+		if (asprintf(&pattern, "%s*", $1) < 0) {
+			CLEANUP;
+			YYNOMEM;
+		}
 
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 			char *name = pmu->name;
@@ -330,8 +335,10 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-				if (parse_events_copy_term_list(orig_terms, &terms))
-					CLEANUP_YYABORT;
+				if (parse_events_copy_term_list(orig_terms, &terms)) {
+					CLEANUP;
+					YYNOMEM;
+				}
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
 							  auto_merge_stats)) {
 					ok++;
@@ -347,15 +354,15 @@ PE_NAME opt_pmu_config
 			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
 			$2 = NULL;
 		}
-		if (!ok)
-			CLEANUP_YYABORT;
+		if (!ok) {
+			CLEANUP;
+			YYABORT;
+		}
 	}
-	parse_events_terms__delete($2);
-	parse_events_terms__delete(orig_terms);
-	free(pattern);
-	free($1);
 	$$ = list;
-#undef CLEANUP_YYABORT
+	list = NULL;
+	CLEANUP;
+#undef CLEANUP
 }
 |
 PE_KERNEL_PMU_EVENT sep_dc
-- 
2.40.1



