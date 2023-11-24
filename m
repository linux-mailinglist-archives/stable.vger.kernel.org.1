Return-Path: <stable+bounces-957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB177F7D51
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2435B20A54
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBE39FE9;
	Fri, 24 Nov 2023 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LLXB/UOJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DB381D4;
	Fri, 24 Nov 2023 18:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF110C433C9;
	Fri, 24 Nov 2023 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850202;
	bh=YwVjVRWSp/d/V6p0uy9SgL+dXozz8xe9oDdttFgRdoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLXB/UOJynCGFcvmeZ8PJpnrLMqxPeZbSBy8MAXmA4m/GYmaJhCpEd3fHp2t//VwH
	 JMkeShyjgOxFSs6+B5UCjRMaOh44v2/NgYNxAV5jS9kkN6U9TnHZtz3u/S5yFInkJC
	 Tfy1pWIMwHi/KzfA42OiOlESh/eqmKA5fWNGRs9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.6 462/530] dm-bufio: fix no-sleep mode
Date: Fri, 24 Nov 2023 17:50:28 +0000
Message-ID: <20231124172042.143077590@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 2a695062a5a42aead8c539a344168d4806b3fda2 upstream.

dm-bufio has a no-sleep mode. When activated (with the
DM_BUFIO_CLIENT_NO_SLEEP flag), the bufio client is read-only and we
could call dm_bufio_get from tasklets. This is used by dm-verity.

