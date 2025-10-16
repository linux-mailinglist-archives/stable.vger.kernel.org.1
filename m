Return-Path: <stable+bounces-186138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A768BE3ADE
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AD51A65A29
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4E2EBBAB;
	Thu, 16 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C8+KAr3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238241F1505
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620991; cv=none; b=p2LzR0wEh8iuTg6b42L45j9AAaEXcCX1bR04FZLWVlXk+gWKUSPPnBLwZgv6yAQu3UStcagJEAZvuMCvAT2Rm7EXfJlf4Y412lx6vgLjhWVGcY8bRy8tYC3gT2XgC1oAumBAQS/e29Em7usWtK5CMciWsWrbk4TMl8HFfiiurGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620991; c=relaxed/simple;
	bh=5BdIYZ+b9sFPuOlACefZinI+C1+p5PwRrsFPgFo17j4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cd7s0oMiuEQ3B71oGWi2OCIwwlGCVN8Lmq+4yG1mKNgjJYweXTU1+x8+N2YN4U7mGPE2wSuY/W1oAc82ng8uWevboUp40NqdOcCS8F+RrQ3+BXqQgoMJsjpImj75G92yzVzrSMuATL0tUnzxW3URte7BMZNhKseBjt9bNx52gKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C8+KAr3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1590C4CEF1;
	Thu, 16 Oct 2025 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620991;
	bh=5BdIYZ+b9sFPuOlACefZinI+C1+p5PwRrsFPgFo17j4=;
	h=Subject:To:Cc:From:Date:From;
	b=C8+KAr3H3DToZ1JSDDDyFj1nlLgoQL0Nwo+WMyCWzn5jh/ECeFjFpm7OwiYODarwn
	 Xlqc8ely+yLUHBAMTzTQW5dLAYaaTZZzRiL1H2HCZP+Lyi49CXWclKF5T+shL83QVu
	 Nwp4riS48RpugWZTzRaypQ9z1Ton09ww0p6EyhcQ=
Subject: FAILED: patch "[PATCH] wifi: rtw89: avoid possible TX wait initialization race" failed to apply to 6.12-stable tree
To: pchelkin@ispras.ru,pkshih@realtek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:21:43 +0200
Message-ID: <2025101643-jolt-creole-6a13@gregkh>
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
git cherry-pick -x c24248ed78f33ea299ea61d105355ba47157d49f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101643-jolt-creole-6a13@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c24248ed78f33ea299ea61d105355ba47157d49f Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Sat, 20 Sep 2025 00:08:48 +0300
Subject: [PATCH] wifi: rtw89: avoid possible TX wait initialization race

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

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ec467ae0e9e6..1f44c7fc1c5e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1153,25 +1153,14 @@ void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
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
@@ -1234,10 +1223,12 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link,
-				    struct sk_buff *skb, int *qsel, bool sw_mld)
+				    struct sk_buff *skb, int *qsel, bool sw_mld,
+				    struct rtw89_tx_wait_info *wait)
 {
 	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_core_tx_request tx_req = {};
 	int ret;
@@ -1254,6 +1245,8 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
+	rcu_assign_pointer(skb_data->wait, wait);
+
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
@@ -1290,7 +1283,8 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 	}
 
-	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false);
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false,
+					NULL);
 }
 
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
@@ -3928,6 +3922,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
 	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_tx_wait_info *wait;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct rtw89_sta *rtwsta;
@@ -3937,6 +3932,12 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
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
@@ -3951,6 +3952,8 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 		goto out;
 	}
 
+	wait->skb = skb;
+
 	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ps)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
@@ -3961,7 +3964,8 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 		goto out;
 	}
 
-	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true);
+	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true,
+				       wait);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
 		dev_kfree_skb_any(skb);
@@ -3970,10 +3974,11 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 
 	rcu_read_unlock();
 
-	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, qsel,
+	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, wait, qsel,
 					       timeout);
 out:
 	rcu_read_unlock();
+	kfree(wait);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d15fa70eb4dc..928c8c84c964 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7476,7 +7476,8 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 		 struct sk_buff *skb, bool fwdl);
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel);
 int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
-				    int qsel, unsigned int timeout);
+				    struct rtw89_tx_wait_info *wait, int qsel,
+				    unsigned int timeout);
 void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 			    struct rtw89_tx_desc_info *desc_info,
 			    void *txdesc);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 8dd91d867ea6..0ee5f8579447 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1494,7 +1494,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct pci_dev *pdev = rtwpci->pdev;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
-	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	bool en_wd_info = desc_info->en_wd_info;
 	u32 txwd_len;
 	u32 txwp_len;
@@ -1510,7 +1509,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
-	rcu_assign_pointer(skb_data->wait, NULL);
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;


