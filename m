Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C47A3992
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbjIQTv3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjIQTvB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:51:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277AC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89F5C433CB;
        Sun, 17 Sep 2023 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980255;
        bh=M3AKh6KQKt+8WdMFk6UOGvMfyzzadE+EGT7aXdguJao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cf7ZBq9eLcvkfsTlwJv9MI9p+FV5DiRBdaHwHnwlxrOi9PGGlV7mR1Alm61UE80MH
         2I9SEahL24UGZcduKJsTh3fi7rmETtJ+eibL3CfopDEMb7HGkHjFdG93GwkXATqdja
         m8qp44uq0b90JhcyR6Y1O5E5ty3ROcL0NkbQzkk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Kleikamp <dave.kleikamp@oracle.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 092/285] perf vendor events arm64: Remove L1D_CACHE_LMISS from AmpereOne list
Date:   Sun, 17 Sep 2023 21:11:32 +0200
Message-ID: <20230917191054.880020905@linuxfoundation.org>
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

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

[ Upstream commit b8af10062df3c23fe002c3f187389bb263b3eb20 ]

amperene/cache.json file tried to include L1D_CACHE_LMISS while it
doesn't exist in common-and-microarch.json. While this bug doesn't seem to
cause issue in newer kernels with jevents.py script, it prevents building
older perf tools with the backported patch.

Fixes: a9650b7f6fc09d16 ("perf vendor events arm64: Add AmpereOne core PMU events")
Reported-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Closes: https://lore.kernel.org/all/76bb2e47-ce44-76ae-838e-53279047084d@oracle.com/
Link: https://lore.kernel.org/r/20230803211331.140553-2-ilkka@os.amperecomputing.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
index fc06330542116..7a2b7b200f144 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
@@ -92,9 +92,6 @@
     {
         "ArchStdEvent": "L1D_CACHE_LMISS_RD"
     },
-    {
-        "ArchStdEvent": "L1D_CACHE_LMISS"
-    },
     {
         "ArchStdEvent": "L1I_CACHE_LMISS"
     },
-- 
2.40.1



