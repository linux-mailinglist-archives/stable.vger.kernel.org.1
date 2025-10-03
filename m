Return-Path: <stable+bounces-183207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF0BB6F47
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C890188CCAE
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634822F0698;
	Fri,  3 Oct 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQ18P73+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B81A0BF1
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497109; cv=none; b=H+SJWfXfEinbss2JPcOLiYkyNeWBLkDWZVpempy7ZwaMYReSSNuOe2S1SpCYywgQjgXiK7W1IkZH5bcgLiBzO9vt3tFOYpDNVs5PKYsS8Hw/1qCJxBzdVFdhb/hE0MZ3hSvwRGpPMzB5gL49NDmBgF+ynWEE9PLiRo/0WoqXLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497109; c=relaxed/simple;
	bh=JArNavTun4z78/Ky98sM+yysCZyYjeSRxkEc1vnE1U4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qCu0A4ZHfLnii9SMNO1ZSa5XFmBYo1sgr28pJzLe1WaLiuFnUJG6l+rnpP/sCz1gr5H+ZsK3KdtgIQegCiwiJYfonuJi6teFY168wKQKRuAK5BPo2u/HBxJAYt+bh6lv/hQTtjMKmhG/b2RXiLhiTQHqdtwRs7XB10Kzff6X290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQ18P73+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EBBC4CEF5;
	Fri,  3 Oct 2025 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497107;
	bh=JArNavTun4z78/Ky98sM+yysCZyYjeSRxkEc1vnE1U4=;
	h=Subject:To:Cc:From:Date:From;
	b=ZQ18P73+ijY8Xw2uYtlc6eaelKLOatBo3XVbltnhOUwkNAmfSFgdLUNA8/nxLNPYo
	 m9qHjU2rjJbKUkR4IY+oLyYQsK5KJ1Y/kNOuQYu8yb8nPh1wmU3r03nfnH9SThJhuj
	 NSKrIPjgCs93/uwctrReLjgMfNtfsCEFHq8b97k4=
Subject: FAILED: patch "[PATCH] wifi: rtw89: fix use-after-free in" failed to apply to 6.12-stable tree
To: pchelkin@ispras.ru,kevin_yang@realtek.com,pkshih@realtek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:11:42 +0200
Message-ID: <2025100342-eternity-attractor-07ca@gregkh>
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
git cherry-pick -x 3e31a6bc07312b448fad3b45de578471f86f0e77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100342-eternity-attractor-07ca@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e31a6bc07312b448fad3b45de578471f86f0e77 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Sat, 20 Sep 2025 00:08:47 +0300
Subject: [PATCH] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()

