Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AB7ED39E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjKOUxn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjKOUxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A45192
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC273C4E778;
        Wed, 15 Nov 2023 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081617;
        bh=yT6avTJkcGwbr+AlQvs69s7XRerK05WpGcr23JmosXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boBDTrMODot/UlgD4OYXzEF8AiAdcvd8X/689sjUnGUe3LV8itDfo2CHkhXQTkCJ3
         sJe/DLBAXOmtCJ9sV2dqoE0v5Tu9UiPHRsCd8t6LUeEtucCogitvOGYd5h7G0YV1hQ
         gs8hQIKVUSyvXLDUCj4T7YaKCd0flmZ7e1RSnhIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 019/191] wifi: mt76: mt7603: rework/fix rx pse hang check
Date:   Wed, 15 Nov 2023 15:44:54 -0500
Message-ID: <20231115204645.679628161@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit baa19b2e4b7bbb509a7ca7939c8785477dcd40ee ]

It turns out that the code in mt7603_rx_pse_busy() does not detect actual
hardware hangs, it only checks for busy conditions in PSE.
A reset should only be performed if these conditions are true and if there
is no rx activity as well.
Reset the counter whenever a rx interrupt occurs. In order to also deal with
a fully loaded CPU that leaves interrupts disabled with continuous NAPI
polling, also check for pending rx interrupts in the function itself.

Fixes: c8846e101502 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 23 +++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index 60a996b63c0c0..915b8349146af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -42,11 +42,13 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 	}
 
 	if (intr & MT_INT_RX_DONE(0)) {
+		dev->rx_pse_check = 0;
 		mt7603_irq_disable(dev, MT_INT_RX_DONE(0));
 		napi_schedule(&dev->mt76.napi[0]);
 	}
 
 	if (intr & MT_INT_RX_DONE(1)) {
+		dev->rx_pse_check = 0;
 		mt7603_irq_disable(dev, MT_INT_RX_DONE(1));
 		napi_schedule(&dev->mt76.napi[1]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index f665a1c95eed2..9eb898ebbb445 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1535,20 +1535,29 @@ static bool mt7603_rx_pse_busy(struct mt7603_dev *dev)
 {
 	u32 addr, val;
 
-	if (mt76_rr(dev, MT_MCU_DEBUG_RESET) & MT_MCU_DEBUG_RESET_QUEUES)
-		return true;
-
 	if (mt7603_rx_fifo_busy(dev))
-		return false;
+		goto out;
 
 	addr = mt7603_reg_map(dev, MT_CLIENT_BASE_PHYS_ADDR + MT_CLIENT_STATUS);
 	mt76_wr(dev, addr, 3);
 	val = mt76_rr(dev, addr) >> 16;
 
-	if (is_mt7628(dev) && (val & 0x4001) == 0x4001)
-		return true;
+	if (!(val & BIT(0)))
+		return false;
+
+	if (is_mt7628(dev))
+		val &= 0xa000;
+	else
+		val &= 0x8000;
+	if (!val)
+		return false;
+
+out:
+	if (mt76_rr(dev, MT_INT_SOURCE_CSR) &
+	    (MT_INT_RX_DONE(0) | MT_INT_RX_DONE(1)))
+		return false;
 
-	return (val & 0x8001) == 0x8001 || (val & 0xe001) == 0xe001;
+	return true;
 }
 
 static bool
-- 
2.42.0



