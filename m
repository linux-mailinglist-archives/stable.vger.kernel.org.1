Return-Path: <stable+bounces-133663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A996CA926BC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204A31901B9D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4D81B3934;
	Thu, 17 Apr 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AcuJ4ZBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1E8462;
	Thu, 17 Apr 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913761; cv=none; b=L5PNdLjwmjIBF/Gl6XN8HMfVUHMxhkG3PR3pq6cHpVC/4QQk3zqnjfkEWVxZsL6M/Z0k9D9bN0SUnltg8abUAJhYZ2dO0HhJEo+BxhT1FBEurAyThvG4YbBK9vXNScHQhkr8J14Sj8KGKyhc9aqhIxf5uaxOTK/MVCV5vjBlt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913761; c=relaxed/simple;
	bh=AzjBoDymluowiIVJPlhuvLmVDYt+dy1Wy0tZVzE5t54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUW90lN+nxQzNmyKgkyuErdqgxIUSEdAMVbu9zfpPJp5ZC8/YOQXeZA8ff5XZo6BRKXbiC8+xrL+4ak6ipIXohvST9V1Iw3S63uToo69xfmzFzxcc6LJiXW37FqagnjchliXaRGyIueb5snTn4nKeJCoIgULz4q3Zx067mdewNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AcuJ4ZBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07863C4CEE4;
	Thu, 17 Apr 2025 18:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913761;
	bh=AzjBoDymluowiIVJPlhuvLmVDYt+dy1Wy0tZVzE5t54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AcuJ4ZBobcAbYxJDmD4ovL8O9tzBtQyvLXxUVyuJQtVSt1Ti90QDCXEpyyEJoTwQV
	 sgl/HbFW3fTi4r2hFX/yVILjqjTbB8a5KmE0eflSuRiaoqSapiCnDVHzT6JJtVHfxC
	 Pb9bLTMe4sDbI5tEJDQDvWqZRnrz0m9VMHImf04A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wen Gong <quic_wgong@quicinc.com>,
	Kang Yang <quic_kangyang@quicinc.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 6.14 444/449] wifi: ath11k: update channel list in worker when wait flag is set
Date: Thu, 17 Apr 2025 19:52:12 +0200
Message-ID: <20250417175136.186459724@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Gong <quic_wgong@quicinc.com>

commit 02aae8e2f957adc1b15b6b8055316f8a154ac3f5 upstream.

With previous patch "wifi: ath11k: move update channel list from update
reg worker to reg notifier", ath11k_reg_update_chan_list() will be
called during reg_process_self_managed_hint().

reg_process_self_managed_hint() will hold rtnl_lock all the time.
But ath11k_reg_update_chan_list() may increase the occupation time of
rtnl_lock, because when wait flag is set, wait_for_completion_timeout()
will be called during 11d/hw scan.

Should minimize the occupation time of rtnl_lock as much as possible
to avoid interfering with rest of the system. So move the update channel
list operation to a new worker, so that wait_for_completion_timeout()
won't be called and will not increase the occupation time of rtnl_lock.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Link: https://patch.msgid.link/20250117061737.1921-3-quic_kangyang@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/core.c |    1 
 drivers/net/wireless/ath/ath11k/core.h |    5 +
 drivers/net/wireless/ath/ath11k/mac.c  |   14 +++++
 drivers/net/wireless/ath/ath11k/reg.c  |   85 ++++++++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/reg.h  |    3 -
 drivers/net/wireless/ath/ath11k/wmi.h  |    1 
 6 files changed, 81 insertions(+), 28 deletions(-)

--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2056,6 +2056,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	ath11k_mac_scan_finish(ar);
 	ath11k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
 
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -685,7 +685,7 @@ struct ath11k {
 	struct mutex conf_mutex;
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath11k_sta info, ath11k_vif info,
-	 * channel context data, survey info, test mode data.
+	 * channel context data, survey info, test mode data, channel_update_queue.
 	 */
 	spinlock_t data_lock;
 
@@ -743,6 +743,9 @@ struct ath11k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct channel_update_work;
+	/* protected with data_lock */
+	struct list_head channel_update_queue;
 
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6283,6 +6283,7 @@ static void ath11k_mac_op_stop(struct ie
 {
 	struct ath11k *ar = hw->priv;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct scan_chan_list_params *params;
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
@@ -6298,6 +6299,7 @@ static void ath11k_mac_op_stop(struct ie
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
 
@@ -6307,10 +6309,19 @@ static void ath11k_mac_op_stop(struct ie
 	}
 
 	spin_lock_bh(&ar->data_lock);
+
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
 		list_del(&ppdu_stats->list);
 		kfree(ppdu_stats);
 	}
+
+	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
+						  struct scan_chan_list_params,
+						  list))) {
+		list_del(&params->list);
+		kfree(params);
+	}
+
 	spin_unlock_bh(&ar->data_lock);
 
 	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
