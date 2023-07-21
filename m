Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366975D1CF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGUSxF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGUSxE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12C30E4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82DC461D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B86C433C7;
        Fri, 21 Jul 2023 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965582;
        bh=JHT+iMQO8LqS+kJkeHNuaxe3v0vmIk4Xw3W1hDP7sx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HArvamNJ7ryOkNbuoVkE1ynY1DsRfT6WvH4DKMGV6IkdOv42UvKodajqBwyKMNzQ
         s8Cvgu7y01yQf2ySTYJKxXSmmiaV9Nn7w1W2KE/CLEj0e6n0+HiQKiKlRJQHArO+6W
         Hn3DaMZb6BaUiT6lkV+b+s7OH3lVl/eYXOvmkl8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feng Mingxi <m202271825@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 014/532] clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe
Date:   Fri, 21 Jul 2023 17:58:38 +0200
Message-ID: <20230721160615.442817345@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Feng Mingxi <m202271825@hust.edu.cn>

[ Upstream commit 8b5bf64c89c7100c921bd807ba39b2eb003061ab ]

Smatch reports:
drivers/clocksource/timer-cadence-ttc.c:529 ttc_timer_probe()
warn: 'timer_baseaddr' from of_iomap() not released on lines: 498,508,516.

timer_baseaddr may have the problem of not being released after use,
I replaced it with the devm_of_iomap() function and added the clk_put()
function to cleanup the "clk_ce" and "clk_cs".

Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")
Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Signed-off-by: Feng Mingxi <m202271825@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230425065611.702917-1-m202271825@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-cadence-ttc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 4efd0cf3b602d..0d52e28fea4de 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -486,10 +486,10 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	 * and use it. Note that the event timer uses the interrupt and it's the
 	 * 2nd TTC hence the irq_of_parse_and_map(,1)
 	 */
-	timer_baseaddr = of_iomap(timer, 0);
-	if (!timer_baseaddr) {
+	timer_baseaddr = devm_of_iomap(&pdev->dev, timer, 0, NULL);
+	if (IS_ERR(timer_baseaddr)) {
 		pr_err("ERROR: invalid timer base address\n");
-		return -ENXIO;
+		return PTR_ERR(timer_baseaddr);
 	}
 
 	irq = irq_of_parse_and_map(timer, 1);
@@ -513,20 +513,27 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	clk_ce = of_clk_get(timer, clksel);
 	if (IS_ERR(clk_ce)) {
 		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_ce);
+		ret = PTR_ERR(clk_ce);
+		goto put_clk_cs;
 	}
 
 	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
 	if (ret)
-		return ret;
+		goto put_clk_ce;
 
 	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
 	if (ret)
-		return ret;
+		goto put_clk_ce;
 
 	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
 
 	return 0;
+
+put_clk_ce:
+	clk_put(clk_ce);
+put_clk_cs:
+	clk_put(clk_cs);
+	return ret;
 }
 
 static const struct of_device_id ttc_timer_of_match[] = {
-- 
2.39.2



