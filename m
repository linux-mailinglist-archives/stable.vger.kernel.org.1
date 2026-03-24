Return-Path: <stable+bounces-230173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HKHD6Sbwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D0309F83
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390AC305ACAE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F553F65EC;
	Tue, 24 Mar 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qWKzpNxL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30D3DEFE6
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361132; cv=none; b=FhSqRcfg1qFiqcTVOXAH1FOD4+qDeHvS7mt76ohl+/Eegal4X/Kk9ObfCx9dyDqDx5D22EkLKZz2DHDi3tXB5bNParYBEgbKcNYE6hyvdqlpVC5eWAPIHls4ccI6gcLWz9bkXk43dqjAwspmmapmdp52dEpA9QdlPWx5G3917Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361132; c=relaxed/simple;
	bh=hlzDm5+Iu98aSv82nJQe+exE+kRqIaJTYfx0WaCjRCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg4LenpBzkGoyo3Rf3gpPDp3tBrmwxXVZM2LgXKhRucHn/M2ygZW7Nv3SThUyloK0XnsTok6XA0lGKFn6mMm1WuNmQwWCRwYN5STjoitQwQM7Miq1NAU7J6WPEXt2Tc7iwp43ti/Ep8rdBNFl+TDTUqRzdVarziCmyexdWDiM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qWKzpNxL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCBqOX504249;
	Tue, 24 Mar 2026 14:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4SiYT
	U/xy7sIFiSOM4bnrcz08aL1/sUo/czQMtzJbXc=; b=qWKzpNxL+2Q003soZlfXM
	qrgpu9zf7aSBrWKwKvbBMRKKy9jdmmIYYX6Gpbg2XNf7dXo1H1D8CX/RByQFJqJX
	lXpX4rMm062lFQH/o4jTun46ZtcdLdKmJmH8e9jwVTuyoVI1nH/A3rfGyzmSe2n8
	RC51bZmXxbV81cVYbG04ByDyOVGUe097PQJcgE8XTzFojwr5TgiV+tQ73fAz9NHY
	ytQwsg0PxtR5rVR3r7ZfPRVbe9YqtWRYTgY7l2rRTDARK6q0Ds2tQDJRhyJZbF2o
	7B05MyUzHvU99qtuUKfgFdTEV6C9+Jjr1f7erUHx00DctLunz15ezBeyev4OuRqI
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kejm6rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCaHkG039945;
	Tue, 24 Mar 2026 14:05:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pduq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Em023161;
	Tue, 24 Mar 2026 14:05:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-9;
	Tue, 24 Mar 2026 14:05:15 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, Simon Horman <horms@kernel.org>,
        Samuel Salin <Samuel.salin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 8/9] idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
Date: Tue, 24 Mar 2026 07:04:55 -0700
Message-ID: <20260324140456.832964-9-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX25jOMUGVwHzE
 mFYOVLlUfateQoTWxdZN+PZzaD2hHTQRWN5ditpew6kMOXeNDaK5iPBIEwVwTPYEh7S1d5rpXZT
 weBRRqNCHx8sHQMziff+3ISneCgGrTXXaxq/kB8jVEpSLgFoQI0AjndC2xZ0L0kPdVDRMDltTtc
 Lk6IWnssEreXGaqkEQoq/hNmBSRn9LdbYsDy70iI+osH6BqiHE3pjEeLTwtwnnOK6gojaQ0To9d
 unolxW5CJmXn/lnUq8N8K4rw/uhWNUQH1avCKGaktRG29WEUIb99QROOIhfCd1QR4f0I9sDYCba
 hrGkP0wHmp9YNIjJlx4cBpGivUpphkP7MZFPDIKTTWvESPxV1HK9/RYHEtx4kaDfrPEkOt9gG5q
 vgA1vDGCewgokwRnIBzOK/2so4xxRul3KpvklHpTGGoI21Lu/u1paXCnhiRHYxC4dD0hQD/dY1h
 YDCYGv00/+kOCJgOxiw==
X-Authority-Analysis: v=2.4 cv=GZAaXAXL c=1 sm=1 tr=0 ts=69c29a1d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=i9q0cWRdgnjbyHwqb1sA:9
X-Proofpoint-ORIG-GUID: zOREdm513JMKUtTs_8L4RNvhCiDqGKuN
X-Proofpoint-GUID: zOREdm513JMKUtTs_8L4RNvhCiDqGKuN
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230173-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,mpg.de:email,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AE9D0309F83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

[ Upstream commit 83f38f210b85676f40ba8586b5a8edae19b56995 ]

