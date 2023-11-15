Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B567ECB81
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjKOTWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjKOTWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D61B6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF7BC433CB;
        Wed, 15 Nov 2023 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076158;
        bh=EA1cNAXme7rWwGZvnWsnz/DsmUW3MQ43Gv8RuSqv21Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev2BkxmAv324HEdneQR+twuMbPpjDw97qmJv0ddlr3hYLMHvSKY/S9jkh3f4st1nc
         a9C3jxhoLCCfxY2b5e3DCiFwV8a91J9wqjDx8cnvTny/aMlX5lUx2K8AZoUyEjzLj9
         ZH5zvic2/oXvX6LLcDmiDBAjs9+t9iOSaLZ77I2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 085/550] wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb
Date:   Wed, 15 Nov 2023 14:11:09 -0500
Message-ID: <20231115191606.602762376@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 832f42699791e7a90e81c15da0ce886b4f8300b8 ]

The error handling code was added in order to allow tx enqueue to fail after
calling .tx_prepare_skb. Since this can no longer happen, the error handling
code is unused.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: bde2e77f7626 ("wifi: mt76: mt7996: set correct wcid in txp")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c        |  3 ---
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c    | 17 -----------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  2 +-
 6 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f539913aadf86..e57ce25f3d816 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -330,9 +330,6 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	if (e->txwi == DMA_DUMMY_DATA)
 		e->txwi = NULL;
 
-	if (e->skb == DMA_DUMMY_DATA)
-		e->skb = NULL;
-
 	*prev_e = *e;
 	memset(e, 0, sizeof(*e));
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 0019890fdb784..fbb1181c58ff3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -106,7 +106,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	else
 		mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
 
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index e415ac5e321f1..a800c071537f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -151,23 +151,6 @@ void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
 		return;
 	}
 
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_connac_txp_common *txp;
-		struct mt76_txwi_cache *t;
-		u16 token;
-
-		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
-		if (is_mt76_fw_txp(mdev))
-			token = le16_to_cpu(txp->fw.token);
-		else
-			token = le16_to_cpu(txp->hw.msdu_id[0]) &
-				~MT_MSDU_ID_VALID;
-
-		t = mt76_token_put(mdev, token);
-		e->skb = t ? t->skb : NULL;
-	}
-
 	if (e->skb)
 		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7df8d95fc3fbc..13071df3f6c21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -808,7 +808,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
 	else
 		txp->rept_wds_wcid = cpu_to_le16(0x3ff);
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 6053a2556c20c..46f1360fbc59a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -48,7 +48,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
 	mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
 
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 25c5deb15d213..b18fa4153aeb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1172,7 +1172,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->fw.rept_wds_wcid = cpu_to_le16(wcid->idx);
 	else
 		txp->fw.rept_wds_wcid = cpu_to_le16(0xfff);
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
-- 
2.42.0



