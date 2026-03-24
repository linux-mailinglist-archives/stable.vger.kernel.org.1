Return-Path: <stable+bounces-230172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDPkI2Kawmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:06:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F532309E78
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B92A930166E3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084223F99C0;
	Tue, 24 Mar 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UVnNIAhV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767663D6496
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361130; cv=none; b=jm2ux1ZTVVEd6sllFlQgGWbUw89szYB3ZNelzARNvyzmxrjqp8p8sFBFr7rV44PIUqg1w54vdhbbKv/pohZB9ZiOvEWGZrAGQzticRVgGULraxohpGe5n0aW7YxhbW6mXJAwfWqJx5e2JFlZq+ULivN0cA8C0E6qMHGMI4BifOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361130; c=relaxed/simple;
	bh=BmE0l8lbQ9m2Omvxq8NokM5VGNUtBsKKS6FXPv6Je+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuimYP+qczLRlvOG3kxNvhb9zplh3WztbQ1pqFnd1FC6tgwdVYvorIY5ya5WDHq+WSSj+AIZBNXF1kf6Muup6yULuPOLAx9ve5ypXwMIDr5fdvwwDQZrwmISEV5ijchy5RDv7mMatQeWlaFwaczs1wGU5C/phFzxIcDt8Yn035g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UVnNIAhV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCFfqT613143;
	Tue, 24 Mar 2026 14:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=22aM9
	v56UCgyaqLNVhqv/eDZB/FaXez2m/FP69l7a/A=; b=UVnNIAhVBoSgzyNPbKPc/
	QEqQJKgFCtPCSyEJXXZfVhrr0FF1qvAlbUHrxrg1vAtgclKhBGIjh3Fv0IsoMLgu
	CA0C8OsdMcLrCrt9TwkaCERGSXDUU2qy8wrWvZO0BIegIoU7q9Rf3Y0Vh24nAALu
	v0FlQ/xFVDgcfoEyFEnxysZrc2MTwlk9G6R8VT9BWAHe53rtGSk0vWG0pQK3YU1N
	CndsPF1xJwpGN6dwEwEtCAyPqizeDOlWEmTEgTPmcGnUt0pTobXcqqiiIPAsKesb
	NVwmc9kvaGKjI7f8mf7go1JBaZCWR0Zh8vOguqgDzpSN2Djm/Pk/mAGZVwKm0FPp
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf4897-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODPTa5039894;
	Tue, 24 Mar 2026 14:05:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Eo023161;
	Tue, 24 Mar 2026 14:05:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-10;
	Tue, 24 Mar 2026 14:05:17 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Simon Horman <horms@kernel.org>, Samuel Salin <Samuel.salin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 9/9] idpf: Fix RSS LUT NULL ptr issue after soft reset
Date: Tue, 24 Mar 2026 07:04:56 -0700
Message-ID: <20260324140456.832964-10-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfXwfYNAjdDYKYA
 nZPLtajIAQrOjWXvQ8OAPsSnHgx8v9QSzwmH8lRxa6IIBQMhrMm23pzODCAJeyGLGzSDfQRld0F
 IymIuPW3kt4V8qVt68Mjqj7G5RXU4rG/Q8ZPiHUZbfuor9l63sofrwEYTF+6RGOVMOBGP/R25FW
 aldFAYQji8NvdEcYnLgQyLD994PArkv8Rmnmq691Hb+FP5ToIgBChVMZ99LzGbP1v8CLVrdbDtx
 4FXRjaR/Z8YWgr+aJIu9+KuAGkGQAx7NzyZu7kcK4rxpWfUc57f0c6TKRMOQ15zhWp+pFPegigO
 D2BnyUvxGIFnUNqfI8jHRqbj8wtvt0F/jZ0mdx8o0e0fCItDpfbA1IIAOMmIH7QPbtdawGI1duz
 kmrvFLHbA3ar04S1DcCKNs9lUB/3ChaDMXMaGFovLvImb7yekobTVdglELYcZv9F1Y9QA9ySZy2
 rha0hapjjs7RwOIkjYA==
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c29a20 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ZIS7vXFbLOReTq1QmyMA:9
X-Proofpoint-ORIG-GUID: ha3rCFp9YTEA_g6YcxzziqI9mldTTakH
X-Proofpoint-GUID: ha3rCFp9YTEA_g6YcxzziqI9mldTTakH
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230172-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0F532309E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

[ Upstream commit ebecca5b093895da801b3eba1a55b4ec4027d196 ]

During soft reset, the RSS LUT is freed and not restored unless the
interface is up. If an ethtool command that accesses the rss lut is
attempted immediately after reset, it will result in NULL ptr
dereference. Also, there is no need to reset the rss lut if the soft reset
does not involve queue count change.