There is a bug observed when rtw89_core_tx_kick_off_and_wait() tries to
access already freed skb_data:

 BUG: KFENCE: use-after-free write in rtw89_core_tx_kick_off_and_wait drivers/net/wireless/realtek/rtw89/core.c:1110

 CPU: 6 UID: 0 PID: 41377 Comm: kworker/u64:24 Not tainted  6.17.0-rc1+ #1 PREEMPT(lazy)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20250523-14.fc42 05/23/2025
 Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]

 Use-after-free write at 0x0000000020309d9d (in kfence-#251):
 rtw89_core_tx_kick_off_and_wait drivers/net/wireless/realtek/rtw89/core.c:1110
 rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
 rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
 rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
 rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.h:141
 rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
 rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
 rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
 process_one_work kernel/workqueue.c:3241
 worker_thread kernel/workqueue.c:3400
 kthread kernel/kthread.c:463
 ret_from_fork arch/x86/kernel/process.c:154
 ret_from_fork_asm arch/x86/entry/entry_64.S:258

 kfence-#251: 0x0000000056e2393d-0x000000009943cb62, size=232, cache=skbuff_head_cache

 allocated by task 41377 on cpu 6 at 77869.159548s (0.009551s ago):
 __alloc_skb net/core/skbuff.c:659
 __netdev_alloc_skb net/core/skbuff.c:734
 ieee80211_nullfunc_get net/mac80211/tx.c:5844
 rtw89_core_send_nullfunc drivers/net/wireless/realtek/rtw89/core.c:3431
 rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
 rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
 rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
 rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.c:3194
 rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
 rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
 rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
 process_one_work kernel/workqueue.c:3241
 worker_thread kernel/workqueue.c:3400
 kthread kernel/kthread.c:463
 ret_from_fork arch/x86/kernel/process.c:154
 ret_from_fork_asm arch/x86/entry/entry_64.S:258

 freed by task 1045 on cpu 9 at 77869.168393s (0.001557s ago):
 ieee80211_tx_status_skb net/mac80211/status.c:1117
 rtw89_pci_release_txwd_skb drivers/net/wireless/realtek/rtw89/pci.c:564
 rtw89_pci_release_tx_skbs.isra.0 drivers/net/wireless/realtek/rtw89/pci.c:651
 rtw89_pci_release_tx drivers/net/wireless/realtek/rtw89/pci.c:676
 rtw89_pci_napi_poll drivers/net/wireless/realtek/rtw89/pci.c:4238
 __napi_poll net/core/dev.c:7495
 net_rx_action net/core/dev.c:7557 net/core/dev.c:7684
 handle_softirqs kernel/softirq.c:580
 do_softirq.part.0 kernel/softirq.c:480
 __local_bh_enable_ip kernel/softirq.c:407
 rtw89_pci_interrupt_threadfn drivers/net/wireless/realtek/rtw89/pci.c:927
 irq_thread_fn kernel/irq/manage.c:1133
 irq_thread kernel/irq/manage.c:1257
 kthread kernel/kthread.c:463
 ret_from_fork arch/x86/kernel/process.c:154
 ret_from_fork_asm arch/x86/entry/entry_64.S:258

It is a consequence of a race between the waiting and the signaling side
of the completion:

            Waiting thread                            Completing thread

rtw89_core_tx_kick_off_and_wait()
  rcu_assign_pointer(skb_data->wait, wait)
  /* start waiting */
  wait_for_completion_timeout()
                                                rtw89_pci_tx_status()
                                                  rtw89_core_tx_wait_complete()
                                                    rcu_read_lock()
                                                    /* signals completion and
                                                     * proceeds further
                                                     */
                                                    complete(&wait->completion)
                                                    rcu_read_unlock()
                                                  ...
                                                  /* frees skb_data */
                                                  ieee80211_tx_status_ni()
  /* returns (exit status doesn't matter) */
  wait_for_completion_timeout()
  ...
  /* accesses the already freed skb_data */
  rcu_assign_pointer(skb_data->wait, NULL)

The completing side might proceed and free the underlying skb even before
the waiting side is fully awoken and run to execution.  Actually the race
happens regardless of wait_for_completion_timeout() exit status, e.g.
the waiting side may hit a timeout and the concurrent completing side is
still able to free the skb.

Skbs which are sent by rtw89_core_tx_kick_off_and_wait() are owned by the
driver.  They don't come from core ieee80211 stack so no need to pass them
to ieee80211_tx_status_ni() on completing side.

Introduce a work function which will act as a garbage collector for
rtw89_tx_wait_info objects and the associated skbs.  Thus no potentially
heavy locks are required on the completing side.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of TX skbs")
Cc: stable@vger.kernel.org
Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250919210852.823912-2-pchelkin@ispras.ru

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fe059c4a6b55..ec467ae0e9e6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1135,6 +1135,14 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						tx_wait_work.work);
+
+	rtw89_tx_wait_list_clear(rtwdev);
+}
+
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	u8 ch_dma;
@@ -1152,6 +1160,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	unsigned long time_left;
 	int ret = 0;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait) {
 		rtw89_core_tx_kick_off(rtwdev, qsel);
@@ -1159,18 +1169,23 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	}
 
 	init_completion(&wait->completion);
