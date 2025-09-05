Return-Path: <stable+bounces-177806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C06B455A8
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF9B4E3CB3
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A234166C;
	Fri,  5 Sep 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LeRfP623"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2333EB1F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070276; cv=none; b=UjYkOtSumV+wVMKscNpbDlkHnLoraQFQsoTiijMLaK0YpavbzZMNC+LqVVLlF2KPNT0slMJEmwqF29wl78tNqBgGrI3T0I9xCLL680EVfe81nuuTpwlQYd3mNpy1eZ6hBfwDTzH6DK0WQrvTOy5uDMM4Rs8mVgBvnr27C4PwGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070276; c=relaxed/simple;
	bh=JH8e+1NSd6si0yqAG//QY+nXSaAMZFAod3HYdR6AXvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgzslS9kD+fOdOq4tlyQfPG7YBVFHr5XuUkrCK5l1FuBzRTc03ezexc16/1pyCBlMYTLEZNa3CvLJQRp1R11wvLvYucftWicf2MNsnRlmmeW7nKbKeGCcBXzcoKZnhJYPeBo8XiZezSJEu43m8ENfXiXYpcmdzy8/ZoUXd6DNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LeRfP623; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AtqNS006200;
	Fri, 5 Sep 2025 11:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=EZeqD
	w66RPOM5iuaXpWVbkyEE1ihEaJHNirRm/usbT8=; b=LeRfP623iu4dJb7+4g+uI
	qqQC3C9KsfyK8KxdPTnsF7s1rkDCijgqYbR4UbEFr2uQv1QGqu3apNWcmtbt+tkW
	EswLUvC03DQS4nvAtXaUjLc3f5IshmpwNtBJJoB6dkHqzWJ/z4I5XU8zX2PVPVlE
	w7SrISIJEBPgtfomuMZ0GUGIKRrGSaxivgbo6HRIIIK6JeFZd/Cp3Zszniy+kE1O
	GBljUIKY2aDxKWyDh3no4Jxp4rSjY9V1tN9/jaEw8RPmFb+vmL/itPbgLv9qgu3W
	WM21QkGY/k8zATyubHBZ4Br+NVgsuowErU6enP8Hnd8EDJzpSAw0017v68P4Z4C+
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa5812q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JcPE019847;
	Fri, 5 Sep 2025 11:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hY030057;
	Fri, 5 Sep 2025 11:04:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-13;
	Fri, 05 Sep 2025 11:04:30 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Wen Gong <quic_wgong@quicinc.com>,
        Kang Yang <quic_kangyang@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 12/15] wifi: ath11k: update channel list in reg notifier instead reg worker
Date: Fri,  5 Sep 2025 04:04:03 -0700
Message-ID: <20250905110406.3021567-13-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bac3c0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=yPCof4ZbAAAA:8 a=d59r8Rie_RDQwNl3S3MA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfX1gZ6b8UHjTp5
 PtKY/OpIZ7HtBdf9U+RwK0P9pahhhWWbL3rOcyKx1tXztwRts23wWTOdEATfCRDIL3JamRPPtWb
 E0IZ/U18XLvLBCgN5F2EtLFRN7bYkWHz3fD9Ea9B1Ps38/q8IKISWb2BsOGQBmMUXnERT/XxIQz
 chdH4WSgvH7SPycT6NYXvAjn2AdukqrX17qrKJB0k6kQBo/jaLTTI0u7xpdQyCi+28SW6oshz/l
 ILhiDzfMOM+WGFcDeS4PWVS3a0nslRGxWUU6SIt6JSwck+WvJbdMbsE7qSXMWKhDY93xp5OB0k9
 caRad/Y1QUhMS5ubKXWeRxXvl0JA3IOwH8TnX55MvMDbzLrrrSP6io3T/TKtAmVmCql7tuV8cnp
 ZcHBRdLV
X-Proofpoint-ORIG-GUID: e4VIiRD2Qbnyjemed7BeCDlmrU99ZZrp
X-Proofpoint-GUID: e4VIiRD2Qbnyjemed7BeCDlmrU99ZZrp

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 933ab187e679e6fbdeea1835ae39efcc59c022d2 ]

Currently when ath11k gets a new channel list, it will be processed
according to the following steps:
1. update new channel list to cfg80211 and queue reg_work.
2. cfg80211 handles new channel list during reg_work.
3. update cfg80211's handled channel list to firmware by
ath11k_reg_update_chan_list().

But ath11k will immediately execute step 3 after reg_work is just
queued. Since step 2 is asynchronous, cfg80211 may not have completed
handling the new channel list, which may leading to an out-of-bounds
write error:
BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
Call Trace:
    ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
    kfree+0x109/0x3a0
    ath11k_regd_update+0x1cf/0x350 [ath11k]
    ath11k_regd_update_work+0x14/0x20 [ath11k]
    process_one_work+0xe35/0x14c0

Should ensure step 2 is completely done before executing step 3. Thus
Wen raised patch[1]. When flag NL80211_REGDOM_SET_BY_DRIVER is set,
cfg80211 will notify ath11k after step 2 is done.

So enable the flag NL80211_REGDOM_SET_BY_DRIVER then cfg80211 will
notify ath11k after step 2 is done. At this time, there will be no
KASAN bug during the execution of the step 3.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/20230201065313.27203-1-quic_wgong@quicinc.com/

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Link: https://patch.msgid.link/20250117061737.1921-2-quic_kangyang@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
(cherry picked from commit 933ab187e679e6fbdeea1835ae39efcc59c022d2)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b0f289784dd3..7bfe47ad62a0 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 
@@ -55,6 +55,19 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath11k_dbg(ar->ab, ATH11K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "driver initiated regd update\n");
+		if (ar->state != ATH11K_STATE_ON)
+			return;
+
+		ret = ath11k_reg_update_chan_list(ar, true);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to update channel list: %d\n", ret);
+
+		return;
+	}
+
 	/* Currently supporting only General User Hints. Cell base user
 	 * hints to be handled later.
 	 * Hints from other sources like Core, Beacons are not expected for
@@ -293,12 +306,6 @@ int ath11k_regd_update(struct ath11k *ar)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH11K_STATE_ON) {
-		ret = ath11k_reg_update_chan_list(ar, true);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
 err:
 	ath11k_warn(ab, "failed to perform regd update : %d\n", ret);
@@ -977,6 +984,7 @@ void ath11k_regd_update_work(struct work_struct *work)
 void ath11k_reg_init(struct ath11k *ar)
 {
 	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	ar->hw->wiphy->reg_notifier = ath11k_reg_notifier;
 }
 
-- 
2.50.1


