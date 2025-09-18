Return-Path: <stable+bounces-168298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BAFB23405
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B927B8B61
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D32ECE93;
	Tue, 12 Aug 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiH1a4Nu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994691DB92A;
	Tue, 12 Aug 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023707; cv=none; b=VUKTNrPwL5z7zV5gvyS1g0etHls1k2Gnst3l7GNlVrPRiNyYVRyjcYW/CRFdheuH62O6oO4gf5cunD9sD2rWFj3yPCiwFE4deFcSCkBeYKecjZHMRlM8n7NPhSReRTsO9yvjuu733sURJ5aQ9O8nc30B2cT49TZq/4BqhgPe7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023707; c=relaxed/simple;
	bh=EP1JG0LOFbvfoCEK7Ws0eFyNSIOHQBK/HLaVPSCJBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXUbd1qdDktmIZDp9uikeYvOKwXXor38LLfIBpjplJYQUV3SWqtdaWACYujngUI/0zD2rUsbKw5Sqs7MDrghiX7vcHuzH9UyWgKW+Ydcgh+FXcrcQWaazxzNY/xyhc2kgOM8sKYJO0AqAcvgB12piIH3yDoShicWkXcnZLnhB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiH1a4Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C787C4CEF0;
	Tue, 12 Aug 2025 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023707;
	bh=EP1JG0LOFbvfoCEK7Ws0eFyNSIOHQBK/HLaVPSCJBqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiH1a4Nu8YmbWWJGlaDGlXAS+5lis0SUMKIACyLBEbw8OZwQY5kOgQoctiDPlMpoD
	 6XGhC8LWIuiUiAPGD14HVGvoAHfsbg/Dio9ebAqfd54vnQiZkFck2A9zzIUPkuduAE
	 8DqecJmlDgUgAPTnRvbXINpNXXilGFBzZRvA2AgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kang Yang <kang.yang@oss.qualcomm.com>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 158/627] wifi: ath12k: update channel list in worker when wait flag is set
Date: Tue, 12 Aug 2025 19:27:33 +0200
Message-ID: <20250812173425.299181120@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kang Yang <kang.yang@oss.qualcomm.com>

[ Upstream commit 437c7a2db6a34db2a9048920694a2bf9b0169726 ]

With previous patch [1], ath12k_reg_update_chan_list() will be called
during reg_process_self_managed_hint().

reg_process_self_managed_hint() will hold rtnl_lock all the time.
But ath12k_reg_update_chan_list() may increase the occupation time of
rtnl_lock, because when wait flag is set, wait_for_completion_timeout()
will be called during 11d/hw scan.

Should minimize the occupation time of rtnl_lock as much as possible
to avoid interfering with rest of the system. So move the update channel
list operation to a new worker, so that wait_for_completion_timeout()
won't be called with the rtnl_lock held.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: f335295aa29c ("wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()") #[1]
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Link: https://patch.msgid.link/20250605082528.701-1-kang.yang@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.c |  1 +
 drivers/net/wireless/ath/ath12k/core.h |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 13 ++++
 drivers/net/wireless/ath/ath12k/reg.c  | 85 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.h  |  1 +
 drivers/net/wireless/ath/ath12k/wmi.h  |  1 +
 6 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 89ae80934b30..cd58ab9c2322 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1409,6 +1409,7 @@ void ath12k_core_halt(struct ath12k *ar)
 	ath12k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
