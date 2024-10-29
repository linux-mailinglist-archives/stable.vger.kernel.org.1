Return-Path: <stable+bounces-89256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AAC9B54CB
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E921F23A4E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66E207A3A;
	Tue, 29 Oct 2024 21:14:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6120721D;
	Tue, 29 Oct 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236493; cv=none; b=pf5yV+w8kzZy3AdjKRn66yNMXsxx46rG+1xkH4///3ny+dOjqY7TfBDM6B4KxjqzHLIEnsAjD9/cMcdhRWIIYlTYbqtA/p6ZAY91HwOiHrVTk6keStx5N9/QqQiYL+aEesYGFMIv5HqKxtsQBvXaBufN4HzwGVoIoYoXaPmQKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236493; c=relaxed/simple;
	bh=0Hmfu0Dmd+ONojT8fbkDPeqhboxJBVmLmMSWyx58uPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8UjwCwZ3P8lDl92Z9eE/OhrS1rIqcKAkOrYmHuyWAkWlBvxU4It3xD+RNFbTO2wkqbMOt9K8ATVAv8TX4P8f2UYtWCKkf+8R89oxFjci/yA/Hdvggw2ScU2QJkpXOO2cUTjeqqJrnfeHf3eL5Z99uRZPTHkCQQGSoVxoBpSkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49THNuUr024976;
	Tue, 29 Oct 2024 21:14:29 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42gqd8m43p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Oct 2024 21:14:29 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 14:14:28 -0700
Received: from pop-os.wrs.com (172.25.44.6) by ala-exchng01.corp.ad.wrs.com
 (147.11.82.252) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Oct 2024 14:14:27 -0700
From: <Randy.MacLeod@windriver.com>
To: <sherry.yang@oracle.com>
CC: <bridge@lists.linux-foundation.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <nikolay@nvidia.com>, <roopa@nvidia.com>,
        <sashal@kernel.org>, <stable@vger.kernel.org>,
        <randy.macleod@windriver.com>
Subject: [PATCH 5.15.y] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Tue, 29 Oct 2024 17:14:26 -0400
Message-ID: <20241029211426.3046219-1-Randy.MacLeod@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004170328.10819-3-sherry.yang@oracle.com>
References: <20241004170328.10819-3-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I5g67KRVeGwd-XnB4L0ZUcMFU6Y4VrpW
X-Authority-Analysis: v=2.4 cv=dKj0m/Zb c=1 sm=1 tr=0 ts=67215035 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=eMPNgDwjIQXpT8XC:21 a=DAUX931o1VcA:10 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=IJ2IFIBGmV0-FWXsoRQA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: I5g67KRVeGwd-XnB4L0ZUcMFU6Y4VrpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_16,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410290159

From: Randy MacLeod <Randy.MacLeod@windriver.com>

[ Upstream commit 8bd67ebb50c0145fd2ca8681ab65eb7e8cde1afc ]

Based on above commit but simplified since pskb_may_pull_reason()
does not exist until 6.1.

syzbot triggered an uninit value[1] error in bridge device's xmit path
by sending a short (less than ETH_HLEN bytes) skb. To fix it check if
we can actually pull that amount instead of assuming.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
Signed-off-by: Randy MacLeod <Randy.MacLeod@windriver.com>
---
 net/bridge/br_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8d6bab244c4a..b2fa4ca28102 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -38,6 +38,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();
-- 
2.34.1


