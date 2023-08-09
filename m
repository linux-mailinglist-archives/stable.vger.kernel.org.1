Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A87775A04
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjHILEl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjHILEk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446F1724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1455162BD5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237BCC433C8;
        Wed,  9 Aug 2023 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579079;
        bh=RsoMg+K2J/fBRgIYfizAwc1xLXeJlItwfzoFl2oMbZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJ3p1A0hUXk+WXx3inknxWjR6aCXVuZZdJvftNt3IzlSzRe/E1TVNXyOJa5wxO+0X
         j0bRYD8QkmWxoC8i1DA5u2QCl4ASxIVqVTSjao3zGtf3HMSJAybfulrMpgPX0NZe02
         U3jxUBzo2H7TRBxobVhMsf8fVKhnGWWpPZ4Is3OM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/204] rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
Date:   Wed,  9 Aug 2023 12:40:05 +0200
Message-ID: <20230809103644.892506770@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 06c6e1b01d9261f03629cefd1f3553503291e6cf ]

If an error occurs after clk_get(), the corresponding resources should be
released.

Use devm_clk_get() to fix it.

Fixes: b5b2bdfc2893 ("rtc: st: Add new driver for ST's LPC RTC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/866af6adbc7454a7b4505eb6c28fbdc86ccff39e.1686251455.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-st-lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 6f33e705928f4..9044c2851a1f2 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -236,7 +236,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	enable_irq_wake(rtc->irq);
 	disable_irq(rtc->irq);
 
-	rtc->clk = clk_get(&pdev->dev, NULL);
+	rtc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rtc->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		return PTR_ERR(rtc->clk);
-- 
2.39.2



