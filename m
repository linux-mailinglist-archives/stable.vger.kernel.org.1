Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080727552F1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGPUNt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGPUNs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F990
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7088960EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55342C433C8;
        Sun, 16 Jul 2023 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538425;
        bh=SROZB65hKjgbj6OZdqSgiBy8/xEOw2f0vEbnAeHTlfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17w8ozAYk6nVpCZAcS1pPo9/0xxT9FXR3YOepnotdT/vwrYMyZuGCryv0k5Pf6wQ8
         zCbes/iLd3tbDOBRBoUICcvkid3Bs/PuIGIdd8mwgh3H44GehxFG/bb/+m2TW1uc+x
         sC1f788AWLnSB1ACB3H/Udj0VJJ+T9yTJIX9G8fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung.kim@lge.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 446/800] perf evsel: Dont let for_each_group() treat the head of the list as one of its nodes
Date:   Sun, 16 Jul 2023 21:44:59 +0200
Message-ID: <20230716194959.443688468@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit 797b9ec8c4bc9ec89f633a9b2c710b7b64753ca4 ]

Address/memory sanitizer was reporting issues in evsel__group_pmu_name
because the for_each_group_evsel loop didn't terminate when the head
was reached, the head would then be cast and accessed as an evsel
leading to invalid memory accesses.

Fix for_each_group_member and for_each_group_evsel to terminate at the
list head. Note, evsel__group_pmu_name no longer iterates the group, but
the problem is present regardless.

Fixes: 717e263fc354d53d ("perf report: Show group description when event group is enabled")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@huawei.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung.kim@lge.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Link: https://lore.kernel.org/r/20230526194442.2355872-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel.h         | 24 ++++++++++++++++--------
 tools/perf/util/evsel_fprintf.c |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0f54f28a69c25..5a488803d368f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -460,16 +460,24 @@ static inline int evsel__group_idx(struct evsel *evsel)
 }
 
 /* Iterates group WITHOUT the leader. */
-#define for_each_group_member(_evsel, _leader) 					\
-for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
-     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
-     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+#define for_each_group_member_head(_evsel, _leader, _head)				\
+for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node);		\
+	(_evsel) && &(_evsel)->core.node != (_head) &&					\
+	(_evsel)->core.leader == &(_leader)->core;					\
+	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+
+#define for_each_group_member(_evsel, _leader)				\
+	for_each_group_member_head(_evsel, _leader, &(_leader)->evlist->core.entries)
 
 /* Iterates group WITH the leader. */
-#define for_each_group_evsel(_evsel, _leader) 					\
-for ((_evsel) = _leader; 							\
-     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
-     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+#define for_each_group_evsel_head(_evsel, _leader, _head)				\
+for ((_evsel) = _leader;								\
+	(_evsel) && &(_evsel)->core.node != (_head) &&					\
+	(_evsel)->core.leader == &(_leader)->core;					\
+	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+
+#define for_each_group_evsel(_evsel, _leader)				\
+	for_each_group_evsel_head(_evsel, _leader, &(_leader)->evlist->core.entries)
 
 static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
 {
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index cc80ec554c0a9..036a2171dc1c5 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
+#include "util/evlist.h"
 #include "evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/event.h"
-- 
2.39.2



