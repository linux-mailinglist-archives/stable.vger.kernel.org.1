Return-Path: <stable+bounces-133003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443BA91991
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1622E1716FD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6322D7BF;
	Thu, 17 Apr 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LchJt/q9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAA2DFA36
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886628; cv=none; b=C2EimrxrQLTZuUhJSOwz5NzPaphgORN/cHuwzn/ba+suoxWnMsTDJVQ8O0h4gp7g4mpJn/xkBRO2Zrc/FRVZ+ZEDQ45kgaGfOBoY06zWfQMUgCt4fAnUtZOMhcVEeLrOuNUpHEqvR/SLl6Qq1xwAScAyqi7Uh6jRUtPka2DgSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886628; c=relaxed/simple;
	bh=T48CQrQ8Dc9sNIrq4Yt2CojLmIsaCz7wE2djRHSzius=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mx8kIh79V/5yr+chplOt1xj2ubhI6wQsyeDFYZcjlHrYiI1TrFYeQ1AoE3kcLo1GPuv+EOJm70IndVX8yPEY8LsV3QelOk0sQ4xMHpsprL46zIE6jqwyoJOCj+qBXkHWG6yRiDN65CGlBN0p3jmiyEnWgZVjB1/umYY1CMMG3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LchJt/q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50739C4CEE4;
	Thu, 17 Apr 2025 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886627;
	bh=T48CQrQ8Dc9sNIrq4Yt2CojLmIsaCz7wE2djRHSzius=;
	h=Subject:To:Cc:From:Date:From;
	b=LchJt/q9nRUfY/R/oKuLXKsiGL8hmpIUx8cW17iPaDSqqi3ufTazedPKIQSnYbr8+
	 nNz1H2RGnjE7euHKg2XksTAU4MJPOkmTmsE2I3/Ei/TJkl/2KuoFoE9D9qHjTe0ZH4
	 jbRQD6BlMqc10hz2XMu4MnwPhuA+JW7K9WjWkOcc=
Subject: FAILED: patch "[PATCH] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba" failed to apply to 6.13-stable tree
To: sean.wang@mediatek.com,cjorden@gmail.com,mingyen.hsieh@mediatek.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:43:44 +0200
Message-ID: <2025041744-scotch-tropics-a86f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 766ea2cf5a398c7eed519b12c6c6cf1631143ea2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041744-scotch-tropics-a86f@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 766ea2cf5a398c7eed519b12c6c6cf1631143ea2 Mon Sep 17 00:00:00 2001
From: Sean Wang <sean.wang@mediatek.com>
Date: Tue, 4 Mar 2025 16:08:46 -0800
Subject: [PATCH] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba
 for MLO"

For MLO, mac80211 will send the BA action for each link to
the driver, so the driver does not need to handle it itself.
Therefore, revert this patch.

Fixes: eb2a9a12c609 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20250305000851.493671-1-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ad47a4b153da..47a6040381a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1289,22 +1289,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, vif, params, true);
+		mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, vif, params, true);
+		mt7925_mcu_uni_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1313,7 +1313,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 7885d71b7a77..ebe7cc30aaf9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -572,10 +572,10 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 
 static int
 mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
-		  struct mt76_wcid *wcid,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -603,60 +603,28 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 
 /** starec & wtbl **/
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_link_sta *mlink;
-	struct mt792x_bss_conf *mconf;
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct mt76_wcid *wcid;
-	u8 link_id, ret;
+	struct mt792x_vif *mvif = msta->vif;
 
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(msta, link_id);
-		wcid = &mlink->wcid;
+	if (enable && !params->amsdu)
+		msta->deflink.wcid.amsdu = false;
 
-		if (enable && !params->amsdu)
-			mlink->wcid.amsdu = false;
-
-		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
-					enable, true);
-		if (ret < 0)
-			break;
-	}
-
-	return ret;
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, true);
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_link_sta *mlink;
-	struct mt792x_bss_conf *mconf;
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct mt76_wcid *wcid;
-	u8 link_id, ret;
+	struct mt792x_vif *mvif = msta->vif;
 
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(msta, link_id);
-		wcid = &mlink->wcid;
-
-		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
-					enable, false);
-		if (ret < 0)
-			break;
-	}
-
-	return ret;
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, false);
 }
 
 static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 8707b5d04743..fd5f9d4ea4a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -263,11 +263,9 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable);
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7925_scan_work(struct work_struct *work);


