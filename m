Return-Path: <stable+bounces-133006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFEA91999
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713697A9796
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4A1AB50D;
	Thu, 17 Apr 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lg7+5gKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960B2DFA42
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886738; cv=none; b=dJVzkFwDSAmPjSUT4AkY8zuOfYgAusXhIEEcMoTmXgyh3hS3x/VDkesZd4hGAz1aaxUdY8Ej9n3/dL1SgcviR/zLmaacyVfA6tmsF0Qit5yxU2FRTtwbDCn7i/qACpWZGQ+0vnMgfmT07AFNPRKB4Jfd949BZsen3D3blbKGIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886738; c=relaxed/simple;
	bh=3GfgWeP1oNwZJMZAJwrLDYCGnlhWSJ2uLLUH1MoQbpw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DKmX+0SKFzOfZbFzpMCfBuVxE+wos1ZPvKnLLMU9ljVbbACnSTxrIBq/zL1opnIRFmTrTUggIUyzsTEdTQXq170oyiloQdBbYyOj8QaUHKJZfoKtqfayq5aCi4brlR040Q4+6/uqrzxL6k9wRaShEE8dc8nyXwXWfgmr1bcqzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lg7+5gKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CC3C4CEE4;
	Thu, 17 Apr 2025 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886738;
	bh=3GfgWeP1oNwZJMZAJwrLDYCGnlhWSJ2uLLUH1MoQbpw=;
	h=Subject:To:Cc:From:Date:From;
	b=Lg7+5gKzFuFczCRXDbcxestUkfM6aZ76/L3FlV4JS79qSHOoa9eRlYkXJ9Uq6GQXa
	 xZnx7NHgk5RgddgaMA1gixkGsRFrG2ljEDjMN/WMfDo38PidYYtV7Ym3l6K5BPhZV/
	 wpdl8I5l8PBgL1lqEZ8bog2kWvx+yak1YEvhmfuc=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd" failed to apply to 6.12-stable tree
To: mingyen.hsieh@mediatek.com,cjorden@gmail.com,nbd@nbd.name,sean.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:45:26 +0200
Message-ID: <2025041726-boned-uniformly-8dde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041726-boned-uniformly-8dde@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 Mon Sep 17 00:00:00 2001
From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date: Tue, 4 Mar 2025 16:08:50 -0800
Subject: [PATCH] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd

Integrate *mlo_sta_cmd and *sta_cmd for the MLO firmware.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Cc: stable@vger.kernel.org
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250305000851.493671-5-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d970243d64ff..17baa653dab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1814,49 +1814,6 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 	}
 }
 
-static int
-mt7925_mcu_sta_cmd(struct mt76_phy *phy,
-		   struct mt76_sta_cmd_info *info)
-{
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)info->vif->drv_priv;
-	struct mt76_dev *dev = phy->dev;
-	struct sk_buff *skb;
-	int conn_state;
-
-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
-					      MT7925_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
-				    CONN_STATE_DISCONNECT;
-	if (info->link_sta)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
-					      info->link_sta,
-					      conn_state, info->newly);
-	if (info->link_sta && info->enable) {
-		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
-		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
-		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
-		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
-					     info->link_sta);
-		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
-					    info->vif, info->rcpi,
-					    info->state);
-		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
-	}
-
-	if (info->enable)
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
-
-	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
-}
-
 static void
 mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 {
@@ -1869,8 +1826,8 @@ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 }
 
 static int
-mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
-		       struct mt76_sta_cmd_info *info)
+mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+		   struct mt76_sta_cmd_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -1884,12 +1841,10 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	if (info->enable)
+	if (info->enable && info->link_sta) {
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      info->enable, info->newly);
-
-	if (info->enable && info->link_sta) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
@@ -1940,7 +1895,6 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
-	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1949,12 +1903,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
-	if (ieee80211_vif_is_mld(vif))
-		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
-	else
-		err = mt7925_mcu_sta_cmd(&dev->mphy, &info);
-
-	return err;
+	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
 }
 
 int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,