The RSS LUT is not initialized until the interface comes up, causing
the following NULL pointer crash when ethtool operations like rxhash on/off
are performed before the interface is brought up for the first time.

Move RSS LUT initialization from ndo_open to vport creation to ensure LUT
is always available. This enables RSS configuration via ethtool before
bringing the interface up. Simplify LUT management by maintaining all
changes in the driver's soft copy and programming zeros to the indirection
table when rxhash is disabled. Defer HW programming until the interface
comes up if it is down during rxhash and LUT configuration changes.

Steps to reproduce:
** Load idpf driver; interfaces will be created
	modprobe idpf
** Before bringing the interfaces up, turn rxhash off
	ethtool -K eth2 rxhash off

[89408.371875] BUG: kernel NULL pointer dereference, address: 0000000000000000
[89408.371908] #PF: supervisor read access in kernel mode
[89408.371924] #PF: error_code(0x0000) - not-present page
[89408.371940] PGD 0 P4D 0
[89408.371953] Oops: Oops: 0000 [#1] SMP NOPTI
<snip>
[89408.372052] RIP: 0010:memcpy_orig+0x16/0x130
[89408.372310] Call Trace:
[89408.372317]  <TASK>
[89408.372326]  ? idpf_set_features+0xfc/0x180 [idpf]
[89408.372363]  __netdev_update_features+0x295/0xde0
[89408.372384]  ethnl_set_features+0x15e/0x460
[89408.372406]  genl_family_rcv_msg_doit+0x11f/0x180
[89408.372429]  genl_rcv_msg+0x1ad/0x2b0
[89408.372446]  ? __pfx_ethnl_set_features+0x10/0x10
[89408.372465]  ? __pfx_genl_rcv_msg+0x10/0x10
[89408.372482]  netlink_rcv_skb+0x58/0x100
[89408.372502]  genl_rcv+0x2c/0x50
[89408.372516]  netlink_unicast+0x289/0x3e0
[89408.372533]  netlink_sendmsg+0x215/0x440
[89408.372551]  __sys_sendto+0x234/0x240
[89408.372571]  __x64_sys_sendto+0x28/0x30
[89408.372585]  x64_sys_call+0x1909/0x1da0
[89408.372604]  do_syscall_64+0x7a/0xfa0
[89408.373140]  ? clear_bhb_loop+0x60/0xb0
[89408.373647]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[89408.378887]  </TASK>
<snip>

Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit 83f38f210b85676f40ba8586b5a8edae19b56995)
[Harshit: While this is a clean cherry-pick I had to change a line of
code where test_bit(IDPF_VPORT_UP,..) is used because 6.12.y branch
doesn't have commit: 8dd72ebc73f3 ("idpf: convert vport state to
bitmap")]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 94 +++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 36 +++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  4 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  9 +-
 5 files changed, 66 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f4d51c885f33..c420f6b71283 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -361,14 +361,12 @@ enum idpf_user_flags {
  * @rss_key: RSS hash key
  * @rss_lut_size: Size of RSS lookup table
  * @rss_lut: RSS lookup table
- * @cached_lut: Used to restore previously init RSS lut
  */
 struct idpf_rss_data {
 	u16 rss_key_size;
 	u8 *rss_key;
 	u16 rss_lut_size;
 	u32 *rss_lut;
-	u32 *cached_lut;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5a3cbd404bc7..8d6a786ac3f4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -999,7 +999,7 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 	u16 idx = vport->idx;
 
 	vport_config = adapter->vport_config[vport->idx];
-	idpf_deinit_rss(vport);
+	idpf_deinit_rss_lut(vport);
 	rss_data = &vport_config->user_config.rss_data;
 	kfree(rss_data->rss_key);
 	rss_data->rss_key = NULL;
@@ -1148,6 +1148,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	u16 idx = adapter->next_vport;
 	struct idpf_vport *vport;
 	u16 num_max_q;
+	int err;
 
 	if (idx == IDPF_NO_FREE_SLOT)
 		return NULL;
@@ -1198,10 +1199,11 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	idpf_vport_init(vport, max_q);
 
-	/* This alloc is done separate from the LUT because it's not strictly
-	 * dependent on how many queues we have. If we change number of queues
-	 * and soft reset we'll need a new LUT but the key can remain the same
-	 * for as long as the vport exists.
+	/* LUT and key are both initialized here. Key is not strictly dependent
+	 * on how many queues we have. If we change number of queues and soft
+	 * reset is initiated, LUT will be freed and a new LUT will be allocated
+	 * as per the updated number of queues during vport bringup. However,
+	 * the key remains the same for as long as the vport exists.
 	 */
 	rss_data = &adapter->vport_config[idx]->user_config.rss_data;
 	rss_data->rss_key = kzalloc(rss_data->rss_key_size, GFP_KERNEL);
@@ -1211,6 +1213,11 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	/* Initialize default rss key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
 
+	/* Initialize default rss LUT */
+	err = idpf_init_rss_lut(vport);
+	if (err)
+		goto free_rss_key;
+
 	/* fill vport slot in the adapter struct */
 	adapter->vports[idx] = vport;
 	adapter->vport_ids[idx] = idpf_get_vport_id(vport);
@@ -1221,6 +1228,8 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	return vport;
 
+free_rss_key:
+	kfree(rss_data->rss_key);
 free_vector_idxs:
 	kfree(vport->q_vector_idxs);
 free_vport:
@@ -1397,6 +1406,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
+	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (np->state != __IDPF_VPORT_DOWN)
@@ -1479,12 +1489,21 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	idpf_restore_features(vport);
 
 	vport_config = adapter->vport_config[vport->idx];
-	if (vport_config->user_config.rss_data.rss_lut)
-		err = idpf_config_rss(vport);
-	else
-		err = idpf_init_rss(vport);
+	rss_data = &vport_config->user_config.rss_data;
+
+	if (!rss_data->rss_lut) {
+		err = idpf_init_rss_lut(vport);
+		if (err) {
+			dev_err(&adapter->pdev->dev,
+				"Failed to initialize RSS LUT for vport %u: %d\n",
+				vport->vport_id, err);
+			goto disable_vport;
+		}
+	}
+
+	err = idpf_config_rss(vport);
 	if (err) {
-		dev_err(&adapter->pdev->dev, "Failed to initialize RSS for vport %u: %d\n",
+		dev_err(&adapter->pdev->dev, "Failed to configure RSS for vport %u: %d\n",
 			vport->vport_id, err);
 		goto disable_vport;
 	}
@@ -1493,13 +1512,11 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to complete interface up for vport %u: %d\n",
 			vport->vport_id, err);
-		goto deinit_rss;
+		goto disable_vport;
 	}
 
 	return 0;
 
-deinit_rss:
-	idpf_deinit_rss(vport);
 disable_vport:
 	idpf_send_disable_vport_msg(vport);
 disable_queues:
@@ -1936,7 +1953,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_stop(vport);
 	}
 
-	idpf_deinit_rss(vport);
+	idpf_deinit_rss_lut(vport);
 	/* We're passing in vport here because we need its wait_queue
 	 * to send a message and it should be getting all the vport
 	 * config data out of the adapter but we need to be careful not
@@ -2102,40 +2119,6 @@ static void idpf_set_rx_mode(struct net_device *netdev)
 		dev_err(dev, "Failed to set promiscuous mode: %d\n", err);
 }
 
-/**
- * idpf_vport_manage_rss_lut - disable/enable RSS
- * @vport: the vport being changed
- *
- * In the event of disable request for RSS, this function will zero out RSS
- * LUT, while in the event of enable request for RSS, it will reconfigure RSS
- * LUT with the default LUT configuration.
- */
-static int idpf_vport_manage_rss_lut(struct idpf_vport *vport)
-{
-	bool ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
-	struct idpf_rss_data *rss_data;
-	u16 idx = vport->idx;
-	int lut_size;
-
-	rss_data = &vport->adapter->vport_config[idx]->user_config.rss_data;
-	lut_size = rss_data->rss_lut_size * sizeof(u32);
-
-	if (ena) {
-		/* This will contain the default or user configured LUT */
-		memcpy(rss_data->rss_lut, rss_data->cached_lut, lut_size);
-	} else {
-		/* Save a copy of the current LUT to be restored later if
-		 * requested.
-		 */
-		memcpy(rss_data->cached_lut, rss_data->rss_lut, lut_size);
-
-		/* Zero out the current LUT to disable */
-		memset(rss_data->rss_lut, 0, lut_size);
-	}
-
-	return idpf_config_rss(vport);
-}
-
 /**
  * idpf_set_features - set the netdev feature flags
  * @netdev: ptr to the netdev being adjusted
@@ -2161,10 +2144,19 @@ static int idpf_set_features(struct net_device *netdev,
 	}
 
 	if (changed & NETIF_F_RXHASH) {
+		struct idpf_netdev_priv *np = netdev_priv(netdev);
+
 		netdev->features ^= NETIF_F_RXHASH;
-		err = idpf_vport_manage_rss_lut(vport);
-		if (err)
-			goto unlock_mutex;
+
+		/* If the interface is not up when changing the rxhash, update
+		 * to the HW is skipped. The updated LUT will be committed to
+		 * the HW when the interface is brought up.
+		 */
+		if (np->state == __IDPF_VPORT_UP) {
+			err = idpf_config_rss(vport);
+			if (err)
+				goto unlock_mutex;
+		}
 	}
 
 	if (changed & NETIF_F_GRO_HW) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6d33783ac8db..2c3673ce7410 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4068,57 +4068,47 @@ static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
 
