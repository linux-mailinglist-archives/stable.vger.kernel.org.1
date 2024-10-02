Return-Path: <stable+bounces-78802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAA98D50D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C301C219AF
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDACF1D0486;
	Wed,  2 Oct 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RzQhldIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD51D0412;
	Wed,  2 Oct 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875573; cv=none; b=iF6hrCgGP8qPYK/3xsIMSxAgVIzA+3zWQ0Z2iPne4x2YY+lJyc6dy9wghRbse4e8GYY3ZyttI0+HiSU8m+wCAiCWe/bZODCLssAQYnq2BUdu3RHc3tEqDTnyBUClnqotuGv7cYXd3BkSSMYKjPcjTn67jNbYY9DnAvjSLfDtjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875573; c=relaxed/simple;
	bh=jiOV+O8mQH43nC+/kWrE4aKbBYaUmKXZ4myFPfrNxms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgUOI/PddK6U3IiF/L7OaW4rzYxHMixXkgMWrteUGGDLsb130dIUi5FH+6EClG85eC4Jl1UrTfca9GIvWSfLBop4p0IhhYDs9RP1ThOR+1dA17PsD+wDNnG7rbz06TbMP+ivNveN3b/lxxEUe2JW0xoaCiIMTWc4jLLS6xgSJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RzQhldIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105DDC4CECD;
	Wed,  2 Oct 2024 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875573;
	bh=jiOV+O8mQH43nC+/kWrE4aKbBYaUmKXZ4myFPfrNxms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzQhldIsOT0fGG9+RIKDAa1gjuCVPOw/i8ec2LBci/R5loS8KdVF5B/I29pvnnqn9
	 3s5StiJobGcZBMUARxvQB19hxvBUNOwdbOI279/1uAjWEi0JkWdnvvzINyCwe4lgOb
	 WstNy29b8pWYyRMFtqQzgdB7yQq5mjIo984aWkhc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 120/695] block, bfq: fix possible UAF for bfqq->bic with merge chain
Date: Wed,  2 Oct 2024 14:51:58 +0200
Message-ID: <20241002125827.262867738@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 18ad4df091dd5d067d2faa8fce1180b79f7041a7 ]

1) initial state, three tasks:

		Process 1       Process 2	Process 3
		 (BIC1)          (BIC2)		 (BIC3)
		  |  Λ            |  Λ		  |  Λ
		  |  |            |  |		  |  |
		  V  |            V  |		  V  |
		  bfqq1           bfqq2		  bfqq3
process ref:	   1		    1		    1

2) bfqq1 merged to bfqq2:

		Process 1       Process 2	Process 3
		 (BIC1)          (BIC2)		 (BIC3)
		  |               |		  |  Λ
		  \--------------\|		  |  |
		                  V		  V  |
		  bfqq1--------->bfqq2		  bfqq3
process ref:	   0		    2		    1

3) bfqq2 merged to bfqq3:

		Process 1       Process 2	Process 3
		 (BIC1)          (BIC2)		 (BIC3)
	 here -> Λ                |		  |
		  \--------------\ \-------------\|
		                  V		  V
		  bfqq1--------->bfqq2---------->bfqq3
process ref:	   0		    1		    3

In this case, IO from Process 1 will get bfqq2 from BIC1 first, and then
get bfqq3 through merge chain, and finially handle IO by bfqq3.
Howerver, current code will think bfqq2 is owned by BIC1, like initial
state, and set bfqq2->bic to BIC1.

bfq_insert_request
-> by Process 1
 bfqq = bfq_init_rq(rq)
  bfqq = bfq_get_bfqq_handle_split
   bfqq = bic_to_bfqq
   -> get bfqq2 from BIC1
 bfqq->ref++
 rq->elv.priv[0] = bic
 rq->elv.priv[1] = bfqq
 if (bfqq_process_refs(bfqq) == 1)
  bfqq->bic = bic
  -> record BIC1 to bfqq2

  __bfq_insert_request
   new_bfqq = bfq_setup_cooperator
   -> get bfqq3 from bfqq2->new_bfqq
   bfqq_request_freed(bfqq)
   new_bfqq->ref++
   rq->elv.priv[1] = new_bfqq
   -> handle IO by bfqq3

Fix the problem by checking bfqq is from merge chain fist. And this
might fix a following problem reported by our syzkaller(unreproducible):

==================================================================
BUG: KASAN: slab-use-after-free in bfq_do_early_stable_merge block/bfq-iosched.c:5692 [inline]
BUG: KASAN: slab-use-after-free in bfq_do_or_sched_stable_merge block/bfq-iosched.c:5805 [inline]
BUG: KASAN: slab-use-after-free in bfq_get_queue+0x25b0/0x2610 block/bfq-iosched.c:5889
Write of size 1 at addr ffff888123839eb8 by task kworker/0:1H/18595

