Return-Path: <stable+bounces-97278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386509E23CE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B817716992B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2B1F8ACD;
	Tue,  3 Dec 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDv3BYa8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4581F76D2;
	Tue,  3 Dec 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240024; cv=none; b=Z82MSzqno0QyDQJ1Qene6GmZmbZZ9nD+jd3lvhApPzAFiHtzDadtC2fofckbSiOdeDj6MNWjRZMN1UwpQqJctkdh7TZUlfPHyms0XA6FG6g4AiJ1nU/9T2+xfCeJKyXmO8gy0xhNEvnUZx7QGoCihVmsQTk7SvoMV+44VKvR4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240024; c=relaxed/simple;
	bh=KY84619X2yINXf4ap7r29ihPRcTkXdaWQFULf+5BUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAcQP0HGa+RhEJHTl71tyPFeo/dgTqqB4t+ZHCFfCw/rVIGHrCfc0esePvgvgR8bJ0UShBeBb/MzJF1lOqo3Z0Ax6q8oArxkZ/wLAKAdsaXnwuVkzqfm/iu9SWbLl/sn1wba7aC4O5M7VqzOfP0uoa7ByMznYaL0SKSDCzBb9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDv3BYa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4FDC4CECF;
	Tue,  3 Dec 2024 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240024;
	bh=KY84619X2yINXf4ap7r29ihPRcTkXdaWQFULf+5BUTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDv3BYa8J7pkwGP6RU9PcgbDznHu3tj+gD8NoRHOM4b2pxkMfJiVK7jtHd+6tbPpc
	 0uGKTjhhAxp8qIpFTD1WJwn0nTNk+myWvQhbqO8FDxN841uUNzTPzTV82uJx2AdxV4
	 2+4fokW92fygzSBDpNSNHYqJYLNQLGsT8SEvV5no=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 784/817] block: model freeze & enter queue as lock for supporting lockdep
Date: Tue,  3 Dec 2024 15:45:56 +0100
Message-ID: <20241203144026.615524426@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d ]

Recently we got several deadlock report[1][2][3] caused by
blk_mq_freeze_queue and blk_enter_queue().

Turns out the two are just like acquiring read/write lock, so model them
as read/write lock for supporting lockdep:

1) model q->q_usage_counter as two locks(io and queue lock)

- queue lock covers sync with blk_enter_queue()

- io lock covers sync with bio_enter_queue()

2) make the lockdep class/key as per-queue:

- different subsystem has very different lock use pattern, shared lock
 class causes false positive easily

- freeze_queue degrades to no lock in case that disk state becomes DEAD
  because bio_enter_queue() won't be blocked any more

- freeze_queue degrades to no lock in case that request queue becomes dying
  because blk_enter_queue() won't be blocked any more

3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
- it is exclusive lock, so dependency with blk_enter_queue() is covered

- it is trylock because blk_mq_freeze_queue() are allowed to run
  concurrently

4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
- nested blk_enter_queue() are allowed

- dependency with blk_mq_freeze_queue() is covered

- blk_queue_exit() is often called from other contexts(such as irq), and
it can't be annotated as lock_release(), so simply do it in
blk_enter_queue(), this way still covered cases as many as possible

With lockdep support, such kind of reports may be reported asap and
needn't wait until the real deadlock is triggered.

For example, lockdep report can be triggered in the report[3] with this
patch applied.

