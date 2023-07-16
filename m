Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDE755141
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGPTyV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGPTyU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DE1BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B00660EAD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F98C433C7;
        Sun, 16 Jul 2023 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537255;
        bh=nsNeRXWzjwbd5lskmWsmwoiddw5fhmwQEs8JxjWWNzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdDgvJzJUGVveAb1lNjUkkaFg49cKYN/yGFH3JTwN7V9ektDYXusv3UuPwAcY5DRs
         Lp0+ZVSV2feMCAj1+HxzYV2O0BGyl8zb+tTHFZhpabpsyiQ7tYtRkTl9o72vKA5wB+
         c4nyQ5/RTMCh02PR8wKkzOZpYUH9o8pZbhg0HLrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 023/800] blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
Date:   Sun, 16 Jul 2023 21:37:56 +0200
Message-ID: <20230716194949.640677510@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit 8d211554679d0b23702bd32ba04aeac0c1c4f660 ]

adjust_inuse_and_calc_cost() use spin_lock_irq() and IRQ will be enabled
when unlock. DEADLOCK might happen if we have held other locks and disabled
IRQ before invoking it.

Fix it by using spin_lock_irqsave() instead, which can keep IRQ state
consistent with before when unlock.

  ================================
  WARNING: inconsistent lock state
  5.10.0-02758-g8e5f91fd772f #26 Not tainted
  --------------------------------
  inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
  kworker/2:3/388 [HC0[0]:SC0[0]:HE0:SE1] takes:
  ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: spin_lock_irq
  ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: bfq_bio_merge+0x141/0x390
  {IN-HARDIRQ-W} state was registered at:
    __lock_acquire+0x3d7/0x1070
    lock_acquire+0x197/0x4a0
    __raw_spin_lock_irqsave
    _raw_spin_lock_irqsave+0x3b/0x60
    bfq_idle_slice_timer_body
    bfq_idle_slice_timer+0x53/0x1d0
    __run_hrtimer+0x477/0xa70
    __hrtimer_run_queues+0x1c6/0x2d0
    hrtimer_interrupt+0x302/0x9e0
    local_apic_timer_interrupt
    __sysvec_apic_timer_interrupt+0xfd/0x420
    run_sysvec_on_irqstack_cond
    sysvec_apic_timer_interrupt+0x46/0xa0
    asm_sysvec_apic_timer_interrupt+0x12/0x20
  irq event stamp: 837522
  hardirqs last  enabled at (837521): [<ffffffff84b9419d>] __raw_spin_unlock_irqrestore
  hardirqs last  enabled at (837521): [<ffffffff84b9419d>] _raw_spin_unlock_irqrestore+0x3d/0x40
  hardirqs last disabled at (837522): [<ffffffff84b93fa3>] __raw_spin_lock_irq
  hardirqs last disabled at (837522): [<ffffffff84b93fa3>] _raw_spin_lock_irq+0x43/0x50
  softirqs last  enabled at (835852): [<ffffffff84e00558>] __do_softirq+0x558/0x8ec
  softirqs last disabled at (835845): [<ffffffff84c010ff>] asm_call_irq_on_stack+0xf/0x20

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&bfqd->lock);
    <Interrupt>
      lock(&bfqd->lock);

   *** DEADLOCK ***

  3 locks held by kworker/2:3/388:
   #0: ffff888107af0f38 ((wq_completion)kthrotld){+.+.}-{0:0}, at: process_one_work+0x742/0x13f0
   #1: ffff8881176bfdd8 ((work_completion)(&td->dispatch_work)){+.+.}-{0:0}, at: process_one_work+0x777/0x13f0
   #2: ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: spin_lock_irq
   #2: ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: bfq_bio_merge+0x141/0x390

  stack backtrace:
  CPU: 2 PID: 388 Comm: kworker/2:3 Not tainted 5.10.0-02758-g8e5f91fd772f #26
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  Workqueue: kthrotld blk_throtl_dispatch_work_fn
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x107/0x167
   print_usage_bug
   valid_state
   mark_lock_irq.cold+0x32/0x3a
   mark_lock+0x693/0xbc0
   mark_held_locks+0x9e/0xe0
   __trace_hardirqs_on_caller
   lockdep_hardirqs_on_prepare.part.0+0x151/0x360
   trace_hardirqs_on+0x5b/0x180
   __raw_spin_unlock_irq
   _raw_spin_unlock_irq+0x24/0x40
   spin_unlock_irq
   adjust_inuse_and_calc_cost+0x4fb/0x970
   ioc_rqos_merge+0x277/0x740
   __rq_qos_merge+0x62/0xb0
   rq_qos_merge
   bio_attempt_back_merge+0x12c/0x4a0
   blk_mq_sched_try_merge+0x1b6/0x4d0
   bfq_bio_merge+0x24a/0x390
   __blk_mq_sched_bio_merge+0xa6/0x460
   blk_mq_sched_bio_merge
   blk_mq_submit_bio+0x2e7/0x1ee0
   __submit_bio_noacct_mq+0x175/0x3b0
   submit_bio_noacct+0x1fb/0x270
   blk_throtl_dispatch_work_fn+0x1ef/0x2b0
   process_one_work+0x83e/0x13f0
   process_scheduled_works
   worker_thread+0x7e3/0xd80
   kthread+0x353/0x470
   ret_from_fork+0x1f/0x30

Fixes: b0853ab4a238 ("blk-iocost: revamp in-period donation snapbacks")
Signed-off-by: Li Nan <linan122@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230527091904.3001833-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 285ced3467abb..6084a9519883e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2455,6 +2455,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	u32 hwi, adj_step;
 	s64 margin;
 	u64 cost, new_inuse;
+	unsigned long flags;
 
 	current_hweight(iocg, NULL, &hwi);
 	old_hwi = hwi;
@@ -2473,11 +2474,11 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	    iocg->inuse == iocg->active)
 		return cost;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock_irqsave(&ioc->lock, flags);
 
 	/* we own inuse only when @iocg is in the normal active state */
 	if (iocg->abs_vdebt || list_empty(&iocg->active_list)) {
-		spin_unlock_irq(&ioc->lock);
+		spin_unlock_irqrestore(&ioc->lock, flags);
 		return cost;
 	}
 
@@ -2498,7 +2499,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	} while (time_after64(vtime + cost, now->vnow) &&
 		 iocg->inuse != iocg->active);
 
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock_irqrestore(&ioc->lock, flags);
 
 	TRACE_IOCG_PATH(inuse_adjust, iocg, now,
 			old_inuse, iocg->inuse, old_hwi, hwi);
-- 
2.39.2