-	for (i = 0; i < rss_data->rss_lut_size; i++) {
+	for (i = 0; i < rss_data->rss_lut_size; i++)
 		rss_data->rss_lut[i] = i % num_active_rxq;
-		rss_data->cached_lut[i] = rss_data->rss_lut[i];
-	}
 }
 
 /**
- * idpf_init_rss - Allocate and initialize RSS resources
+ * idpf_init_rss_lut - Allocate and initialize RSS LUT
  * @vport: virtual port
  *
- * Return 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
-int idpf_init_rss(struct idpf_vport *vport)
+int idpf_init_rss_lut(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_rss_data *rss_data;
-	u32 lut_size;
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
+	if (!rss_data->rss_lut) {
+		u32 lut_size;
 
-	lut_size = rss_data->rss_lut_size * sizeof(u32);
-	rss_data->rss_lut = kzalloc(lut_size, GFP_KERNEL);
-	if (!rss_data->rss_lut)
-		return -ENOMEM;
-
-	rss_data->cached_lut = kzalloc(lut_size, GFP_KERNEL);
-	if (!rss_data->cached_lut) {
-		kfree(rss_data->rss_lut);
-		rss_data->rss_lut = NULL;
-
-		return -ENOMEM;
+		lut_size = rss_data->rss_lut_size * sizeof(u32);
+		rss_data->rss_lut = kzalloc(lut_size, GFP_KERNEL);
+		if (!rss_data->rss_lut)
+			return -ENOMEM;
 	}
 
 	/* Fill the default RSS lut values */
 	idpf_fill_dflt_rss_lut(vport);
 
