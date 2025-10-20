Return-Path: <stable+bounces-188156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA67BF2366
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E385D3A3FD6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C72B24678F;
	Mon, 20 Oct 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyJcZeTC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4820D4E9
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975261; cv=none; b=FG0vyLbGJH/rRZupNvAdwhg/wlweLCR+0VJYKEA3EAI8N8ZADxv69NAXQiyVRY14XaKxsydF8Z4MuvCZgdmARaJX4NIdUIw5PHozrRLo1k7oTlW11SrkEsUrx4StCijQ4jCcJ/dfaLxfadTTNf80+Z/2HMIWN69yqAeXRYYxMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975261; c=relaxed/simple;
	bh=auO9jviLhUxP/Lv+6+EOLBZKS9p6clkS1anXo4s1lgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkIgBPYL6F0gGBdp3rw5Y8h59cwQzazHCgbqbw8ZrC/ex+7qj5qSh4GbH20wD6HrqersTEJaPM3qq9tF4b3dVoKg6XqPFFdWcWK5T7uoVBh/eABA3+jr0TdeMEBJ3A2KyBAvqIaLgzKs6dIvmxnH84Un6xgxw/wZHiYiLjYa8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyJcZeTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFADC4CEF9;
	Mon, 20 Oct 2025 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975260;
	bh=auO9jviLhUxP/Lv+6+EOLBZKS9p6clkS1anXo4s1lgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyJcZeTCcH4YffhKj6CrWiDKh7iIvY6tF/LXP1iYNZ8wrQYYKG4f7EKrnlHrCUqL2
	 OEmNhRIgDgAqQgxTVxwooN7fSjgQpc+pnEl5QXfK7qcptNMbL2hBy1UGoJEHGtzlq3
	 K/3Nrn5nk1gegP0kf9AdiDzNB5BIWmienxeg/zuhLZ03VNN0B7+MehxqQ4RCY8Ryp6
	 yKSxDNecfc2ROJGha/vTqpt2iub1QfEFr1uzIL942h/993KnmX5nzL3WzkzCbV5mwR
	 QU+LVc/tFWSFF1XkAmNOxeebNjtRYVkwRsUW1oW/hy1QHRHtm3TLc5CjoPfOolYI8Z
	 CxEgB8TFHuZMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: rtw89: avoid possible TX wait initialization race
Date: Mon, 20 Oct 2025 11:47:33 -0400
Message-ID: <20251020154733.1824513-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101643-jolt-creole-6a13@gregkh>
References: <2025101643-jolt-creole-6a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit c24248ed78f33ea299ea61d105355ba47157d49f ]

The value of skb_data->wait indicates whether skb is passed on to the
core mac80211 stack or released by the driver itself.  Make sure that by
the time skb is added to txwd queue and becomes visible to the completing
side, it has already allocated and initialized TX wait related data (in
case it's needed).

This is found by code review and addresses a possible race scenario
described below:

      Waiting thread                          Completing thread

rtw89_core_send_nullfunc()
  rtw89_core_tx_write_link()
    ...
    rtw89_pci_txwd_submit()
      skb_data->wait = NULL
      /* add skb to the queue */
      skb_queue_tail(&txwd->queue, skb)

  /* another thread (e.g. rtw89_ops_tx) performs TX kick off for the same queue */

                                            rtw89_pci_napi_poll()
                                            ...
                                              rtw89_pci_release_txwd_skb()
                                                /* get skb from the queue */
                                                skb_unlink(skb, &txwd->queue)
                                                rtw89_pci_tx_status()
                                                  rtw89_core_tx_wait_complete()
                                                  /* use incorrect skb_data->wait */
  rtw89_core_tx_kick_off_and_wait()
  /* assign skb_data->wait but too late */

Found by Linux Verification Center (linuxtesting.org).

Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of TX skbs")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250919210852.823912-3-pchelkin@ispras.ru
[ adapted rtw89_core_tx_write_link() modifications to rtw89_core_tx_write() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 39 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     |  6 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |  2 -
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 99711a4fb85df..df8fad7a2aea6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -978,25 +978,14 @@ void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 }
 
 int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
-				    int qsel, unsigned int timeout)
+				    struct rtw89_tx_wait_info *wait, int qsel,
+				    unsigned int timeout)
 {
-	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
-	struct rtw89_tx_wait_info *wait;
 	unsigned long time_left;
 	int ret = 0;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
-	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
-	if (!wait) {
-		rtw89_core_tx_kick_off(rtwdev, qsel);
-		return 0;
-	}
-
-	init_completion(&wait->completion);
-	wait->skb = skb;
-	rcu_assign_pointer(skb_data->wait, wait);
-
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
@@ -1057,10 +1046,12 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel)
+			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel,
+			struct rtw89_tx_wait_info *wait)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct rtw89_core_tx_request tx_req = {0};
 	struct rtw89_sta_link *rtwsta_link = NULL;
 	struct rtw89_vif_link *rtwvif_link;
