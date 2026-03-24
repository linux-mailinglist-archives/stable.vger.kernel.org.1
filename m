Return-Path: <stable+bounces-230169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE9DFoWbwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F9309F74
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988903051847
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A03DEFE6;
	Tue, 24 Mar 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CQS5DyP+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A813FADE9
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361119; cv=none; b=pvXJeH9AzN0w/mTLpDQWvYWdAGEbrBjHKCzqUt/f1ulVl4EQ7vsQj6ili1/IUIwVwpEcaT+1GxTZKjS3UGiUSO/WUbWwPiDk0DPc4ZgQVcHL6AbXPjUGOe2thG4YJTJ5FUUfg9ZH9mvFa3MY3vunQS3RvaR8YCdiE/D3sSL9xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361119; c=relaxed/simple;
	bh=0foMM4PgER9aYufgc31Uoczs8mwgeqeMrcQVWGKYs1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lisxpa8wwT4HeA9XHwrcK4buchsJk1QTwNvBu3TGy1XZ1wYlPxpjvIXMLTuGL2Xl7ZS8qNc0bJZI9cOUTZlCFbN/FuiCd11mFi1MNFp4M1UivDNxOhJyce5fjdXvUq9Hj8r6r0On4MhsVyZhPG/seEBuZuvpSWJEI+1TCB68qSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CQS5DyP+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCC1BH1021874;
	Tue, 24 Mar 2026 14:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lxtEa
	IBmfwzG2QOde8xgQA2Cjvsd1t77cI/au90VTqs=; b=CQS5DyP+hTdkZYEv0q8d1
	fG1HxcST8DmJgfoO+DhZMY36JP+OSuHtAt2jYxCXmaVvoxEvPLdZfeQdknsAgFRb
	XSQJ7sdnbSuKwVQVT5eTeoF7BlmE+9PyV1ERl8ncUhdXP1pMbedzqnWNet8qiakx
	oNhNNXMgsp/eZaIikIDwo10A4FjEWCAeHqYzUAQwm+QluQXfSrgjCOcyrO4Mt6Vt
	5eWIFYZVIbg4FILmfmjDOBjg4D9yZgBKlY6uZ5LIY5DsONL21KE6jC3j+FhNH0yu
	CHt4yXAYXhEnXvrNpxtLEs1u37b6jm4Km4HC7VmmIv7PvNx/lEz7FfHtpUkye78i
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpm9jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCD1Ml039986;
	Tue, 24 Mar 2026 14:05:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Ek023161;
	Tue, 24 Mar 2026 14:05:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-8;
	Tue, 24 Mar 2026 14:05:13 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
        Madhu Chittim <madhu.chittim@intel.com>,
        Samuel Salin <Samuel.salin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 7/9] idpf: detach and close netdevs while handling a reset
Date: Tue, 24 Mar 2026 07:04:54 -0700
Message-ID: <20260324140456.832964-8-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: pOstIJ-ac3v6LBsdzKI-a0JRQYiOZ-UD
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c29a1b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=9Lb6z3q6lhQZ2YmtXF0A:9
X-Proofpoint-ORIG-GUID: pOstIJ-ac3v6LBsdzKI-a0JRQYiOZ-UD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfXxXNXptlnyRIe
 7RcHcVucClUYBfz66l6zoAGt/mVB5vsyLNrKTAcb31eJldE++pVOxHadyDpov9yhbsCpUmV7Con
 naasxqQM0Z/uUnznror+c9Jq5yjdP9e01dj7WGHDOKZy8cpa666TLZ+ly0UKWFYNwpGs+tJiuW+
 sZRBoaiPJxs48J+3Ahiro7qVq080v4ufwbpmXDMYvXLddjim4ViibbzEfSzAkczR3AuIh+QacyD
 eqVK3JHuSOBr+7/58KN/EFKKIVdktyf9H5cej4tZJUWrEBN8S8LRc82AuXlYgYnJolIA65oALYd
 8qHWMitWQ4x3mnay3z/fSuklnvRhBBGYnlgcPAoXQTjfUfOwt2yNSZNlz9ZtEFSYXHWVgqteRBa
 8iBiNKc+DJRYKvqUk1vU+t2iwtbpE5R3P5alvJXUBdVRHoR6o6IbfdZs1lRGrFGJOOaXNQZTQrE
 utsdyObwp2qV0lTo9hQ==
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230169-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,intel.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AC5F9309F74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit 2e281e1155fc476c571c0bd2ffbfe28ab829a5c3 ]

Protect the reset path from callbacks by setting the netdevs to detached
state and close any netdevs in UP state until the reset handling has
completed. During a reset, the driver will de-allocate resources for the
vport, and there is no guarantee that those will recover, which is why the
existing vport_ctrl_lock does not provide sufficient protection.

