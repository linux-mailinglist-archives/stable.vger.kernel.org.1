Return-Path: <stable+bounces-10695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0169382CB3D
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8261C21B7E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A211846;
	Sat, 13 Jan 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyxgqpVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20553EC5;
	Sat, 13 Jan 2024 09:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950A3C433F1;
	Sat, 13 Jan 2024 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139833;
	bh=Gj/EXQuvxwGzwiIqBXUDuIGA4IqvOCJXdDi5YjpCXu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyxgqpVadHguYYGVhpNtarL7oqi2uXmNRLc0J5Ch5iardRM4z4FqnsWetFe5t4NfU
	 KgvSQ2vmK6FeGLcLLafhUO15xAMCNAjvEh+zdPYi/zdiqgt+lWjzy+Ux4UV0fvtQM8
	 v3zSDvwhPIZSmpmXvy2NbE2cvybaADvEeg/SREmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Jon Maxwell <jmaxwell37@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH 5.4 38/38] ipv6: remove max_size check inline with ipv4
Date: Sat, 13 Jan 2024 10:50:14 +0100
Message-ID: <20240113094207.620864763@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.455533180@linuxfoundation.org>
References: <20240113094206.455533180@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/dst_ops.h |    2 +-
 net/core/dst.c        |    8 ++------
 net/ipv6/route.c      |   13 +++++--------
 3 files changed, 8 insertions(+), 15 deletions(-)

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
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -83,12 +83,8 @@ void *dst_alloc(struct dst_ops *ops, str
 
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
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -88,7 +88,7 @@ static struct dst_entry *ip6_negative_ad
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
-static int		 ip6_dst_gc(struct dst_ops *ops);
+static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
 static int		ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -3207,11 +3207,10 @@ out:
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
@@ -3219,11 +3218,10 @@ static int ip6_dst_gc(struct dst_ops *op
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
@@ -3233,7 +3231,6 @@ static int ip6_dst_gc(struct dst_ops *op
 out:
 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
-	return entries > rt_max_size;
 }
 
 static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
@@ -6321,7 +6318,7 @@ static int __net_init ip6_route_net_init
 #endif
 
 	net->ipv6.sysctl.flush_delay = 0;
-	net->ipv6.sysctl.ip6_rt_max_size = 4096;
+	net->ipv6.sysctl.ip6_rt_max_size = INT_MAX;
 	net->ipv6.sysctl.ip6_rt_gc_min_interval = HZ / 2;
 	net->ipv6.sysctl.ip6_rt_gc_timeout = 60*HZ;
 	net->ipv6.sysctl.ip6_rt_gc_interval = 30*HZ;



