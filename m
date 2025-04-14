Return-Path: <stable+bounces-132666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C345A88BBE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E228189AC52
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3D1AF0BF;
	Mon, 14 Apr 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iHnmd86m"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2B1A3031
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656665; cv=none; b=Vfo1EkDREJzOR9n4RX0FIno7Thupl6rn5l3yR6Jzhj7zuNKUZtAB27+cTsW5fttWLhCCH/2xa1rhSgLMO+ncqMxRm2FcssdXsGkxltKChEdQVdABKrreS5Sze6lv8CV537x4+Eo78KI+Z8z3D0vjDszn+58yaHMlX+wx7AMBr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656665; c=relaxed/simple;
	bh=rQUlMHyD8MJEmUcRviCFcj/9kJJJj2fL3io4f1Kl+DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2upwHFIEGuPFdoLRlvV2aHbnBZZRpom1mfpRboWSXyPYeNzAPS59h427FGvMOBZ4sMwsnJMukBdzgoAZfqhp62xHoN4oFkzWTz7VdA8Q2nci51UZJsLbGjsqPwg95Vzh7Xa98fovhrsPHVDEzdVMpHMNvKFb1FeaSq/8n6MIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iHnmd86m; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EH0p6W016959;
	Mon, 14 Apr 2025 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=BjJ+h
	K+pNvO2NvJga8l5UWEk4VdWf0bonZmf4Xe8pvY=; b=iHnmd86ml+Dq/A+48NwKs
	ZlcMKVX4FZwfUpNdtbdrw2tqU6RJwokTKZkbCdCeQryYbNlz0MWT4dxUuAIK2XYf
	GZCkcuwtm6XWmR4l2D46IIUS6dDs/9k1OyFBLKxSgnvP9T5Or6/teT55kC06OGvN
	7MitOM4z2jgvv9v6WpiBrGd0ujEzhH+zLr+sbFy4DgrHllulXZhwIFYo76esArrr
	Oxx43nYPGtW21MiDdcc2LID5dAbQgY4qzaiwxYaZbI1nOkBBoohDvcXUaYAKuXIF
	UCIZ0szuwSmMjNkedG+oppAB7Xh+IpOU0bkyfM83FFYyCfwz1as9pcmOzTqQThDh
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4615yag95c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHiUsD024737;
	Mon, 14 Apr 2025 18:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d4y5fdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:49 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53EIoUHM035509;
	Mon, 14 Apr 2025 18:50:48 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d4y5f48-7;
	Mon, 14 Apr 2025 18:50:48 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 6/6] ipv6: release nexthop on device removal
Date: Mon, 14 Apr 2025 11:50:23 -0700
Message-ID: <20250414185023.2165422-7-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
References: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=922 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140137
X-Proofpoint-GUID: eO_jlQV9uJ9KB2syP_hXkrNv6D_t5tTS
X-Proofpoint-ORIG-GUID: eO_jlQV9uJ9KB2syP_hXkrNv6D_t5tTS

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit eb02688c5c45c3e7af7e71f036a7144f5639cbfe ]

The CI is hitting some aperiodic hangup at device removal time in the
pmtu.sh self-test:

unregister_netdevice: waiting for veth_A-R1 to become free. Usage count = 6
ref_tracker: veth_A-R1@ffff888013df15d8 has 1/5 users at
	dst_init+0x84/0x4a0
	dst_alloc+0x97/0x150
	ip6_dst_alloc+0x23/0x90
	ip6_rt_pcpu_alloc+0x1e6/0x520
	ip6_pol_route+0x56f/0x840
	fib6_rule_lookup+0x334/0x630
	ip6_route_output_flags+0x259/0x480
	ip6_dst_lookup_tail.constprop.0+0x5c2/0x940
	ip6_dst_lookup_flow+0x88/0x190
	udp_tunnel6_dst_lookup+0x2a7/0x4c0
	vxlan_xmit_one+0xbde/0x4a50 [vxlan]
	vxlan_xmit+0x9ad/0xf20 [vxlan]
	dev_hard_start_xmit+0x10e/0x360
	__dev_queue_xmit+0xf95/0x18c0
	arp_solicit+0x4a2/0xe00
	neigh_probe+0xaa/0xf0

While the first suspect is the dst_cache, explicitly tracking the dst
owing the last device reference via probes proved such dst is held by
the nexthop in the originating fib6_info.

Similar to commit f5b51fe804ec ("ipv6: route: purge exception on
removal"), we need to explicitly release the originating fib info when
disconnecting a to-be-removed device from a live ipv6 dst: move the
fib6_info cleanup into ip6_dst_ifdown().

Tested running:

./pmtu.sh cleanup_ipv6_exception

in a tight loop for more than 400 iterations with no spat, running an
unpatched kernel  I observed a splat every ~10 iterations.

Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_info")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit eb02688c5c45c3e7af7e71f036a7144f5639cbfe)
[Harshit: Resolved conflict due to missing commit: e5f80fcf869a ("ipv6:
give an IPv6 dev to blackhole_netdev") and commit: b4cb4a1391dc ("net:
use unrcu_pointer() helper") in linux-5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/ipv6/route.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f8b2fdaef67f..f30a5b7d93f4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -377,6 +377,7 @@ static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
 	struct inet6_dev *idev = rt->rt6i_idev;
 	struct net_device *loopback_dev =
 		dev_net(dev)->loopback_dev;
+	struct fib6_info *from;
 
 	if (idev && idev->dev != loopback_dev) {
 		struct inet6_dev *loopback_idev = in6_dev_get(loopback_dev);
@@ -385,6 +386,8 @@ static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
 			in6_dev_put(idev);
 		}
 	}
+	from = xchg((__force struct fib6_info **)&rt->from, NULL);
+	fib6_info_release(from);
 }
 
 static bool __rt6_check_expired(const struct rt6_info *rt)
@@ -1443,7 +1446,6 @@ static DEFINE_SPINLOCK(rt6_exception_lock);
 static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 				 struct rt6_exception *rt6_ex)
 {
-	struct fib6_info *from;
 	struct net *net;
 
 	if (!bucket || !rt6_ex)
@@ -1455,8 +1457,6 @@ static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 	/* purge completely the exception to allow releasing the held resources:
 	 * some [sk] cache may keep the dst around for unlimited time
 	 */
-	from = xchg((__force struct fib6_info **)&rt6_ex->rt6i->from, NULL);
-	fib6_info_release(from);
 	dst_dev_put(&rt6_ex->rt6i->dst);
 
 	hlist_del_rcu(&rt6_ex->hlist);
-- 
2.47.1


