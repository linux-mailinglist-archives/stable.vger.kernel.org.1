Return-Path: <stable+bounces-238508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIDdKAtu4mmp5wAAu9opvQ
	(envelope-from <stable+bounces-238508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:29:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5E41D7DD
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB7B13011040
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46B30CDB6;
	Fri, 17 Apr 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jtian54t"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666D27E049;
	Fri, 17 Apr 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446979; cv=none; b=cDdnsNt7hXhpOgJsvNK0oRqQfSqhIGisf3GYUUZ8zgSbE8dJVAdUvQMX5qKIX6bVIrTELr4eop0SPV6zSGExMYM82o0qtJuK22xYeSVEM6aNLqfETtK3mJaik2B4w5y9NhUAWEL7qUGd/rI4Doiu94HrcS8lTtUFOAFgQ1dAQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446979; c=relaxed/simple;
	bh=TRBcaNfkHHAR+2jWAULG7pJOWRZmEcJutS3QqXdMTRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H450vJYJzNlYlmSPV62Z6NiigQzYWDLMSdbLfRJrISCbGPh3C16kEDBPHf69f22zn20g5gU2lMNPtyYAlU2xf1E3CAGom11P8bECl+Nus5XnW05iPn9EEkLEGuKJSuoQyg8eDz4UsSDNr4G1NK0v1ns5ZOoerZhO8X0Z4dqnsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jtian54t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H6kPlM087621;
	Fri, 17 Apr 2026 17:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2dbA6caidxJZX0dCD8ua5pXOUPnLEIhqNDVBBkrNV
	SQ=; b=Jtian54t588ILvtuz4ILgwp08/gYivJfxOTl6mHRugtEBW1h6zUE1bIFV
	YkocqqNl85byZrOeY/ytvklJEUOY7DmZI9W9xTViFXbFL4AQnFsxrY1zpa6WIvQe
	UWlN4I6nOvxO6AE9/VA1lnlYBKf7HmMP5usepl/fZxOrxeYYfUwirf6OtL6FlZJG
	Y4hCIFE/RX7IVpLK1j1eWPFzZC9mQsy9S2LhBeELvRooBkCm5McUS78v86+O35K8
	lvW6K6RaqyPrQ7oJlyPZjeCdUO/gBg/qU3Zm5Z78VGakC//dMVDL4U6Aza75Jzfd
	+Evb3IoDe5QgLPPyY/sNmEJavH5TA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rurnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 17:29:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63HHRcHv005103;
	Fri, 17 Apr 2026 17:29:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dkrucr43h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 17:29:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HHTFGq23069438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 17:29:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7466758057;
	Fri, 17 Apr 2026 17:29:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11F8258061;
	Fri, 17 Apr 2026 17:29:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.173.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 17:29:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, Mingming Cao <mmc@linux.ibm.com>,
        Shaik Abdulla <shaik.abdulla1@ibm.com>,
        Naveed Ahmed <naveedaus@in.ibm.com>
Subject: [PATCH net v2] ibmveth: Disable GSO for packets with small MSS
Date: Fri, 17 Apr 2026 10:29:10 -0700
Message-Id: <20260417172910.81433-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE3NCBTYWx0ZWRfX9zSfBUfj1NHh
 Sjwzop2iUZkCfxFWX0z4p+JIj9pk1JJ3YY4Q63AENqPWpkjukTpBdfGWLPqQt5baquLGOi9+Tm5
 2B+MAWE/fYt1id/EQ/k0D6pAhDbZ7qbd/xp57WHGPk8UwzRnWzUr3cS3BKj6CJ01s2V9RFTZ21P
 3AHhKdKf6Bolp7nBCrYapfviQjuVjah+vwC98YDtdW5oWBKdrvyADOBD0s5hIFNncI8kf8L+xTU
 9ZQSb3QfyO1CsBAn1k9zMnbj5o+UceXeMrMvFPAoGeSRqIpKum+RSrTOMO3N0N0kQYwTMlEwHb+
 OQUXBluWHoXOGapiDZqggHFl5B89H7vPsRvPZXnG/qQcUTVTSqLRh7THcXYEwGbu0+gDlxLUpCI
 BI2G0v9GfmT+cer6dor3n9bs1NoevTwIppmQsUC6NV/KkFDWx3i6pDEkvzxPwxvwJqDvnOtKjgJ
 RTtFk9FeEpnzH60G79Q==
X-Proofpoint-ORIG-GUID: aBHJLVuFWYbfzP9VVzdQ9gDuZEjV3tIB
X-Proofpoint-GUID: 9FTDNG4RccCHvMAhTrywhBTS6D84Jnnt
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e26df1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0DtoxFBozvEr3AFqBbAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170174
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238508-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 43F5E41D7DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some physical adapters on Power systems do not support segmentation
offload when the MSS is less than 224 bytes. Attempting to send such
packets causes the adapter to freeze, stopping all traffic until
manually reset.

Implement ndo_features_check to disable GSO for packets with small MSS
values. The network stack will perform software segmentation instead.

The 224-byte minimum matches ibmvnic
commit <f10b09ef687f> ("ibmvnic: Enforce stronger sanity checks
on GSO packets")
which uses the same physical adapters in SEA configurations.

Validated using iptables to force small MSS values. Without the fix,
the adapter freezes. With the fix, packets are segmented in software
and transmission succeeds.

Fixes: 8641dd85799f ("ibmveth: Add support for TSO")
Cc: stable@vger.kernel.org
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
Tested-by: Naveed Ahmed <naveedaus@in.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
v2: Add Fixes tag as requested by automated checks 

 drivers/net/ethernet/ibm/ibmveth.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 58cc3147afe2..7935c9384ef4 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1756,6 +1756,25 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
+static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
+						struct net_device *dev,
+						netdev_features_t features)
+{
+	/* Some physical adapters do not support segmentation offload with
+	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
+	 */
+	if (skb_is_gso(skb)) {
+		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
+			netdev_warn_once(dev,
+					 "MSS %u too small for LSO, disabling GSO\n",
+					 skb_shinfo(skb)->gso_size);
+			features &= ~NETIF_F_GSO_MASK;
+		}
+	}
+
+	return features;
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -1767,6 +1786,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_set_features	= ibmveth_set_features,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
+	.ndo_features_check	= ibmveth_features_check,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 068f99df133e..d87713668ed3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -37,6 +37,7 @@
 #define IBMVETH_ILLAN_IPV4_TCP_CSUM		0x0000000000000002UL
 #define IBMVETH_ILLAN_ACTIVE_TRUNK		0x0000000000000001UL
 
+#define IBMVETH_MIN_LSO_MSS		224	/* Minimum MSS for LSO */
 /* hcall macros */
 #define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
   plpar_hcall_norets(H_REGISTER_LOGICAL_LAN, ua, buflst, rxq, fltlst, mac)
-- 
2.39.3 (Apple Git-146)


