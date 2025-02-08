Return-Path: <stable+bounces-114410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77252A2D82D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 19:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFE7165852
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0BB19DF6A;
	Sat,  8 Feb 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WphY9DEE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D317ADE8;
	Sat,  8 Feb 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041161; cv=none; b=tOAxph4ZHIee3m9iIUw17th+IQZW2z5kPO0pMv2D33cQtgr0u0yNpoKe0Jn12u5g/UyEA8MFPYdERmwSYCjz57cRKyqceNg4xii9vAk2nSW6n/M/WfREGU1pz5AhYNU5sc4mY4RCnOArvcP4Y+gWWEVmwpHImDUVStA77cnguR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041161; c=relaxed/simple;
	bh=sajzIyNNSUyrK0Pz0GieFDphBDiVEqEVBjHIrHQ0yIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUs7/CfeVRjj5Z+leYxtZffnoIsgeRSGTM7PAMfqit82VfUaAy2ci0QbXg+sjc/ZNHYOWcR71mIPt39hxzy9XnU65EyeZIU7M0nnFOgHPiIlGln8eZvLHRfvTnVtRy/5wBrQk55H0zoHzWAfJRWOw7VlrHM1hvOp6/XeaQu2ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WphY9DEE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518He2jY028056;
	Sat, 8 Feb 2025 18:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=65n3nMNYjMKKCqpVKVCbhxDBQZrAz
	RYDjSxMSnZwCdM=; b=WphY9DEE/k2sP9yxqvUHQNiA2+Px3w8+lsrgN0sd/GBup
	4H8hXNroDpN+12E3K80qkK4QS88+vpi83Rm+jVayQssQUJtudsbOHcJHnsHGs9mB
	hBu6tpqtVl8sViQfS3+tLaRyAa+GNhDjBJm2Q685zSo2RDL6dSqux8KHdZ4Inb0g
	pD4fFnilXhEnlUixp05uDMNeOvJHiUDfB8XNpiTG8ErZGcb9kvZtOD2Q/UnqWDPp
	hRmlbbchfgYjsV+ly1tPn5J15ptRIv8hkPF7G9exFAltHtbLcbo9biZ1yqn+M5pY
	W4zEJu4D+F3JmOw06a3WJ5XCqVaJZk00XS8cPkh1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn0e4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:59:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518EfCPp002610;
	Sat, 8 Feb 2025 18:59:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq5yssb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:59:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 518IxBlV019993;
	Sat, 8 Feb 2025 18:59:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44nwq5ysry-1;
	Sat, 08 Feb 2025 18:59:11 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        jiri@resnulli.us, liuhangbin@gmail.com, kuba@kernel.org,
        netdev@vger.kernel.org, stfomichev@gmail.com, shannon.nelson@amd.com,
        darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 1/2] netdevsim: print human readable IP address
Date: Sat,  8 Feb 2025 10:59:08 -0800
Message-ID: <20250208185909.2998264-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080161
X-Proofpoint-GUID: Pr4ygZgmcAW5ukLLbIE5CDFQMTSSK5Do
X-Proofpoint-ORIG-GUID: Pr4ygZgmcAW5ukLLbIE5CDFQMTSSK5Do

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit c71bc6da6198a6d88df86094f1052bb581951d65 ]

Currently, IPSec addresses are printed in hexadecimal format, which is
not user-friendly. e.g.

  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
  sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
  sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

This patch updates the code to print the IPSec address in a human-readable
format for easier debug. e.g.

 # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
 SA count=4 tx=40
 sa[0] tx ipaddr=0.0.0.0
 sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[1] rx ipaddr=192.168.0.1
 sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[2] tx ipaddr=::
 sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[3] rx ipaddr=2000::1
 sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[3]    key=0x3167608a ca4f1397 43565909 941fa627

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241010040027.21440-2-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit c71bc6da6198a6d88df86094f1052bb581951d65)
[Harshit: backport to stable kernels]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/netdevsim/ipsec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index feca55eef993..ec1fc1d3ea36 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -39,10 +39,14 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 		if (!sap->used)
 			continue;
 
-		p += scnprintf(p, bufsize - (p - buf),
-			       "sa[%i] %cx ipaddr=0x%08x %08x %08x %08x\n",
-			       i, (sap->rx ? 'r' : 't'), sap->ipaddr[0],
-			       sap->ipaddr[1], sap->ipaddr[2], sap->ipaddr[3]);
+		if (sap->xs->props.family == AF_INET6)
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI6c\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr);
+		else
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI4\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr[3]);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),
-- 
2.46.0


