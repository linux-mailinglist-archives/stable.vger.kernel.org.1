Return-Path: <stable+bounces-10616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94882C87E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 01:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34989B23E4D
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE8107A6;
	Sat, 13 Jan 2024 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aSgqsOb4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF808107B2
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705107333; x=1736643333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4e2qnYe6xUPkuxgTbdDTpikuSY8Nj40GHGVtH9Gz0c=;
  b=aSgqsOb4UhIH0K8chtbBI6/ELFhb11nNIH3Mlusk2GyTpnitDLoAJQvs
   LIPq3RWz+rk5g3kPyDd+28yfC0VO9IHZPUKQjXVxX77Q8ohc5EEXDvCjJ
   k1N9fQUE566vogSSZ+fYtvancMyoe/JI2cU7EFBk6SI1DwIsd2MutxXFz
   k=;
X-IronPort-AV: E=Sophos;i="6.04,191,1695686400"; 
   d="scan'208";a="177804958"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 00:55:30 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id DCAF5410AD;
	Sat, 13 Jan 2024 00:55:29 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.200:2525] with esmtp (Farcaster)
 id 127759f1-3f0b-42ac-bc72-e72888053b18; Sat, 13 Jan 2024 00:55:29 +0000 (UTC)
X-Farcaster-Flow-ID: 127759f1-3f0b-42ac-bc72-e72888053b18
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:55:29 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.171.38) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:55:28 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <trawets@amazon.com>, <security@kernel.org>,
	Jon Maxwell <jmaxwell37@gmail.com>, Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>
Subject: [PATCH stable 4.19.x 4/4] ipv6: remove max_size check inline with ipv4
Date: Fri, 12 Jan 2024 16:53:08 -0800
Message-ID: <20240113005308.2422331-4-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240113005308.2422331-1-surajjs@amazon.com>
References: <2024011155-gruffly-chunk-e186@gregkh>
 <20240113005308.2422331-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)

From: Jon Maxwell <jmaxwell37@gmail.com>

commit af6d10345ca76670c1b7c37799f0d5576ccef277 upstream.

In ip6_dst_gc() replace:

  if (entries > gc_thresh)

With:

  if (entries > ops->gc_thresh)

Sending Ipv6 packets in a loop via a raw socket triggers an issue where a
route is cloned by ip6_rt_cache_alloc() for each packet sent. This quickly
consumes the Ipv6 max_size threshold which defaults to 4096 resulting in
these warnings:

[1]   99.187805] dst_alloc: 7728 callbacks suppressed
[2] Route cache is full: consider increasing sysctl net.ipv6.route.max_size.
.
.
[300] Route cache is full: consider increasing sysctl net.ipv6.route.max_size.

When this happens the packet is dropped and sendto() gets a network is
unreachable error:

remaining pkt 200557 errno 101
remaining pkt 196462 errno 101
.
.
remaining pkt 126821 errno 101

Implement David Aherns suggestion to remove max_size check seeing that Ipv6
has a GC to manage memory usage. Ipv4 already does not check max_size.

Here are some memory comparisons for Ipv4 vs Ipv6 with the patch:

Test by running 5 instances of a program that sends UDP packets to a raw
socket 5000000 times. Compare Ipv4 and Ipv6 performance with a similar
program.

Ipv4:

Before test:

MemFree:        29427108 kB
Slab:             237612 kB

ip6_dst_cache       1912   2528    256   32    2 : tunables    0    0    0
xfrm_dst_cache         0      0    320   25    2 : tunables    0    0    0
ip_dst_cache        2881   3990    192   42    2 : tunables    0    0    0

During test:

MemFree:        29417608 kB
Slab:             247712 kB

ip6_dst_cache       1912   2528    256   32    2 : tunables    0    0    0
xfrm_dst_cache         0      0    320   25    2 : tunables    0    0    0
ip_dst_cache       44394  44394    192   42    2 : tunables    0    0    0

After test:

MemFree:        29422308 kB
Slab:             238104 kB

ip6_dst_cache       1912   2528    256   32    2 : tunables    0    0    0
xfrm_dst_cache         0      0    320   25    2 : tunables    0    0    0
ip_dst_cache        3048   4116    192   42    2 : tunables    0    0    0

Ipv6 with patch:

Errno 101 errors are not observed anymore with the patch.

Before test:

MemFree:        29422308 kB
Slab:             238104 kB