-	return idpf_config_rss(vport);
+	return 0;
 }
 
 /**
- * idpf_deinit_rss - Release RSS resources
+ * idpf_deinit_rss_lut - Release RSS LUT
  * @vport: virtual port
  */
-void idpf_deinit_rss(struct idpf_vport *vport)
+void idpf_deinit_rss_lut(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_rss_data *rss_data;
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-	kfree(rss_data->cached_lut);
-	rss_data->cached_lut = NULL;
 	kfree(rss_data->rss_lut);
 	rss_data->rss_lut = NULL;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 5f8a9b9f5d5d..ddba70d4b8ee 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1018,8 +1018,8 @@ void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
 void idpf_vport_intr_ena(struct idpf_vport *vport);
 int idpf_config_rss(struct idpf_vport *vport);
-int idpf_init_rss(struct idpf_vport *vport);
-void idpf_deinit_rss(struct idpf_vport *vport);
+int idpf_init_rss_lut(struct idpf_vport *vport);
+void idpf_deinit_rss_lut(struct idpf_vport *vport);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport);
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d1f374da0098..3d80b53161a4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2341,6 +2341,10 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
  * @vport: virtual port data structure
  * @get: flag to set or get rss look up table
  *
+ * When rxhash is disabled, RSS LUT will be configured with zeros.  If rxhash
+ * is enabled, the LUT values stored in driver's soft copy will be used to setup
+ * the HW.
+ *
  * Returns 0 on success, negative on failure.
  */
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
@@ -2351,10 +2355,12 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
 	struct idpf_rss_data *rss_data;
 	int buf_size, lut_buf_size;
 	ssize_t reply_sz;
+	bool rxhash_ena;
 	int i;
 
 	rss_data =
 		&vport->adapter->vport_config[vport->idx]->user_config.rss_data;
+	rxhash_ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
 	buf_size = struct_size(rl, lut, rss_data->rss_lut_size);
 	rl = kzalloc(buf_size, GFP_KERNEL);
 	if (!rl)
@@ -2376,7 +2382,8 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
 	} else {
 		rl->lut_entries = cpu_to_le16(rss_data->rss_lut_size);
 		for (i = 0; i < rss_data->rss_lut_size; i++)
-			rl->lut[i] = cpu_to_le32(rss_data->rss_lut[i]);
+			rl->lut[i] = rxhash_ena ?
+				cpu_to_le32(rss_data->rss_lut[i]) : 0;
 
 		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_LUT;
 	}
-- 
2.50.1


