Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060A7ECB82
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjKOTWp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKOTWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D220F1AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC3C433C7;
        Wed, 15 Nov 2023 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076159;
        bh=GlpT4XYHyAW98GHB97K3uTUBXQOINvG+ECjauaP0/fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDLRya+QwS/Q0GXnNGYJ5y8jnP6n6WVMrznrb66ENmiNpmFgk1yu56a9vjxATMZrp
         gzhGqtiXVS5LSTC23X3af8LwrfjMtcJYkOLjBdWNLjAjCvGRlB2tz+dCvyWFGQhUGP
         fu6r6SJ6nsLf1zV6AvaGn2fMzl2ilYygGYXwdJYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Michael-CY Lee <michael-cy.lee@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 086/550] wifi: mt76: mt7996: set correct wcid in txp
Date:   Wed, 15 Nov 2023 14:11:10 -0500
Message-ID: <20231115191606.671994316@linuxfoundation.org>
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

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit bde2e77f76266fbd81ff74cb12b3d87f9460b1e0 ]

Set correct wcid in txp to let the SDO hw module look into the correct
wtbl, otherwise the tx descriptor may be wrongly fiiled. This patch also
fixed the issue that driver could not correctly report sta statistics,
especially in WDS mode, which misled AQL.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Co-developed-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 8 +++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 6663a0b46541a..a6d8e59a2b60e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -243,6 +243,8 @@ enum tx_mgnt_type {
 #define MT_TXD7_UDP_TCP_SUM		BIT(15)
 #define MT_TXD7_TX_TIME			GENMASK(9, 0)
 
+#define MT_TXD9_WLAN_IDX		GENMASK(23, 8)
+
 #define MT_TX_RATE_STBC			BIT(14)
 #define MT_TX_RATE_NSS			GENMASK(13, 10)
 #define MT_TX_RATE_MODE			GENMASK(9, 6)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index b18fa4153aeb2..7da3baecc6de2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1168,10 +1168,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 
 	txp->fw.token = cpu_to_le16(id);
-	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
-		txp->fw.rept_wds_wcid = cpu_to_le16(wcid->idx);
-	else
-		txp->fw.rept_wds_wcid = cpu_to_le16(0xfff);
+	txp->fw.rept_wds_wcid = cpu_to_le16(sta ? wcid->idx : 0xfff);
+
 	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
@@ -1228,7 +1226,7 @@ mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
 		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 			mt7996_tx_check_aggr(sta, txwi);
 	} else {
-		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+		wcid_idx = le32_get_bits(txwi[9], MT_TXD9_WLAN_IDX);
 	}
 
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
-- 
2.42.0



