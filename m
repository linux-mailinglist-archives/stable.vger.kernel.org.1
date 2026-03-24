Return-Path: <stable+bounces-230167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAF5DXubwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95937309F6D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D578B304BDA6
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109743FBEA2;
	Tue, 24 Mar 2026 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WVwSGuMB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008F3D6496
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361117; cv=none; b=c7shDmG4i9TTAd/+kbI4VRCBbReLdSS3NbhsTFh+qQ5iGKunzdzMh9lgK0vzSjurmkyuAgJgugiB0vBwFoQdGMVwd9wA+2wyIv2B1l/QLuvennOAxGt0MD3zBBLboWlvKwuYQ3/z24bUWJ4wd+CazSJxih6eXpvi8H86Ybd4rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361117; c=relaxed/simple;
	bh=Y/XwTZhzTHe66vZRcWs39CIRe65Md+HQp78xVnqkeC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdvoarYEYfNsLftraDnZBxrqmcqR/V3qYZZmcE5hfIPrhZszFDElXmXk/8pW40eDAkmny5Q20Ati9Xwju/MZsZTX/N9jrRCq4y6MGGfStm19kUhCqzPfgYN+asZKt7ObX4IJMp8EtPBWXnQdwXHHAULG3xtxxLdzoltc8Ktik5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WVwSGuMB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCCCh61022186;
	Tue, 24 Mar 2026 14:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=o7eQg
	87jJPm7+2K/Di74Pxmz6wiHSmybJ232KmaoDMg=; b=WVwSGuMBHIMTtC/6AgiEL
	jX+RjvhX+Qa1qYjZPTLwgRJbTxwAq0omYS/O+J4uBuAHHbueAAzAjqFqTOHO90MV
	xFwtBPIx9XjJA4eMcavAJnAuj21nLH9IOoNeIKlCKAC363T+xcxwwMHuqPa8uQzZ
	dnP4eIZtDgDsm2BLP0ELToc5jKPKDiOeb4GnxZHvWz9YxzFw8jICXLfeSLeTjcCR
	OY7tqH7tVEZrP3uhUAFwECKRUshQid4eMSd3ssppCoLwqZA+KSu9jDsVYMfTC99H
	thmIq+NfFnnSiv3advqbIDIry3eYHaD2uepVpmSRRM1Fj+fYySMPv/amfRY54nLp
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpm9j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODlFdv039969;
	Tue, 24 Mar 2026 14:05:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Eg023161;
	Tue, 24 Mar 2026 14:05:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-6;
	Tue, 24 Mar 2026 14:05:10 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
        Sunitha Mekala <sunithax.d.mekala@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 5/9] ice: Fix PTP NULL pointer dereference during VSI rebuild
Date: Tue, 24 Mar 2026 07:04:52 -0700
Message-ID: <20260324140456.832964-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-GUID: XyXpydN9dPmX9zk21J_W-OYiFf6_1ilT
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c29a18 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=DfNHnWVPAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=kJ0sdOceS5tOHr70fhAA:9 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: XyXpydN9dPmX9zk21J_W-OYiFf6_1ilT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX5gPwu/JkhrKf
 ZyRzf1FZJ23/J6HafheQVqzdzBLf55nn9g7j8tfYWsFFt4C/rqtsTIqNTGgcWSq1dwBPx8gw3KH
 H3azlzDRWeyu7QdiLfizwFnmQ1gOLgn09U2qncnStHZ2WE64OFtE8Cw/C7gtECXEhKn9Lldwf5j
 iegtp/PchPh6tc6LYOMn+G3J1QJ/0Z8Uq4KLs5oQwXgGgCwkgZuHlBChN7O/Xkoq3YJ7AC2ooVv
 xSQS3EpljtbkJ6RIMw3YLbVWYp9V3jbDYIAb6HVPn8tBpauSyXnx8s5pHp+4qstgvmGMs2jwewq
 e5c4w5EfTyNUR+lYJaoJI/zZYW+rsRaTrEhqiGfi/Kk9cFzNOXYXNvdn77NM/HHiJkuak2s+16w
 Y5CetKE7mfObE4UJZkLGZXitZ+oAJpnyriDSzX7HhSGbKmY9cR7tZDxqNP7SokidQhyMEDJ4LJ0
 qinPyDHN5GTM8EJs1/g==
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230167-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,intel.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 95937309F6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit fc6f36eaaedcf4b81af6fe1a568f018ffd530660 ]

