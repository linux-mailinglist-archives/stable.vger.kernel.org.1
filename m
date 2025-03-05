Return-Path: <stable+bounces-120539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B15A5073D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667187A7330
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8712505CF;
	Wed,  5 Mar 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uNJpwMnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F16ADD;
	Wed,  5 Mar 2025 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197255; cv=none; b=OOfqvhNqpGRP0hWpdjZcYpNJijmg+izXxOb0g5anSnPcsQkOUt8P14iG5qGB/cUwrMAbHa7mjKhDSioLfof9qlJi6h3XG+K9t/ujhHs4ib5kCmyL3rvmnv1cVDvBpCXUTybcYZHXqcU7pg77bxGcPr6Jqhclc0ZOj2pewT0e9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197255; c=relaxed/simple;
	bh=YTAV30ry9ZvLzhiwbdCh16ozQVdcvGRWVTqY/ly2fdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYifRXyecjB8Y3UQgiwr13PqmqjJu2VpeizD/0DukVdeGZkihkE9YRix7lFQHS4PfP0r2rPsjS+axPsGvDDmtZ0vuW++T2BuTOGc/Otn/a24WdP8OGes0JmdccYYz6YxvOVTLXi/ZL8TYTDWhg2Zyhs5MGIPnQazaDU0XMfGMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uNJpwMnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72257C4CEE2;
	Wed,  5 Mar 2025 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197253;
	bh=YTAV30ry9ZvLzhiwbdCh16ozQVdcvGRWVTqY/ly2fdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNJpwMnfDKVe5GPuHefATIXbIGwMm+rw7SmWYzB7k2CYGUUF/FtgdcPmje2dVtWYU
	 xGRj/sDeftlxHzX90qNxUw0+eDnu3kjOy/VMzRijy8yaTZdamV6vNeghly/zuL+h71
	 MQeN96BHyZTRv9shufF5O9QYiwG5EXRZJFOGZyOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Hagar Hemdan <hagarhem@amazon.com>
Subject: [PATCH 6.1 092/176] block, bfq: fix bfqq uaf in bfq_limit_depth()
Date: Wed,  5 Mar 2025 18:47:41 +0100
Message-ID: <20250305174509.158436282@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

commit e8b8344de3980709080d86c157d24e7de07d70ad upstream.

Set new allocated bfqq to bic or remove freed bfqq from bic are both
protected by bfqd->lock, however bfq_limit_depth() is deferencing bfqq
from bic without the lock, this can lead to UAF if the io_context is
shared by multiple tasks.

For example, test bfq with io_uring can trigger following UAF in v6.6:

==================================================================
BUG: KASAN: slab-use-after-free in bfqq_group+0x15/0x50

Call Trace:
 <TASK>
 dump_stack_lvl+0x47/0x80
 print_address_description.constprop.0+0x66/0x300
 print_report+0x3e/0x70
 kasan_report+0xb4/0xf0
 bfqq_group+0x15/0x50
 bfqq_request_over_limit+0x130/0x9a0
 bfq_limit_depth+0x1b5/0x480
 __blk_mq_alloc_requests+0x2b5/0xa00
 blk_mq_get_new_requests+0x11d/0x1d0
 blk_mq_submit_bio+0x286/0xb00
 submit_bio_noacct_nocheck+0x331/0x400
 __block_write_full_folio+0x3d0/0x640
 writepage_cb+0x3b/0xc0
 write_cache_pages+0x254/0x6c0
 write_cache_pages+0x254/0x6c0
 do_writepages+0x192/0x310
 filemap_fdatawrite_wbc+0x95/0xc0
 __filemap_fdatawrite_range+0x99/0xd0
 filemap_write_and_wait_range.part.0+0x4d/0xa0
 blkdev_read_iter+0xef/0x1e0
 io_read+0x1b6/0x8a0
 io_issue_sqe+0x87/0x300
 io_wq_submit_work+0xeb/0x390
 io_worker_handle_work+0x24d/0x550
 io_wq_worker+0x27f/0x6c0
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Allocated by task 808602:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_slab_alloc+0x83/0x90
 kmem_cache_alloc_node+0x1b1/0x6d0
 bfq_get_queue+0x138/0xfa0
 bfq_get_bfqq_handle_split+0xe3/0x2c0
 bfq_init_rq+0x196/0xbb0
 bfq_insert_request.isra.0+0xb5/0x480
 bfq_insert_requests+0x156/0x180
 blk_mq_insert_request+0x15d/0x440
 blk_mq_submit_bio+0x8a4/0xb00
 submit_bio_noacct_nocheck+0x331/0x400
 __blkdev_direct_IO_async+0x2dd/0x330
 blkdev_write_iter+0x39a/0x450
 io_write+0x22a/0x840
 io_issue_sqe+0x87/0x300
 io_wq_submit_work+0xeb/0x390
 io_worker_handle_work+0x24d/0x550
 io_wq_worker+0x27f/0x6c0
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1b/0x30

