Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE4D7A7F76
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjITM1Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjITM1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:27:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6D18A
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:27:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E71C433C8;
        Wed, 20 Sep 2023 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212823;
        bh=Gb7yHe4NrQj/Z2pggUi7Mq2gAFY3Onb69PNv9uFwsTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVzadv/tAmBAc712hT2FU+eLHSsupdmneoKEGn/pZaMJS2z5Oo0nR59lnrVekyAni
         NgbnGoh8VMoxRa6hyp8+CqXoG9vMzWm6qhhbqaseaSlnNbLTZkcTjSJqmJTENPiKi6
         FVxeninZuw9vaEr1tfmp01BqkwrdeCt4NvW9RHyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Yang <xu.yang_2@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 058/367] perf/imx_ddr: dont enable counter0 if none of 4 counters are used
Date:   Wed, 20 Sep 2023 13:27:15 +0200
Message-ID: <20230920112900.003705580@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit f4e2bd91ddf5e8543cbe7ad80b3fba3d2dc63fa3 ]

In current driver, counter0 will be enabled after ddr_perf_pmu_enable()
is called even though none of the 4 counters are used. This will cause
counter0 continue to count until ddr_perf_pmu_disabled() is called. If
pmu is not disabled all the time, the pmu interrupt will be asserted
from time to time due to counter0 will overflow and irq handler will
clear it. It's not an expected behavior. This patch will not enable
counter0 if none of 4 counters are used.

Fixes: 9a66d36cc7ac ("drivers/perf: imx_ddr: Add DDR performance counter support to perf")
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20230811015438.1999307-2-xu.yang_2@nxp.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 912a220a9db92..a0e45c726bbf0 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -77,6 +77,7 @@ struct ddr_pmu {
 	const struct fsl_ddr_devtype_data *devtype_data;
 	int irq;
 	int id;
+	int active_counter;
 };
 
 static ssize_t ddr_perf_cpumask_show(struct device *dev,
@@ -353,6 +354,10 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 
 	ddr_perf_counter_enable(pmu, event->attr.config, counter, true);
 
+	if (!pmu->active_counter++)
+		ddr_perf_counter_enable(pmu, EVENT_CYCLES_ID,
+			EVENT_CYCLES_COUNTER, true);
+
 	hwc->state = 0;
 }
 
@@ -407,6 +412,10 @@ static void ddr_perf_event_stop(struct perf_event *event, int flags)
 	ddr_perf_counter_enable(pmu, event->attr.config, counter, false);
 	ddr_perf_event_update(event);
 
+	if (!--pmu->active_counter)
+		ddr_perf_counter_enable(pmu, EVENT_CYCLES_ID,
+			EVENT_CYCLES_COUNTER, false);
+
 	hwc->state |= PERF_HES_STOPPED;
 }
 
@@ -425,25 +434,10 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 
 static void ddr_perf_pmu_enable(struct pmu *pmu)
 {
-	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
-
-	/* enable cycle counter if cycle is not active event list */
-	if (ddr_pmu->events[EVENT_CYCLES_COUNTER] == NULL)
-		ddr_perf_counter_enable(ddr_pmu,
-				      EVENT_CYCLES_ID,
-				      EVENT_CYCLES_COUNTER,
-				      true);
 }
 
 static void ddr_perf_pmu_disable(struct pmu *pmu)
 {
-	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
-
-	if (ddr_pmu->events[EVENT_CYCLES_COUNTER] == NULL)
-		ddr_perf_counter_enable(ddr_pmu,
-				      EVENT_CYCLES_ID,
-				      EVENT_CYCLES_COUNTER,
-				      false);
 }
 
 static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
-- 
2.40.1



