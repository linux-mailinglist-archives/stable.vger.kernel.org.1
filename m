Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6187A394F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjIQTrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbjIQTr2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:47:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703649F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:47:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBCC433C8;
        Sun, 17 Sep 2023 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980043;
        bh=F8HshgyubaPnrlF1S2BeA+ZyoPTGAZuHqTqDCl9JvxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BX7BP12JfQQp/BqKPRlx3k5JqXODZqcVzF0blwvxq6Ytd9RHv6YkPDReC0lj7qGWZ
         dDH6MXo9oDBvS2vkzbmpEZf9ubSMbZTD1Q3hgyuuyNTRIvYCRMeP1NnvE4CIBkspBZ
         H8yE23gAVY1KADkCLMJyLLNvfx6JIgP9nz8BBMYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 081/285] perf bpf-filter: Fix sample flag check with ||
Date:   Sun, 17 Sep 2023 21:11:21 +0200
Message-ID: <20230917191054.514408126@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit dc7f01f1bceca38839992b3371e0be8a3c9d5acf ]

For logical OR operator, the actual sample_flags are in the 'groups'
list so it needs to check entries in the list instead.  Otherwise it
would show the following error message.

  $ sudo perf record -a -e cycles:p --filter 'period > 100 || weight > 0' sleep 1
  Error: cycles:p event does not have sample flags 0
  failed to set filter "BPF" on event cycles:p with 2 (No such file or directory)

Actually it should warn on 'weight' is used without WEIGHT flag.

  Error: cycles:p event does not have PERF_SAMPLE_WEIGHT
   Hint: please add -W option to perf record
  failed to set filter "BPF" on event cycles:p with 2 (No such file or directory)

Fixes: 4310551b76e0d676 ("perf bpf filter: Show warning for missing sample flags")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230811025822.3859771-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf-filter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0b30688d78a7f..a1f076ef653d3 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -62,6 +62,16 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	if (evsel->core.attr.sample_type & expr->sample_flags)
 		return 0;
 
+	if (expr->op == PBF_OP_GROUP_BEGIN) {
+		struct perf_bpf_filter_expr *group;
+
+		list_for_each_entry(group, &expr->groups, list) {
+			if (check_sample_flags(evsel, group) < 0)
+				return -1;
+		}
+		return 0;
+	}
+
 	info = get_sample_info(expr->sample_flags);
 	if (info == NULL) {
 		pr_err("Error: %s event does not have sample flags %lx\n",
-- 
2.40.1



