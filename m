Return-Path: <stable+bounces-204512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B534CEF514
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 544DC3011A8A
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA962D47E2;
	Fri,  2 Jan 2026 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5XFQHUH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C226A0DB
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386274; cv=none; b=WhjIfU4mSVoQ6QdVo/ZJyOmM7Lbhn44+OMDApeg+Tr3xB27obuEGq2zI+vGXYJ/1pPlIGouqlkpe8UflTWIBe6VqxRKLZCuKIPFVGj3pmLJOm6NJ6vOMGQfutQZ7j59eQKdt1LHsF6ltIpiUgK4aU0QKK+46LctF2H6yFOnYT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386274; c=relaxed/simple;
	bh=pax269xZ3WJVUW8fk8fIaqtXtznqWgwMwikmlWphaEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy6hNk3lZZxnV5+8VOB3lALxmFoTgqHm0zGyusTLVzGLcN/WcG//RhntW6jbmR0zb8dqjjl6kjKY/c5uWZSz8V2bw+A/Trsft1sKT3AX92sCReZAQhX3qQKrTHwar8mwzZu7Y3ZE09DRClsoWlsHwzTmJTsGgjXneYu25IMrf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5XFQHUH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602BwXaG2958584;
	Fri, 2 Jan 2026 20:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=U00hh
	OcWgd39dXSBsbv6Nf8zaAYZbUKUYbIRCXk5bzU=; b=C5XFQHUHAMDv1JX8oKui/
	22m2QPSi48TEBe7lh+0ly3eKhfzcKSNLtQ78OqfAT4R+9Ku+r5nRNRFaCIab92iE
	mY0DA+c0yRWSrzflQXvaNv45P5WUuTAYNWGCI5Iw75IO3ZZ5zv3onPMcaIYoRtUV
	HPZbALmVTVzkJc46Lh0hallJpZ5/JkaaQkff/o4xTjEGtyKdHn9PWktVOPWph948
	gAn8AQZifmThuzfQZuuJZqjVk+YDpkMW2Q+hHkL44U+35u+KuHKvav9XihMUGPTn
	w8hfXJoOfzcwlO2VmeLGkIjoEN7E7zLtJQOcpGTJP9a6LCw0HL1AxnkU7hId13TS
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba680neun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602KG5Ns022512;
	Fri, 2 Jan 2026 20:37:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa66md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 602KbZ4d025726;
	Fri, 2 Jan 2026 20:37:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wa66fb-6;
	Fri, 02 Jan 2026 20:37:44 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 5/7] ipv6: adopt dst_dev() helper
Date: Fri,  2 Jan 2026 12:37:25 -0800
Message-ID: <20260102203727.1455662-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
References: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020184
X-Proofpoint-ORIG-GUID: 3LqN39UWfr-hL9DufC75COpxjGhFzCKP
X-Proofpoint-GUID: 3LqN39UWfr-hL9DufC75COpxjGhFzCKP
X-Authority-Analysis: v=2.4 cv=HPLO14tv c=1 sm=1 tr=0 ts=69582c9a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=OMpWK6eTjYvuxetBp9YA:9
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4NSBTYWx0ZWRfX21nUDJuE9bbZ
 XOPob9itOHEybKJVPs6M8f7d/dJh/cZCKoQJtmADi9TLiJXEm5Oo3TWShnTipCxWs7Hl1NDdsHX
 1DcIqAv1Lcd4asp2CThkkBm1Dj5X8/6szPHJU2NxsXvuFYwJ0avZds48cBkUhETtXI6HAeQ4oTy
 R9Fu6MFvcovPxcrXlRb9pNxiNRHngae9Ku8JwsaFGR2kGkiM9AG8JSVyvBZroSc1DDwGAiscsE6
 2pDpgdZJyWXQCdDl1OGGWvVVqQOP0Tn/e1l1zFwZi6aNBHqsFCooeK2QixD/O57M1AQ+ywbGf0+
 8mdIQVuqfhsLS8bNzVMZzEHGD5cV+MeYM3VndlIf0z7jspTQDyHwGChefYqGvmu2pEAxoWt/Agv
 vGTgCqyMZA221MSfaJonZY13Jk7uABJPdyGj02DrjrptahgIr5W4spawolRzV2FJaSUvRqWDQhT
 BNxSns46qlBuJHl+hZg==

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1caf27297215a5241f9bfc9c07336349d9034ee3 ]