ip6_dst_cache       1912   2528    256   32    2 : tunables    0    0    0
xfrm_dst_cache         0      0    320   25    2 : tunables    0    0    0
ip_dst_cache        3048   4116    192   42    2 : tunables    0    0    0

During Test:

MemFree:        29431516 kB
Slab:             240940 kB

ip6_dst_cache      11980  12064    256   32    2 : tunables    0    0    0
xfrm_dst_cache         0      0    320   25    2 : tunables    0    0    0
ip_dst_cache        3048   4116    192   42    2 : tunables    0    0    0

After Test:

MemFree:        29441816 kB
Slab:             238132 kB

ip6_dst_cache       1902   2432    256   32    2 : tunables    0    0    0
xfrm_dst_cache         0      0    320   25    2 : tunables    0    0    0
ip_dst_cache        3048   4116    192   42    2 : tunables    0    0    0

Tested-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230112012532.311021-1-jmaxwell37@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 4.19.x
---
 include/net/dst_ops.h |  2 +-
 net/core/dst.c        |  8 ++------
 net/ipv6/route.c      | 13 +++++--------
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 88ff7bb2bb9b..632086b2f644 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -16,7 +16,7 @@ struct dst_ops {
 	unsigned short		family;
 	unsigned int		gc_thresh;
 
-	int			(*gc)(struct dst_ops *ops);
+	void			(*gc)(struct dst_ops *ops);
 	struct dst_entry *	(*check)(struct dst_entry *, __u32 cookie);
 	unsigned int		(*default_advmss)(const struct dst_entry *);
 	unsigned int		(*mtu)(const struct dst_entry *);
diff --git a/net/core/dst.c b/net/core/dst.c
index 1a9f84f8cde1..1b1677683b97 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -99,12 +99,8 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 
 	if (ops->gc &&
 	    !(flags & DST_NOCOUNT) &&
-	    dst_entries_get_fast(ops) > ops->gc_thresh) {
-		if (ops->gc(ops)) {
-			pr_notice_ratelimited("Route cache is full: consider increasing sysctl net.ipv6.route.max_size.\n");
-			return NULL;
-		}
-	}
+	    dst_entries_get_fast(ops) > ops->gc_thresh)
+		ops->gc(ops);
 
 	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
 	if (!dst)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0f8d7786e8e8..9dbc9c0cbc5a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -92,7 +92,7 @@ static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
-static int		 ip6_dst_gc(struct dst_ops *ops);
+static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static int		ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -2767,11 +2767,10 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
 	return dst;
 }
 
-static int ip6_dst_gc(struct dst_ops *ops)
+static void ip6_dst_gc(struct dst_ops *ops)
 {
 	struct net *net = container_of(ops, struct net, ipv6.ip6_dst_ops);
 	int rt_min_interval = net->ipv6.sysctl.ip6_rt_gc_min_interval;
-	int rt_max_size = net->ipv6.sysctl.ip6_rt_max_size;
 	int rt_elasticity = net->ipv6.sysctl.ip6_rt_gc_elasticity;
 	int rt_gc_timeout = net->ipv6.sysctl.ip6_rt_gc_timeout;
 	unsigned long rt_last_gc = net->ipv6.ip6_rt_last_gc;
@@ -2779,11 +2778,10 @@ static int ip6_dst_gc(struct dst_ops *ops)
 	int entries;
 
 	entries = dst_entries_get_fast(ops);
-	if (entries > rt_max_size)
+	if (entries > ops->gc_thresh)
 		entries = dst_entries_get_slow(ops);
 
-	if (time_after(rt_last_gc + rt_min_interval, jiffies) &&
-	    entries <= rt_max_size)
+	if (time_after(rt_last_gc + rt_min_interval, jiffies))
 		goto out;
 
 	fib6_run_gc(atomic_inc_return(&net->ipv6.ip6_rt_gc_expire), net, true);
@@ -2793,7 +2791,6 @@ static int ip6_dst_gc(struct dst_ops *ops)
 out:
 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
-	return entries > rt_max_size;
 }
 
 static int ip6_convert_metrics(struct net *net, struct fib6_info *rt,
@@ -5336,7 +5333,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 #endif
 
 	net->ipv6.sysctl.flush_delay = 0;
-	net->ipv6.sysctl.ip6_rt_max_size = 4096;
+	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
 	net->ipv6.sysctl.ip6_rt_gc_interval = 30*HZ;
-- 
2.34.1


