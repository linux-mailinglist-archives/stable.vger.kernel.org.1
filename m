Return-Path: <stable+bounces-78467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8892598BAF5
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4759C283776
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9751BF7F5;
	Tue,  1 Oct 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsIi0W4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0419AD4F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781910; cv=none; b=c1yVDOup6GA5A4rVJaWK/dn0vbav1OWBlVtAs8RpSC4HeSoI8SrQgrzC41dmyzwxVzFkO+exMo9ppawznu9M2c5jTs9lyOCPIJo2GpDhtOvdKgK297hhMq6iRXuL9Hi2d7Rs5CXrztfyaS66oUPh54ACTij4aj7qKRsFoLzanS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781910; c=relaxed/simple;
	bh=jonA0JigixndExJea8hbhba9iZT3o4l3aujkQKq+AzM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jSKcEA4XEB+HtzG0FXWyXTSbB068OExWnl4L1dL/oLGQS6KHyWGaaH9mZtAMLM8O5Z4GjUnREyIjYqVh0e7VNJGKwj1Brbkfi9TpY0PDIsMG+deOwZ7ddSAZw058zQW2qeQB+qBeFCUwxAbm7VLJe/l9fT+2Ur2XqJPC5yMW3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsIi0W4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D22C4CECD;
	Tue,  1 Oct 2024 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781909;
	bh=jonA0JigixndExJea8hbhba9iZT3o4l3aujkQKq+AzM=;
	h=Subject:To:Cc:From:Date:From;
	b=QsIi0W4bgKyBAV47YNRkNE27rQY/FSMqMUikfPHpYvh8DRUGCz5twOlct/Y5QN9Pu
	 niXnrKbWqEnFau8Apq88Jkl0R+CW+CF5hRUnCA7KOVRpAxAcCnQHEoFToSNISJah9J
	 usxez+RTqJmzmxDQYnO7eSHakAlEBkj090ldV7LA=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7925: fix a potential association failure upon" failed to apply to 6.10-stable tree
To: michael.lo@mediatek.com,mingyen.hsieh@mediatek.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:25:07 +0200
Message-ID: <2024100106-candy-amicably-5df2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 45064d19fd3af6aeb0887b35b5564927980cf150
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100106-candy-amicably-5df2@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

45064d19fd3a ("wifi: mt76: mt7925: fix a potential association failure upon resuming")
5f5b6a745c69 ("wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA")
89397bccc882 ("wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA")
064a5955aa27 ("wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA")
f7cc8944039c ("wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA")
21760dcd2ab6 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS")
220865160cf6 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS")
eff53d6ee11b ("wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS")
d62f77e34778 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS")
b8b04b6616ba ("wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS")
fa5f44463f51 ("wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS")
acdfc3e79899 ("wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS")
7cebb6a66ac6 ("wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS")
43626f0e0c99 ("wifi: mt76: mt7925: support for split bss_info_changed method")
4c28c0976ed8 ("wifi: mt76: mt792x: add struct mt792x_link_sta")
30e89baeb01f ("wifi: mt76: mt792x: add struct mt792x_bss_conf")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45064d19fd3af6aeb0887b35b5564927980cf150 Mon Sep 17 00:00:00 2001
From: Michael Lo <michael.lo@mediatek.com>
Date: Mon, 2 Sep 2024 17:00:54 +0800
Subject: [PATCH] wifi: mt76: mt7925: fix a potential association failure upon
 resuming

In multi-channel scenarios, the granted channel must be aborted before
suspending. Otherwise, the firmware will be put into a wrong state,
resulting in an association failure after resuming.

With this patch, the granted channel will be aborted before suspending
if necessary.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20240902090054.15806-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 38a301533297..791c8b00e112 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -439,6 +439,19 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
 	mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
 }
 
+void mt7925_roc_abort_sync(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7925_roc_iter, (void *)phy);
+}
+EXPORT_SYMBOL_GPL(mt7925_roc_abort_sync);
+
 void mt7925_roc_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
@@ -1112,6 +1125,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
 
+	mt7925_roc_abort_sync(dev);
+
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index e80824a10b2c..f5c02e5f5066 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -307,6 +307,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		       enum mt7925_roc_req type, u8 token_id);
 int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			 u8 token_id);
+void mt7925_roc_abort_sync(struct mt792x_dev *dev);
 int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq);
 int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index cb25eb50a45b..9aec675450f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -449,6 +449,8 @@ static int mt7925_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt7925_roc_abort_sync(dev);
+
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
 		goto restore_suspend;