Unfortunately, commit 450e8dee51aa ("dm bufio: improve concurrent IO
performance") broke this and the kernel would warn that cache_get()
was calling down_read() from no-sleeping context. The bug can be
reproduced by using "veritysetup open" with the "--use-tasklets"
flag.

This commit fixes dm-bufio, so that the tasklet mode works again, by
expanding use of the 'no_sleep_enabled' static_key to conditionally
use either a rw_semaphore or rwlock_t (which are colocated in the
buffer_tree structure using a union).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v6.4
Fixes: 450e8dee51aa ("dm bufio: improve concurrent IO performance")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-bufio.c |   87 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 25 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -254,7 +254,7 @@ enum evict_result {
 
 typedef enum evict_result (*le_predicate)(struct lru_entry *le, void *context);
 
-static struct lru_entry *lru_evict(struct lru *lru, le_predicate pred, void *context)
+static struct lru_entry *lru_evict(struct lru *lru, le_predicate pred, void *context, bool no_sleep)
 {
 	unsigned long tested = 0;
 	struct list_head *h = lru->cursor;
@@ -295,7 +295,8 @@ static struct lru_entry *lru_evict(struc
 
 		h = h->next;
 
-		cond_resched();
+		if (!no_sleep)
+			cond_resched();
 	}
 
 	return NULL;
@@ -382,7 +383,10 @@ struct dm_buffer {
  */
 
 struct buffer_tree {
-	struct rw_semaphore lock;
+	union {
+		struct rw_semaphore lock;
+		rwlock_t spinlock;
+	} u;
 	struct rb_root root;
 } ____cacheline_aligned_in_smp;
 
@@ -393,9 +397,12 @@ struct dm_buffer_cache {
 	 * on the locks.
 	 */
 	unsigned int num_locks;
+	bool no_sleep;
 	struct buffer_tree trees[];
 };
 
+static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
+
 static inline unsigned int cache_index(sector_t block, unsigned int num_locks)
 {
 	return dm_hash_locks_index(block, num_locks);
@@ -403,22 +410,34 @@ static inline unsigned int cache_index(s
 
 static inline void cache_read_lock(struct dm_buffer_cache *bc, sector_t block)
 {
-	down_read(&bc->trees[cache_index(block, bc->num_locks)].lock);
+	if (static_branch_unlikely(&no_sleep_enabled) && bc->no_sleep)
+		read_lock_bh(&bc->trees[cache_index(block, bc->num_locks)].u.spinlock);
+	else
+		down_read(&bc->trees[cache_index(block, bc->num_locks)].u.lock);
 }
 
 static inline void cache_read_unlock(struct dm_buffer_cache *bc, sector_t block)
 {
-	up_read(&bc->trees[cache_index(block, bc->num_locks)].lock);
+	if (static_branch_unlikely(&no_sleep_enabled) && bc->no_sleep)
+		read_unlock_bh(&bc->trees[cache_index(block, bc->num_locks)].u.spinlock);
+	else
+		up_read(&bc->trees[cache_index(block, bc->num_locks)].u.lock);
 }
 
 static inline void cache_write_lock(struct dm_buffer_cache *bc, sector_t block)
 {
-	down_write(&bc->trees[cache_index(block, bc->num_locks)].lock);
+	if (static_branch_unlikely(&no_sleep_enabled) && bc->no_sleep)
+		write_lock_bh(&bc->trees[cache_index(block, bc->num_locks)].u.spinlock);
+	else
+		down_write(&bc->trees[cache_index(block, bc->num_locks)].u.lock);
 }
 
 static inline void cache_write_unlock(struct dm_buffer_cache *bc, sector_t block)
 {
-	up_write(&bc->trees[cache_index(block, bc->num_locks)].lock);
+	if (static_branch_unlikely(&no_sleep_enabled) && bc->no_sleep)
+		write_unlock_bh(&bc->trees[cache_index(block, bc->num_locks)].u.spinlock);
+	else
+		up_write(&bc->trees[cache_index(block, bc->num_locks)].u.lock);
 }
 
 /*
@@ -442,18 +461,32 @@ static void lh_init(struct lock_history
 
 static void __lh_lock(struct lock_history *lh, unsigned int index)
 {
-	if (lh->write)
-		down_write(&lh->cache->trees[index].lock);
-	else
-		down_read(&lh->cache->trees[index].lock);
+	if (lh->write) {
+		if (static_branch_unlikely(&no_sleep_enabled) && lh->cache->no_sleep)
+			write_lock_bh(&lh->cache->trees[index].u.spinlock);
+		else
+			down_write(&lh->cache->trees[index].u.lock);
+	} else {
+		if (static_branch_unlikely(&no_sleep_enabled) && lh->cache->no_sleep)
+			read_lock_bh(&lh->cache->trees[index].u.spinlock);
+		else
+			down_read(&lh->cache->trees[index].u.lock);
+	}
 }
 
 static void __lh_unlock(struct lock_history *lh, unsigned int index)
 {
-	if (lh->write)
-		up_write(&lh->cache->trees[index].lock);
-	else
-		up_read(&lh->cache->trees[index].lock);
+	if (lh->write) {
+		if (static_branch_unlikely(&no_sleep_enabled) && lh->cache->no_sleep)
+			write_unlock_bh(&lh->cache->trees[index].u.spinlock);
+		else
+			up_write(&lh->cache->trees[index].u.lock);
+	} else {
+		if (static_branch_unlikely(&no_sleep_enabled) && lh->cache->no_sleep)
+			read_unlock_bh(&lh->cache->trees[index].u.spinlock);
+		else
+			up_read(&lh->cache->trees[index].u.lock);
+	}
 }
 
 /*
@@ -502,14 +535,18 @@ static struct dm_buffer *list_to_buffer(
 	return le_to_buffer(le);
 }
 
-static void cache_init(struct dm_buffer_cache *bc, unsigned int num_locks)
+static void cache_init(struct dm_buffer_cache *bc, unsigned int num_locks, bool no_sleep)
 {
 	unsigned int i;
 
 	bc->num_locks = num_locks;
+	bc->no_sleep = no_sleep;
 
 	for (i = 0; i < bc->num_locks; i++) {
-		init_rwsem(&bc->trees[i].lock);
+		if (no_sleep)
+			rwlock_init(&bc->trees[i].u.spinlock);
+		else
+			init_rwsem(&bc->trees[i].u.lock);
 		bc->trees[i].root = RB_ROOT;
 	}
 
@@ -648,7 +685,7 @@ static struct dm_buffer *__cache_evict(s
 	struct lru_entry *le;
 	struct dm_buffer *b;
 
-	le = lru_evict(&bc->lru[list_mode], __evict_pred, &w);
+	le = lru_evict(&bc->lru[list_mode], __evict_pred, &w, bc->no_sleep);
 	if (!le)
 		return NULL;
 
@@ -702,7 +739,7 @@ static void __cache_mark_many(struct dm_
 	struct evict_wrapper w = {.lh = lh, .pred = pred, .context = context};
 
 	while (true) {
-		le = lru_evict(&bc->lru[old_mode], __evict_pred, &w);
+		le = lru_evict(&bc->lru[old_mode], __evict_pred, &w, bc->no_sleep);
 		if (!le)
 			break;
 
@@ -915,10 +952,11 @@ static void cache_remove_range(struct dm
 {
 	unsigned int i;
 
+	BUG_ON(bc->no_sleep);
 	for (i = 0; i < bc->num_locks; i++) {
-		down_write(&bc->trees[i].lock);
+		down_write(&bc->trees[i].u.lock);
 		__remove_range(bc, &bc->trees[i].root, begin, end, pred, release);
-		up_write(&bc->trees[i].lock);
+		up_write(&bc->trees[i].u.lock);
 	}
 }
 
@@ -979,8 +1017,6 @@ struct dm_bufio_client {
 	struct dm_buffer_cache cache; /* must be last member */
 };
 
-static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
-
 /*----------------------------------------------------------------*/
 
 #define dm_bufio_in_request()	(!!current->bio_list)
@@ -1871,7 +1907,8 @@ static void *new_read(struct dm_bufio_cl
 	if (need_submit)
 		submit_io(b, REQ_OP_READ, read_endio);
 
-	wait_on_bit_io(&b->state, B_READING, TASK_UNINTERRUPTIBLE);
+	if (nf != NF_GET)	/* we already tested this condition above */
+		wait_on_bit_io(&b->state, B_READING, TASK_UNINTERRUPTIBLE);
 
 	if (b->read_error) {
 		int error = blk_status_to_errno(b->read_error);
@@ -2421,7 +2458,7 @@ struct dm_bufio_client *dm_bufio_client_
 		r = -ENOMEM;
 		goto bad_client;
 	}
-	cache_init(&c->cache, num_locks);
+	cache_init(&c->cache, num_locks, (flags & DM_BUFIO_CLIENT_NO_SLEEP) != 0);
 
 	c->bdev = bdev;
 	c->block_size = block_size;



