Return-Path: <stable+bounces-230170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BidHk2awmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:06:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A159309E5B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF80D302FB2F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66883F65EC;
	Tue, 24 Mar 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DU3SkS7N"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA03DF017
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361119; cv=none; b=HcB1CbK2AMc9gTZfyNbUCDY5goR8J1lgqxZbzYVt7mFM9pC7OMrvwlMTuqi6vO5ZaVcPrRRGC5jf31e9kzCpcQ8LL91D8k8BSaWuqs2k//VAYTVR+eVjWe3fBDH5lmRwzKD1jpmM8Cc43ZEL5cWvQClLCrdsRVvgV8E/CYoxQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361119; c=relaxed/simple;
	bh=HSkjrzSJPGU4Ma7xU5n1lqXwD+uX4AbGz64nGOL70X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf8cKHv4wnmlcZS65qOgugcHNqviMVx9QQqdvNDbmfkprFFYKb94m8q/REnP21lrUG+7K89KTJSLBM5iodWXGZVez9q8z6gaWLaYnPhJFjJJl/D0sgqRQGZTNAxZtfTBPFYWBYlSPDhcehtMGdW8gV1PiP8+kPnp3vnDxI8xsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DU3SkS7N; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCCLRb1022573;
	Tue, 24 Mar 2026 14:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h3vlf
	xAN46RgLpo+cTChFHd/Pdtzhj1TTwAImIhx0pM=; b=DU3SkS7NwXgPSa/g7DqCK
	egLAuLjuaXCTyXLb5oNpu65CZ2tX561LneFez4EDlO00z4tKKWot9IbqF1ptGWl8
	+yP4IZMQWqQNHwvyQkL/3lYQ1oAhPNZlhXoHv95nSZQP6wOXjvDu3DvDHrklYzHm
	6gYXM5LBKZjSkrPIwxNhh28FTqIvgQVumXYYigWQz5hijWSwnJqt+EPBGR0PsNSW
	nGo21zNayungg/Zs+kGNMpuiwUakWhYcchKFZM8xuPj41OQsEOQ3Cd2nDGNg6QwH
	ir8iUo5pwTJHC3OIM4KhUGQhN1tRPyMxG0oyZZ7oYj0HqniKnSTJhlFgZgqIDgJu
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpm9jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODlFdw039969;
	Tue, 24 Mar 2026 14:05:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pds3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Ei023161;
	Tue, 24 Mar 2026 14:05:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-7;
	Tue, 24 Mar 2026 14:05:12 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>, Samuel Salin <Samuel.salin@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 6/9] idpf: check error for register_netdev() on init
Date: Tue, 24 Mar 2026 07:04:53 -0700
Message-ID: <20260324140456.832964-7-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: dGiYQJ7I48WlpY40Cjdq_4BGCLdwNfd9
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c29a1a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=OUklxLpIFIs_SJMlCuIA:9
X-Proofpoint-ORIG-GUID: dGiYQJ7I48WlpY40Cjdq_4BGCLdwNfd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfXw+QYciUL6rv6
 F99yEHsSdFsb3he3vMjfEZ82FOtPjtT8J9e9wrVngoHzglVEYnbZhl+ve2ncNdWLYYidPQrEiZp
 g9Kh2QtrLHzgGoMfTpDeAU79dVw+I5k+hRKh+OHyTWujm2/VRnrS8yGnAseamv05ZVidZgX/cTR
 gRiPDjJu7S7fhrfuVLX+NdueH/D0KBYitxSlICeFza6MniB/WDviHLpDtl1/glSy0mqLv5fJb+J
 9NF/T+sTWsfZI1yAp4SBJq4SmEn2gUpPOQZJ8v0+XXdF65HXmcK2H0xHKkI+hC2hknIqmnHxXy/
 drjKs9ZY3R9KvLeOQ1ViqvMGVa+75GagL7Sh7/qRQJUODM7RQIwftdbipcesdAkCrOF+DBXJPz2
 DuzOz2UOty+G0PfBjUYlkiiQ7v8m1E65iMg9+zRubQ3dPuP0T48cPa9FQBt4Wfa8wCjIfsvWmg6
 IUYSpRsHpTDll2j4jcQ==
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230170-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1A159309E5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit 680811c67906191b237bbafe7dabbbad64649b39 ]

Current init logic ignores the error code from register_netdev(),
which will cause WARN_ON() on attempt to unregister it, if there was one,
and there is no info for the user that the creation of the netdev failed.

WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
...
[ 3707.563641]  unregister_netdev+0x1c/0x30
[ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
[ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
[ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
[ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
[ 3707.563769]  pci_device_remove+0xab/0x1e0
[ 3707.563786]  device_release_driver_internal+0x371/0x530
[ 3707.563803]  driver_detach+0xbf/0x180
[ 3707.563816]  bus_remove_driver+0x11b/0x2a0
[ 3707.563829]  pci_unregister_driver+0x2a/0x250

Introduce an error check and log the vport number and error code.
On removal make sure to check VPORT_REG_NETDEV flag prior to calling
unregister and free on the netdev.

Add local variables for idx, vport_config and netdev for readability.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit 680811c67906191b237bbafe7dabbbad64649b39)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a0677b327783..cd5a0ea59860 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -911,15 +911,19 @@ static int idpf_stop(struct net_device *netdev)
 static void idpf_decfg_netdev(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	u16 idx = vport->idx;
 
 	kfree(vport->rx_ptype_lkup);
 	vport->rx_ptype_lkup = NULL;
 
-	unregister_netdev(vport->netdev);
-	free_netdev(vport->netdev);
+	if (test_and_clear_bit(IDPF_VPORT_REG_NETDEV,
+			       adapter->vport_config[idx]->flags)) {
+		unregister_netdev(vport->netdev);
+		free_netdev(vport->netdev);
+	}
 	vport->netdev = NULL;
 
-	adapter->netdevs[vport->idx] = NULL;
+	adapter->netdevs[idx] = NULL;
 }
 
 /**
@@ -1541,13 +1545,22 @@ void idpf_init_task(struct work_struct *work)
 	}
 
 	for (index = 0; index < adapter->max_vports; index++) {
-		if (adapter->netdevs[index] &&
-		    !test_bit(IDPF_VPORT_REG_NETDEV,
-			      adapter->vport_config[index]->flags)) {
-			register_netdev(adapter->netdevs[index]);
-			set_bit(IDPF_VPORT_REG_NETDEV,
-				adapter->vport_config[index]->flags);
+		struct net_device *netdev = adapter->netdevs[index];
+		struct idpf_vport_config *vport_config;
+
+		vport_config = adapter->vport_config[index];
+
+		if (!netdev ||
+		    test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags))
+			continue;
+
+		err = register_netdev(netdev);
+		if (err) {
+			dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
+				index, ERR_PTR(err));
+			continue;
 		}
+		set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
 	}
 
 	/* As all the required vports are created, clear the reset flag
-- 
2.50.1


