Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0F7ECD9D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjKOTh1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjKOTh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D8C9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA6AC433C8;
        Wed, 15 Nov 2023 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077043;
        bh=kmI89/JzW5SM/Wvw4S9wk9KXh/JbI9iMjOMDsD3sWMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAZLP2BSFz+WyzNLlqqMeWjjiA6jiXTCqfXgzEgIcI2YLOzYgyi5DgPqgJzI1GJAv
         Nm29AJj5xvSocQT+e6OMBLQXm9j0Tg2i3/HTVik9MLeqw0IhkyvzMhEpk2oqg9TuRQ
         EwaeCWvRp0v1m4k+uN5Jfu7jIaGNwdyO/1c5DsEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bo Jiao <Bo.Jiao@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 090/603] wifi: mt76: fix potential memory leak of beacon commands
Date:   Wed, 15 Nov 2023 14:10:35 -0500
Message-ID: <20231115191619.371278193@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bo Jiao <Bo.Jiao@mediatek.com>

[ Upstream commit d6a2f91741d9f43b31cb16c82da37f35117a6d1c ]

Fix potential memory leak when setting beacon and inband discovery
commands.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 ++++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5cf45c5ce5e13..44d5aad6c3cc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1925,8 +1925,10 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
 	}
 
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	info = IEEE80211_SKB_CB(skb);
 	info->control.vif = vif;
@@ -1938,6 +1940,7 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	if (skb->len > MT7915_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1994,11 +1997,14 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	if (skb->len > MT7915_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 44a7c5af43e06..f4545342018f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2042,11 +2042,14 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 		return PTR_ERR(rskb);
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	if (skb->len > MT7996_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2106,11 +2109,14 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
 	}
 
-	if (!skb)
+	if (!skb) {
+		dev_kfree_skb(rskb);
 		return -EINVAL;
+	}
 
 	if (skb->len > MT7996_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
+		dev_kfree_skb(rskb);
 		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
-- 
2.42.0



