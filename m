Return-Path: <stable+bounces-10613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0882C87B
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 01:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CC41C22A9C
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E54107A2;
	Sat, 13 Jan 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zc3ZEl/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F8F4FB
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705107331; x=1736643331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/ryUoyE7UX4DGy8qjyQj61fxwz5rbEErXetkJwBXUI=;
  b=Zc3ZEl/M0o0Y6pbzbbhN+YjIcLYZ/bQ18r2TcKKCTCeIj+IcAh83ptWt
   nEpnWaI3Ey1Q8ITrEceq0rsR+cUHW7OlGCj+NQx7SWLDwhK/yI84V2AEz
   YF+Nn3uavBp9JUAXIzgKpgW8TEXWL45GmS0SZC4E5KO6ZysFdSQL02vqt
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,191,1695686400"; 
   d="scan'208";a="389545043"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 00:55:30 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 8AAECA0AD9;
	Sat, 13 Jan 2024 00:55:29 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.200:2525] with esmtp (Farcaster)
 id 2e75b4e6-540f-45d6-91c9-bb2f5af267fe; Sat, 13 Jan 2024 00:55:29 +0000 (UTC)
X-Farcaster-Flow-ID: 2e75b4e6-540f-45d6-91c9-bb2f5af267fe
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:55:29 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.171.38) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:55:28 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <trawets@amazon.com>, <security@kernel.org>,
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>
Subject: [PATCH stable 4.19.x 3/4] ipv6: make ip6_rt_gc_expire an atomic_t
Date: Fri, 12 Jan 2024 16:53:07 -0800
Message-ID: <20240113005308.2422331-3-surajjs@amazon.com>
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
[ 4.19: context adjustment in include/net/netns/ipv6.h ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 4.19.x
---
 include/net/netns/ipv6.h |  4 ++--
 net/ipv6/route.c         | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index f0e396ab9bec..8f4d013fa05f 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -72,8 +72,8 @@ struct netns_ipv6 {
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
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d8944ae0171a..0f8d7786e8e8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2775,6 +2775,7 @@ static int ip6_dst_gc(struct dst_ops *ops)
 	int rt_elasticity = net->ipv6.sysctl.ip6_rt_gc_elasticity;
 	int rt_gc_timeout = net->ipv6.sysctl.ip6_rt_gc_timeout;
 	unsigned long rt_last_gc = net->ipv6.ip6_rt_last_gc;
+	unsigned int val;
 	int entries;
 
 	entries = dst_entries_get_fast(ops);
@@ -2785,13 +2786,13 @@ static int ip6_dst_gc(struct dst_ops *ops)
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
 
@@ -5343,7 +5344,7 @@ static int __net_init ip6_route_net_init(struct net *net)
 	net->ipv6.sysctl.ip6_rt_mtu_expires = 10*60*HZ;
 	net->ipv6.sysctl.ip6_rt_min_advmss = IPV6_MIN_MTU - 20 - 40;
 
-	net->ipv6.ip6_rt_gc_expire = 30*HZ;
+	atomic_set(&net->ipv6.ip6_rt_gc_expire, 30*HZ);
 
 	ret = 0;
 out:
-- 
2.34.1


