Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA60775752
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjHIKok (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHIKoj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA31702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F0A63127
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD997C433C7;
        Wed,  9 Aug 2023 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577878;
        bh=1p+ZaaiirH1QJYwhEVbbjQXfkOCiHm/fkZERm1Saqe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPtpyVnYrK7EJmyWBM/LOZjrDMyXJ4dLrcnneY2JKjLpB9x7YYefDRCaOr/isjHpj
         cNS0nFwxxbEkZGsHuybRZEErEgeoecVQhhkYhx+OEmqPjxrp9L+cC+5Si3ONrfLH+W
         nwSiNZjw44edjK4b9wrdZI+8yXYitlZiOmTB8AYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 026/165] perf pmu arm64: Fix reading the PMU cpu slots in sysfs
Date:   Wed,  9 Aug 2023 12:39:17 +0200
Message-ID: <20230809103643.673268041@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>

[ Upstream commit 9754353d0ab123d71bf572a483ecc8b330ef36a3 ]

Commit f8ad6018ce3c065a ("perf pmu: Remove duplication around
EVENT_SOURCE_DEVICE_PATH") uses sysfs__read_ull() to read a full sysfs
path, which will never succeeds as it already comes with the sysfs mount
point in it, which sysfs__read_ull() will add again.

Fix it by reading the file using filename__read_ull(), that will not add
the sysfs mount point.

Fixes: f8ad6018ce3c065a ("perf pmu: Remove duplication around EVENT_SOURCE_DEVICE_PATH")
Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
Tested-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/arm64/util/pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index ef1ed645097c6..ce0d1c7578348 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -56,10 +56,11 @@ double perf_pmu__cpu_slots_per_cycle(void)
 		perf_pmu__pathname_scnprintf(path, sizeof(path),
 					     pmu->name, "caps/slots");
 		/*
-		 * The value of slots is not greater than 32 bits, but sysfs__read_int
-		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
+		 * The value of slots is not greater than 32 bits, but
+		 * filename__read_int can't read value with 0x prefix,
+		 * so use filename__read_ull instead.
 		 */
-		sysfs__read_ull(path, &slots);
+		filename__read_ull(path, &slots);
 	}
 
 	return slots ? (double)slots : NAN;
-- 
2.40.1