Use the new helper as a step to deal with potential dst->dev races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 1caf27297215a5241f9bfc9c07336349d9034ee3)
[Harshit: Backport to 6.12.y, pulled this is a prerequisite]
Stable-dep-of: 99a2ace61b21 ("net: use dst_dev_rcu() in sk_setup_caps()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/ip6_route.h          |  4 ++--
 net/ipv6/exthdrs.c               |  2 +-
 net/ipv6/icmp.c                  |  4 +++-
 net/ipv6/ila/ila_lwt.c           |  2 +-
 net/ipv6/ioam6_iptunnel.c        |  4 ++--
 net/ipv6/ip6_gre.c               |  8 +++++---
 net/ipv6/ip6_output.c            | 19 ++++++++++---------
 net/ipv6/ip6_tunnel.c            |  4 ++--
 net/ipv6/ip6_udp_tunnel.c        |  2 +-
 net/ipv6/ip6_vti.c               |  2 +-
 net/ipv6/ndisc.c                 |  6 ++++--
 net/ipv6/netfilter/nf_dup_ipv6.c |  2 +-
 net/ipv6/output_core.c           |  2 +-
 net/ipv6/route.c                 | 20 ++++++++++++--------
 net/ipv6/rpl_iptunnel.c          |  4 ++--
 net/ipv6/seg6_iptunnel.c         | 20 +++++++++++---------
 net/ipv6/seg6_local.c            |  2 +-
 17 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 6dbdf60b342f..9255f21818ee 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -274,7 +274,7 @@ static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 	unsigned int mtu;
 
 	if (np && READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE) {
-		mtu = READ_ONCE(dst->dev->mtu);
+		mtu = READ_ONCE(dst_dev(dst)->mtu);
 		mtu -= lwtunnel_headroom(dst->lwtstate, mtu);
 	} else {
 		mtu = dst_mtu(dst);
@@ -337,7 +337,7 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 
 	mtu = IPV6_MIN_MTU;
 	rcu_read_lock();
-	idev = __in6_dev_get(dst->dev);
+	idev = __in6_dev_get(dst_dev(dst));
 	if (idev)
 		mtu = READ_ONCE(idev->cnf.mtu6);
 	rcu_read_unlock();
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 6789623b2b0d..20f77fdfb73d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -306,7 +306,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
-		__IP6_INC_STATS(dev_net(dst->dev), idev,
+		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
 				IPSTATS_MIB_INHDRERRORS);
 fail_and_free:
 		kfree_skb(skb);
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 4d14ab7f7e99..8117c1784596 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -196,6 +196,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 			       struct flowi6 *fl6, bool apply_ratelimit)
 {
 	struct net *net = sock_net(sk);
+	struct net_device *dev;
 	struct dst_entry *dst;
 	bool res = false;
 
@@ -208,10 +209,11 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	 * this lookup should be more aggressive (not longer than timeout).
 	 */
 	dst = ip6_route_output(net, sk, fl6);
+	dev = dst_dev(dst);
 	if (dst->error) {
 		IP6_INC_STATS(net, ip6_dst_idev(dst),
 			      IPSTATS_MIB_OUTNOROUTES);
-	} else if (dst->dev && (dst->dev->flags&IFF_LOOPBACK)) {
+	} else if (dev && (dev->flags & IFF_LOOPBACK)) {
 		res = true;
 	} else {
 		struct rt6_info *rt = dst_rt6_info(dst);
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 7d574f5132e2..7bb9edc5c28c 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -70,7 +70,7 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		 */
 
 		memset(&fl6, 0, sizeof(fl6));
-		fl6.flowi6_oif = orig_dst->dev->ifindex;
+		fl6.flowi6_oif = dst_dev(orig_dst)->ifindex;
 		fl6.flowi6_iif = LOOPBACK_IFINDEX;
 		fl6.daddr = *rt6_nexthop(dst_rt6_info(orig_dst),
 					 &ip6h->daddr);
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 163b9e47eb9f..9e4774771023 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -328,7 +328,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	if (has_tunsrc)
 		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
 	else
-		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
+		ipv6_dev_get_saddr(net, dst_dev(dst), &hdr->daddr,
 				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
 
 	skb_postpush_rcsum(skb, hdr, len);
@@ -417,7 +417,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	}
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 68e9a41eed49..806c15e0a4cf 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1084,9 +1084,11 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
-
+	if (!t->parms.collect_md && dst) {
+		mtu = READ_ONCE(dst_dev(dst)->mtu);
+		if (dst_mtu(dst) > mtu)
+			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
+	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f0e5431c2d46..24b68e99636e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -60,7 +60,7 @@
 static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	const struct in6_addr *daddr, *nexthop;
@@ -271,7 +271,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	struct hop_jumbo_hdr *hop_jumbo;
 	int hoplen = sizeof(*hop_jumbo);
@@ -503,7 +503,8 @@ int ip6_forward(struct sk_buff *skb)
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net *net = dev_net(dst_dev(dst));
+	struct net_device *dev;
 	struct inet6_dev *idev;
 	SKB_DR(reason);
 	u32 mtu;
@@ -591,12 +592,12 @@ int ip6_forward(struct sk_buff *skb)
 		goto drop;
 	}
 	dst = skb_dst(skb);
-
+	dev = dst_dev(dst);
 	/* IPv6 specs say nothing about it, but it is clear that we cannot
 	   send redirects to source routed frames.
 	   We don't send redirects to frames decapsulated from IPsec.
 	 */
-	if (IP6CB(skb)->iif == dst->dev->ifindex &&
+	if (IP6CB(skb)->iif == dev->ifindex &&
 	    opt->srcrt == 0 && !skb_sec_path(skb)) {
 		struct in6_addr *target = NULL;
 		struct inet_peer *peer;
@@ -644,7 +645,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	if (ip6_pkt_too_big(skb, mtu)) {
 		/* Again, force OUTPUT device used as source address */
-		skb->dev = dst->dev;
+		skb->dev = dev;
 		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INTOOBIGERRORS);
 		__IP6_INC_STATS(net, ip6_dst_idev(dst),
@@ -653,7 +654,7 @@ int ip6_forward(struct sk_buff *skb)
 		return -EMSGSIZE;
 	}
 
-	if (skb_cow(skb, dst->dev->hard_header_len)) {
+	if (skb_cow(skb, dev->hard_header_len)) {
 		__IP6_INC_STATS(net, ip6_dst_idev(dst),
 				IPSTATS_MIB_OUTDISCARDS);
 		goto drop;
@@ -666,7 +667,7 @@ int ip6_forward(struct sk_buff *skb)
 	hdr->hop_limit--;
 
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
-		       net, NULL, skb, skb->dev, dst->dev,
+		       net, NULL, skb, skb->dev, dev,
 		       ip6_forward_finish);
 
 error:
@@ -1093,7 +1094,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 #ifdef CONFIG_IPV6_SUBTREES
 	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr, np->saddr_cache) ||
 #endif
-	   (fl6->flowi6_oif && fl6->flowi6_oif != dst->dev->ifindex)) {
+	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
 		dst_release(dst);
 		dst = NULL;
 	}
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index b72ca1034906..6450ecf0d0a7 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1179,7 +1179,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		ndst = dst;
 	}
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		DEV_STATS_INC(dev, collisions);
@@ -1255,7 +1255,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	/* Calculate max headroom for all the headers and adjust
 	 * needed_headroom if necessary.
 	 */
-	max_headroom = LL_RESERVED_SPACE(dst->dev) + sizeof(struct ipv6hdr)
+	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
 			+ dst->header_len + t->hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..2acf1bb93fc0 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -168,7 +168,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
 		return ERR_PTR(-ENETUNREACH);
 	}
-	if (dst->dev == dev) { /* is this necessary? */
+	if (dst_dev(dst) == dev) { /* is this necessary? */
 		netdev_dbg(dev, "circular route to %pI6\n", &fl6.daddr);
 		dst_release(dst);
 		return ERR_PTR(-ELOOP);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 012350469144..fd6f76e36e80 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -497,7 +497,7 @@ vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 			      (const struct in6_addr *)&x->id.daddr))
 		goto tx_err_link_failure;
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		DEV_STATS_INC(dev, collisions);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 8699d1a188dc..d961e6c2d09d 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -473,6 +473,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 {
 	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev;
 	struct inet6_dev *idev;
 	struct net *net;
 	struct sock *sk;
@@ -507,11 +508,12 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	idev = __in6_dev_get(dst->dev);
+	dev = dst_dev(dst);
+	idev = __in6_dev_get(dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, dst->dev,
+		      net, sk, skb, NULL, dev,
 		      dst_output);
 	if (!err) {
 		ICMP6MSGOUT_INC_STATS(net, idev, type);
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 0c39c77fe8a8..a8bb04bd94cf 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -38,7 +38,7 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 	}
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
-	skb->dev      = dst->dev;
+	skb->dev      = dst_dev(dst);
 	skb->protocol = htons(ETH_P_IPV6);
 
 	return true;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 806d4b5dd1e6..90a178dd24aa 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -105,7 +105,7 @@ int ip6_dst_hoplimit(struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
 	if (hoplimit == 0) {
-		struct net_device *dev = dst->dev;
+		struct net_device *dev = dst_dev(dst);
 		struct inet6_dev *idev;
 
 		rcu_read_lock();
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 22866444efc0..355f903f88c0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -228,13 +228,13 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
 	const struct rt6_info *rt = dst_rt6_info(dst);
 
 	return ip6_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
-				dst->dev, skb, daddr);
+				dst_dev(dst), skb, daddr);
 }
 
 static void ip6_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
 	const struct rt6_info *rt = dst_rt6_info(dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 
 	daddr = choose_neigh_daddr(rt6_nexthop(rt, &in6addr_any), NULL, daddr);
 	if (!daddr)
@@ -2934,7 +2934,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 		if (res.f6i->nh) {
 			struct fib6_nh_match_arg arg = {
-				.dev = dst->dev,
+				.dev = dst_dev(dst),
 				.gw = &rt6->rt6i_gateway,
 			};
 
@@ -3229,7 +3229,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	unsigned int mtu = dst_mtu(dst);
 	struct net *net;
 
@@ -4253,7 +4253,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	if (res.f6i->nh) {
 		struct fib6_nh_match_arg arg = {
-			.dev = dst->dev,
+			.dev = dst_dev(dst),
 			.gw = &rt->rt6i_gateway,
 		};
 
@@ -4540,13 +4540,14 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 static int ip6_pkt_drop(struct sk_buff *skb, u8 code, int ipstats_mib_noroutes)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net_device *dev = dst_dev(dst);
+	struct net *net = dev_net(dev);
 	struct inet6_dev *idev;
 	SKB_DR(reason);
 	int type;
 
 	if (netif_is_l3_master(skb->dev) ||
-	    dst->dev == net->loopback_dev)
+	    dev == net->loopback_dev)
 		idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
 	else
 		idev = ip6_dst_idev(dst);
@@ -5764,11 +5765,14 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 	 * each as a nexthop within RTA_MULTIPATH.
 	 */
 	if (rt6) {
+		struct net_device *dev;
+
 		if (rt6_flags & RTF_GATEWAY &&
 		    nla_put_in6_addr(skb, RTA_GATEWAY, &rt6->rt6i_gateway))
 			goto nla_put_failure;
 
-		if (dst->dev && nla_put_u32(skb, RTA_OIF, dst->dev->ifindex))
+		dev = dst_dev(dst);
+		if (dev && nla_put_u32(skb, RTA_OIF, dev->ifindex))
 			goto nla_put_failure;
 
 		if (dst->lwtstate &&
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index eccfa4203e96..c7942cf65567 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -242,7 +242,7 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	}
@@ -297,7 +297,7 @@ static int rpl_input(struct sk_buff *skb)
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	} else {
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 51583461ae29..27918fc0c972 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -128,7 +128,8 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 			       int proto, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net_device *dev = dst_dev(dst);
+	struct net *net = dev_net(dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	struct ipv6_sr_hdr *isrh;
 	int hdrlen, tot_len, err;
@@ -181,7 +182,7 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
@@ -212,7 +213,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 {
 	__u8 first_seg = osrh->first_segment;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net_device *dev = dst_dev(dst);
+	struct net *net = dev_net(dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	int hdrlen = ipv6_optlen(osrh);
 	int red_tlv_offset, tlv_offset;
@@ -270,7 +272,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	if (skip_srh) {
 		hdr->nexthdr = proto;
 
-		set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
 		goto out;
 	}
 
@@ -306,7 +308,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 srcaddr:
 	isrh->nexthdr = proto;
-	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
@@ -507,7 +509,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	} else {
@@ -518,7 +520,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 			       dev_net(skb->dev), NULL, skb, NULL,
-			       skb_dst(skb)->dev, seg6_input_finish);
+			       skb_dst_dev(skb), seg6_input_finish);
 
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
 drop:
@@ -593,7 +595,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	}
@@ -603,7 +605,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
-			       NULL, skb_dst(skb)->dev, dst_output);
+			       NULL, dst_dev(dst), dst_output);
 
 	return dst_output(net, sk, skb);
 drop:
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index e445a0a45568..bb196d451a55 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -310,7 +310,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 	if (!local_delivery)
 		dev_flags |= IFF_LOOPBACK;
 
-	if (dst && (dst->dev->flags & dev_flags) && !dst->error) {
+	if (dst && (dst_dev(dst)->flags & dev_flags) && !dst->error) {
 		dst_release(dst);
 		dst = NULL;
 	}
-- 
2.50.1


