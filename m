Return-Path: <stable+bounces-10610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248282C874
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 01:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D4B1F237ED
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D8107A6;
	Sat, 13 Jan 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S5PwQw6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C86F4FB
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705106620; x=1736642620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHlpdMtZPZlKg2xUMnyd509FHxLUqQfhW+WX8tKarUs=;
  b=S5PwQw6Wfh59tkLUSqmU0aOsJsvEkj1bIMPlwJpphZfMpX7leSxAg/7l
   urKe7gMKK4Es1s6n2FKPYyeI/yVM8a+smzh7zErqfvUjohXe7dRwZCSdN
   hba0sxNIlBjiHn41yzZDwRd9upclYE9msxiqd321PobBzW7aN2hNIYqrr
   A=;
X-IronPort-AV: E=Sophos;i="6.04,191,1695686400"; 
   d="scan'208";a="321425343"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 00:43:38 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 648151005FC;
	Sat, 13 Jan 2024 00:43:36 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:51305]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.54:2525] with esmtp (Farcaster)
 id e12ff9c0-7db3-48ad-bdc2-67597fe5dcc5; Sat, 13 Jan 2024 00:43:36 +0000 (UTC)
X-Farcaster-Flow-ID: e12ff9c0-7db3-48ad-bdc2-67597fe5dcc5
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:43:35 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.171.38) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:43:35 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <trawets@amazon.com>, <security@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>
Subject: [PATCH stable 5.4.x 1/3] net/dst: use a smaller percpu_counter batch for dst entries accounting
Date: Fri, 12 Jan 2024 16:42:52 -0800
Message-ID: <20240113004254.2416044-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024011155-gruffly-chunk-e186@gregkh>
References: <2024011155-gruffly-chunk-e186@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)

From: Eric Dumazet <edumazet@google.com>

commit cf86a086a18095e33e0637cb78cda1fcf5280852 upstream.

percpu_counter_add() uses a default batch size which is quite big
on platforms with 256 cpus. (2*256 -> 512)

This means dst_entries_get_fast() can be off by +/- 2*(nr_cpus^2)
(131072 on servers with 256 cpus)

Reduce the batch size to something more reasonable, and
add logic to ip6_dst_gc() to call dst_entries_get_slow()
before calling the _very_ expensive fib6_run_gc() function.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 5.4.x
---
 include/net/dst_ops.h | 4 +++-
 net/core/dst.c        | 8 ++++----
 net/ipv6/route.c      | 3 +++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 443863c7b8da..88ff7bb2bb9b 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -53,9 +53,11 @@ static inline int dst_entries_get_slow(struct dst_ops *dst)
 	return percpu_counter_sum_positive(&dst->pcpuc_entries);
 }
 
+#define DST_PERCPU_COUNTER_BATCH 32
 static inline void dst_entries_add(struct dst_ops *dst, int val)
 {
-	percpu_counter_add(&dst->pcpuc_entries, val);
+	percpu_counter_add_batch(&dst->pcpuc_entries, val,
+				 DST_PERCPU_COUNTER_BATCH);
 }
 
 static inline int dst_entries_init(struct dst_ops *dst)
diff --git a/net/core/dst.c b/net/core/dst.c
index 193af526e908..d6b6ced0d451 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -81,11 +81,11 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 {
 	struct dst_entry *dst;
 
-	if (ops->gc && dst_entries_get_fast(ops) > ops->gc_thresh) {
+	if (ops->gc &&
+	    !(flags & DST_NOCOUNT) &&
+	    dst_entries_get_fast(ops) > ops->gc_thresh) {
 		if (ops->gc(ops)) {
-			printk_ratelimited(KERN_NOTICE "Route cache is full: "
-					   "consider increasing sysctl "
-					   "net.ipv[4|6].route.max_size.\n");
+			pr_notice_ratelimited("Route cache is full: consider increasing sysctl net.ipv6.route.max_size.\n");
 			return NULL;
 		}
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 209d52ebbd19..c38e421ca783 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3218,6 +3218,9 @@ static int ip6_dst_gc(struct dst_ops *ops)
 	int entries;
 
 	entries = dst_entries_get_fast(ops);
+	if (entries > rt_max_size)
+		entries = dst_entries_get_slow(ops);
+
 	if (time_after(rt_last_gc + rt_min_interval, jiffies) &&
 	    entries <= rt_max_size)
 		goto out;
-- 
2.34.1


