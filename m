Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABD755162
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGPTzv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGPTzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2BA1B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56D460EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B635BC433C8;
        Sun, 16 Jul 2023 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537348;
        bh=LXQ1BrzHdL+ckJ9Zos8oiGhFhruWKclmrHLkGmpZHZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvx33vC3AibZC5aPiXI4E3ZdiFoav//boOK0EwBMgTigS7nFdCs868qncRxgi/PQz
         9E3l1/ThDRejt9ymyz+uYASTruDSOWAvdy8JnzrVz2Qugx9Rwdj5oDWHEFDRB2fsOR
         tyGQfY6JFB9joCMBL/yPECJQ9QZvRtIVWCQLf+lY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Sidharth Kshatriya <sid.kshatriya@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 064/800] drivers/perf: apple_m1: Force 63bit counters for M2 CPUs
Date:   Sun, 16 Jul 2023 21:38:37 +0200
Message-ID: <20230716194950.578299296@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 8be3593b9efa8903d2ee7bb9cdf57a8e56c66f36 ]

Sidharth reports that on M2, the PMU never generates any interrupt
when using 'perf record', which is a annoying as you get no sample.
I'm temped to say "no sample, no problem", but others may have
a different opinion.

Upon investigation, it appears that the counters on M2 are
significantly different from the ones on M1, as they count on
64 bits instead of 48. Which of course, in the fine M1 tradition,
means that we can only use 63 bits, as the top bit is used to signal
the interrupt...

This results in having to introduce yet another flag to indicate yet
another odd counter width. Who knows what the next crazy implementation
will do...

With this, perf can work out the correct offset, and 'perf record'
works as intended.

Tested on M2 and M2-Pro CPUs.

Cc: Janne Grunau <j@jannau.net>
Cc: Hector Martin <marcan@marcan.st>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Fixes: 7d0bfb7c9977 ("drivers/perf: apple_m1: Add Apple M2 support")
Reported-by: Sidharth Kshatriya <sid.kshatriya@gmail.com>
Tested-by: Sidharth Kshatriya <sid.kshatriya@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230528080205.288446-1-maz@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/apple_m1_cpu_pmu.c | 30 ++++++++++++++++++++++++------
 drivers/perf/arm_pmu.c          |  2 ++
 include/linux/perf/arm_pmu.h    |  2 ++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 8574c6e58c83a..cd2de44b61b91 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -493,6 +493,17 @@ static int m1_pmu_map_event(struct perf_event *event)
 	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
 }
 
+static int m2_pmu_map_event(struct perf_event *event)
+{
+	/*
+	 * Same deal as the above, except that M2 has 64bit counters.
+	 * Which, as far as we're concerned, actually means 63 bits.
+	 * Yes, this is getting awkward.
+	 */
+	event->hw.flags |= ARMPMU_EVT_63BIT;
+	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
+}
+
 static void m1_pmu_reset(void *info)
 {
 	int i;
@@ -525,7 +536,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int m1_pmu_init(struct arm_pmu *cpu_pmu)
+static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -536,7 +547,14 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
-	cpu_pmu->map_event	  = m1_pmu_map_event;
+
+	if (flags & ARMPMU_EVT_47BIT)
+		cpu_pmu->map_event = m1_pmu_map_event;
+	else if (flags & ARMPMU_EVT_63BIT)
+		cpu_pmu->map_event = m2_pmu_map_event;
+	else
+		return WARN_ON(-EINVAL);
+
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -550,25 +568,25 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu)
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
-	return m1_pmu_init(cpu_pmu);
+	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_firestorm_pmu";
-	return m1_pmu_init(cpu_pmu);
+	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_avalanche_pmu";
-	return m1_pmu_init(cpu_pmu);
+	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_blizzard_pmu";
-	return m1_pmu_init(cpu_pmu);
+	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 15bd1e34a88ea..277e29fbd504f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -109,6 +109,8 @@ static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
 	if (event->hw.flags & ARMPMU_EVT_64BIT)
 		return GENMASK_ULL(63, 0);
+	else if (event->hw.flags & ARMPMU_EVT_63BIT)
+		return GENMASK_ULL(62, 0);
 	else if (event->hw.flags & ARMPMU_EVT_47BIT)
 		return GENMASK_ULL(46, 0);
 	else
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 525b5d64e3948..c0e4baf940dce 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -26,9 +26,11 @@
  */
 #define ARMPMU_EVT_64BIT		0x00001 /* Event uses a 64bit counter */
 #define ARMPMU_EVT_47BIT		0x00002 /* Event uses a 47bit counter */
+#define ARMPMU_EVT_63BIT		0x00004 /* Event uses a 63bit counter */
 
 static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_64BIT) == ARMPMU_EVT_64BIT);
 static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_47BIT) == ARMPMU_EVT_47BIT);
+static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_63BIT) == ARMPMU_EVT_63BIT);
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
-- 
2.39.2



