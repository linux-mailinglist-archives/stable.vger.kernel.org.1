Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4372579ACB2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357925AbjIKWG4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjIKOTD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:19:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A7CC433C8;
        Mon, 11 Sep 2023 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441937;
        bh=WHBRju4HWUaL8iQEd4lRAsevW/5YEBDduatxMDhRRDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhCC1V/B8nr+6yCYpuKkGbT/3PVlRUrRxYDHtXeHuSyCkCPWixNkIdgJ+7m9J3C5x
         yprXVOo8Hi5mvc7DXS+Wu0R8VjLzxYvVrTL59FeLSUqqr7kvmXvkisLtQBoulnTdCg
         YP0v7lRE/WdknDKmilT92SM1Cp0KUhCkxukwPvbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 589/739] workqueue: fix data race with the pwq->stats[] increment
Date:   Mon, 11 Sep 2023 15:46:28 +0200
Message-ID: <20230911134707.553784108@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

[ Upstream commit fe48ba7daefe75bbbefa2426deddc05f2d530d2d ]

KCSAN has discovered a data race in kernel/workqueue.c:2598:

[ 1863.554079] ==================================================================
[ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_work

[ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu 27:
[ 1863.554154] process_one_work (kernel/workqueue.c:2598)
[ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[ 1863.554177] kthread (kernel/kthread.c:389)
[ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu 12:
[ 1863.554224] process_one_work (kernel/workqueue.c:2598)
[ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[ 1863.554247] kthread (kernel/kthread.c:389)
[ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a

[ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
[ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G             L     6.5.0-rc6+ #44
[ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[ 1863.554941] ==================================================================

    lockdep_invariant_state(true);
→   pwq->stats[PWQ_STAT_STARTED]++;
    trace_workqueue_execute_start(work);
    worker->current_func(work);

Moving pwq->stats[PWQ_STAT_STARTED]++; before the line

    raw_spin_unlock_irq(&pool->lock);

resolves the data race without performance penalty.

KCSAN detected at least one additional data race:

[  157.834751] ==================================================================
[  157.834770] BUG: KCSAN: data-race in process_one_work / process_one_work

[  157.834793] write to 0xffff9934453f77a0 of 8 bytes by task 468 on cpu 29:
[  157.834804] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606)
[  157.834815] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752)
[  157.834826] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389)
[  157.834834] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145)
[  157.834845] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312)

[  157.834859] read to 0xffff9934453f77a0 of 8 bytes by task 214 on cpu 7:
[  157.834868] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606)
[  157.834879] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752)
[  157.834890] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389)
[  157.834897] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145)
[  157.834907] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312)

[  157.834920] value changed: 0x000000000000052a -> 0x0000000000000532

[  157.834933] Reported by Kernel Concurrency Sanitizer on:
[  157.834941] CPU: 7 PID: 214 Comm: kworker/u64:2 Tainted: G             L     6.5.0-rc7-kcsan-00169-g81eaf55a60fc #4
[  157.834951] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  157.834958] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[  157.835567] ==================================================================

in code:

        trace_workqueue_execute_end(work, worker->current_func);
→       pwq->stats[PWQ_STAT_COMPLETED]++;
        lock_map_release(&lockdep_map);
        lock_map_release(&pwq->wq->lockdep_map);

which needs to be resolved separately.

Fixes: 725e8ec59c56c ("workqueue: Add pwq->stats[] and a monitoring script")
Cc: Tejun Heo <tj@kernel.org>
Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Link: https://lore.kernel.org/lkml/20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 800b4208dba9a..e51ab3d4765eb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2569,6 +2569,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id);
 
+	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
 
 	lock_map_acquire(&pwq->wq->lockdep_map);
@@ -2595,7 +2596,6 @@ __acquires(&pool->lock)
 	 * workqueues), so hiding them isn't a problem.
 	 */
 	lockdep_invariant_state(true);
-	pwq->stats[PWQ_STAT_STARTED]++;
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
-- 
2.40.1



