Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792716FACAA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjEHL0x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjEHL0o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C93A5F3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E9EB62D9A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42164C433EF;
        Mon,  8 May 2023 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545185;
        bh=8r86ET8CjpRMe2jQpa5GkEJa/m5rbmbRQz4fYwqxoT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhVYVHDIStD8rGgowOXcuL5sQ2+Z3OR9Zb1h/RzTeZCFB1dXdOW4NBSskJT8oMZ7q
         0e25qq2ufxTDoi4oXV6x0e8SKv/luog/u4+VaiuU7MKw6SJuRCoBVJT93krwiRz+Lo
         nY1/Y7PhXJpzaS/iyAKeubLgEpaf9721c8+G7VeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 653/694] dmaengine: at_xdmac: fix imbalanced runtime PM reference counter
Date:   Mon,  8 May 2023 11:48:08 +0200
Message-Id: <20230508094457.111958981@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit e53957e1ec5196671e49a48f90a5c9555153189a ]

In case there are channels not paused during suspend (which on AT91 case
is valid for serial driver when no_console_suspend boot argument is used)
the at_xdmac_runtime_suspend_descriptors() was called more than
one time due to at_xdmac_off(). To fix this add a new argument to
at_xdmac_off() to specify if runtime PM reference counter needs to be
decremented for queued active descriptors. Along with it moved the
at_xdmac_runtime_suspend_descriptors() call under at_xdmac_chan_is_paused()
check on suspend path as for the rest of channels the suspend is delayed
by atmel_xdmac_prepare() in case channel is enabled. Same approach has
been applied on resume path.

Fixes: 650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230214151827.1050280-3-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index f654ecaafb906..af3b494f9ba9b 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -412,7 +412,7 @@ static bool at_xdmac_chan_is_enabled(struct at_xdmac_chan *atchan)
 	return ret;
 }
 
-static void at_xdmac_off(struct at_xdmac *atxdmac)
+static void at_xdmac_off(struct at_xdmac *atxdmac, bool suspend_descriptors)
 {
 	struct dma_chan		*chan, *_chan;
 	struct at_xdmac_chan	*atchan;
@@ -431,7 +431,7 @@ static void at_xdmac_off(struct at_xdmac *atxdmac)
 	at_xdmac_write(atxdmac, AT_XDMAC_GID, -1L);
 
 	/* Decrement runtime PM ref counter for each active descriptor. */
-	if (!list_empty(&atxdmac->dma.channels)) {
+	if (!list_empty(&atxdmac->dma.channels) && suspend_descriptors) {
 		list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels,
 					 device_node) {
 			atchan = to_at_xdmac_chan(chan);
@@ -2118,18 +2118,18 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 
 		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
-			if (!at_xdmac_chan_is_paused(atchan))
+			if (!at_xdmac_chan_is_paused(atchan)) {
 				at_xdmac_device_pause(chan);
+				at_xdmac_runtime_suspend_descriptors(atchan);
+			}
 			atchan->save_cim = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			atchan->save_cnda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA);
 			atchan->save_cndc = at_xdmac_chan_read(atchan, AT_XDMAC_CNDC);
 		}
-
-		at_xdmac_runtime_suspend_descriptors(atchan);
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
 
-	at_xdmac_off(atxdmac);
+	at_xdmac_off(atxdmac, false);
 	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_noidle(atxdmac->dev);
 	clk_disable_unprepare(atxdmac->clk);
@@ -2165,14 +2165,14 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		atchan = to_at_xdmac_chan(chan);
 
-		ret = at_xdmac_runtime_resume_descriptors(atchan);
-		if (ret < 0)
-			return ret;
-
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
-			if (at_xdmac_chan_is_paused(atchan))
+			if (at_xdmac_chan_is_paused(atchan)) {
+				ret = at_xdmac_runtime_resume_descriptors(atchan);
+				if (ret < 0)
+					return ret;
 				at_xdmac_device_resume(chan);
+			}
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
@@ -2318,7 +2318,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&atxdmac->dma.channels);
 
 	/* Disable all chans and interrupts. */
-	at_xdmac_off(atxdmac);
+	at_xdmac_off(atxdmac, true);
 
 	for (i = 0; i < nr_channels; i++) {
 		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
@@ -2382,7 +2382,7 @@ static int at_xdmac_remove(struct platform_device *pdev)
 	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
 	int		i;
 
-	at_xdmac_off(atxdmac);
+	at_xdmac_off(atxdmac, true);
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atxdmac->dma);
 	pm_runtime_disable(atxdmac->dev);
-- 
2.39.2



