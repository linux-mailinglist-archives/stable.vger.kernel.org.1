Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F46876CBFF
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 13:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjHBLsW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjHBLsV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 07:48:21 -0400
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 04:48:17 PDT
Received: from out-119.mta1.migadu.com (out-119.mta1.migadu.com [IPv6:2001:41d0:203:375::77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55E2213D
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 04:48:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690976484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T+ENxNNh1VCVl4ROXkng2uRDpdAyY2LesSEjG2ACXzo=;
        b=xu1ok/oB+39iBLYCcSwkfU7v2usshaReboCFtjihveKpBz4Uz7XIdAum/+NuOlw4gTlImA
        xW4rjWtq8C9ELPWZ9g5oRa334zfs1yxY/Qti4PP5ORZzYmnBjWrX6BE+wtL7sOQGBky+WV
        j2tnngs2q91PB6tAthZjOySU4ixOweQ=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, enlin.mu@unisoc.com
Subject: [PATCH] perf: Fix function pointer case
Date:   Wed,  2 Aug 2023 19:40:53 +0800
Message-Id: <20230802114053.3613-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574 upstream.
With the advent of CFI it is no longer acceptible to cast function
pointers.

The robot complains thusly:

  kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 kernel/events/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 97052b2dff7e..c7f13da672c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1224,6 +1224,11 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
 	return 0;
 }
 
+static int perf_mux_hrtimer_restart_ipi(void *arg)
+{
+	return perf_mux_hrtimer_restart(arg);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
 	int *count = this_cpu_ptr(pmu->pmu_disable_count);
@@ -11137,8 +11142,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
-		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpuctx);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
-- 
2.34.1