+	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ab->rfkill_work);
 	cancel_work_sync(&ab->update_11d_work);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7bcd9c70309f..289998585fcb 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -719,7 +719,7 @@ struct ath12k {
 
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_link_vif info,
-	 * channel context data, survey info, test mode data.
+	 * channel context data, survey info, test mode data, regd_channel_update_queue.
 	 */
 	spinlock_t data_lock;
 
@@ -778,6 +778,8 @@ struct ath12k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct regd_channel_update_work;
+	struct list_head regd_channel_update_queue;
 
 	struct wiphy_work wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5be7b79db341..3616269538e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8289,6 +8289,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 {
 	struct ath12k_hw *ah = ar->ah;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct ath12k_wmi_scan_chan_list_arg *arg;
 	int ret;
 
 	lockdep_assert_held(&ah->hw_mutex);
@@ -8303,6 +8304,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
+	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->rfkill_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
@@ -8310,10 +8312,18 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	complete(&ar->completed_11d_scan);
 
 	spin_lock_bh(&ar->data_lock);
+
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
 		list_del(&ppdu_stats->list);
 		kfree(ppdu_stats);
 	}
+
+	while ((arg = list_first_entry_or_null(&ar->regd_channel_update_queue,
+					       struct ath12k_wmi_scan_chan_list_arg,
+					       list))) {
+		list_del(&arg->list);
+		kfree(arg);
+	}
 	spin_unlock_bh(&ar->data_lock);
 
 	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
@@ -12207,6 +12217,7 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 	int i;
 
 	for_each_ar(ah, ar, i) {
+		cancel_work_sync(&ar->regd_channel_update_work);
 		cancel_work_sync(&ar->regd_update_work);
 		ath12k_debugfs_unregister(ar);
 		ath12k_fw_stats_reset(ar);
@@ -12567,6 +12578,8 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
+	INIT_WORK(&ar->regd_channel_update_work, ath12k_regd_update_chan_list_work);
+	INIT_LIST_HEAD(&ar->regd_channel_update_queue);
 	INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
 
 	wiphy_work_init(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 2598b39d5d7e..0fc7f209956d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -137,32 +137,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 	struct ath12k_wmi_channel_arg *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret, left;
-
-	if (wait && ar->state_11d == ATH12K_11D_RUNNING) {
-		left = wait_for_completion_timeout(&ar->completed_11d_scan,
-						   ATH12K_SCAN_TIMEOUT_HZ);
-		if (!left) {
-			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-				   "failed to receive 11d scan complete: timed out\n");
-			ar->state_11d = ATH12K_11D_IDLE;
-		}
-		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-			   "reg 11d scan wait left time %d\n", left);
-	}
-
-	if (wait &&
-	    (ar->scan.state == ATH12K_SCAN_STARTING ||
-	    ar->scan.state == ATH12K_SCAN_RUNNING)) {
-		left = wait_for_completion_timeout(&ar->scan.completed,
-						   ATH12K_SCAN_TIMEOUT_HZ);
-		if (!left)
-			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-				   "failed to receive hw scan complete: timed out\n");
-
-		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-			   "reg hw scan wait left time %d\n", left);
-	}
+	int i, ret = 0;
 
 	if (ar->ah->state == ATH12K_HW_STATE_RESTARTING)
 		return 0;
@@ -244,6 +219,16 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 		}
 	}
 
+	if (wait) {
+		spin_lock_bh(&ar->data_lock);
+		list_add_tail(&arg->list, &ar->regd_channel_update_queue);
+		spin_unlock_bh(&ar->data_lock);
+
+		queue_work(ar->ab->workqueue, &ar->regd_channel_update_work);
+
+		return 0;
+	}
+
 	ret = ath12k_wmi_send_scan_chan_list_cmd(ar, arg);
 	kfree(arg);
 
@@ -764,6 +749,54 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 	return new_regd;
 }
 
+void ath12k_regd_update_chan_list_work(struct work_struct *work)
+{
+	struct ath12k *ar = container_of(work, struct ath12k,
+					 regd_channel_update_work);
+	struct ath12k_wmi_scan_chan_list_arg *arg;
+	struct list_head local_update_list;
+	int left;
+
+	INIT_LIST_HEAD(&local_update_list);
+
+	spin_lock_bh(&ar->data_lock);
+	list_splice_tail_init(&ar->regd_channel_update_queue, &local_update_list);
+	spin_unlock_bh(&ar->data_lock);
+
+	while ((arg = list_first_entry_or_null(&local_update_list,
+					       struct ath12k_wmi_scan_chan_list_arg,
+					       list))) {
+		if (ar->state_11d != ATH12K_11D_IDLE) {
+			left = wait_for_completion_timeout(&ar->completed_11d_scan,
+							   ATH12K_SCAN_TIMEOUT_HZ);
+			if (!left) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+					   "failed to receive 11d scan complete: timed out\n");
+				ar->state_11d = ATH12K_11D_IDLE;
+			}
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "reg 11d scan wait left time %d\n", left);
+		}
+
+		if ((ar->scan.state == ATH12K_SCAN_STARTING ||
+		     ar->scan.state == ATH12K_SCAN_RUNNING)) {
+			left = wait_for_completion_timeout(&ar->scan.completed,
+							   ATH12K_SCAN_TIMEOUT_HZ);
+			if (!left)
+				ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+					   "failed to receive hw scan complete: timed out\n");
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "reg hw scan wait left time %d\n", left);
+		}
+
+		ath12k_wmi_send_scan_chan_list_cmd(ar, arg);
+		list_del(&arg->list);
+		kfree(arg);
+	}
+}
+
 void ath12k_regd_update_work(struct work_struct *work)
 {
 	struct ath12k *ar = container_of(work, struct ath12k,
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 8af8e9ba462e..0aeba06182c5 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -113,6 +113,7 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 				struct ath12k_reg_info *reg_info,
 				enum wmi_vdev_type vdev_type,
 				enum ieee80211_ap_reg_power power_type);
+void ath12k_regd_update_chan_list_work(struct work_struct *work);
 enum wmi_reg_6g_ap_type
 ath12k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
 enum ath12k_reg_status ath12k_reg_validate_reg_info(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c640ffa180c8..117150220b99 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3948,6 +3948,7 @@ struct wmi_stop_scan_cmd {
 } __packed;
 
 struct ath12k_wmi_scan_chan_list_arg {
+	struct list_head list;
 	u32 pdev_id;
 	u16 nallchans;
 	struct ath12k_wmi_channel_arg channel[];
-- 
2.39.5




