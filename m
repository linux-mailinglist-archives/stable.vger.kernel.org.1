Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493D703B96
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjEOSEU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbjEOSEE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78631176E8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5984C6305E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E5C433EF;
        Mon, 15 May 2023 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173698;
        bh=rIQeblNjgmVgd2TYruXgnKIbYnJiSQrez73lvWcUA0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNp0o/4IQ/t+WDT7t4atHAiNOHt1aglL632U1xzFXPFRipkM7ZvJvsLvEUaPHmgug
         HWcDUWeSSiYM1Dd559NevWfzpROsSEFrSoScqdwU3qwWHpB5bkmO6ScW3y9te6sb4o
         14epgT4dJQ7kaixLflYzhkzCTX0lNEt7XLcc8Ek0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qinrun Dai <flno@hust.edu.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 179/282] clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails
Date:   Mon, 15 May 2023 18:29:17 +0200
Message-Id: <20230515161727.643124306@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Qinrun Dai <flno@hust.edu.cn>

[ Upstream commit fb73556386e074e9bee9fa2d253aeaefe4e063e0 ]

Smatch reports:
drivers/clocksource/timer-davinci.c:332 davinci_timer_register()
warn: 'base' from ioremap() not released on lines: 274.

Fix this and other potential memory leak problems
by adding a set of corresponding exit lables.

Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
Signed-off-by: Qinrun Dai <flno@hust.edu.cn>
Link: https://lore.kernel.org/r/20230413135037.1505799-1-flno@hust.edu.cn
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-davinci.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index bb4eee31ae082..3dc0c6ceed027 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -258,21 +258,25 @@ int __init davinci_timer_register(struct clk *clk,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
 		pr_err("Unable to request memory region\n");
-		return -EBUSY;
+		rv = -EBUSY;
+		goto exit_clk_disable;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
 		pr_err("Unable to map the register range\n");
-		return -ENOMEM;
+		rv = -ENOMEM;
+		goto exit_mem_region;
 	}
 
 	davinci_timer_init(base);
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
-	if (!clockevent)
-		return -ENOMEM;
+	if (!clockevent) {
+		rv = -ENOMEM;
+		goto exit_iounmap_base;
+	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -297,7 +301,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt\n");
-		return rv;
+		goto exit_free_clockevent;
 	}
 
 	davinci_clocksource.dev.rating = 300;
@@ -324,13 +328,27 @@ int __init davinci_timer_register(struct clk *clk,
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource\n");
-		return rv;
+		goto exit_free_irq;
 	}
 
 	sched_clock_register(davinci_timer_read_sched_clock,
 			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
 
 	return 0;
+
+exit_free_irq:
+	free_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			clockevent);
+exit_free_clockevent:
+	kfree(clockevent);
+exit_iounmap_base:
+	iounmap(base);
+exit_mem_region:
+	release_mem_region(timer_cfg->reg.start,
+			   resource_size(&timer_cfg->reg));
+exit_clk_disable:
+	clk_disable_unprepare(clk);
+	return rv;
 }
 
 static int __init of_davinci_timer_register(struct device_node *np)
-- 
2.39.2



