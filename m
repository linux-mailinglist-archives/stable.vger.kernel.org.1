Return-Path: <stable+bounces-126364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEAA6FFEE
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AAB7A30FF
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71290267F7A;
	Tue, 25 Mar 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+sh5f2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB362561A2;
	Tue, 25 Mar 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906087; cv=none; b=VQWdIK1ppn0YDLZVO9ScHIErksXNr/lf2/PFTZ/8tLFB7E1lzc/frB5B7QpZ+6LglP6WkTt0QV0cG1kpXNkR7vav2GpaTHLYSN6Bu57112bcxS4AToXYkNojEu2nYBgTCDxRziihu79C8kOxXTvMm09yQrkBXyKmPNfsbdrYj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906087; c=relaxed/simple;
	bh=ggTdI8wdnXbEyaBH2E89geFD7lUEw1bcCoCKRkD82AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axXBd0i6fIzLb6KXwLewMpLgmUZboxAVWhH/i4UMwFwvwhLEXvnW9CkiHAh9/ifqL0L017hlsu6Uh6kLVmboiuU9UILM55vNwRowiPpCJu64pdXd4Og7+1nWF++8fg3/ePdrSIGz3zp62qsgMkYQnIACHWCXI1xnjFM0/qOQf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+sh5f2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C725FC4CEE4;
	Tue, 25 Mar 2025 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906087;
	bh=ggTdI8wdnXbEyaBH2E89geFD7lUEw1bcCoCKRkD82AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+sh5f2Bf7UISU5lNzyCQRWzin9trq3CcYi36HHuWKchD+CwKgnfYQ7P7ydh4n41z
	 4K1khAipfhhT3A3bDO1NPVm9YrfToZuF7ClzD7ymF+FPCCrM7zJYNSCfMvqIdTznaS
	 4VxXSOztLI1hOIHWdyF5HJCIunI1hKHdUl6kMu+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Hagar Hemdan <hagarhem@amazon.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.13 118/119] Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
Date: Tue, 25 Mar 2025 08:22:56 -0400
Message-ID: <20250325122152.071071355@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

commit 76f970ce51c80f625eb6ddbb24e9cb51b977b598 upstream.

This reverts commit eff6c8ce8d4d7faef75f66614dd20bb50595d261.

Hazem reported a 30% drop in UnixBench spawn test with commit
eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
(aarch64) (single level MC sched domain):

  https://lkml.kernel.org/r/20250205151026.13061-1-hagarhem@amazon.com

There is an early bail from sched_move_task() if p->sched_task_group is
equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
(Ubuntu '22.04.5 LTS').

So in:

  do_exit()

    sched_autogroup_exit_task()

      sched_move_task()

        if sched_get_task_group(p) == p->sched_task_group
          return

        /* p is enqueued */
        dequeue_task()              \
        sched_change_group()        |
          task_change_group_fair()  |
            detach_task_cfs_rq()    |                              (1)
            set_task_rq()           |
            attach_task_cfs_rq()    |
        enqueue_task()              /

(1) isn't called for p anymore.

Turns out that the regression is related to sgs->group_util in
group_is_overloaded() and group_has_capacity(). If (1) isn't called for
all the 'spawn' tasks then sgs->group_util is ~900 and
sgs->group_capacity = 1024 (single CPU sched domain) and this leads to
group_is_overloaded() returning true (2) and group_has_capacity() false
(3) much more often compared to the case when (1) is called.

I.e. there are much more cases of 'group_is_overloaded' and
'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
then returns much more often a CPU != smp_processor_id() (5).

This isn't good for these extremely short running tasks (FORK + EXIT)
and also involves calling sched_balance_find_dst_group_cpu() unnecessary
(single CPU sched domain).

Instead if (1) is called for 'p->flags & PF_EXITING' then the path
(4),(6) is taken much more often.

  select_task_rq_fair(..., wake_flags = WF_FORK)

    cpu = smp_processor_id()

    new_cpu = sched_balance_find_dst_cpu(..., cpu, ...)

      group = sched_balance_find_dst_group(..., cpu)

        do {

          update_sg_wakeup_stats()

            sgs->group_type = group_classify()

              if group_is_overloaded()                             (2)
                return group_overloaded

              if !group_has_capacity()                             (3)
                return group_fully_busy

              return group_has_spare                               (4)

        } while group

        if local_sgs.group_type > idlest_sgs.group_type
          return idlest                                            (5)

        case group_has_spare:

          if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
            return NULL                                            (6)

Unixbench Tests './Run -c 4 spawn' on:

(a) VM AWS instance (m7gd.16xlarge) with v6.13 ('maxcpus=4 nr_cpus=4')
    and Ubuntu 22.04.5 LTS (aarch64).

    Shell & test run in '/user.slice/user-1000.slice/session-1.scope'.

    w/o patch	w/ patch
    21005	27120

(b) i7-13700K with tip/sched/core ('nosmt maxcpus=8 nr_cpus=8') and
    Ubuntu 22.04.5 LTS (x86_64).

    Shell & test run in '/A'.

    w/o patch	w/ patch
    67675	88806

CONFIG_SCHED_AUTOGROUP=y & /sys/proc/kernel/sched_autogroup_enabled equal
0 or 1.

Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Hagar Hemdan <hagarhem@amazon.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250314151345.275739-1-dietmar.eggemann@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9010,7 +9010,7 @@ void sched_release_group(struct task_gro
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static struct task_group *sched_get_task_group(struct task_struct *tsk)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -9022,13 +9022,7 @@ static struct task_group *sched_get_task
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
-
-	return tg;
-}
-
-static void sched_change_group(struct task_struct *tsk, struct task_group *group)
-{
-	tsk->sched_task_group = group;
+	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
@@ -9049,20 +9043,11 @@ void sched_move_task(struct task_struct
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
-	struct task_group *group;
 	struct rq *rq;
 
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	/*
-	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
-	 * group changes.
-	 */
-	group = sched_get_task_group(tsk);
-	if (group == tsk->sched_task_group)
-		return;
-
 	update_rq_clock(rq);
 
 	running = task_current_donor(rq, tsk);
@@ -9073,7 +9058,7 @@ void sched_move_task(struct task_struct
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, group);
+	sched_change_group(tsk);
 	if (!for_autogroup)
 		scx_cgroup_move_task(tsk);
 



