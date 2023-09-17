Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24087A397F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbjIQTuZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbjIQTuH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4C9F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC58C433C8;
        Sun, 17 Sep 2023 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980201;
        bh=1K5l+iUdpDE5FibWCYRa7RaE245etzykjg8QezRLfkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3dCaAgNnBVXCwy3Gw9UlqEEoQ7D6ZWK3VEdEFaLjeR88LRhWRZkzXMv0mX7mGWzu
         JI9r24bOy7c3n8PF7F76x9S/ezsAyy6kCG9deyGTbmlVU6+plVLb8SmDiCI2zYOwSB
         4j/hrAKPziX3ADE9Vxwgg8QDr6uZRg7oOGKktDgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Li <liwei391@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Ming Wang <wangming01@loongson.cn>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 095/285] perf header: Fix missing PMU caps
Date:   Sun, 17 Sep 2023 21:11:35 +0200
Message-ID: <20230917191054.983893952@linuxfoundation.org>
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

[ Upstream commit 9897009eecae821efc684ecdd1d04584f5501509 ]

PMU caps are written as HEADER_PMU_CAPS or for the special case of the
PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and not
any "core" PMU, the logic had become broken and core PMUs not called
"cpu" were not having their caps written.

This affects ARM and s390 non-hybrid PMUs.

Simplify the PMU caps writing logic to scan one fewer time and to be
more explicit in its behavior.

Fixes: 178ddf3bad981380 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
Reported-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Ming Wang <wangming01@loongson.cn>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20230825024002.801955-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74a..13c71d28e0eb3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
 	int ret;
 
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    perf_pmu__caps_parse(pmu) <= 0)
+		if (!strcmp(pmu->name, "cpu")) {
+			/*
+			 * The "cpu" PMU is special and covered by
+			 * HEADER_CPU_PMU_CAPS. Note, core PMUs are
+			 * counted/written here for ARM, s390 and Intel hybrid.
+			 */
+			continue;
+		}
+		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
 		nr_pmu++;
 	}
@@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
 		return 0;
 
 	/*
-	 * Write hybrid pmu caps first to maintain compatibility with
-	 * older perf tool.
+	 * Note older perf tools assume core PMUs come first, this is a property
+	 * of perf_pmus__scan.
 	 */
-	if (perf_pmus__num_core_pmus() > 1) {
-		pmu = NULL;
-		while ((pmu = perf_pmus__scan_core(pmu))) {
-			ret = __write_pmu_caps(ff, pmu, true);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
 	pmu = NULL;
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (pmu->is_core || !pmu->nr_caps)
+		if (!strcmp(pmu->name, "cpu")) {
+			/* Skip as above. */
+			continue;
+		}
+		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
-
 		ret = __write_pmu_caps(ff, pmu, true);
 		if (ret < 0)
 			return ret;
-- 
2.40.1



