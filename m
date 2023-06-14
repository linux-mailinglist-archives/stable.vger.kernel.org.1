Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4B719E1C
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjFAN3O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjFAN25 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036D31A8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A984644FC
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FBEC433D2;
        Thu,  1 Jun 2023 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626105;
        bh=8fVECFHP9ZvZXtQY/+6EpwYdAyXQaQ0UHP9UK1tzG88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUF+VqbmzruWnOpgFYtfvyQMmlJJmDdqFwbZ1mNkPLoNfxEsDMl6O1Hh+vp5JmNPf
         VTgN9YbDGK9RzClHKnRmXkqF+BUzIiS4DfNh+lKHiGaxXsmk7eEcA7mE4lGb+L6A/+
         ZJEoj+Jk0l28tmjU42GuDn0NCOhTs/NdnefMBgYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 32/42] dmaengine: at_xdmac: do not resume channels paused by consumers
Date:   Thu,  1 Jun 2023 14:21:41 +0100
Message-Id: <20230601131940.479423088@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 44fe8440bda545b5d167329df88c47609a645168 ]

In case there are DMA channels not paused by consumers in suspend
process (valid on AT91 SoCs for serial driver when no_console_suspend) the
driver pauses them (using at_xdmac_device_pause() which is also the same
function called by dmaengine_pause()) and then in the resume process the
driver resumes them calling at_xdmac_device_resume() which is the same
function called by dmaengine_resume()). This is good for DMA channels
not paused by consumers but for drivers that calls
dmaengine_pause()/dmaegine_resume() on suspend/resume path this may lead to
DMA channel being enabled before the IP is enabled. For IPs that needs
strict ordering with regards to DMA channel enablement this will lead to
wrong behavior. To fix this add a new set of functions
at_xdmac_device_pause_internal()/at_xdmac_device_resume_internal() to be
called only on suspend/resume.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230214151827.1050280-4-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 48 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7f7557e4c31d7..cb1374b161291 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -186,6 +186,7 @@
 enum atc_status {
 	AT_XDMAC_CHAN_IS_CYCLIC = 0,
 	AT_XDMAC_CHAN_IS_PAUSED,
+	AT_XDMAC_CHAN_IS_PAUSED_INTERNAL,
 };
 
 struct at_xdmac_layout {
@@ -346,6 +347,11 @@ static inline int at_xdmac_chan_is_paused(struct at_xdmac_chan *atchan)
 	return test_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 }
 
+static inline int at_xdmac_chan_is_paused_internal(struct at_xdmac_chan *atchan)
+{
+	return test_bit(AT_XDMAC_CHAN_IS_PAUSED_INTERNAL, &atchan->status);
+}
+
 static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
 {
 	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
@@ -1807,6 +1813,26 @@ static int at_xdmac_device_config(struct dma_chan *chan,
 	return ret;
 }
 
+static void at_xdmac_device_pause_set(struct at_xdmac *atxdmac,
+				      struct at_xdmac_chan *atchan)
+{
+	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
+	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC) &
+	       (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
+		cpu_relax();
+}
+
+static void at_xdmac_device_pause_internal(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&atchan->lock, flags);
+	set_bit(AT_XDMAC_CHAN_IS_PAUSED_INTERNAL, &atchan->status);
+	at_xdmac_device_pause_set(atxdmac, atchan);
+	spin_unlock_irqrestore(&atchan->lock, flags);
+}
+
 static int at_xdmac_device_pause(struct dma_chan *chan)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
@@ -1819,15 +1845,25 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 		return 0;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
-	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
-	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
-		cpu_relax();
+
+	at_xdmac_device_pause_set(atxdmac, atchan);
+	/* Decrement runtime PM ref counter for each active descriptor. */
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	return 0;
 }
 
+static void at_xdmac_device_resume_internal(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&atchan->lock, flags);
+	at_xdmac_write(atxdmac, atxdmac->layout->grwr, atchan->mask);
+	clear_bit(AT_XDMAC_CHAN_IS_PAUSED_INTERNAL, &atchan->status);
+	spin_unlock_irqrestore(&atchan->lock, flags);
+}
+
 static int at_xdmac_device_resume(struct dma_chan *chan)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
@@ -1982,7 +2018,7 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (!at_xdmac_chan_is_paused(atchan))
-				at_xdmac_device_pause(chan);
+				at_xdmac_device_pause_internal(atchan);
 			atchan->save_cim = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			atchan->save_cnda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA);
 			atchan->save_cndc = at_xdmac_chan_read(atchan, AT_XDMAC_CNDC);
@@ -2027,7 +2063,7 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (at_xdmac_chan_is_paused(atchan))
-				at_xdmac_device_resume(chan);
+				at_xdmac_device_resume_internal(atchan);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
-- 
2.39.2