idpf_detach_and_close() is called right before reset handling. If the
reset handling succeeds, the netdevs state is recovered via call to
idpf_attach_and_open(). If the reset handling fails the netdevs remain
down. The detach/down calls are protected with RTNL lock to avoid racing
with callbacks. On the recovery side the attach can be done without
holding the RTNL lock as there are no callbacks expected at that point,
due to detach/close always being done first in that flow.

The previous logic restoring the netdevs state based on the
IDPF_VPORT_UP_REQUESTED flag in the init task is not needed anymore, hence
the removal of idpf_set_vport_state(). The IDPF_VPORT_UP_REQUESTED is
still being used to restore the state of the netdevs following the reset,
but has no use outside of the reset handling flow.

idpf_init_hard_reset() is converted to void, since it was used as such and
there is no error handling being done based on its return value.

Before this change, invoking hard and soft resets simultaneously will
cause the driver to lose the vport state:
ip -br a
<inf>	UP
echo 1 > /sys/class/net/ens801f0/device/reset& \
ethtool -L ens801f0 combined 8
ip -br a
<inf>	DOWN
ip link set <inf> up
ip -br a
<inf>	DOWN

Also in case of a failure in the reset path, the netdev is left
exposed to external callbacks, while vport resources are not
initialized, leading to a crash on subsequent ifup/down:
[408471.398966] idpf 0000:83:00.0: HW reset detected
[408471.411744] idpf 0000:83:00.0: Device HW Reset initiated
[408472.277901] idpf 0000:83:00.0: The driver was unable to contact the device's firmware. Check that the FW is running. Driver state= 0x2
[408508.125551] BUG: kernel NULL pointer dereference, address: 0000000000000078
[408508.126112] #PF: supervisor read access in kernel mode
[408508.126687] #PF: error_code(0x0000) - not-present page
[408508.127256] PGD 2aae2f067 P4D 0
[408508.127824] Oops: Oops: 0000 [#1] SMP NOPTI
...
[408508.130871] RIP: 0010:idpf_stop+0x39/0x70 [idpf]
...
[408508.139193] Call Trace:
[408508.139637]  <TASK>
[408508.140077]  __dev_close_many+0xbb/0x260
[408508.140533]  __dev_change_flags+0x1cf/0x280
[408508.140987]  netif_change_flags+0x26/0x70
[408508.141434]  dev_change_flags+0x3d/0xb0
[408508.141878]  devinet_ioctl+0x460/0x890
[408508.142321]  inet_ioctl+0x18e/0x1d0
[408508.142762]  ? _copy_to_user+0x22/0x70
[408508.143207]  sock_do_ioctl+0x3d/0xe0
[408508.143652]  sock_ioctl+0x10e/0x330
[408508.144091]  ? find_held_lock+0x2b/0x80
[408508.144537]  __x64_sys_ioctl+0x96/0xe0
[408508.144979]  do_syscall_64+0x79/0x3d0
[408508.145415]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[408508.145860] RIP: 0033:0x7f3e0bb4caff

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit 2e281e1155fc476c571c0bd2ffbfe28ab829a5c3)
[Harshit: Backport to 6.12.y, resolve conflicts at 5 places:
These are caused to missing non-backportable commits:
1. commit: bd74a86bc75d ("idpf: link NAPIs to queues")
2. commit: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev
create, init, and destroy")
3. commit: 8dd72ebc73f3 ("idpf: convert vport state to bitmap")
4. commit: bf86a012e676 ("idpf: implement remaining IDC RDMA core
   callbacks and handlers") in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 115 +++++++++++++--------
 1 file changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cd5a0ea59860..5a3cbd404bc7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -693,6 +693,65 @@ static int idpf_init_mac_addr(struct idpf_vport *vport,
 	return 0;
 }
 
+static void idpf_detach_and_close(struct idpf_adapter *adapter)
+{
+	int max_vports = adapter->max_vports;
+
+	for (int i = 0; i < max_vports; i++) {
+		struct net_device *netdev = adapter->netdevs[i];
+
+		/* If the interface is in detached state, that means the
+		 * previous reset was not handled successfully for this
+		 * vport.
+		 */
+		if (!netif_device_present(netdev))
+			continue;
+
+		/* Hold RTNL to protect racing with callbacks */
+		rtnl_lock();
+		netif_device_detach(netdev);
+		if (netif_running(netdev)) {
+			set_bit(IDPF_VPORT_UP_REQUESTED,
+				adapter->vport_config[i]->flags);
+			dev_close(netdev);
+		}
+		rtnl_unlock();
+	}
+}
+
+static void idpf_attach_and_open(struct idpf_adapter *adapter)
+{
+	int max_vports = adapter->max_vports;
+
+	for (int i = 0; i < max_vports; i++) {
+		struct idpf_vport *vport = adapter->vports[i];
+		struct idpf_vport_config *vport_config;
+		struct net_device *netdev;
+
+		/* In case of a critical error in the init task, the vport
+		 * will be freed. Only continue to restore the netdevs
+		 * if the vport is allocated.
+		 */
+		if (!vport)
+			continue;
+
+		/* No need for RTNL on attach as this function is called
+		 * following detach and dev_close(). We do take RTNL for
+		 * dev_open() below as it can race with external callbacks
+		 * following the call to netif_device_attach().
+		 */
+		netdev = adapter->netdevs[i];
+		netif_device_attach(netdev);
+		vport_config = adapter->vport_config[vport->idx];
+		if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED,
+				       vport_config->flags)) {
+			rtnl_lock();
+			dev_open(netdev, NULL);
+			rtnl_unlock();
+		}
+	}
+}
+
 /**
  * idpf_cfg_netdev - Allocate, configure and register a netdev
  * @vport: main vport structure
@@ -990,10 +1049,11 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	unsigned int i = vport->idx;
 
 	idpf_deinit_mac_addr(vport);
-	idpf_vport_stop(vport);
 
-	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
+	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags)) {
+		idpf_vport_stop(vport);
 		idpf_decfg_netdev(vport);
+	}
 	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		idpf_del_all_mac_filters(vport);
 
@@ -1471,7 +1531,6 @@ void idpf_init_task(struct work_struct *work)
 	struct idpf_vport_config *vport_config;
 	struct idpf_vport_max_q max_q;
 	struct idpf_adapter *adapter;
-	struct idpf_netdev_priv *np;
 	struct idpf_vport *vport;
 	u16 num_default_vports;
 	struct pci_dev *pdev;
@@ -1528,12 +1587,6 @@ void idpf_init_task(struct work_struct *work)
 	if (idpf_cfg_netdev(vport))
 		goto unwind_vports;
 
-	/* Once state is put into DOWN, driver is ready for dev_open */
-	np = netdev_priv(vport->netdev);
-	np->state = __IDPF_VPORT_DOWN;
-	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
-		idpf_vport_open(vport);
-
 	/* Spawn and return 'idpf_init_task' work queue until all the
 	 * default vports are created
 	 */