+	wait->skb = skb;
 	rcu_assign_pointer(skb_data->wait, wait);
 
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
-	if (time_left == 0)
-		ret = -ETIMEDOUT;
-	else if (!wait->tx_done)
-		ret = -EAGAIN;
 
-	rcu_assign_pointer(skb_data->wait, NULL);
-	kfree_rcu(wait, rcu_head);
+	if (time_left == 0) {
+		ret = -ETIMEDOUT;
+		list_add_tail(&wait->list, &rtwdev->tx_waits);
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work,
+					 RTW89_TX_WAIT_WORK_TIMEOUT);
+	} else {
+		if (!wait->tx_done)
+			ret = -EAGAIN;
+		rtw89_tx_wait_release(wait);
+	}
 
 	return ret;
 }
@@ -5548,6 +5563,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	wiphy_work_cancel(wiphy, &btc->dhcp_notify_work);
 	wiphy_work_cancel(wiphy, &btc->icmp_notify_work);
 	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->tx_wait_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->track_ps_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->chanctx_work);
@@ -5773,6 +5789,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
 	INIT_LIST_HEAD(&rtwdev->scan_info.chan_list);
+	INIT_LIST_HEAD(&rtwdev->tx_waits);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -5784,6 +5801,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_delayed_work_init(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	wiphy_delayed_work_init(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
 	wiphy_delayed_work_init(&rtwdev->mcc_prepare_done_work, rtw89_mcc_prepare_done_work);
+	wiphy_delayed_work_init(&rtwdev->tx_wait_work, rtw89_tx_wait_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
 	wiphy_delayed_work_init(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3d4ad2ffb75c..d15fa70eb4dc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3507,9 +3507,12 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+#define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
+	struct list_head list;
 	struct completion completion;
+	struct sk_buff *skb;
 	bool tx_done;
 };
 
@@ -6000,6 +6003,9 @@ struct rtw89_dev {
 	/* used to protect rpwm */
 	spinlock_t rpwm_lock;
 
+	struct list_head tx_waits;
+	struct wiphy_delayed_work tx_wait_work;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
@@ -6256,6 +6262,26 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 	list_first_entry_or_null(&p->dlink_pool, typeof(*p->links_inst), dlink_schd); \
 })
 
+static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info *wait)
+{
+	dev_kfree_skb_any(wait->skb);
+	kfree_rcu(wait, rcu_head);
+}
+
+static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tx_wait_info *wait, *tmp;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
+		if (!completion_done(&wait->completion))
+			continue;
+		list_del(&wait->list);
+		rtw89_tx_wait_release(wait);
+	}
+}
+
 static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 				     struct rtw89_core_tx_request *tx_req)
 {
@@ -6265,6 +6291,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
+	rtw89_tx_wait_list_clear(rtwdev);
 }
 
 static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
@@ -7345,11 +7372,12 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
-static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
+static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       bool tx_done)
 {
 	struct rtw89_tx_wait_info *wait;
+	bool ret = false;
 
 	rcu_read_lock();
 
@@ -7357,11 +7385,14 @@ static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 	if (!wait)
 		goto out;
 
+	ret = true;
 	wait->tx_done = tx_done;
-	complete(&wait->completion);
+	/* Don't access skb anymore after completion */
+	complete_all(&wait->completion);
 
 out:
 	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c8286eb84276..8dd91d867ea6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -464,7 +464,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
-	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
+		return;
 
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index bb39fdbcba0d..fe7beff8c424 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -502,7 +502,9 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 		}
 
 		drv_stop_rx(ser);
+		wiphy_lock(wiphy);
 		drv_trx_reset(ser);
+		wiphy_unlock(wiphy);
 
 		/* wait m3 */
 		hal_send_m2_event(ser);


