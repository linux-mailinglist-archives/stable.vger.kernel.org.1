Return-Path: <stable+bounces-200718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C53DCB2DE5
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AFEB301D654
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773DE1E9906;
	Wed, 10 Dec 2025 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="Z1SYZ5WI"
X-Original-To: stable@vger.kernel.org
Received: from out30-84.freemail.mail.aliyun.com (out30-84.freemail.mail.aliyun.com [115.124.30.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D65277CBF
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765368975; cv=none; b=iGpTrEvP2tytCAFSTrM6lg6xGUEuZC9bpzCbYhPjN27HQ3mYaLdXogehonm5FLOtIl4TDfk/kAvaKmLnAWNd9cUPfhnI8ITG6Yl3Z51jz3lqB8v8HDXPWLGUgZYuzQz+tv+dHYf0Fi3YewPOQl1QW8WzFmDZA6lbJJPAJn2WR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765368975; c=relaxed/simple;
	bh=FH+AmxQ73azXYNPJCbG3kWs7G6sIevlHceRqlJODigQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f0+TDNuUhcXDS7IHF+i859zCN9bl5PEaTPhCLJkZMYUY+P+vQZMXkwjSrZdIHAQeL1+7MIKiU30Jwl1d40KKKocOPBVJrA3emBRw47EDaRzy99d5R1BrP2vGZXV+9wFn+fPRFSYfr7QYi3L/3D6vt9XQiQVJKk5+9hNjeCOpLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=Z1SYZ5WI; arc=none smtp.client-ip=115.124.30.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1765368968; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=oRqqRD/ugCzkvoWwW0TRtd/4xk0lkbO/Cre0x1NnAvs=;
	b=Z1SYZ5WIq9nLAJ2vghu0npfj6Nh7e6gcrE1SlBRKBO+DHIi7GwYGuVkMES//grfJCrjo0VH0dcl7qrVEK2Hj7GfaKoB6rhSLmQl66RrckOiTWfJs8tPE+vLgwQNM2MrVC72ja7H9zPXSMbFa0wgzP6YrAH5NT3qqQ4Nj/GDjy00=
Received: from ubuntu24..(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0WuWgmCL_1765368965 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 20:16:08 +0800
From: ruohanlan@aliyun.com
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.1.y] page_pool: Fix use-after-free in page_pool_recycle_in_ring
Date: Wed, 10 Dec 2025 12:15:55 +0000
Message-ID: <20251210121555.5106-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit 271683bb2cf32e5126c592b5d5e6a756fa374fd9 ]

syzbot reported a uaf in page_pool_recycle_in_ring:

BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30 kernel/locking/lockdep.c:5862
Read of size 8 at addr ffff8880286045a0 by task syz.0.284/6943

CPU: 0 UID: 0 PID: 6943 Comm: syz.0.284 Not tainted 6.13.0-rc3-syzkaller-gdfa94ce54f41 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 lock_release+0x151/0xa30 kernel/locking/lockdep.c:5862
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:165 [inline]
 _raw_spin_unlock_bh+0x1b/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_produce_bh include/linux/ptr_ring.h:164 [inline]
 page_pool_recycle_in_ring net/core/page_pool.c:707 [inline]
 page_pool_put_unrefed_netmem+0x748/0xb00 net/core/page_pool.c:826
 page_pool_put_netmem include/net/page_pool/helpers.h:323 [inline]
 page_pool_put_full_netmem include/net/page_pool/helpers.h:353 [inline]
 napi_pp_put_page+0x149/0x2b0 net/core/skbuff.c:1036
 skb_pp_recycle net/core/skbuff.c:1047 [inline]
 skb_free_head net/core/skbuff.c:1094 [inline]
 skb_release_data+0x6c4/0x8a0 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1263 [inline]
 __skb_queue_purge_reason include/linux/skbuff.h:3343 [inline]

root cause is:

page_pool_recycle_in_ring
  ptr_ring_produce
    spin_lock(&r->producer_lock);
    WRITE_ONCE(r->queue[r->producer++], ptr)
      //recycle last page to pool
				page_pool_release
				  page_pool_scrub
				    page_pool_empty_ring
				      ptr_ring_consume
				      page_pool_return_page  //release all page
				  __page_pool_destroy
				     free_percpu(pool->recycle_stats);
				     free(pool) //free

     spin_unlock(&r->producer_lock); //pool->ring uaf read
  recycle_stat_inc(pool, ring);

page_pool can be free while page pool recycle the last page in ring.
Add producer-lock barrier to page_pool_release to prevent the page
pool from being free before all pages have been recycled.

recycle_stat_inc() is empty when CONFIG_PAGE_POOL_STATS is not
enabled, which will trigger Wempty-body build warning. Add definition
for pool stat macro to fix warning.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20250513083123.3514193-1-dongchenchen2@huawei.com
Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Reported-by: syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=204a4382fcb3311f3858
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250527114152.3119109-1-dongchenchen2@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor context change fixed. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 net/core/page_pool.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5c66092f9580..4a3abd86f8ce 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -128,9 +128,9 @@ u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 EXPORT_SYMBOL(page_pool_ethtool_stats_get);
 
 #else
-#define alloc_stat_inc(pool, __stat)
-#define recycle_stat_inc(pool, __stat)
-#define recycle_stat_add(pool, __stat, val)
+#define alloc_stat_inc(...)	do { } while (0)
+#define recycle_stat_inc(...)	do { } while (0)
+#define recycle_stat_add(...)	do { } while (0)
 #endif
 
 static bool page_pool_producer_lock(struct page_pool *pool)
@@ -539,19 +539,16 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 
 static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
-	int ret;
-	/* BH protection not needed if current is softirq */
-	if (in_softirq())
-		ret = ptr_ring_produce(&pool->ring, page);
-	else
-		ret = ptr_ring_produce_bh(&pool->ring, page);
+	bool in_softirq, ret;
 
-	if (!ret) {
+	/* BH protection not needed if current is softirq */
+	in_softirq = page_pool_producer_lock(pool);
+	ret = !__ptr_ring_produce(&pool->ring, page);
+	if (ret)
 		recycle_stat_inc(pool, ring);
-		return true;
-	}
+	page_pool_producer_unlock(pool, in_softirq);
 
-	return false;
+	return ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -826,10 +823,14 @@ static void page_pool_scrub(struct page_pool *pool)
 
 static int page_pool_release(struct page_pool *pool)
 {
+	bool in_softirq;
 	int inflight;
 
 	page_pool_scrub(pool);
 	inflight = page_pool_inflight(pool);
+	/* Acquire producer lock to make sure producers have exited. */
+	in_softirq = page_pool_producer_lock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 	if (!inflight)
 		page_pool_free(pool);
 
-- 
2.43.0


