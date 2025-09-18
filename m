Return-Path: <stable+bounces-173386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71481B35D4E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C712C1BA71E0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F4322A03;
	Tue, 26 Aug 2025 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYZ88V5T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEA32143D;
	Tue, 26 Aug 2025 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208113; cv=none; b=Nd0nLt4V9i/087Bo6a6gWImze2S9sEkufWqkwxRlmfh7AC5TWKWD6VkoWIFOyAHT9zswuJhN2Wc3zULccGk6dHY6lNE/VUjJ496+8mIAFf8JaRkcqLTdmI3pIvRpalhHQ5JMnqtJRZVlU6ABUXnzGe8MHPbEgwl52KRCtcGRWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208113; c=relaxed/simple;
	bh=F4HKLhPYH04mvXdbN540nHbpzTzGa3hTgjzoaKJS1Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsJzDEx9iKYD8vQPOXc5IPKTZLh+8sM4YOrolwLZhMAo4+exo1q7Gd7tThb9EahsBjT00J4NQI/GcUEQAPkgYRd0Mn1ILNW4+BmDYXLnA9EQCQYQXRrQlZowVb3lCXjKSW583LM4/uT0/zSkH6aaeaEWl+wFOogaPyOXHyr2gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYZ88V5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4059C4CEF1;
	Tue, 26 Aug 2025 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208113;
	bh=F4HKLhPYH04mvXdbN540nHbpzTzGa3hTgjzoaKJS1Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYZ88V5ThMka30YB+JVbA+O/jb/RWRoyX6DWNKUSSQKScgcFaxNM5E2XUb0fRuiJg
	 GVUyImp6mNOl15qyGOXZde6jGdGshH+f35bzRGW7upt+Np7SZQeCYBK8qyBrxGfCZQ
	 M7Wd7XDU1S0eu7jQXtCoxoAtM6osCtiQJMv2erSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Haberland <sth@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 442/457] block: fix potential deadlock while running nr_hw_queue update
Date: Tue, 26 Aug 2025 13:12:06 +0200
Message-ID: <20250826110948.209833042@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 04225d13aef11b2a539014def5e47d8c21fd74a5 ]

Move scheduler tags (sched_tags) allocation and deallocation outside
both the ->elevator_lock and ->freeze_lock when updating nr_hw_queues.
This change breaks the dependency chain from the percpu allocator lock
to the elevator lock, helping to prevent potential deadlocks, as
observed in the reported lockdep splat[1].

This commit introduces batch allocation and deallocation helpers for
sched_tags, which are now used from within __blk_mq_update_nr_hw_queues
routine while iterating through the tagset.

With this change, all sched_tags memory management is handled entirely
outside the ->elevator_lock and the ->freeze_lock context, thereby
eliminating the lock dependency that could otherwise manifest during
nr_hw_queues updates.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Reported-by: Stefan Haberland <sth@linux.ibm.com>
Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Link: https://lore.kernel.org/r/20250730074614.2537382-4-nilay@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 2d82f3bd8910 ("blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-sched.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h |  4 +++
 block/blk-mq.c       | 16 +++++++----
 block/blk.h          |  4 ++-
 block/elevator.c     | 15 ++++------
 5 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2d6d1ebdd8fb..e2ce4a28e6c9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -427,6 +427,32 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
 	kfree(et);
 }
 
+void blk_mq_free_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+	struct elevator_tags *et;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		/*
+		 * Accessing q->elevator without holding q->elevator_lock is
+		 * safe because we're holding here set->update_nr_hwq_lock in
+		 * the writer context. So, scheduler update/switch code (which
+		 * acquires the same lock but in the reader context) can't run
+		 * concurrently.
+		 */
+		if (q->elevator) {
+			et = xa_load(et_table, q->id);
+			if (unlikely(!et))
+				WARN_ON_ONCE(1);
+			else
+				blk_mq_free_sched_tags(et, set);
+		}
+	}
+}
+
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues)
 {
@@ -477,6 +503,45 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	return NULL;
 }
 
+int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
+{
+	struct request_queue *q;
+	struct elevator_tags *et;
+	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		/*
+		 * Accessing q->elevator without holding q->elevator_lock is
+		 * safe because we're holding here set->update_nr_hwq_lock in
+		 * the writer context. So, scheduler update/switch code (which
+		 * acquires the same lock but in the reader context) can't run
+		 * concurrently.
+		 */
+		if (q->elevator) {
+			et = blk_mq_alloc_sched_tags(set, nr_hw_queues);
+			if (!et)
+				goto out_unwind;
+			if (xa_insert(et_table, q->id, et, gfp))
+				goto out_free_tags;
+		}
+	}
+	return 0;
+out_free_tags:
+	blk_mq_free_sched_tags(et, set);
+out_unwind:
+	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
+		if (q->elevator) {
+			et = xa_load(et_table, q->id);
+			if (et)
+				blk_mq_free_sched_tags(et, set);
+		}
+	}
+	return -ENOMEM;
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 		struct elevator_tags *et)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0cde00cd1c47..b554e1d55950 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -25,8 +25,12 @@ void blk_mq_sched_free_rqs(struct request_queue *q);
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues);
+int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
+void blk_mq_free_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set);
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32d11305d51b..4cb2f5ca8656 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4972,12 +4972,13 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
  * Switch back to the elevator type stored in the xarray.
  */
 static void blk_mq_elv_switch_back(struct request_queue *q,
-		struct xarray *elv_tbl)
+		struct xarray *elv_tbl, struct xarray *et_tbl)
 {
 	struct elevator_type *e = xa_load(elv_tbl, q->id);
+	struct elevator_tags *t = xa_load(et_tbl, q->id);
 
 	/* The elv_update_nr_hw_queues unfreezes the queue. */
-	elv_update_nr_hw_queues(q, e);
+	elv_update_nr_hw_queues(q, e, t);
 
 	/* Drop the reference acquired in blk_mq_elv_switch_none. */
 	if (e)
@@ -5029,7 +5030,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
-	struct xarray elv_tbl;
+	struct xarray elv_tbl, et_tbl;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -5042,6 +5043,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	memflags = memalloc_noio_save();
 
+	xa_init(&et_tbl);
+	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
+		goto out_memalloc_restore;
+
 	xa_init(&elv_tbl);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5085,7 +5090,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(q, &elv_tbl);
+		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
@@ -5096,7 +5101,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 
 	xa_destroy(&elv_tbl);
-
+	xa_destroy(&et_tbl);
+out_memalloc_restore:
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 4746a7704856..5d9ca8c95193 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
+struct elevator_tags;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
@@ -322,7 +323,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e);
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *t);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index e9dc837b7b70..fe96c6f4753c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -705,7 +705,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *t)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
@@ -715,25 +716,21 @@ void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
 
 	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = e->elevator_name;
-		ctx.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
-		if (!ctx.et) {
-			WARN_ON_ONCE(1);
-			goto unfreeze;
-		}
+		ctx.et = t;
+
 		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
 		ret = elevator_switch(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
-unfreeze:
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 	/*
 	 * Free sched tags if it's allocated but we couldn't switch elevator.
 	 */
-	if (ctx.et && !ctx.new)
-		blk_mq_free_sched_tags(ctx.et, set);
+	if (t && !ctx.new)
+		blk_mq_free_sched_tags(t, set);
 }
 
 /*
-- 
2.50.1




