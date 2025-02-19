Return-Path: <stable+bounces-117727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1108EA3B7A5
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A54E7A550E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1BE1DE4D0;
	Wed, 19 Feb 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UryvKppU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3131D14FF
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956169; cv=none; b=HrPJ20VXRjqeTi1F85JfprxtPiFRhj23ar72C8oYVUTGK1K0r61nYqDfg4okD+04QQ0pXA96VoxQ+Ik1fcvD9HY/apVFmXAWdUe9bQjqBcgGNRbAL4FVKhaSjV0iBw7e73GV7+rWmiqV2D1E1dWhppHtxe1sS2fMlLRxPjNo2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956169; c=relaxed/simple;
	bh=KJOXxKdviK1n9YtV/2g8ZXgf9Th4YrG0dJ8H5a/bSYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr7NJuD2Nal0c+HPbTluxTETfpLRyPik9MorvcHmdDx13ABTszXfpCkayZ9VR4o1lN2F9mstGvGuJzCnebKvYifa8Hu9iBiZ/h2uEVhjnfWa8Mpu3j5SDY6P0vEej+AvqLJh6kXZO4A/yJB6HMvjILAFG98g5nLo60+VaBMxYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UryvKppU; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739956168; x=1771492168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zp38mG4JpDLNv7LJ1UritY7YAynfn3LBsTZybZKTamI=;
  b=UryvKppU7uiAgFPZw4p9mupa2jICaRWiIu8l/8Z7Gx4Wcy57Zn485KCL
   /qZ7vsejYnaFeViZbw7v3kQFhDN3oIQN76iRooeIc7gskekmIOdAMO0O3
   or0ZATofux62DGsnRy8Q7Iw/YdPUU6J6HPKsoPq8T3CZTzZdUemcA8bKq
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,298,1732579200"; 
   d="scan'208";a="409839941"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:09:22 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.0.204:44170]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.84.99:2525] with esmtp (Farcaster)
 id 01a35ad1-e63e-4e80-a236-78554e14b35b; Wed, 19 Feb 2025 09:09:20 +0000 (UTC)
X-Farcaster-Flow-ID: 01a35ad1-e63e-4e80-a236-78554e14b35b
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 19 Feb 2025 09:09:20 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 19 Feb 2025 09:09:20 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 7E2F5A015A;
	Wed, 19 Feb 2025 09:09:19 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 162EB20DC9; Wed, 19 Feb 2025 09:09:19 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>, Jan Kara
	<jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 6.1] block, bfq: fix bfqq uaf in bfq_limit_depth()
Date: Wed, 19 Feb 2025 09:09:02 +0000
Message-ID: <20250219090907.30462-2-hagarhem@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219090907.30462-1-hagarhem@amazon.com>
References: <20250219090907.30462-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
---
 block/bfq-iosched.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 76b2e66d09070..d1c62a4e8c357 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -581,23 +581,31 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
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
@@ -642,7 +650,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 			 * class.
 			 */
 			wsum = 0;
-			for (i = 0; i <= class_idx; i++) {
+			for (i = 0; i <= bfqq->ioprio_class - 1; i++) {
 				wsum = wsum * IOPRIO_BE_NR +
 					sched_data->service_tree[i].wsum;
 			}
@@ -665,7 +673,9 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
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
@@ -703,8 +713,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	}
 
 	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
-		struct bfq_queue *bfqq =
-			bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+		/* Fast path to check if bfqq is already allocated. */
+		if (!bic_to_bfqq(bic, op_is_sync(opf), act_idx))
+			continue;
 
 		/*
 		 * Does queue (or any parent entity) exceed number of
@@ -712,7 +723,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		 * limit depth so that it cannot consume more
 		 * available requests and thus starve other entities.
 		 */
-		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
+		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
 			depth = 1;
 			break;
 		}
-- 
2.47.1