@@ -10014,6 +10025,7 @@ static const struct wiphy_iftype_ext_cap
 
 static void __ath11k_mac_unregister(struct ath11k *ar)
 {
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(ar->hw);
@@ -10413,6 +10425,8 @@ int ath11k_mac_allocate(struct ath11k_ba
 		init_completion(&ar->thermal.wmi_sync);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
+		INIT_WORK(&ar->channel_update_work, ath11k_regd_update_chan_list_work);
+		INIT_LIST_HEAD(&ar->channel_update_queue);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
 
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -124,32 +124,7 @@ int ath11k_reg_update_chan_list(struct a
 	struct channel_param *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret, left;
-
-	if (wait && ar->state_11d != ATH11K_11D_IDLE) {
-		left = wait_for_completion_timeout(&ar->completed_11d_scan,
-						   ATH11K_SCAN_TIMEOUT_HZ);
-		if (!left) {
-			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-				   "failed to receive 11d scan complete: timed out\n");
-			ar->state_11d = ATH11K_11D_IDLE;
-		}
-		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "11d scan wait left time %d\n", left);
-	}
-
-	if (wait &&
-	    (ar->scan.state == ATH11K_SCAN_STARTING ||
-	    ar->scan.state == ATH11K_SCAN_RUNNING)) {
-		left = wait_for_completion_timeout(&ar->scan.completed,
-						   ATH11K_SCAN_TIMEOUT_HZ);
-		if (!left)
-			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-				   "failed to receive hw scan complete: timed out\n");
-
-		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "hw scan wait left time %d\n", left);
-	}
+	int i, ret = 0;
 
 	if (ar->state == ATH11K_STATE_RESTARTING)
 		return 0;
@@ -231,6 +206,16 @@ int ath11k_reg_update_chan_list(struct a
 		}
 	}
 
+	if (wait) {
+		spin_lock_bh(&ar->data_lock);
+		list_add_tail(&params->list, &ar->channel_update_queue);
+		spin_unlock_bh(&ar->data_lock);
+
+		queue_work(ar->ab->workqueue, &ar->channel_update_work);
+
+		return 0;
+	}
+
 	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
 	kfree(params);
 
@@ -811,6 +796,54 @@ ret:
 	return new_regd;
 }
 
+void ath11k_regd_update_chan_list_work(struct work_struct *work)
+{
+	struct ath11k *ar = container_of(work, struct ath11k,
+					 channel_update_work);
+	struct scan_chan_list_params *params;
+	struct list_head local_update_list;
+	int left;
+
+	INIT_LIST_HEAD(&local_update_list);
+
+	spin_lock_bh(&ar->data_lock);
+	list_splice_tail_init(&ar->channel_update_queue, &local_update_list);
+	spin_unlock_bh(&ar->data_lock);
+
+	while ((params = list_first_entry_or_null(&local_update_list,
+						  struct scan_chan_list_params,
+						  list))) {
+		if (ar->state_11d != ATH11K_11D_IDLE) {
+			left = wait_for_completion_timeout(&ar->completed_11d_scan,
+							   ATH11K_SCAN_TIMEOUT_HZ);
+			if (!left) {
+				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+					   "failed to receive 11d scan complete: timed out\n");
+				ar->state_11d = ATH11K_11D_IDLE;
+			}
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+				   "reg 11d scan wait left time %d\n", left);
+		}
+
+		if ((ar->scan.state == ATH11K_SCAN_STARTING ||
+		     ar->scan.state == ATH11K_SCAN_RUNNING)) {
+			left = wait_for_completion_timeout(&ar->scan.completed,
+							   ATH11K_SCAN_TIMEOUT_HZ);
+			if (!left)
+				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+					   "failed to receive hw scan complete: timed out\n");
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+				   "reg hw scan wait left time %d\n", left);
+		}
+
+		ath11k_wmi_send_scan_chan_list_cmd(ar, params);
+		list_del(&params->list);
+		kfree(params);
+	}
+}
+
 static bool ath11k_reg_is_world_alpha(char *alpha)
 {
 	if (alpha[0] == '0' && alpha[1] == '0')
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_REG_H
@@ -33,6 +33,7 @@ void ath11k_reg_init(struct ath11k *ar);
 void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
+void ath11k_regd_update_chan_list_work(struct work_struct *work);
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
 		      struct cur_regulatory_info *reg_info, bool intersect,
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3817,6 +3817,7 @@ struct wmi_stop_scan_cmd {
 };
 
 struct scan_chan_list_params {
+	struct list_head list;
 	u32 pdev_id;
 	u16 nallchans;
 	struct channel_param ch_param[];



