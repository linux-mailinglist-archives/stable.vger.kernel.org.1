Return-Path: <stable+bounces-154463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123FFADD9A1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF66A5A55E5
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10120C497;
	Tue, 17 Jun 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQvsyP3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E7212B28;
	Tue, 17 Jun 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179268; cv=none; b=uhFAAs0kuzA4dDM3cq0CVGL6p4wM0wLhUeVXQon3QsmXr/Qc4tW+XWhXPeOKBCpj3GhjacS2gPNZH0XhBkRbpaIg96Tpuv7VV441fGGwoAffIdop9IE10MUMd6h8qMZoi1g0MdNk+tPBLgc4CI+upPlqSp+eWbyGzEKC/xrer4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179268; c=relaxed/simple;
	bh=yfLi21x4vmcLbiXOWgGc7/yS9OiS3lFquF1b6BMs8jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn/R7rtesyIcRnkg6bng/srq6NE3ovv/l3MVupDq2bQ9jTahIFZceo+ZKrXorC40705pqLR3b5cb6d4tx/q+MlEKj0s73m4cWDRZd05lzz05XU2WSwPq9HwOf00cc1Da9R6cvbfSFqN8l7d3p0buIhQdxd0qPevRDKKvQmfC9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQvsyP3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA64C4CEE3;
	Tue, 17 Jun 2025 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179267;
	bh=yfLi21x4vmcLbiXOWgGc7/yS9OiS3lFquF1b6BMs8jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQvsyP3/32qw7WCEbwkGdw59Dj5bDsOdsV9O7eeeoZkiI1830Rgi9JFe4QD+58xPf
	 P4SIu2Wg9ewh98rFQiEJPWikgcCTF1ii+JL6TQu//gFQFiOzl9Je4WSIhg/qn1MfKf
	 1uZtXCwXU7d6IgpuvQLDz0cX/wiFr/XXqLdw3s3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yury Vostrikov <mon@unformed.ru>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 672/780] wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
Date: Tue, 17 Jun 2025 17:26:20 +0200
Message-ID: <20250617152518.837174176@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 9f6e82d11bb9692a90d20b10f87345598945c803 ]

We get report [1] that CPU is running a hot loop in
ath11k_debugfs_fw_stats_request():

94.60%     0.00%  i3status         [kernel.kallsyms]                 [k] do_syscall_64
        |
         --94.60%--do_syscall_64
                   |
                    --94.55%--__sys_sendmsg
                              ___sys_sendmsg
                              ____sys_sendmsg
                              netlink_sendmsg
                              netlink_unicast
                              genl_rcv
                              netlink_rcv_skb
                              genl_rcv_msg
                              |
                               --94.55%--genl_family_rcv_msg_dumpit
                                         __netlink_dump_start
                                         netlink_dump
                                         genl_dumpit
                                         nl80211_dump_station
                                         |
                                          --94.55%--ieee80211_dump_station
                                                    sta_set_sinfo
                                                    |
                                                     --94.55%--ath11k_mac_op_sta_statistics
                                                               ath11k_debugfs_get_fw_stats
                                                               |
                                                                --94.55%--ath11k_debugfs_fw_stats_request
                                                                          |
                                                                          |--41.73%--_raw_spin_lock_bh
                                                                          |
                                                                          |--22.74%--__local_bh_enable_ip
                                                                          |
                                                                          |--9.22%--_raw_spin_unlock_bh
                                                                          |
                                                                           --6.66%--srso_alias_safe_ret

This is because, if for whatever reason ar->fw_stats_done is not set by
ath11k_update_stats_event(), ath11k_debugfs_fw_stats_request() won't yield
CPU before an up to 3s timeout.

Change to completion mechanism to avoid CPU burning.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Reported-by: Yury Vostrikov <mon@unformed.ru>
Closes: https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com/ # [1]
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250220082448.31039-2-quic_bqiang@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c    |  1 +
 drivers/net/wireless/ath/ath11k/core.h    |  2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c | 38 +++++++++--------------
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c     |  2 +-
 5 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8d08dd47bde9c..6c346a8df2df1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -951,6 +951,7 @@ void ath11k_fw_stats_init(struct ath11k *ar)
 	INIT_LIST_HEAD(&ar->fw_stats.bcn);
 
 	init_completion(&ar->fw_stats_complete);
+	init_completion(&ar->fw_stats_done);
 }
 
 void ath11k_fw_stats_free(struct ath11k_fw_stats *stats)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 1a3d0de4afde8..6abbb29034f07 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -783,7 +783,7 @@ struct ath11k {
 	u8 alpha2[REG_ALPHA2_LEN + 1];
 	struct ath11k_fw_stats fw_stats;
 	struct completion fw_stats_complete;
-	bool fw_stats_done;
+	struct completion fw_stats_done;
 
 	/* protected by conf_mutex */
 	bool ps_state_enable;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index bf192529e3fe2..1d03e3aab011d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -96,7 +96,6 @@ void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
 {
 	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
 	spin_unlock_bh(&ar->data_lock);
@@ -114,7 +113,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 	/* WMI_REQUEST_PDEV_STAT request has been already processed */
 
 	if (stats->stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
-		ar->fw_stats_done = true;
+		complete(&ar->fw_stats_done);
 		return;
 	}
 
@@ -138,7 +137,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				      &ar->fw_stats.vdevs);
 
 		if (is_end) {
-			ar->fw_stats_done = true;
+			complete(&ar->fw_stats_done);
 			num_vdev = 0;
 		}
 		return;
@@ -158,7 +157,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				      &ar->fw_stats.bcn);
 
 		if (is_end) {
-			ar->fw_stats_done = true;
+			complete(&ar->fw_stats_done);
 			num_bcn = 0;
 		}
 	}
@@ -168,21 +167,15 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 					   struct stats_request_params *req_param)
 {
 	struct ath11k_base *ab = ar->ab;
-	unsigned long timeout, time_left;
+	unsigned long time_left;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + secs_to_jiffies(3);
-
 	ath11k_debugfs_fw_stats_reset(ar);
 
 	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
 
 	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
 
@@ -193,21 +186,18 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 	}
 
 	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-
 	if (!time_left)
 		return -ETIMEDOUT;
 
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
 
-		spin_lock_bh(&ar->data_lock);
-		if (ar->fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
-	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 97816916abac9..8a018c0190c8a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9384,11 +9384,11 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	spin_unlock_bh(&ar->data_lock);
 
 	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
 
 	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d7f852bebf4aa..27cb0bb06b93c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8189,7 +8189,7 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 	 */
 	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
 		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
-		ar->fw_stats_done = true;
+		complete(&ar->fw_stats_done);
 		goto complete;
 	}
 
-- 
2.39.5




