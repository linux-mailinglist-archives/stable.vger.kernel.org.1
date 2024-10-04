Return-Path: <stable+bounces-80776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E109909E4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE5DB25211
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB11D9A72;
	Fri,  4 Oct 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNOWWoQz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D01E376B;
	Fri,  4 Oct 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061426; cv=none; b=I2VINzQ1bQfSvaB1hZyWsWQlhqAxfEMsoDxo5t6XPLbu/DlFP8aOhSocc+hCOkETPi7bN08FwTInu0rSP/HiAeA4dzsv/0ZCTGORVXSYzKq6He9yNzBTww4rj2WQNpCYqTuG7ooFjJQz5GGNEznUzJS26HVH+HeL6KPCO+22dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061426; c=relaxed/simple;
	bh=7SjwWmBpU1dVE9eUFJi9tlgEm3VA+kYZZdgBI9HMTUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNHW+FehF33T1ib/f+pBax3QdZ6ZnTJdFmhOpk/tJ98TTh4yZFBmNI6qkC+67duIlIBN44wO/KS8B5IZDBNKeLh5t6DNQwWm7NUp9b3DN+59eHubN/1sBbfoozoSo5ZLvcoWIfGo0j7stbb8wm503tcCcluQxj8aDwhmIfttX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hNOWWoQz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494GfvnY031811;
	Fri, 4 Oct 2024 17:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=W
	z0MiqEw+sT/I0NG6+Nr++0T8bkr8ZYXSjO9Nx2LsRo=; b=hNOWWoQzPLeGHSQrE
	mxk6NaanzEXAHKfZ06/LWQOj4DBngshe74eZoaP4rsBOpoya8jmsxME/CLKUY4zj
	5/7puHneR/o7R+A3MgZKqit4rdqQqUZCORxENvZQr3uKV3STc9cfABgnfLyzgBtg
	Hx5z26q8gLrSr8rjt1SXoIrHncTqNkqHjbXU4a7TSmq3DF7GoC/gJjkh8F+ZUv4A
	MzsUmX+F2MjHasbiewRddQe/Re3RRSsUOF3GqM+X7GerRBeRXrHXTSY59X5elJhc
	eNMYMMAkapRwb6ZHj7m6WvbsmpC2ZU/uuZ8CYtFFn5ntXzvKXnLnygLbw0fe5uji
	wjKKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204922m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:03:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494FKnmp005813;
	Fri, 4 Oct 2024 17:03:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056te0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:03:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494GxlJo035743;
	Fri, 4 Oct 2024 17:03:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422056tdvr-3;
	Fri, 04 Oct 2024 17:03:35 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, kuba@kernel.org, gregkh@linuxfoundation.org,
        roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.15.y 2/2] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Fri,  4 Oct 2024 10:03:28 -0700
Message-ID: <20241004170328.10819-3-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241004170328.10819-1-sherry.yang@oracle.com>
References: <20241004170328.10819-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040118
X-Proofpoint-GUID: CJsDE1f3dD5l4hI9AVlQgZMjAMgIB5_4
X-Proofpoint-ORIG-GUID: CJsDE1f3dD5l4hI9AVlQgZMjAMgIB5_4

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit 8bd67ebb50c0145fd2ca8681ab65eb7e8cde1afc ]

syzbot triggered an uninit value[1] error in bridge device's xmit path
by sending a short (less than ETH_HLEN bytes) skb. To fix it check if
we can actually pull that amount instead of assuming.

Tested with dropwatch:
 drop at: br_dev_xmit+0xb93/0x12d0 [bridge] (0xffffffffc06739b3)
 origin: software
 timestamp: Mon May 13 11:31:53 2024 778214037 nsec
 protocol: 0x88a8
 length: 2
 original length: 2
 drop reason: PKT_TOO_SMALL

[1]
BUG: KMSAN: uninit-value in br_dev_xmit+0x61d/0x1cb0 net/bridge/br_device.c:65
 br_dev_xmit+0x61d/0x1cb0 net/bridge/br_device.c:65
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
 __dev_queue_xmit+0x34db/0x5350 net/core/dev.c:4341
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 __bpf_tx_skb net/core/filter.c:2136 [inline]
 __bpf_redirect_common net/core/filter.c:2180 [inline]
 __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
 ____bpf_clone_redirect net/core/filter.c:2460 [inline]
 bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Sherry: bp to 5.15.y. This is to fix CVE-2024-38538]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 net/bridge/br_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8d6bab244c4a..89ca2169ea43 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -27,6 +27,7 @@ EXPORT_SYMBOL_GPL(nf_br_ops);
 /* net device transmit always called with BH disabled */
 netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, ETH_HLEN);
 	struct net_bridge_mcast_port *pmctx_null = NULL;
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
@@ -38,6 +39,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();
-- 
2.46.0