After soft reset, set the RSS LUT to default values based on the updated
queue count only if the reset was a result of a queue count change and
the LUT was not configured by the user. In all other cases, don't touch
the LUT.

Steps to reproduce:

** Bring the interface down (if up)
ifconfig eth1 down

** update the queue count (eg., 27->20)
ethtool -L eth1 combined 20

** display the RSS LUT
ethtool -x eth1

[82375.558338] BUG: kernel NULL pointer dereference, address: 0000000000000000
[82375.558373] #PF: supervisor read access in kernel mode
[82375.558391] #PF: error_code(0x0000) - not-present page
[82375.558408] PGD 0 P4D 0
[82375.558421] Oops: Oops: 0000 [#1] SMP NOPTI
<snip>
[82375.558516] RIP: 0010:idpf_get_rxfh+0x108/0x150 [idpf]
[82375.558786] Call Trace:
[82375.558793]  <TASK>
[82375.558804]  rss_prepare.isra.0+0x187/0x2a0
[82375.558827]  rss_prepare_data+0x3a/0x50
[82375.558845]  ethnl_default_doit+0x13d/0x3e0
[82375.558863]  genl_family_rcv_msg_doit+0x11f/0x180
[82375.558886]  genl_rcv_msg+0x1ad/0x2b0
[82375.558902]  ? __pfx_ethnl_default_doit+0x10/0x10
[82375.558920]  ? __pfx_genl_rcv_msg+0x10/0x10
[82375.558937]  netlink_rcv_skb+0x58/0x100
[82375.558957]  genl_rcv+0x2c/0x50
[82375.558971]  netlink_unicast+0x289/0x3e0
[82375.558988]  netlink_sendmsg+0x215/0x440
[82375.559005]  __sys_sendto+0x234/0x240
[82375.559555]  __x64_sys_sendto+0x28/0x30
[82375.560068]  x64_sys_call+0x1909/0x1da0
[82375.560576]  do_syscall_64+0x7a/0xfa0
[82375.561076]  ? clear_bhb_loop+0x60/0xb0
[82375.561567]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
<snip>

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit ebecca5b093895da801b3eba1a55b4ec4027d196)
[Harshit: backport to 6.12.y, conflicts due to missing commit:
8dd72ebc73f3 - idpf: convert vport state to bitmap andbd74a86bc75d -
idpf: link NAPIs to queues which changes idpf_vport_open/stop() APIs
also take rtnl argument)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 20 ++++----------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  1 +
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 8d6a786ac3f4..02915646b8e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1405,8 +1405,6 @@ static int idpf_vport_open(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_vport_config *vport_config;
-	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (np->state != __IDPF_VPORT_DOWN)
@@ -1488,19 +1486,6 @@ static int idpf_vport_open(struct idpf_vport *vport)
 
 	idpf_restore_features(vport);
 
-	vport_config = adapter->vport_config[vport->idx];
-	rss_data = &vport_config->user_config.rss_data;
-
-	if (!rss_data->rss_lut) {
-		err = idpf_init_rss_lut(vport);
-		if (err) {
-			dev_err(&adapter->pdev->dev,
-				"Failed to initialize RSS LUT for vport %u: %d\n",
-				vport->vport_id, err);
-			goto disable_vport;
-		}
-	}
-
 	err = idpf_config_rss(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure RSS for vport %u: %d\n",
@@ -1953,7 +1938,6 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_stop(vport);
 	}
 
-	idpf_deinit_rss_lut(vport);
 	/* We're passing in vport here because we need its wait_queue
 	 * to send a message and it should be getting all the vport
 	 * config data out of the adapter but we need to be careful not
@@ -1979,6 +1963,10 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
+	if (reset_cause == IDPF_SR_Q_CHANGE &&
+	    !netif_is_rxfh_configured(vport->netdev))
+		idpf_fill_dflt_rss_lut(vport);
+
 	if (current_state == __IDPF_VPORT_UP)
 		err = idpf_vport_open(vport);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2c3673ce7410..82a927265b9c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4059,7 +4059,7 @@ int idpf_config_rss(struct idpf_vport *vport)
  * idpf_fill_dflt_rss_lut - Fill the indirection table with the default values
  * @vport: virtual port structure
  */
-static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	u16 num_active_rxq = vport->num_rxq;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index ddba70d4b8ee..a34c791c4608 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1017,6 +1017,7 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
 void idpf_vport_intr_ena(struct idpf_vport *vport);
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss_lut(struct idpf_vport *vport);
 void idpf_deinit_rss_lut(struct idpf_vport *vport);
-- 
2.50.1