[1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
https://bugzilla.kernel.org/show_bug.cgi?id=219166

[2] del_gendisk() vs blk_queue_enter() race condition
https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/

[3] queue_freeze & queue_enter deadlock in scsi
https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241025003722.3630252-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 3802f73bd807 ("block: fix uaf for flush rq while iterating tags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c       | 18 ++++++++++++++++--
 block/blk-mq.c         | 26 ++++++++++++++++++++++----
 block/blk.h            | 29 ++++++++++++++++++++++++++---
 block/genhd.c          | 15 +++++++++++----
 include/linux/blkdev.h |  6 ++++++
 5 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc5e8c5eaac9f..09d10bb95fda0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -261,6 +261,8 @@ static void blk_free_queue(struct request_queue *q)
 		blk_mq_release(q);
 
 	ida_free(&blk_queue_ida, q->id);
+	lockdep_unregister_key(&q->io_lock_cls_key);
+	lockdep_unregister_key(&q->q_lock_cls_key);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
@@ -278,18 +280,20 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
-void blk_queue_start_drain(struct request_queue *q)
+bool blk_queue_start_drain(struct request_queue *q)
 {
 	/*
 	 * When queue DYING flag is set, we need to block new req
 	 * entering queue, so we call blk_freeze_queue_start() to
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
-	blk_freeze_queue_start(q);
+	bool freeze = __blk_freeze_queue_start(q);
 	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
 	/* Make blk_queue_enter() reexamine the DYING flag. */
 	wake_up_all(&q->mq_freeze_wq);
+
+	return freeze;
 }
 
 /**
@@ -321,6 +325,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 			return -ENODEV;
 	}
 
+	rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_release(&q->q_lockdep_map, _RET_IP_);
 	return 0;
 }
 
@@ -352,6 +358,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 			goto dead;
 	}
 
+	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_release(&q->io_lockdep_map, _RET_IP_);
 	return 0;
 dead:
 	bio_io_error(bio);
@@ -441,6 +449,12 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
 	if (error)
 		goto fail_stats;
+	lockdep_register_key(&q->io_lock_cls_key);
+	lockdep_register_key(&q->q_lock_cls_key);
+	lockdep_init_map(&q->io_lockdep_map, "&q->q_usage_counter(io)",
+			 &q->io_lock_cls_key, 0);
+	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
+			 &q->q_lock_cls_key, 0);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a2c40a97328b6..46e1cd2d1be8d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -120,17 +120,29 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 	inflight[1] = mi.inflight[1];
 }
 
-void blk_freeze_queue_start(struct request_queue *q)
+bool __blk_freeze_queue_start(struct request_queue *q)
 {
+	int freeze;
+
 	mutex_lock(&q->mq_freeze_lock);
 	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
+		freeze = true;
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
+		freeze = false;
 	}
+
+	return freeze;
+}
+
+void blk_freeze_queue_start(struct request_queue *q)
+{
+	if (__blk_freeze_queue_start(q))
+		blk_freeze_acquire_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
@@ -176,8 +188,10 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
+	int unfreeze = false;
+
 	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
 		q->q_usage_counter.data->force_atomic = true;
@@ -186,13 +200,17 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
+		unfreeze = true;
 	}
 	mutex_unlock(&q->mq_freeze_lock);
+
+	return unfreeze;
 }
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	__blk_mq_unfreeze_queue(q, false);
+	if (__blk_mq_unfreeze_queue(q, false))
+		blk_unfreeze_release_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
@@ -205,7 +223,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_freeze_queue_start_non_owner(struct request_queue *q)
 {
-	blk_freeze_queue_start(q);
+	__blk_freeze_queue_start(q);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
 
diff --git a/block/blk.h b/block/blk.h
index 61c2afa67daab..42f1d31d4649a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
 #include <linux/timekeeping.h>
@@ -35,8 +36,9 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
-void blk_queue_start_drain(struct request_queue *q);
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
+bool blk_queue_start_drain(struct request_queue *q);
+bool __blk_freeze_queue_start(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
 void bio_await_chain(struct bio *bio);
@@ -69,8 +71,11 @@ static inline int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
-	if (blk_try_enter_queue(q, false))
+	if (blk_try_enter_queue(q, false)) {
+		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 		return 0;
+	}
 	return __bio_queue_enter(q, bio);
 }
 
@@ -724,4 +729,22 @@ void blk_integrity_verify(struct bio *bio);
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
+static inline void blk_freeze_acquire_lock(struct request_queue *q, bool
+		disk_dead, bool queue_dying)
+{
+	if (!disk_dead)
+		rwsem_acquire(&q->io_lockdep_map, 0, 1, _RET_IP_);
+	if (!queue_dying)
+		rwsem_acquire(&q->q_lockdep_map, 0, 1, _RET_IP_);
+}
+
+static inline void blk_unfreeze_release_lock(struct request_queue *q, bool
+		disk_dead, bool queue_dying)
+{
+	if (!queue_dying)
+		rwsem_release(&q->q_lockdep_map, _RET_IP_);
+	if (!disk_dead)
+		rwsem_release(&q->io_lockdep_map, _RET_IP_);
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980b..6ad3fcde01105 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -581,13 +581,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 	rcu_read_unlock();
 }
 
-static void __blk_mark_disk_dead(struct gendisk *disk)
+static bool __blk_mark_disk_dead(struct gendisk *disk)
 {
 	/*
 	 * Fail any new I/O.
 	 */
 	if (test_and_set_bit(GD_DEAD, &disk->state))
-		return;
+		return false;
 
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
@@ -600,7 +600,7 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	/*
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
-	blk_queue_start_drain(disk->queue);
+	return blk_queue_start_drain(disk->queue);
 }
 
 /**
@@ -641,6 +641,7 @@ void del_gendisk(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct block_device *part;
 	unsigned long idx;
+	bool start_drain, queue_dying;
 
 	might_sleep();
 
@@ -668,7 +669,10 @@ void del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	__blk_mark_disk_dead(disk);
+	start_drain = __blk_mark_disk_dead(disk);
+	queue_dying = blk_queue_dying(q);
+	if (start_drain)
+		blk_freeze_acquire_lock(q, true, queue_dying);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
@@ -725,6 +729,9 @@ void del_gendisk(struct gendisk *disk)
 		if (queue_is_mq(q))
 			blk_mq_exit_queue(q);
 	}
+
+	if (start_drain)
+		blk_unfreeze_release_lock(q, true, queue_dying);
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 643c9020a35a6..a6e42a823b71e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 
 struct module;
 struct request_queue;
@@ -471,6 +472,11 @@ struct request_queue {
 	struct xarray		hctx_table;
 
 	struct percpu_ref	q_usage_counter;
+	struct lock_class_key	io_lock_cls_key;
+	struct lockdep_map	io_lockdep_map;
+
+	struct lock_class_key	q_lock_cls_key;
+	struct lockdep_map	q_lockdep_map;
 
 	struct request		*last_merge;
 
-- 
2.43.0




