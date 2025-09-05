Return-Path: <stable+bounces-177810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A81B455AE
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA7A05216
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6032275E;
	Fri,  5 Sep 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b86cS7Li"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFA341AC2
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070284; cv=none; b=pbWdSzDifr1QOS4Xgr1+WWZbFLAJ/lC8u41Np+R7thdKlQHOoiHhYge3TA1l+tJnj5+rTeP6zAgZ6Vzy0BBaG3+uakuaUc4t2UUiuMf2hizaee2/imJKFyoxJD4HM0qdnn1Pk3OtiS0TWqEihYSiE1h9fiAflSgJa4iOIup8Ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070284; c=relaxed/simple;
	bh=4zBSwsy6EW8fVbPa1zMJzzgsCAlYysirhLJvPHbplmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ2CxQhoDVqUeDjdMzAi+kiibYmOac2/nDFGSib8HMHgnllSTUZmNMWnNdCDzeaZbkSIVbiDfUgx6VJMBjANHF6aXxosLUhNsCj79nRt5fkOqON0ajCJ4QFv2Sb3sE5tXEw3OTNSQeXosxx1cvafSfWYonmlv70ZcrXO6foDYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b86cS7Li; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B0vVA027478;
	Fri, 5 Sep 2025 11:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=135gk
	qcoSJ+voj+SYdYdNLTi2N0C1WLD4Xol5N2Naa8=; b=b86cS7LieQ8iwWaHX34Cr
	jxyTZXon5DfNzUpHDMZSnI0KNw9RbuqLdj4UtPzt+eqFrDKJduqvjHucbHhJpfim
	FWd/3ee1YT0M0c6R3X0rRMMinaECZw0QdM46yWknRDnTxrd93/PVWXFQVrnCBeTw
	9f3qk+DRWYGS4ywtF5b+wtI0M3NNakm50FZM6/clm6kpRnE+K4XX0w0BDaAtI14S
	hgEiY1kD0mUpFdMduAnMueMNW3uGy9ND61NwYMHlr9qoA1hFqkWAax4ICB4WRHyY
	8uNKcBtPrapuiwI6Gz0zaWodJs+NznvSeehQFfYR787rf1bos51xoUmrqvJA3MMX
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxkg80b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JZ3G019604;
	Fri, 5 Sep 2025 11:04:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hc030057;
	Fri, 5 Sep 2025 11:04:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-15;
	Fri, 05 Sep 2025 11:04:34 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Wang Liang <wangliang74@huawei.com>,
        David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 14/15] net: fix NULL pointer dereference in l3mdev_l3_rcv
Date: Fri,  5 Sep 2025 04:04:05 -0700
Message-ID: <20250905110406.3021567-15-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNyBTYWx0ZWRfX8bJ/kpLZa0+u
 6BLkrzlepHFuqL/Kr1waeM+bJRQ298vK+v+fno2AzTC5lWS6iX94BqL1JZrT69krNv4UX3+8Cwh
 eKQysNE8Jqy+TJHsZuEkTIr6TdFTjwfY3hEolBqfwZMZMGIaDiGWHxfk7mg0EG09x7F5MH4qdod
 cK0tVdarCIo6NU162+5rzH5yYzaF5ff0WnHbHd5MF4XYinvjAssyhRXrwyvWMKwX8McuR9WeNRc
 btznfR8uFVkNYjFt699e3tTMKg9mfdt2BmLWeOUtYv88dYTQLCPqFOVMTfqbM0XnSJ3lwKlEnBS
 iMY/BEg4abgnmq6p6pEl320SulSg2rhBUzNBxLT/6/EHwz+AldXplJikX2bF7hhjrJ7zj2ZNXVP
 dz6fm1rr
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68bac3c4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=bC-a23v3AAAA:8 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=cRglST0ZI0GUjvPb-E8A:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: bcU8mQDo-YMzO5k3M98-dOB5tGqmH-VJ
X-Proofpoint-GUID: bcU8mQDo-YMzO5k3M98-dOB5tGqmH-VJ

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 0032c99e83b9ce6d5995d65900aa4b6ffb501cce ]

When delete l3s ipvlan:

    ip link del link eth0 ipvlan1 type ipvlan mode l3s

This may cause a null pointer dereference:

    Call trace:
     ip_rcv_finish+0x48/0xd0
     ip_rcv+0x5c/0x100
     __netif_receive_skb_one_core+0x64/0xb0
     __netif_receive_skb+0x20/0x80
     process_backlog+0xb4/0x204
     napi_poll+0xe8/0x294
     net_rx_action+0xd8/0x22c
     __do_softirq+0x12c/0x354

This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
like this:

    (CPU1)                     | (CPU2)
    l3mdev_l3_rcv()            |
      check dev->priv_flags:   |
        master = skb->dev;     |
                               |
                               | ipvlan_l3s_unregister()
                               |   set dev->priv_flags
                               |   dev->l3mdev_ops = NULL;
                               |
      visit master->l3mdev_ops |

To avoid this by do not set dev->l3mdev_ops when unregister l3s ipvlan.

Suggested-by: David Ahern <dsahern@kernel.org>
Fixes: c675e06a98a4 ("ipvlan: decouple l3s mode dependencies from other modes")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250321090353.1170545-1-wangliang74@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 0032c99e83b9ce6d5995d65900aa4b6ffb501cce)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ipvlan/ipvlan_l3s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index d5b05e803219..ca35a50bb640 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -224,5 +224,4 @@ void ipvlan_l3s_unregister(struct ipvl_port *port)
 
 	dev->priv_flags &= ~IFF_L3MDEV_RX_HANDLER;
 	ipvlan_unregister_nf_hook(read_pnet(&port->pnet));
-	dev->l3mdev_ops = NULL;
 }
-- 
2.50.1


