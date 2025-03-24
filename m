Return-Path: <stable+bounces-125976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA918A6E4B6
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECE21896298
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD941DF99D;
	Mon, 24 Mar 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xX0ujGO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB291DC9BB
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849445; cv=none; b=MuohFXek8WarVKOzLvykwwtG9EyGAQ6dVJL92wLmh3QrKv6/Vtu5nkeCWT+2tDeDBgAnS0BlVDGeyCGDHQLZnzjnHar8WpiSJuGxPsHY3yMtLkQF1sltUETERYSL/AAAYrhLER2dpcg9YrEDl1gTSZfphoYKvZ/rBF8ucnQSX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849445; c=relaxed/simple;
	bh=fPgeKoCydVuC+o9VI3ffWH0sWcb64qCFgzccenvzf3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UDILbd3DDEQB19DmxTMIyb86NYfo70z7shDefIfF/dHUcjKqr4KsTwtD9GT6YAlh8Zrtrk3ps5FiNixU1EhMnbmdeD/sLXseatbR3uIIbjiWrswph+uNVeBmUiAqgbcfElMtzGCtOSCYrSPhNwczEGTyVRMykSJyPLlCapITMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xX0ujGO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B4DC4CEE4;
	Mon, 24 Mar 2025 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742849444;
	bh=fPgeKoCydVuC+o9VI3ffWH0sWcb64qCFgzccenvzf3Y=;
	h=Subject:To:Cc:From:Date:From;
	b=xX0ujGO3PZ3K7wRw6fdpq9F1twsvK1hcSadqQiAKr5uVLpb1RBP9i/VrzQTQ02bmQ
	 HmSwziIzSGATFQ0ogWYQ2dTLsPCxHZk8NdI6tc9qnT1A5y4w6SzvKUyjcwLfd0sr1m
	 SVLyrUKJM2YEfyivxqaTlvsOt2dpEfnJF+9U1z2Y=
Subject: FAILED: patch "[PATCH] Revert "sched/core: Reduce cost of sched_move_task when" failed to apply to 6.6-stable tree
To: dietmar.eggemann@arm.com,abuehaze@amazon.com,hagarhem@amazon.com,mingo@kernel.org,peterz@infradead.org,torvalds@linux-foundation.org,vincent.guittot@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 16:49:22 -0400
Message-ID: <2025032422-giblet-smelting-2a62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 76f970ce51c80f625eb6ddbb24e9cb51b977b598
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032422-giblet-smelting-2a62@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76f970ce51c80f625eb6ddbb24e9cb51b977b598 Mon Sep 17 00:00:00 2001
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Fri, 14 Mar 2025 16:13:45 +0100
Subject: [PATCH] Revert "sched/core: Reduce cost of sched_move_task when
 config autogroup"

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

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d..042351c7afce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9016,7 +9016,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static struct task_group *sched_get_task_group(struct task_struct *tsk)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -9028,13 +9028,7 @@ static struct task_group *sched_get_task_group(struct task_struct *tsk)
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
@@ -9055,20 +9049,11 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
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
@@ -9079,7 +9064,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, group);
+	sched_change_group(tsk);
 	if (!for_autogroup)
 		scx_cgroup_move_task(tsk);
 


