Return-Path: <stable+bounces-10694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AC82CB3C
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196BFB20E2B
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3A185A;
	Sat, 13 Jan 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t6JTNYwg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A61848;
	Sat, 13 Jan 2024 09:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8DEC433F1;
	Sat, 13 Jan 2024 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139830;
	bh=WtaJF7mnwuMK9hNr7F5tQUrsMFPEYqczTi0jJQd4bV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6JTNYwgCMxGlukRZ4p18Yw6N2s8v56h3cSsGZpwhdzdOdnU+rTE/9JN40qYOSWO/
	 iNrBc0UPd1x5sHnqcMlfTq34La1NNnc1oxw+1bRDfrpeM30paYM5JDdPp2c/rBBl6B
	 o/J0vC4Xu86duIDZZO4PV/ufvx1Ah6yptEk8B7b8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH 5.4 37/38] ipv6: make ip6_rt_gc_expire an atomic_t
Date: Sat, 13 Jan 2024 10:50:13 +0100
Message-ID: <20240113094207.590835711@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit 9cb7c013420f98fa6fd12fc6a5dc055170c108db upstream.

Reads and Writes to ip6_rt_gc_expire always have been racy,
as syzbot reported lately [1]

There is a possible risk of under-flow, leading
to unexpected high value passed to fib6_run_gc(),
although I have not observed this in the field.

Hosts hitting ip6_dst_gc() very hard are under pretty bad
state anyway.

[1]
BUG: KCSAN: data-race in ip6_dst_gc / ip6_dst_gc

read-write to 0xffff888102110744 of 4 bytes by task 13165 on cpu 1:
 ip6_dst_gc+0x1f3/0x220 net/ipv6/route.c:3311
 dst_alloc+0x9b/0x160 net/core/dst.c:86
 ip6_dst_alloc net/ipv6/route.c:344 [inline]
 icmp6_dst_alloc+0xb2/0x360 net/ipv6/route.c:3261
 mld_sendpack+0x2b9/0x580 net/ipv6/mcast.c:1807
 mld_send_cr net/ipv6/mcast.c:2119 [inline]
 mld_ifc_work+0x576/0x800 net/ipv6/mcast.c:2651
 process_one_work+0x3d3/0x720 kernel/workqueue.c:2289
 worker_thread+0x618/0xa70 kernel/workqueue.c:2436
 kthread+0x1a9/0x1e0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

read-write to 0xffff888102110744 of 4 bytes by task 11607 on cpu 0:
 ip6_dst_gc+0x1f3/0x220 net/ipv6/route.c:3311
 dst_alloc+0x9b/0x160 net/core/dst.c:86
 ip6_dst_alloc net/ipv6/route.c:344 [inline]
 icmp6_dst_alloc+0xb2/0x360 net/ipv6/route.c:3261
 mld_sendpack+0x2b9/0x580 net/ipv6/mcast.c:1807
 mld_send_cr net/ipv6/mcast.c:2119 [inline]
 mld_ifc_work+0x576/0x800 net/ipv6/mcast.c:2651
 process_one_work+0x3d3/0x720 kernel/workqueue.c:2289
 worker_thread+0x618/0xa70 kernel/workqueue.c:2436
 kthread+0x1a9/0x1e0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

value changed: 0x00000bb3 -> 0x00000ba9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 11607 Comm: kworker/0:21 Not tainted 5.18.0-rc1-syzkaller-00037-g42e7a03d3bad-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: mld mld_ifc_work

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20220413181333.649424-1-eric.dumazet@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ 5.4: context adjustment in include/net/netns/ipv6.h ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netns/ipv6.h |    4 ++--
 net/ipv6/route.c         |   11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -78,8 +78,8 @@ struct netns_ipv6 {
 	struct dst_ops		ip6_dst_ops;
 	rwlock_t		fib6_walker_lock;
 	spinlock_t		fib6_gc_lock;
-	unsigned int		 ip6_rt_gc_expire;
-	unsigned long		 ip6_rt_last_gc;
+	atomic_t		ip6_rt_gc_expire;
+	unsigned long		ip6_rt_last_gc;
 #ifdef CONFIG_IPV6_MULTIPLE_TABLES
 	unsigned int		fib6_rules_require_fldissect;
 	bool			fib6_has_custom_rules;
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3215,6 +3215,7 @@ static int ip6_dst_gc(struct dst_ops *op
 	int rt_elasticity = net->ipv6.sysctl.ip6_rt_gc_elasticity;
 	int rt_gc_timeout = net->ipv6.sysctl.ip6_rt_gc_timeout;
 	unsigned long rt_last_gc = net->ipv6.ip6_rt_last_gc;
+	unsigned int val;
 	int entries;
 
 	entries = dst_entries_get_fast(ops);
@@ -3225,13 +3226,13 @@ static int ip6_dst_gc(struct dst_ops *op
 	    entries <= rt_max_size)
 		goto out;
 
-	net->ipv6.ip6_rt_gc_expire++;
-	fib6_run_gc(net->ipv6.ip6_rt_gc_expire, net, true);
+	fib6_run_gc(atomic_inc_return(&net->ipv6.ip6_rt_gc_expire), net, true);
 	entries = dst_entries_get_slow(ops);
 	if (entries < ops->gc_thresh)
-		net->ipv6.ip6_rt_gc_expire = rt_gc_timeout>>1;
+		atomic_set(&net->ipv6.ip6_rt_gc_expire, rt_gc_timeout >> 1);
 out:
-	net->ipv6.ip6_rt_gc_expire -= net->ipv6.ip6_rt_gc_expire>>rt_elasticity;
+	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
+	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
 	return entries > rt_max_size;
 }
 
@@ -6329,7 +6330,7 @@ static int __net_init ip6_route_net_init
 	net->ipv6.sysctl.ip6_rt_min_advmss = IPV6_MIN_MTU - 20 - 40;
 	net->ipv6.sysctl.skip_notify_on_dev_down = 0;
 
-	net->ipv6.ip6_rt_gc_expire = 30*HZ;
+	atomic_set(&net->ipv6.ip6_rt_gc_expire, 30*HZ);
 
 	ret = 0;
 out:



