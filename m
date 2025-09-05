Return-Path: <stable+bounces-177808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607CB455AB
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFED5A8509
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14513342CB3;
	Fri,  5 Sep 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TlRC2EW5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2A33EB13
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070277; cv=none; b=JSaLT1/A8wlJsvJjYMF5JUG7fsm25gFkVqz9+coXy4+SjkgIHZmiGbC6C0u7eo0TM7Z6099uN1Ty6uR5gXfGKHYDbKs2Y1+LCNKlbbUoy7el3VEiX2pcpQW/jfxLiCQYzamf0Kfu3aeJmf6a37EowgoCCI3x3pym8lOFIg/xOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070277; c=relaxed/simple;
	bh=rTHt+fKta2xQZtgok42Ul1xGvbrc5716C1eYIgLCOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt+WY1Xh+dwjsr5I38n8hfZsiqDbBQWEXLN878vc9HSUklxZP7ph1qt6tCy4Sq8gsSeGk4S5uybpFFMunglNimAsfymCrPVOlDkMw6AyC1A0N/P7QWLxK64mippVYgYWPHqHkL1K8brhsci1Zw3ScsJOafRqooE5gKbbOrZaN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TlRC2EW5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AuhCn011248;
	Fri, 5 Sep 2025 11:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NUq97
	o2jR9UI96E03LJxUIgBNC6UQZAKAKms/UISsDU=; b=TlRC2EW5S6p6WjcR1ViwV
	seyBdNpFtAXnY1xNixlusT/P1VWqtS69yU1euFtcsRI+Di3s9SL37NriOHIM15y9
	XXj1mv0LJS2sWCxNxLUknxN2jysBhaCwquiN02OwA9bBsPA5aSsReCq1/OirKCen
	hIrTw/pv2j5IqCerhONLSbR1SKMgUEzjPiGLGY+ialOPbaMMXSgrox/lfl9zAtYs
	3/4JJ+Ik0j9jlV8BcgRM/bSgRolFLKygZooBIjAkhPSgCeR82MU/RXk0//++3/Ew
	e6DoOBF1kqI4rTHZm1ENHhldJSPyoS1eVhMC8tJvMx63HquLC8NuyOSGIFvNU44f
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yx0u822n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JbYM019691;
	Fri, 5 Sep 2025 11:04:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49ha030057;
	Fri, 5 Sep 2025 11:04:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-14;
	Fri, 05 Sep 2025 11:04:32 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Wen Gong <quic_wgong@quicinc.com>,
        Kang Yang <quic_kangyang@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 13/15] wifi: ath11k: update channel list in worker when wait flag is set
Date: Fri,  5 Sep 2025 04:04:04 -0700
Message-ID: <20250905110406.3021567-14-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA5OSBTYWx0ZWRfX3/h8DGgCMSic
 XvVIKKLWmcJhoGGhURLrKSLb3F6EXg+mhlzW1+SzD+Kch6ScbK2PxVX+V96anwelD1cXs/LEuoi
 xtp8IDv4lTsq2aDIAnWIJrixof2ckiWVSzajgRH+VI90I/4UsXNb5Y+QX2jTVQpWJb71FpGVmNF
 R0OMC3ApZi5i355Px0c4ZCPFe3+zG/afAWih1JbN9zOcpbme9dMr86aJ4iO8sI40as8welATzAy
 iqOCDbm+V1uwr8UJaLI6/cp8FjlAGWBr6ZSKbqGLfabOV6THkSEO6kqQvd8vUouIjhHr5XmlJhm
 F0xWlEho+BlAImRY392kwTTonkj0c9bnRbJeyo9XCRcL5um7yvIdzGHEw40MQSD5MKJ4GqsYrWr
 JF1Sf5R8
X-Proofpoint-ORIG-GUID: v12KdVEkqWVum4PNDJpHv-ei5DB9p2Qk
X-Authority-Analysis: v=2.4 cv=KIxaDEFo c=1 sm=1 tr=0 ts=68bac3c2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yPCof4ZbAAAA:8 a=emnsI_xwZ2k9BQ13VbAA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: v12KdVEkqWVum4PNDJpHv-ei5DB9p2Qk

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 02aae8e2f957adc1b15b6b8055316f8a154ac3f5 ]

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
(cherry picked from commit 02aae8e2f957adc1b15b6b8055316f8a154ac3f5)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  5 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 14 +++++
 drivers/net/wireless/ath/ath11k/reg.c  | 85 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/reg.h  |  3 +-
 drivers/net/wireless/ath/ath11k/wmi.h  |  1 +
 6 files changed, 81 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2ec1771262fd..bb46ef986b2a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1972,6 +1972,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	ath11k_mac_scan_finish(ar);
 	ath11k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09fdb7be0e19..0cf49754653a 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -689,7 +689,7 @@ struct ath11k {
 	struct mutex conf_mutex;
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath11k_sta info, ath11k_vif info,
-	 * channel context data, survey info, test mode data.
+	 * channel context data, survey info, test mode data, channel_update_queue.
 	 */
 	spinlock_t data_lock;
 
@@ -747,6 +747,9 @@ struct ath11k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct channel_update_work;
+	/* protected with data_lock */
+	struct list_head channel_update_queue;
 
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ddf4ec6b244b..6313c45b3d2a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6289,6 +6289,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath11k *ar = hw->priv;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct scan_chan_list_params *params;
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
@@ -6304,6 +6305,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
 
@@ -6313,10 +6315,19 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
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
@@ -10101,6 +10112,7 @@ static const struct wiphy_iftype_ext_capab ath11k_iftypes_ext_capa[] = {
 
 static void __ath11k_mac_unregister(struct ath11k *ar)
 {
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(ar->hw);
@@ -10500,6 +10512,8 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->thermal.wmi_sync);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
+		INIT_WORK(&ar->channel_update_work, ath11k_regd_update_chan_list_work);
+		INIT_LIST_HEAD(&ar->channel_update_queue);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
 
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 7bfe47ad62a0..d62a2014315a 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -124,32 +124,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
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
@@ -231,6 +206,16 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
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
 
@@ -811,6 +796,54 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
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
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 263ea9061948..72b483594015 100644
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
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8982b909c821..30b4b0c17682 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3817,6 +3817,7 @@ struct wmi_stop_scan_cmd {
 };
 
 struct scan_chan_list_params {
+	struct list_head list;
 	u32 pdev_id;
 	u16 nallchans;
 	struct channel_param ch_param[];
-- 
2.50.1