Fix race condition where PTP periodic work runs while VSI is being
rebuilt, accessing NULL vsi->rx_rings.

The sequence was:
1. ice_ptp_prepare_for_reset() cancels PTP work
2. ice_ptp_rebuild() immediately queues PTP work
3. VSI rebuild happens AFTER ice_ptp_rebuild()
4. PTP work runs and accesses NULL vsi->rx_rings

Fix: Keep PTP work cancelled during rebuild, only queue it after
VSI rebuild completes in ice_rebuild().

Added ice_ptp_queue_work() helper function to encapsulate the logic
for queuing PTP work, ensuring it's only queued when PTP is supported
and the state is ICE_PTP_READY.

Error log:
[  121.392544] ice 0000:60:00.1: PTP reset successful
[  121.392692] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  121.392712] #PF: supervisor read access in kernel mode
[  121.392720] #PF: error_code(0x0000) - not-present page
[  121.392727] PGD 0
[  121.392734] Oops: Oops: 0000 [#1] SMP NOPTI
[  121.392746] CPU: 8 UID: 0 PID: 1005 Comm: ice-ptp-0000:60 Tainted: G S                  6.19.0-rc6+ #4 PREEMPT(voluntary)
[  121.392761] Tainted: [S]=CPU_OUT_OF_SPEC
[  121.392773] RIP: 0010:ice_ptp_update_cached_phctime+0xbf/0x150 [ice]
[  121.393042] Call Trace:
[  121.393047]  <TASK>
[  121.393055]  ice_ptp_periodic_work+0x69/0x180 [ice]
[  121.393202]  kthread_worker_fn+0xa2/0x260
[  121.393216]  ? __pfx_ice_ptp_periodic_work+0x10/0x10 [ice]
[  121.393359]  ? __pfx_kthread_worker_fn+0x10/0x10
[  121.393371]  kthread+0x10d/0x230
[  121.393382]  ? __pfx_kthread+0x10/0x10
[  121.393393]  ret_from_fork+0x273/0x2b0
[  121.393407]  ? __pfx_kthread+0x10/0x10
[  121.393417]  ret_from_fork_asm+0x1a/0x30
[  121.393432]  </TASK>

Fixes: 803bef817807d ("ice: factor out ice_ptp_rebuild_owner()")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit fc6f36eaaedcf4b81af6fe1a568f018ffd530660)
[Harshit: Backported to 6.12.y, ice_ptp_prepare_rebuild_sec() is not
present in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 17 ++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  5 +++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8683883e23b1..0fe496b1a226 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7792,6 +7792,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	/* Restore timestamp mode settings after VSI rebuild */
 	ice_ptp_restore_timestamp_mode(pf);
+
+	/* Start PTP periodic work after VSI is fully rebuilt */
+	ice_ptp_queue_work(pf);
 	return;
 
 err_vsi_rebuild:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4e6006991e8f..17d9d2d8ea47 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2753,6 +2753,20 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(err ? 10 : 500));
 }
 
+/**
+ * ice_ptp_queue_work - Queue PTP periodic work for a PF
+ * @pf: Board private structure
+ *
+ * Helper function to queue PTP periodic work after VSI rebuild completes.
+ * This ensures that PTP work only runs when VSI structures are ready.
+ */
+void ice_ptp_queue_work(struct ice_pf *pf)
+{
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
+	    pf->ptp.state == ICE_PTP_READY)
+		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work, 0);
+}
+
 /**
  * ice_ptp_prepare_for_reset - Prepare PTP for reset
  * @pf: Board private structure
@@ -2888,9 +2902,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ptp->state = ICE_PTP_READY;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	dev_info(ice_pf_to_dev(pf), "PTP reset successful\n");
 	return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index f1cfa6aa4e76..ccc1eeb16f0e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -333,6 +333,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
 void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
+void ice_ptp_queue_work(struct ice_pf *pf);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 {
@@ -384,6 +385,10 @@ static inline void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 }
 
+static inline void ice_ptp_queue_work(struct ice_pf *pf)
+{
+}
+
 static inline int ice_ptp_clock_index(struct ice_pf *pf)
 {
 	return -1;
-- 
2.50.1


