Return-Path: <stable+bounces-250117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gItHNAUNDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:35:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CCF59875B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64963476679
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB093E9C0C;
	Wed, 20 May 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHiII7gS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34D37754D;
	Wed, 20 May 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294588; cv=none; b=kmNhKjoj7id0lrot/6Zq5bnDGNI/bNGPEq2u1cLyALaRzjkE/L/cVthZDlbuksWXOJ1lu8Z6kI6c3rYqLc0/FPCJqUPMsJMHRdZzDVS9hIsYzecLeAuwRbXtTB54yVEre14KLgp/AssSozkNRfPOVHYh9b5R4GHWHsqalC5dRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294588; c=relaxed/simple;
	bh=WuwCp04v1VjooelMPpRX+9G5pbeb+rgB0ajm7tIrBBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQJpAkOPs80kXXA0Pot+PXTGXLJ2WykPY+ZGZJQwxU6D6DmyvQImrdHqLABbaojTAorrF2dX68b3jDxs4OkTJonW+cLgoDpB8S9vkGbxyws15/DwQdzDXOTSWAvU4jMUbT254Xwdm2wPi6HG3mfSEbb3BHHa7m5YUntheK6I674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHiII7gS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E341F000E9;
	Wed, 20 May 2026 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294587;
	bh=qASBLM94+1ovpqYB5HGJ4f5sai3N9ihp4Qu8pW71SHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHiII7gS6qjutle3c1TzBDzXOAFjcBHT1E8fm7HJLO5Z5MGJu4+4paZKEVohYCbAc
	 n/sUMTa9rbr03J0A8AnpjLXCcVqH90iCydUSRUKTHOz8unGyyx3AbmkLtOoX1m0a4t
	 KjgbL3YFOEG4PiOcLEvowzM8ZvLYIuhB5HE8xeGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0097/1146] wifi: mt76: mt7996: Switch to the secondary link if the default one is removed
Date: Wed, 20 May 2026 18:05:47 +0200
Message-ID: <20260520162150.542494853@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250117-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:email]
X-Rspamd-Queue-Id: 58CCF59875B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 5ef44c200618430b004233cbfc1b0929a13d5ac8 ]

Switch to the secondary link if available in mt7996_mac_sta_remove_links
routine if the primary one is removed.
Moreover reset secondary link index for single link scenario.

Fixes: 85cd5534a3f2e ("wifi: mt76: mt7996: use correct link_id when filling TXD and TXP")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20251205-mt76-txq-wicd-fix-v2-3-f19ba48af7c1@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 12 ++---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 51 +++++++++++++------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2fc4513388ab7..5e0c85066803d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2404,14 +2404,12 @@ mt7996_mac_reset_sta_iter(void *data, struct ieee80211_sta *sta)
 			continue;
 
 		mt7996_mac_sta_deinit_link(dev, msta_link);
-
-		if (msta->deflink_id == i) {
-			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
-			continue;
-		}
-
-		kfree_rcu(msta_link, rcu_head);
+		if (msta_link != &msta->deflink)
+			kfree_rcu(msta_link, rcu_head);
 	}
+
+	msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+	msta->seclink_id = msta->deflink_id;
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c6204a8673ee7..50ccfe3e10bad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -961,6 +961,22 @@ mt7996_post_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static void
+mt7996_sta_init_txq_wcid(struct ieee80211_sta *sta, int idx)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct mt76_txq *mtxq;
+
+		if (!sta->txq[i])
+			continue;
+
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+		mtxq->wcid = idx;
+	}
+}
+
 static int
 mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 			 struct ieee80211_bss_conf *link_conf,
@@ -978,21 +994,10 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 		return -ENOSPC;
 
 	if (msta->deflink_id == IEEE80211_LINK_UNSPECIFIED) {
-		int i;
-
 		msta_link = &msta->deflink;
 		msta->deflink_id = link_id;
 		msta->seclink_id = msta->deflink_id;
-
-		for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
-			struct mt76_txq *mtxq;
-
-			if (!sta->txq[i])
-				continue;
-
-			mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-			mtxq->wcid = idx;
-		}
+		mt7996_sta_init_txq_wcid(sta, idx);
 	} else {
 		msta_link = kzalloc_obj(*msta_link);
 		if (!msta_link)
@@ -1075,12 +1080,28 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		mphy->num_sta--;
 		if (msta->deflink_id == link_id) {
 			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
-			continue;
+			if (msta->seclink_id == link_id) {
+				/* no secondary link available */
+				msta->seclink_id = msta->deflink_id;
+			} else {
+				struct mt7996_sta_link *msta_seclink;
+
+				/* switch to the secondary link */
+				msta_seclink = mt76_dereference(
+						msta->link[msta->seclink_id],
+						mdev);
+				if (msta_seclink) {
+					msta->deflink_id = msta->seclink_id;
+					mt7996_sta_init_txq_wcid(sta,
+						msta_seclink->wcid.idx);
+				}
+			}
 		} else if (msta->seclink_id == link_id) {
-			msta->seclink_id = IEEE80211_LINK_UNSPECIFIED;
+			msta->seclink_id = msta->deflink_id;
 		}
 
-		kfree_rcu(msta_link, rcu_head);
+		if (msta_link != &msta->deflink)
+			kfree_rcu(msta_link, rcu_head);
 	}
 }
 
-- 
2.53.0




