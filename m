Return-Path: <stable+bounces-99826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6D9E739B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A05F16AB11
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92A20B81D;
	Fri,  6 Dec 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X1cw9+iS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD559207E0C;
	Fri,  6 Dec 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498481; cv=none; b=o/3GKxPKzWn/pcURPS5f0Es0KIOtsRZ6odSoEYw4F+6Rjs4DWG8D5QKn3PAQA1KhdTZzYJdgCb48oxLNpwj0YcU8aDcSrF86StR00Lhj938TLibTEhFHxPXxwtA7ejYCg1AJkosd+uY7IAdYmUMCfy/0KS7mjdTjYBpNqZIm6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498481; c=relaxed/simple;
	bh=38f1Gr8xH7zXe00+2hYi5ISKbgIYI8XvFBgiGC2Jpes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGvNFeg9fD+iw+UcksssFJ61IKAbBHK+m18eHvDot1DWfC17D1GX4DCGc5l+HlPCFCf2YUAue/EkMNnBXjh3tbl1r3IUUNabgc0sIk5PDgnBeOJsIQTLqBdCwY28wIAn0cuXY8DVJvoCJBe2umRY5MTBFQo9v0O7BwkiYTlXuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X1cw9+iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C07C4CED1;
	Fri,  6 Dec 2024 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498480;
	bh=38f1Gr8xH7zXe00+2hYi5ISKbgIYI8XvFBgiGC2Jpes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1cw9+iSuieBsXjp0w2CDK9QIyTruLU0ZwQ5c7L++qtEIbdHspKt3iBa3H5I+EpG9
	 2ot1y5R5NdSY3U572QtDU3czK/z9VlxLWsqg7NB2KzgXiWH1K6ufi8cYwlTafQ7lu0
	 CxEm09XHK9z0y9/IiGJZtSeRrLoYV7AxkGxqTj2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 598/676] block, bfq: fix bfqq uaf in bfq_limit_depth()
Date: Fri,  6 Dec 2024 15:36:57 +0100
Message-ID: <20241206143716.729136881@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e8b8344de3980709080d86c157d24e7de07d70ad ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7e0dcded5713a..dd8ca3f7ba60a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -582,23 +582,31 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
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
@@ -643,7 +651,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 			 * class.
 			 */
 			wsum = 0;
-			for (i = 0; i <= class_idx; i++) {
+			for (i = 0; i <= bfqq->ioprio_class - 1; i++) {
 				wsum = wsum * IOPRIO_BE_NR +
 					sched_data->service_tree[i].wsum;
 			}
@@ -666,7 +674,9 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
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
@@ -704,8 +714,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	}
 
 	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
-		struct bfq_queue *bfqq =
-			bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+		/* Fast path to check if bfqq is already allocated. */
+		if (!bic_to_bfqq(bic, op_is_sync(opf), act_idx))
+			continue;
 
 		/*
 		 * Does queue (or any parent entity) exceed number of
@@ -713,7 +724,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		 * limit depth so that it cannot consume more
 		 * available requests and thus starve other entities.
 		 */
-		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
+		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
 			depth = 1;
 			break;
 		}
-- 
2.43.0




