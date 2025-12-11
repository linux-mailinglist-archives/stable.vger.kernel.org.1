Return-Path: <stable+bounces-200787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C17CB570A
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91174300160F
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EDA2D7DC3;
	Thu, 11 Dec 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="UyrxfyhM"
X-Original-To: stable@vger.kernel.org
Received: from out30-85.freemail.mail.aliyun.com (out30-85.freemail.mail.aliyun.com [115.124.30.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D410E3
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447321; cv=none; b=Te3CtOzvI3U4xaRj/pPdk3jUajGNsQKFTLahILSmyLH4eyw8gfCvoJQcXD5zJ2IsN+6akh79S+FjK6pOsejom2A3j4weP7cBHocYOBZEbLQa308T59XClvHf2VjksBb4JkioQtVpqQFcKVuwAZmjp09uaEsPhO3z3rEx01e/Zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447321; c=relaxed/simple;
	bh=4xiU96Q0mgniSBK16q6Db2db4DXy/nChG4MvI2E+XOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gx4ld8TWtDhAF2s1YQv8yYDYKzLnL7kk25DR2i0sqp7Z2pbZZi4Gg7PM4h8/78waQIsqMsBdDq5nNwkKhB28P0A+pBxsCiMPeL4NIjNXKce7orSn3+jDbQzRLz0L8VlXfp/3KiqLCVkrUduqeuSvN0+QCTmDtiHpX80zmUHgI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=UyrxfyhM; arc=none smtp.client-ip=115.124.30.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1765447316; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=nz75RabnrWvTTJG5T8I1UYfVWPn1mTQOyqairqY2PjM=;
	b=UyrxfyhMXL2nT4faS6sz0QyFqbLZy1CybHU+OXeursyLTpgl296cWGgx1xqusWI8ZSAp33MEj2sgD7KX5Or3yhYi9Ks8xpIx01M35MXvPMMAagxWbSReo0FSykNxm0Gff18lQkrm78Q/+CRHl9vqZrpKRZ0d1BcrMSKZkfqziO4=
Received: from ubuntu24..(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0Wua5IO7_1765447302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 18:01:55 +0800
From: ruohanlan@aliyun.com
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.15.y] page_pool: Fix use-after-free in page_pool_recycle_in_ring
Date: Thu, 11 Dec 2025 10:01:10 +0000
Message-ID: <20251211100110.4139-1-ruohanlan@aliyun.com>
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
[ Linux 5.15.y does not support page pool statistics
  (CONFIG_PAGE_POOL_STATS), so remove the related source code
  changes from the patch. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 net/core/page_pool.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4ec7e6229f69..b3047197a5e8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -414,14 +414,14 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 
 static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
-	int ret;
+	bool in_softirq, ret;
+
 	/* BH protection not needed if current is softirq */
-	if (in_softirq())
-		ret = ptr_ring_produce(&pool->ring, page);
-	else
-		ret = ptr_ring_produce_bh(&pool->ring, page);
+	in_softirq = page_pool_producer_lock(pool);
+	ret = !__ptr_ring_produce(&pool->ring, page);
+	page_pool_producer_unlock(pool, in_softirq);
 
-	return (ret == 0) ? true : false;
+	return ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -684,10 +684,14 @@ static void page_pool_scrub(struct page_pool *pool)
 
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