@@ -1093,6 +1084,8 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
+	rcu_assign_pointer(skb_data->wait, wait);
+
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
@@ -2908,7 +2901,7 @@ static void rtw89_core_txq_push(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 		rtw89_core_txq_check_agg(rtwdev, rtwtxq, skb);
-		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, NULL);
+		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, NULL, NULL);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to push txq: %d\n", ret);
 			ieee80211_free_txskb(rtwdev->hw, skb);
@@ -3084,7 +3077,7 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
 		skb_unlink(skb, &rtwsta->roc_queue);
 
-		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
+		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel, NULL);
 		if (ret) {
 			rtw89_warn(rtwdev, "pending tx failed with %d\n", ret);
 			dev_kfree_skb_any(skb);
@@ -3106,6 +3099,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link, bool qos, bool ps)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_tx_wait_info *wait;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
@@ -3114,6 +3108,12 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
 		return 0;
 
+	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
+	if (!wait)
+		return -ENOMEM;
+
+	init_completion(&wait->completion);
+
 	rcu_read_lock();
 	sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
 	if (!sta) {
@@ -3127,11 +3127,13 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 		goto out;
 	}
 
+	wait->skb = skb;
+
 	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ps)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
 
-	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
+	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel, wait);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
 		dev_kfree_skb_any(skb);
@@ -3140,10 +3142,11 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 
 	rcu_read_unlock();
 
-	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, qsel,
+	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, wait, qsel,
 					       RTW89_ROC_TX_TIMEOUT);
 out:
 	rcu_read_unlock();
+	kfree(wait);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cb703588e3a4f..7be32b83d4d64 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6818,12 +6818,14 @@ static inline bool rtw89_is_rtl885xb(struct rtw89_dev *rtwdev)
 }
 
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
+			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel,
+			struct rtw89_tx_wait_info *wait);
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 		 struct sk_buff *skb, bool fwdl);
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel);
 int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
-				    int qsel, unsigned int timeout);
+				    struct rtw89_tx_wait_info *wait, int qsel,
+				    unsigned int timeout);
 void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 			    struct rtw89_tx_desc_info *desc_info,
 			    void *txdesc);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 3a1a2b243adf0..d1f9bd41f8b5d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -36,7 +36,7 @@ static void rtw89_ops_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
-	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
+	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel, NULL);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb: %d\n", ret);
 		ieee80211_free_txskb(hw, skb);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5fd5fe88e6b08..a87e1778a0d41 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1366,7 +1366,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct pci_dev *pdev = rtwpci->pdev;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
-	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	bool en_wd_info = desc_info->en_wd_info;
 	u32 txwd_len;
 	u32 txwp_len;
@@ -1382,7 +1381,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
-	rcu_assign_pointer(skb_data->wait, NULL);
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
-- 
2.51.0