Freed by task 808589:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x27/0x40
 __kasan_slab_free+0x126/0x1b0
 kmem_cache_free+0x10c/0x750
 bfq_put_queue+0x2dd/0x770
 __bfq_insert_request.isra.0+0x155/0x7a0
 bfq_insert_request.isra.0+0x122/0x480
 bfq_insert_requests+0x156/0x180
 blk_mq_dispatch_plug_list+0x528/0x7e0
 blk_mq_flush_plug_list.part.0+0xe5/0x590
 __blk_flush_plug+0x3b/0x90
 blk_finish_plug+0x40/0x60
 do_writepages+0x19d/0x310
 filemap_fdatawrite_wbc+0x95/0xc0
 __filemap_fdatawrite_range+0x99/0xd0
 filemap_write_and_wait_range.part.0+0x4d/0xa0
 blkdev_read_iter+0xef/0x1e0
 io_read+0x1b6/0x8a0
 io_issue_sqe+0x87/0x300
 io_wq_submit_work+0xeb/0x390
 io_worker_handle_work+0x24d/0x550
 io_wq_worker+0x27f/0x6c0
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1b/0x30

Fix the problem by protecting bic_to_bfqq() with bfqd->lock.

CC: Jan Kara <jack@suse.cz>
Fixes: 76f1df88bbc2 ("bfq: Limit number of requests consumed by each cgroup")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20241129091509.2227136-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bfq-iosched.c |   37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -581,23 +581,31 @@ static struct request *bfq_choose_req(st
 #define BFQ_LIMIT_INLINE_DEPTH 16
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+static bool bfqq_request_over_limit(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic, blk_opf_t opf,
+				    unsigned int act_idx, int limit)
 {
-	struct bfq_data *bfqd = bfqq->bfqd;
-	struct bfq_entity *entity = &bfqq->entity;
 	struct bfq_entity *inline_entities[BFQ_LIMIT_INLINE_DEPTH];
 	struct bfq_entity **entities = inline_entities;
-	int depth, level, alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
-	int class_idx = bfqq->ioprio_class - 1;
+	int alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
 	struct bfq_sched_data *sched_data;
+	struct bfq_entity *entity;
+	struct bfq_queue *bfqq;
 	unsigned long wsum;
 	bool ret = false;
-
-	if (!entity->on_st_or_in_serv)
-		return false;
+	int depth;
+	int level;
 
 retry:
 	spin_lock_irq(&bfqd->lock);
+	bfqq = bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+	if (!bfqq)
+		goto out;
+
+	entity = &bfqq->entity;
+	if (!entity->on_st_or_in_serv)
+		goto out;
+
 	/* +1 for bfqq entity, root cgroup not included */
 	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
 	if (depth > alloc_depth) {
@@ -642,7 +650,7 @@ retry:
 			 * class.
 			 */
 			wsum = 0;
-			for (i = 0; i <= class_idx; i++) {
+			for (i = 0; i <= bfqq->ioprio_class - 1; i++) {
 				wsum = wsum * IOPRIO_BE_NR +
 					sched_data->service_tree[i].wsum;
 			}
@@ -665,7 +673,9 @@ out:
 	return ret;
 }
 #else
-static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+static bool bfqq_request_over_limit(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic, blk_opf_t opf,
+				    unsigned int act_idx, int limit)
 {
 	return false;
 }
@@ -703,8 +713,9 @@ static void bfq_limit_depth(blk_opf_t op
 	}
 
 	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
-		struct bfq_queue *bfqq =
-			bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+		/* Fast path to check if bfqq is already allocated. */
+		if (!bic_to_bfqq(bic, op_is_sync(opf), act_idx))
+			continue;
 
 		/*
 		 * Does queue (or any parent entity) exceed number of
@@ -712,7 +723,7 @@ static void bfq_limit_depth(blk_opf_t op
 		 * limit depth so that it cannot consume more
 		 * available requests and thus starve other entities.
 		 */
-		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
+		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
 			depth = 1;
 			break;
 		}



