Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA06FACA8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjEHL0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjEHL0m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92123C1D2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5122062CB6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6608DC433D2;
        Mon,  8 May 2023 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545182;
        bh=rOH1ss8kEGYw0aRvGuspzfaz6QYauXSlvNI3STWi7A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0O1VwPU2GfqLpKcDPZMV4VaryubKye4Bv92WXgPh6twWnQjvGgbQRzh8H+XzZvxZ
         KNEuV8LfoEBhsShcZpFNEvRYEDlq7UBEmjMDsgEL7wSMwlRgeQ1pQ7SJRX6IxnAHY5
         Ak6t2oXU8DtOwdbgdMaZMu8KOQWumDSLQq22RoFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 652/694] dmaengine: at_xdmac: disable/enable clock directly on suspend/resume
Date:   Mon,  8 May 2023 11:48:07 +0200
Message-Id: <20230508094457.061648530@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 2de5ddb5e68c94b781b3789bca1ce52000d7d0e0 ]

Runtime PM APIs for at_xdmac just plays with clk_enable()/clk_disable()
letting aside the clk_prepare()/clk_unprepare() that needs to be
executed as the clock is also prepared on probe. Thus instead of using
runtime PM force suspend/resume APIs use
clk_disable_unprepare() + pm_runtime_put_noidle() on suspend and
clk_prepare_enable() + pm_runtime_get_noresume() on resume. This
approach as been chosen instead of using runtime PM force suspend/resume
with clk_unprepare()/clk_prepare() as it looks simpler and the final
code is better.

While at it added the missing pm_runtime_mark_last_busy() on suspend before
decrementing the reference counter.

Fixes: 650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230214151827.1050280-2-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 1f0fab180f8f1..f654ecaafb906 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2130,7 +2130,11 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
 
 	at_xdmac_off(atxdmac);
-	return pm_runtime_force_suspend(atxdmac->dev);
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_noidle(atxdmac->dev);
+	clk_disable_unprepare(atxdmac->clk);
+
+	return 0;
 }
 
 static int __maybe_unused atmel_xdmac_resume(struct device *dev)
@@ -2142,10 +2146,12 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	int			i;
 	int ret;
 
-	ret = pm_runtime_force_resume(atxdmac->dev);
-	if (ret < 0)
+	ret = clk_prepare_enable(atxdmac->clk);
+	if (ret)
 		return ret;
 
+	pm_runtime_get_noresume(atxdmac->dev);
+
 	at_xdmac_axi_config(pdev);
 
 	/* Clear pending interrupts. */
-- 
2.39.2



