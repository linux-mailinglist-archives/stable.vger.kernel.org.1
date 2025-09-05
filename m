Return-Path: <stable+bounces-177802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016CB455A4
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A401C884F5
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BAB340DBD;
	Fri,  5 Sep 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxyqnBCF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F330EF77
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070268; cv=none; b=b2cu2kc76ts9UFywFO2QPbm2KWcHkK+F6QiBqcLVhdGWA8JsnR3xrLS5u7FpZHsTFMtiSkFSiEb+HJ797YDP0WL2oh/cVzbIMT0nwFB4ft8R2yBJvrFwdZAo9Cf/5KS8AGBuMAFMatVHPlXiV6mtNHCrYZzGD69YmHtc6JiBJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070268; c=relaxed/simple;
	bh=z8wz8meHQFnw19eYMJVeCFg69eCxIKdt6jxKvLWidnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLBLIsVtodV95mT1zD6oPUS1FRafhtOmUECGgpftXMoZGRnDLI5QhstB0RGOMtJubT4V845nnl0PEq8LpT5q4isKe/UQd4nYd8+pquvCPvZHmJoj9B7/GyxurVLLZjOGc++uBMwWI1Ghdvy2+4xGgYbD5kVc352K8zQEmxOPsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RxyqnBCF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B0HP0027071;
	Fri, 5 Sep 2025 11:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=O8iHW
	Xih8lMuuI/BGe085j+suJMiSbvYU71pl0hCGCc=; b=RxyqnBCF4s3VLlzpSzIVx
	Aoh51dnp1MEPLuDk1/UwlIDstoPQgq1SYz31Q+JVI+41irRtGpJ9LeCWaJ7cv8Iq
	WEqJ2CSap3128MxeSuAVvyRBcUQDgZydcFJiLsF6uJrAD1cxI6XnA232Ky+40X0N
	wPtnvJwUkWzQfATAOwN4alJGvr3MREB06wszLs3w6Cw52Cj2eWUVwnWryE8zggqu
	Pii7ewthPVIIgBrTzkAfA7tu9Quiph5tso7gLX3hVn7TuhcPUqEtWrsnXQQQWcj0
	A7TUA31CigJbRUdFXm3gUrcaCLbvYZRlWbqE3a9bkhTa9yeAcYLe/L0j0W+kWCcm
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxkg80am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JbqZ019696;
	Fri, 5 Sep 2025 11:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqr29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hG030057;
	Fri, 5 Sep 2025 11:04:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-4;
	Fri, 05 Sep 2025 11:04:15 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 03/15] net: dsa: provide implementation of .support_eee()
Date: Fri,  5 Sep 2025 04:03:54 -0700
Message-ID: <20250905110406.3021567-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNyBTYWx0ZWRfXzKPtL9HLEz1W
 rsnwXwafRIM9qQnoJOpt15PndiuaOwM9Ixx5ZX14uOB6EhznnKRbbxcgxfVOxTbWDg2+BQ4kKRd
 BJ+/oMgIRsOz/haF0HGnQ8zG0uewdaeLfNf5P4bDZZuWR7v8xBjTwEzdMVIxJu9Ph3EonG/0UyZ
 adP9Dg3LL54Tg5BLEcSrRSJ028IEoIZ4YORGJ4wZwbq5i78sjH3UTbcRRdx5rLQNsZ/WTxjvMxJ
 oKTcX18DQ26htyhGrOa4soiEbh8WU2CZ4NTsYO6ixm4XbTrVS5yLviXgDYt93T6UaTJJlaM30+j
 9ik1DBoZEgpfX9NEP87qJqVLiz5zawX/T34shHE6hmZlWfMkn/jLpc0rzT9Mk99VfzyhoAnMqdJ
 WtLSE/xx
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68bac3b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=PHq6YzTAAAAA:8 a=Q-fNiiVtAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=65m1C5psNWssoKoMDBUA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-ORIG-GUID: 32uV4iEmeXOB-rSg6lScY-7aGe4Ad3on
X-Proofpoint-GUID: 32uV4iEmeXOB-rSg6lScY-7aGe4Ad3on

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 99379f587278c818777cb4778e2c79c6c1440c65 ]

Provide a trivial implementation for the .support_eee() method which
switch drivers can use to simply indicate that they support EEE on
all their user ports.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/E1tL149-006cZJ-JJ@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 99379f587278c818777cb4778e2c79c6c1440c65)
[Harshit: Resolve contextual conflicts due to missing commit:
539770616521 ("net: dsa: remove obsolete phylink dsa_switch operations")
and commit: ecb595ebba0e ("net: dsa: remove
dsa_port_phylink_mac_select_pcs()") in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/dsa.h |  1 +
 net/dsa/port.c    | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index fa99fc5249e9..877f9b270cf6 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1399,5 +1399,6 @@ static inline bool dsa_user_dev_check(const struct net_device *dev)
 
 netdev_tx_t dsa_enqueue_skb(struct sk_buff *skb, struct net_device *dev);
 void dsa_port_phylink_mac_change(struct dsa_switch *ds, int port, bool up);
+bool dsa_supports_eee(struct dsa_switch *ds, int port);
 
 #endif
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 25258b33e59e..9c77c80e8fe9 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1589,6 +1589,22 @@ dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 	return pcs;
 }
 
+/* dsa_supports_eee - indicate that EEE is supported
+ * @ds: pointer to &struct dsa_switch
+ * @port: port index
+ *
+ * A default implementation for the .support_eee() DSA operations member,
+ * which drivers can use to indicate that they support EEE on all of their
+ * user ports.
+ *
+ * Returns: true
+ */
+bool dsa_supports_eee(struct dsa_switch *ds, int port)
+{
+	return true;
+}
+EXPORT_SYMBOL_GPL(dsa_supports_eee);
+
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
-- 
2.50.1


