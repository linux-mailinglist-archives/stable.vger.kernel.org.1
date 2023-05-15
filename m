Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA7703B95
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbjEOSET (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbjEOSEC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221E186C3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1924362D2F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB86C433EF;
        Mon, 15 May 2023 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173692;
        bh=PnTxC6ZspMAoU9p98pS9YNbmRzWcT+l5DJJt25F4nLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14MUAcTGdSxnaRxuuuoB6TYsG3smqqGZvqCF291UZ3r6NNRLHN9Kk+wc2B7Lf0ZRg
         wOU0WH/5OXNvkLIYvJlaMBdtHnBwPzWakHpkvhwbbvMjFt5LYgZnT/c3FD8FhC0OO1
         BtorPbHQjCfc/bUYigc+G5cHpjDgel/KgDrUPchU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 177/282] clocksource/drivers/davinci: Avoid trailing \n hidden in pr_fmt()
Date:   Mon, 15 May 2023 18:29:15 +0200
Message-Id: <20230515161727.584889329@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bdf8783c0dae9d3d8fc1c4078fe849ab8aa8b583 ]

pr_xxx() functions usually have '\n' at the end of the logging message.
Here, this '\n' is added via the 'pr_fmt' macro.

In order to be more consistent with other files, use a more standard
convention and put these '\n' back in the messages themselves and remove it
from the pr_fmt macro.

While at it, remove a useless message in case of 'kzalloc' failure,
especially with a __GFP_NOFAIL flag.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200409092543.14727-1-christophe.jaillet@wanadoo.fr
Stable-dep-of: fb73556386e0 ("clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-davinci.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index e421946a91c5a..aae9383682303 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -18,7 +18,7 @@
 #include <clocksource/timer-davinci.h>
 
 #undef pr_fmt
-#define pr_fmt(fmt) "%s: " fmt "\n", __func__
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #define DAVINCI_TIMER_REG_TIM12			0x10
 #define DAVINCI_TIMER_REG_TIM34			0x14
@@ -250,20 +250,20 @@ int __init davinci_timer_register(struct clk *clk,
 
 	rv = clk_prepare_enable(clk);
 	if (rv) {
-		pr_err("Unable to prepare and enable the timer clock");
+		pr_err("Unable to prepare and enable the timer clock\n");
 		return rv;
 	}
 
 	if (!request_mem_region(timer_cfg->reg.start,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
-		pr_err("Unable to request memory region");
+		pr_err("Unable to request memory region\n");
 		return -EBUSY;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
-		pr_err("Unable to map the register range");
+		pr_err("Unable to map the register range\n");
 		return -ENOMEM;
 	}
 
@@ -271,10 +271,8 @@ int __init davinci_timer_register(struct clk *clk,
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL | __GFP_NOFAIL);
-	if (!clockevent) {
-		pr_err("Error allocating memory for clockevent data");
+	if (!clockevent)
 		return -ENOMEM;
-	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -298,7 +296,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 davinci_timer_irq_timer, IRQF_TIMER,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
-		pr_err("Unable to request the clockevent interrupt");
+		pr_err("Unable to request the clockevent interrupt\n");
 		return rv;
 	}
 
@@ -325,7 +323,7 @@ int __init davinci_timer_register(struct clk *clk,
 
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
-		pr_err("Unable to register clocksource");
+		pr_err("Unable to register clocksource\n");
 		return rv;
 	}
 
@@ -343,20 +341,20 @@ static int __init of_davinci_timer_register(struct device_node *np)
 
 	rv = of_address_to_resource(np, 0, &timer_cfg.reg);
 	if (rv) {
-		pr_err("Unable to get the register range for timer");
+		pr_err("Unable to get the register range for timer\n");
 		return rv;
 	}
 
 	rv = of_irq_to_resource_table(np, timer_cfg.irq,
 				      DAVINCI_TIMER_NUM_IRQS);
 	if (rv != DAVINCI_TIMER_NUM_IRQS) {
-		pr_err("Unable to get the interrupts for timer");
+		pr_err("Unable to get the interrupts for timer\n");
 		return rv;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Unable to get the timer clock");
+		pr_err("Unable to get the timer clock\n");
 		return PTR_ERR(clk);
 	}
 
-- 
2.39.2



