Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B209E7ED02C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbjKOTxV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjKOTxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:53:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B31B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:53:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91DCC433C8;
        Wed, 15 Nov 2023 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077991;
        bh=LV2Hb8hc5LEnGtU7Jal+tkZeZAvQzjr6CDi9WcQ3+aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yUyNGPcZmQGEEOynzZWl5VoZqS2HSzmNYXbpNmyFwCvvXhSdt7M2mcjFF/Jo6XZSn
         IDPGVCyRjguvUlQk4ill7n2Du+w3fYr1QPZskCwRG3dkUOjZlQ5pErW7eYxFH52eBe
         q4fPZnj4G2pPeykDSfatfhIVWjS7ur2GzGhu+nxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/379] wifi: mt76: mt7603: improve watchdog reset reliablity
Date:   Wed, 15 Nov 2023 14:21:58 -0500
Message-ID: <20231115192647.704598223@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit c677dda165231c3efffb9de4bace249d5d2a51b9 ]

Only trigger PSE reset if PSE was stuck, otherwise it can cause DMA issues.
Trigger the PSE reset while DMA is fully stopped in order to improve
reliabilty.

Fixes: c8846e101502 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 541dc1da94c00..2980e1234d13f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1430,15 +1430,6 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt7603_beacon_set_timer(dev, -1, 0);
 
-	if (dev->reset_cause[RESET_CAUSE_RESET_FAILED] ||
-	    dev->cur_reset_cause == RESET_CAUSE_RX_PSE_BUSY ||
-	    dev->cur_reset_cause == RESET_CAUSE_BEACON_STUCK ||
-	    dev->cur_reset_cause == RESET_CAUSE_TX_HANG)
-		mt7603_pse_reset(dev);
-
-	if (dev->reset_cause[RESET_CAUSE_RESET_FAILED])
-		goto skip_dma_reset;
-
 	mt7603_mac_stop(dev);
 
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
@@ -1448,28 +1439,32 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt7603_irq_disable(dev, mask);
 
-	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_FORCE_TX_EOF);
-
 	mt7603_pse_client_reset(dev);
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
 
+	mt7603_dma_sched_reset(dev);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
 	}
 
-	mt76_tx_status_check(&dev->mt76, true);
+	if (dev->reset_cause[RESET_CAUSE_RESET_FAILED] ||
+	    dev->cur_reset_cause == RESET_CAUSE_RX_PSE_BUSY)
+		mt7603_pse_reset(dev);
 
-	mt7603_dma_sched_reset(dev);
+	if (!dev->reset_cause[RESET_CAUSE_RESET_FAILED]) {
+		mt7603_mac_dma_start(dev);
 
-	mt7603_mac_dma_start(dev);
+		mt7603_irq_enable(dev, mask);
 
-	mt7603_irq_enable(dev, mask);
+		clear_bit(MT76_RESET, &dev->mphy.state);
+	}
 
-skip_dma_reset:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
-- 
2.42.0



