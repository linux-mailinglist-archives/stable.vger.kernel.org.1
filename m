Return-Path: <stable+bounces-126439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D7A7016E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2061891A24
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976725D204;
	Tue, 25 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELor0Xn0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D625C704;
	Tue, 25 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906226; cv=none; b=PJe65L8zvJ1d7W3BUrUvQaTJVMx/EZdxjqCXGU6jvjOp1coURHROteLApqgQO65cXVN8fz9EMKquFfmqgKzvujaiUTUfQDZfk9Q0R+1LWhnu4iwD98+EcZFwJUPMZWqsbFGWqoKGCOUFWiY62T2MetiNGe6QS3fyKwLv1jmMpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906226; c=relaxed/simple;
	bh=WJwCzn0+W0v2opICXevCIGsJjX02+jDp26ZEywwVoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWdiOOSAoVFmV2Gsg8LikKMncO8+P/Q7fDetPflIjZoPoGVtgD4L5eG11ZseGlf8MuxgEAQ9aDednLGs9zySfYfo7RK9vN5rIvmPcFwP0VEljnu2AB38ukvxQd9eXKFohc05LPudQXyDGUmJAVCZZmwDVAfOat42vxDeIslvqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELor0Xn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC90FC4CEE4;
	Tue, 25 Mar 2025 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906226;
	bh=WJwCzn0+W0v2opICXevCIGsJjX02+jDp26ZEywwVoKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELor0Xn08w0Us+xCQUyC4N5OCoDkErfp//BMRhWfVWnnR+GdLNLTF2vnRARcymKfI
	 e8bf7Lf6d7SRbAtFK6KnbzncBVlUJu5ZCgJdyzdFsnckU873Xb8QK2OktZYWtE2UVv
	 ebHXAjVM0iTzgLrTaiXJw2biM5+IDSULH+W9mx54=
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
Subject: [PATCH 6.6 72/77] Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
Date: Tue, 25 Mar 2025 08:23:07 -0400
Message-ID: <20250325122146.301672233@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
References: <20250325122144.259256924@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
[Hagar: clean revert of eff6c8ce8dd7 to make it work on 6.6]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10494,7 +10494,7 @@ void sched_release_group(struct task_gro
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static struct task_group *sched_get_task_group(struct task_struct *tsk)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10506,13 +10506,7 @@ static struct task_group *sched_get_task
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
@@ -10533,19 +10527,10 @@ void sched_move_task(struct task_struct
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
-	struct task_group *group;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
-	/*
-	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
-	 * group changes.
-	 */
-	group = sched_get_task_group(tsk);
-	if (group == tsk->sched_task_group)
-		goto unlock;
-
 	update_rq_clock(rq);
 
 	running = task_current(rq, tsk);
@@ -10556,7 +10541,7 @@ void sched_move_task(struct task_struct
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, group);
+	sched_change_group(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10570,7 +10555,6 @@ void sched_move_task(struct task_struct
 		resched_curr(rq);
 	}
 
-unlock:
 	task_rq_unlock(rq, tsk, &rf);
 }
 