CPU: 0 PID: 18595 Comm: kworker/0:1H Tainted: G             L     6.6.0-07439-gba2303cacfda #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Workqueue: kblockd blk_mq_requeue_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x10d/0x610 mm/kasan/report.c:475
 kasan_report+0x8e/0xc0 mm/kasan/report.c:588
 bfq_do_early_stable_merge block/bfq-iosched.c:5692 [inline]
 bfq_do_or_sched_stable_merge block/bfq-iosched.c:5805 [inline]
 bfq_get_queue+0x25b0/0x2610 block/bfq-iosched.c:5889
 bfq_get_bfqq_handle_split+0x169/0x5d0 block/bfq-iosched.c:6757
 bfq_init_rq block/bfq-iosched.c:6876 [inline]
 bfq_insert_request block/bfq-iosched.c:6254 [inline]
 bfq_insert_requests+0x1112/0x5cf0 block/bfq-iosched.c:6304
 blk_mq_insert_request+0x290/0x8d0 block/blk-mq.c:2593
 blk_mq_requeue_work+0x6bc/0xa70 block/blk-mq.c:1502
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
 worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305
 </TASK>

Allocated by task 20776:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:763 [inline]
 slab_alloc_node mm/slub.c:3458 [inline]
 kmem_cache_alloc_node+0x1a4/0x6f0 mm/slub.c:3503
 ioc_create_icq block/blk-ioc.c:370 [inline]
 ioc_find_get_icq+0x180/0xaa0 block/blk-ioc.c:436
 bfq_prepare_request+0x39/0xf0 block/bfq-iosched.c:6812
 blk_mq_rq_ctx_init.isra.7+0x6ac/0xa00 block/blk-mq.c:403
 __blk_mq_alloc_requests+0xcc0/0x1070 block/blk-mq.c:517
 blk_mq_get_new_requests block/blk-mq.c:2940 [inline]
 blk_mq_submit_bio+0x624/0x27c0 block/blk-mq.c:3042
 __submit_bio+0x331/0x6f0 block/blk-core.c:624
 __submit_bio_noacct_mq block/blk-core.c:703 [inline]
 submit_bio_noacct_nocheck+0x816/0xb40 block/blk-core.c:732
 submit_bio_noacct+0x7a6/0x1b50 block/blk-core.c:826
 xlog_write_iclog+0x7d5/0xa00 fs/xfs/xfs_log.c:1958
 xlog_state_release_iclog+0x3b8/0x720 fs/xfs/xfs_log.c:619
 xlog_cil_push_work+0x19c5/0x2270 fs/xfs/xfs_log_cil.c:1330
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
 worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305

Freed by task 946:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 __kasan_slab_free+0x12c/0x1c0 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1815 [inline]
 slab_free_freelist_hook mm/slub.c:1841 [inline]
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0x118/0x6f0 mm/slub.c:3808
 rcu_do_batch+0x35c/0xe30 kernel/rcu/tree.c:2189
 rcu_core+0x819/0xd90 kernel/rcu/tree.c:2462
 __do_softirq+0x1b0/0x7a2 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2712 [inline]
 call_rcu+0xce/0x1020 kernel/rcu/tree.c:2826
 ioc_destroy_icq+0x54c/0x830 block/blk-ioc.c:105
 ioc_release_fn+0xf0/0x360 block/blk-ioc.c:124
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
 worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305

Second to last potentially related work creation:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2712 [inline]
 call_rcu+0xce/0x1020 kernel/rcu/tree.c:2826
 ioc_destroy_icq+0x54c/0x830 block/blk-ioc.c:105
 ioc_release_fn+0xf0/0x360 block/blk-ioc.c:124
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
 worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305

The buggy address belongs to the object at ffff888123839d68
 which belongs to the cache bfq_io_cq of size 1360
The buggy address is located 336 bytes inside of
 freed 1360-byte region [ffff888123839d68, ffff88812383a2b8)

The buggy address belongs to the physical page:
page:ffffea00048e0e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88812383f588 pfn:0x123838
head:ffffea00048e0e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ffffc0000a40(workingset|slab|head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000a40 ffff88810588c200 ffffea00048ffa10 ffff888105889488
raw: ffff88812383f588 0000000000150006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888123839d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888123839e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888123839e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888123839f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888123839f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 36eca8948323 ("block, bfq: add Early Queue Merge (EQM)")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240902130329.3787024-2-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 36a4998c4b378..83adac3e71dbe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6934,7 +6934,8 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	 * addition, if the queue has also just been split, we have to
 	 * resume its state.
 	 */
-	if (likely(bfqq != &bfqd->oom_bfqq) && bfqq_process_refs(bfqq) == 1) {
+	if (likely(bfqq != &bfqd->oom_bfqq) && !bfqq->new_bfqq &&
+	    bfqq_process_refs(bfqq) == 1) {
 		bfqq->bic = bic;
 		if (split) {
 			/*
-- 
2.43.0




