Return-Path: <stable+bounces-125981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1CCA6E5C9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE7A166C30
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6A6EC4;
	Mon, 24 Mar 2025 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="afW9LzLd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAC19005D
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852236; cv=none; b=KdSh/lGFQ44oFG80riWa61I6IAKvANft76NIf33bWoGTCmNnfYsRnO+RzSMSVe081zVGRHLGrY3Kku0VmozQOmXo79cs9mRZ1Jr2zjO+oKwrdH9MB9A6rgxje4RHH+3Sr3JEvamDHMUnE6Fu/tqNGgaUU8J1pRcPW/zNBv920ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852236; c=relaxed/simple;
	bh=DuZJ2DMhInp6iy51ZK5j4hqvXuXIT+zy52uoNv5DihM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjJr2oNdeT7i86zjhlPk/y8FS9PdOxPXEemjB3bgoICgdrCjvZ4O5CHtO09t60kPrZRxApZlM2748jlwuwMjrB6Q/7ZQ23zEpiJdhe7RXSYI5iReu8/heC1A16kROYnb05jWW4RIcvWZeTqAU74EQ0w9ynhLiJQUFXf7lZOJzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=afW9LzLd; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742852235; x=1774388235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SgMg6hT7T/A00k9UWFVG8rxYBxo+uRTq9wBMsdloZ4U=;
  b=afW9LzLdaiNzrcY2lpBx+mAbJbIWdD+UnV6Vc4ubReZLt5354+hAUZf6
   jPIq2knyQ+aDOd3qjcEcHCRCyICkPsg62kfzIKcoON07r1fxnisShsjJx
   uuF9X1XJ3dRvR1N4soxXJPK+zRYWQrZI+DysbkW82L9wvr1DOmp0uy7wW
   U=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; 
   d="scan'208";a="473976012"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 21:37:12 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:49623]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.159:2525] with esmtp (Farcaster)
 id 5a6c5cf0-d2d5-4d69-86ae-b678259030be; Mon, 24 Mar 2025 21:37:10 +0000 (UTC)
X-Farcaster-Flow-ID: 5a6c5cf0-d2d5-4d69-86ae-b678259030be
Received: from EX19D018EUA003.ant.amazon.com (10.252.50.163) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 21:37:10 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D018EUA003.ant.amazon.com (10.252.50.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 21:37:10 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 21:37:09 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id 416FDA0588;
	Mon, 24 Mar 2025 21:37:09 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id C819720DF6; Mon, 24 Mar 2025 21:37:08 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Hemdan <hagarhem@amazon.com>, "Hazem
 Mohamed Abuelfotoh" <abuehaze@amazon.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.6] Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
Date: Mon, 24 Mar 2025 21:37:03 +0000
Message-ID: <20250324213706.8335-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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

    w/o patch   w/ patch
    21005       27120

(b) i7-13700K with tip/sched/core ('nosmt maxcpus=8 nr_cpus=8') and
    Ubuntu 22.04.5 LTS (x86_64).

    Shell & test run in '/A'.

    w/o patch   w/ patch
    67675       88806

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
---
 kernel/sched/core.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 942734bf7347..8c5f75af07db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10494,7 +10494,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static struct task_group *sched_get_task_group(struct task_struct *tsk)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10506,13 +10506,7 @@ static struct task_group *sched_get_task_group(struct task_struct *tsk)
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
@@ -10533,19 +10527,10 @@ void sched_move_task(struct task_struct *tsk)
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
@@ -10556,7 +10541,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, group);
+	sched_change_group(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10570,7 +10555,6 @@ void sched_move_task(struct task_struct *tsk)
 		resched_curr(rq);
 	}
 
-unlock:
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-- 
2.47.1


