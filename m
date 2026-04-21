Return-Path: <stable+bounces-240029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKsULHvk5mn01gEAu9opvQ
	(envelope-from <stable+bounces-240029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:44:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707E43591C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 749A53006123
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3B27EFEE;
	Tue, 21 Apr 2026 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="gIAlWkqy"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13827BF93;
	Tue, 21 Apr 2026 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739446; cv=none; b=NntvvdK0mjeiT6fYPpV7J17uNOBl0qMeT30Y/QgySm6p+QDVs7NCfOylSeWuJLb0CNgahladkSC9O6CcHRNhNHGaNQ8mMsXo0YQUR7PSg1/VGH8DV0dJG79SRV6BLQwO/7msMLm3Vs5+gH0jZ5jMJms6v/yuBRulQbBXv9jU/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739446; c=relaxed/simple;
	bh=o1V2gPv+XxTOCK67PlbDTjqKNHAxt4PaGVm6F8YEFGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gm4OQDBp8UppFnw8x6IxVfmhZe+vDpPn9FJvJBKybuR3pmgmuXXEyaKvTYJsZ0eoLtXlUCHdqokz5gNPKtLHHuPpQJfsQb+tlv63/TSlw9uOLUEYWW7NT8+J49vHyxRcyjfIw9IHDCFcSbVYX2pe7rLF3UfAxpUUJi/DfLT2yls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=gIAlWkqy; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gIAlWkqy4VUgdn7l61qR4C1gYz20lnkghC7Xjbxoyf2xxCt+TvjUzgOEyifRAZBQ/FxQue6U3Ls0h
	 FAEDxKItVokVq7F86N8QgEAGpZAIIoCx2NOdlhAdv53rm++cV5q2bEozIXkKLR1Tc3sBBJZL3NQy4s
	 UZVbe+QhsOw3uLaQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-26-12031 (RichMail) with SMTP id 2eff69e6e46855b-00562;
	Tue, 21 Apr 2026 10:43:54 +0800 (CST)
X-RM-TRANSID:2eff69e6e46855b-00562
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	nbd@nbd.name
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	toke@toke.dk,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nbd@openwrt.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	johannes.berg@intel.com
Subject: [PATCH 6.1.y] wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure
Date: Tue, 21 Apr 2026 10:43:52 +0800
Message-Id: <20260421024352.3132450-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-240029-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,toke.dk,kernel.org,sipsolutions.net,gmail.com,collabora.com,openwrt.org,lists.infradead.org,intel.com];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.190];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,nbd.name:email]
X-Rspamd-Queue-Id: 5707E43591C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit d5ad6ab61cbd89afdb60881f6274f74328af3ee9 ]

ieee80211_tx_prepare_skb() has three error paths, but only two of them
free the skb. The first error path (ieee80211_tx_prepare() returning
TX_DROP) does not free it, while invoke_tx_handlers() failure and the
fragmentation check both do.

Add kfree_skb() to the first error path so all three are consistent,
and remove the now-redundant frees in callers (ath9k, mt76,
mac80211_hwsim) to avoid double-free.

Document the skb ownership guarantee in the function's kdoc.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://patch.msgid.link/20260314065455.2462900-1-nbd@nbd.name
Fixes: 06be6b149f7e ("mac80211: add ieee80211_tx_prepare_skb() helper function")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Exclude changes to drivers/net/wireless/mediatek/mt76/scan.c as this file is first
 introduced by commit 31083e38548f("wifi: mt76: add code for emulating hardware scanning")
 after linux-6.14.]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/net/wireless/ath/ath9k/channel.c | 6 ++----
 drivers/net/wireless/mac80211_hwsim.c    | 1 -
 include/net/mac80211.h                   | 4 ++++
 net/mac80211/tx.c                        | 4 +++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 571062f2e82a..ba8ec5112afe 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1011,7 +1011,7 @@ static void ath_scan_send_probe(struct ath_softc *sc,
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 
 	if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, NULL))
-		goto error;
+		return;
 
 	txctl.txq = sc->tx.txq_map[IEEE80211_AC_VO];
 	if (ath_tx_start(sc->hw, skb, &txctl))
@@ -1124,10 +1124,8 @@ ath_chanctx_send_vif_ps_frame(struct ath_softc *sc, struct ath_vif *avp,
 
 		skb->priority = 7;
 		skb_set_queue_mapping(skb, IEEE80211_AC_VO);
-		if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, &sta)) {
-			dev_kfree_skb_any(skb);
+		if (!ieee80211_tx_prepare_skb(sc->hw, vif, skb, band, &sta))
 			return false;
-		}
 		break;
 	default:
 		return false;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 80a2a668cfb9..316b5f56b6e5 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2743,7 +2743,6 @@ static void hw_scan_work(struct work_struct *work)
 						      hwsim->tmp_chan->band,
 						      NULL)) {
 				rcu_read_unlock();
-				kfree_skb(probe);
 				continue;
 			}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 62e0847d3793..1769d03e6b1d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6874,6 +6874,10 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise.
+ * On failure, the skb is freed by this function; callers must not
+ * free it again.
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 7333e43dfc35..2e99a1063e93 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1934,8 +1934,10 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
 	struct ieee80211_tx_data tx;
 	struct sk_buff *skb2;
 
-	if (ieee80211_tx_prepare(sdata, &tx, NULL, skb) == TX_DROP)
+	if (ieee80211_tx_prepare(sdata, &tx, NULL, skb) == TX_DROP) {
+		kfree_skb(skb);
 		return false;
+	}
 
 	info->band = band;
 	info->control.vif = vif;
-- 
2.34.1