@@ -1709,27 +1762,6 @@ static int idpf_check_reset_complete(struct idpf_hw *hw,
 	return -EBUSY;
 }
 
-/**
- * idpf_set_vport_state - Set the vport state to be after the reset
- * @adapter: Driver specific private structure
- */
-static void idpf_set_vport_state(struct idpf_adapter *adapter)
-{
-	u16 i;
-
-	for (i = 0; i < adapter->max_vports; i++) {
-		struct idpf_netdev_priv *np;
-
-		if (!adapter->netdevs[i])
-			continue;
-
-		np = netdev_priv(adapter->netdevs[i]);
-		if (np->state == __IDPF_VPORT_UP)
-			set_bit(IDPF_VPORT_UP_REQUESTED,
-				adapter->vport_config[i]->flags);
-	}
-}
-
 /**
  * idpf_init_hard_reset - Initiate a hardware reset
  * @adapter: Driver specific private structure
@@ -1738,35 +1770,23 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
  * reallocate. Also reinitialize the mailbox. Return 0 on success,
  * negative on failure.
  */
-static int idpf_init_hard_reset(struct idpf_adapter *adapter)
+static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 {
 	struct idpf_reg_ops *reg_ops = &adapter->dev_ops.reg_ops;
 	struct device *dev = &adapter->pdev->dev;
-	struct net_device *netdev;
 	int err;
-	u16 i;
 
+	idpf_detach_and_close(adapter);
 	mutex_lock(&adapter->vport_ctrl_lock);
 
 	dev_info(dev, "Device HW Reset initiated\n");
 
-	/* Avoid TX hangs on reset */
-	for (i = 0; i < adapter->max_vports; i++) {
-		netdev = adapter->netdevs[i];
-		if (!netdev)
-			continue;
-
-		netif_carrier_off(netdev);
-		netif_tx_disable(netdev);
-	}
-
 	/* Prepare for reset */
 	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
 		reg_ops->trigger_reset(adapter, IDPF_HR_DRV_LOAD);
 	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
 		bool is_reset = idpf_is_reset_detected(adapter);
 
-		idpf_set_vport_state(adapter);
 		idpf_vc_core_deinit(adapter);
 		if (!is_reset)
 			reg_ops->trigger_reset(adapter, IDPF_HR_FUNC_RESET);
@@ -1813,7 +1833,12 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 unlock_mutex:
 	mutex_unlock(&adapter->vport_ctrl_lock);
 
-	return err;
+	/* Attempt to restore netdevs and initialize RDMA CORE AUX device,
+	 * provided vc_core_init succeeded. It is still possible that
+	 * vports are not allocated at this point if the init task failed.
+	 */
+	if (!err)
+		idpf_attach_and_open(adapter);
 }
 
 /**
-- 
2.50.1


