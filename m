Return-Path: <stable+bounces-131841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEBEA8156B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67894E2743
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659C2459C5;
	Tue,  8 Apr 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jycr3qi5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="octOhNrT"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474324293C;
	Tue,  8 Apr 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139135; cv=none; b=Cve0lpDtRhq85y31ZTM1X2gVniFPLjW4rD7wZLqDvQjS2xdof2JcpCfsQygKfa52Y1/BTo2J1fx2V0pXKq2PNjQIS6zlXA3Tw8AderTT3yBQDPg63gK6om2fY1zZjjLIQM3D4pgiTtOhSd2NKUiXALrts/O/CcQVQB+sXFKf8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139135; c=relaxed/simple;
	bh=mSKVF5vf8AGRYhp6vZi1AHuZz+IwbgUxHVZNPTJ4KiA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YMPQw9bM4oVdIoHXwftJG+e8CeRaV7OBhSDS7zjkzTmR6VYdJg/3Jq9rNtfSdzhsU3ZBIvkQBBApYQsvBF0/debYRH7wPfwHAY4PQOCg5aQttILeveGokg1XUHaIfiTmjx4cZJBBTpZp7rsKGA80VBpSwzbKJgvRKBT9ihd+4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jycr3qi5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=octOhNrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Np1BYFi2LiUFyUeRiqzMh8O5TPOS2ojFZUDS1JNVI/Y=;
	b=jycr3qi5jMpF9l82tVjqhbMYMZfOcUsN2RXpl3gTQ9WcN2Iou67aa/RoiFlJP9OG0mzH2Z
	OKT+ubZkdcT17Zy9X5v6oz4O5MJ/PkE6E/ULQlw2mLNTNV00YWKmLhg8wT08Xsd+2GUE2J
	l6KJoZXNKruBY6sEUFAk2v0xl15zsmJv8qR2R9XRkv2ONlvUAJxjXntUfGUZ69PM1XMOIg
	PhbsWV6LJFKgX7aHnMY0H8zO+T8AQE3Wf7bY6TR/1tKd+BuTag8LXtOojIqxxd8FBrXdRL
	i6lHgESYjHhWUW9lDC9fHw5S2wZDRZIj4Dj+IDpSNQqhDoUth+OKluGsAKj5zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Np1BYFi2LiUFyUeRiqzMh8O5TPOS2ojFZUDS1JNVI/Y=;
	b=octOhNrTBPoNzlfGWp+Oj8uuxmRAp/y2bSdN8Vdskeiz/qNZ2InaVdmyJu4Vf2XdAubHGY
	8X/JJlA8Bca5bSBw==
From: "tip-bot2 for Harshit Agarwal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Fix race in push_rt_task
Cc: Jon Kohler <jon@nutanix.com>,
 Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
 Rahul Chunduru <rahul.chunduru@nutanix.com>,
 Harshit Agarwal <harshit@nutanix.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, Phil Auld <pauld@redhat.com>,
 Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250225180553.167995-1-harshit@nutanix.com>
References: <20250225180553.167995-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913083.31282.6439737092347995378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     690e47d1403e90b7f2366f03b52ed3304194c793
Gitweb:        https://git.kernel.org/tip/690e47d1403e90b7f2366f03b52ed330419=
4c793
Author:        Harshit Agarwal <harshit@nutanix.com>
AuthorDate:    Tue, 25 Feb 2025 18:05:53=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:55 +02:00

sched/rt: Fix race in push_rt_task

Overview
=3D=3D=3D=3D=3D=3D=3D=3D
When a CPU chooses to call push_rt_task and picks a task to push to
another CPU's runqueue then it will call find_lock_lowest_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.

Crashes
=3D=3D=3D=3D=3D=3D=3D
This bug resulted in quite a few flavors of crashes triggering kernel
panics with various crash signatures such as assert failures, page
faults, null pointer dereferences, and queue corruption errors all
coming from scheduler itself.

Some of the crashes:
-> kernel BUG at kernel/sched/rt.c:1616! BUG_ON(idx >=3D MAX_RT_PRIO)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? pick_next_task_rt+0x6e/0x1d0
   ? do_error_trap+0x64/0xa0
   ? pick_next_task_rt+0x6e/0x1d0
   ? exc_invalid_op+0x4c/0x60
   ? pick_next_task_rt+0x6e/0x1d0
   ? asm_exc_invalid_op+0x12/0x20
   ? pick_next_task_rt+0x6e/0x1d0
   __schedule+0x5cb/0x790
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: kernel NULL pointer dereference, address: 00000000000000c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? __warn+0x8a/0xe0
   ? exc_page_fault+0x3d6/0x520
   ? asm_exc_page_fault+0x1e/0x30
   ? pick_next_task_rt+0xb5/0x1d0
   ? pick_next_task_rt+0x8c/0x1d0
   __schedule+0x583/0x7e0
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: unable to handle page fault for address: ffff9464daea5900
   kernel BUG at kernel/sched/rt.c:1861! BUG_ON(rq->cpu !=3D task_cpu(p))

-> kernel BUG at kernel/sched/rt.c:1055! BUG_ON(!rq->nr_running)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? do_error_trap+0x64/0xa0
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? exc_invalid_op+0x4c/0x60
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? asm_exc_invalid_op+0x12/0x20
   ? dequeue_top_rt_rq+0xa2/0xb0
   dequeue_rt_entity+0x1f/0x70
   dequeue_task_rt+0x2d/0x70
   __schedule+0x1a8/0x7e0
   ? blk_finish_plug+0x25/0x40
   schedule+0x3c/0xb0
   futex_wait_queue_me+0xb6/0x120
   futex_wait+0xd9/0x240
   do_futex+0x344/0xa90
   ? get_mm_exe_file+0x30/0x60
   ? audit_exe_compare+0x58/0x70
   ? audit_filter_rules.constprop.26+0x65e/0x1220
   __x64_sys_futex+0x148/0x1f0
   do_syscall_64+0x30/0x80
   entry_SYSCALL_64_after_hwframe+0x62/0xc7

-> BUG: unable to handle page fault for address: ffff8cf3608bc2c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? spurious_kernel_fault+0x171/0x1c0
   ? exc_page_fault+0x3b6/0x520
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? asm_exc_page_fault+0x1e/0x30
   ? _cond_resched+0x15/0x30
   ? futex_wait_queue_me+0xc8/0x120
   ? futex_wait+0xd9/0x240
   ? try_to_wake_up+0x1b8/0x490
   ? futex_wake+0x78/0x160
   ? do_futex+0xcd/0xa90
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? plist_del+0x6a/0xd0
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? dequeue_pushable_task+0x20/0x70
   ? __schedule+0x382/0x7e0
   ? asm_sysvec_reschedule_ipi+0xa/0x20
   ? schedule+0x3c/0xb0
   ? exit_to_user_mode_prepare+0x9e/0x150
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_sysvec_reschedule_ipi+0x12/0x20

Above are some of the common examples of the crashes that were observed
due to this issue.

Details
=3D=3D=3D=3D=3D=3D=3D
Let's look at the following scenario to understand this race.

1) CPU A enters push_rt_task
  a) CPU A has chosen next_task =3D task p.
  b) CPU A calls find_lock_lowest_rq(Task p, CPU Z=E2=80=99s rq).
  c) CPU A identifies CPU X as a destination CPU (X < Z).
  d) CPU A enters double_lock_balance(CPU Z=E2=80=99s rq, CPU X=E2=80=99s rq).
  e) Since X is lower than Z, CPU A unlocks CPU Z=E2=80=99s rq. Someone else =
has
     locked CPU X=E2=80=99s rq, and thus, CPU A must wait.

2) At CPU Z
  a) Previous task has completed execution and thus, CPU Z enters
     schedule, locks its own rq after CPU A releases it.
  b) CPU Z dequeues previous task and begins executing task p.
  c) CPU Z unlocks its rq.
  d) Task p yields the CPU (ex. by doing IO or waiting to acquire a
     lock) which triggers the schedule function on CPU Z.
  e) CPU Z enters schedule again, locks its own rq, and dequeues task p.
  f) As part of dequeue, it sets p.on_rq =3D 0 and unlocks its rq.

3) At CPU B
  a) CPU B enters try_to_wake_up with input task p.
  b) Since CPU Z dequeued task p, p.on_rq =3D 0, and CPU B updates
     B.state =3D WAKING.
  c) CPU B via select_task_rq determines CPU Y as the target CPU.

4) The race
  a) CPU A acquires CPU X=E2=80=99s lock and relocks CPU Z.
  b) CPU A reads task p.cpu =3D Z and incorrectly concludes task p is
     still on CPU Z.
  c) CPU A failed to notice task p had been dequeued from CPU Z while
     CPU A was waiting for locks in double_lock_balance. If CPU A knew
     that task p had been dequeued, it would return NULL forcing
     push_rt_task to give up the task p's migration.
  d) CPU B updates task p.cpu =3D Y and calls ttwu_queue.
  e) CPU B locks Ys rq. CPU B enqueues task p onto Y and sets task
     p.on_rq =3D 1.
  f) CPU B unlocks CPU Y, triggering memory synchronization.
  g) CPU A reads task p.on_rq =3D 1, cementing its assumption that task p
     has not migrated.
  h) CPU A decides to migrate p to CPU X.

This leads to A dequeuing p from Y's queue and various crashes down the
line.

Solution
=3D=3D=3D=3D=3D=3D=3D=3D
The solution here is fairly simple. After obtaining the lock (at 4a),
the check is enhanced to make sure that the task is still at the head of
the pushable tasks list. If not, then it is anyway not suitable for
being pushed out.

Testing
=3D=3D=3D=3D=3D=3D=3D
The fix is tested on a cluster of 3 nodes, where the panics due to this
are hit every couple of days. A fix similar to this was deployed on such
cluster and was stable for more than 30 days.

Co-developed-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Will Ton <william.ton@nutanix.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250225180553.167995-1-harshit@nutanix.com
---
 kernel/sched/rt.c | 54 ++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 778911b..e40422c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1894,6 +1894,27 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
=20
+static struct task_struct *pick_next_pushable_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p =3D plist_first_entry(&rq->rt.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	BUG_ON(rq->cpu !=3D task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_donor(rq, p));
+	BUG_ON(p->nr_cpus_allowed <=3D 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!rt_task(p));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *r=
q)
 {
@@ -1924,18 +1945,16 @@ static struct rq *find_lock_lowest_rq(struct task_str=
uct *task, struct rq *rq)
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
-			 * migrated already or had its affinity changed.
-			 * Also make sure that it wasn't scheduled on its rq.
+			 * migrated already or had its affinity changed,
+			 * therefore check if the task is still at the
+			 * head of the pushable tasks list.
 			 * It is possible the task was scheduled, set
 			 * "migrate_disabled" and then got preempted, so we must
 			 * check the task migration disable flag here too.
 			 */
-			if (unlikely(task_rq(task) !=3D rq ||
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !rt_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     task !=3D pick_next_pushable_task(rq))) {
=20
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq =3D NULL;
@@ -1955,27 +1974,6 @@ static struct rq *find_lock_lowest_rq(struct task_stru=
ct *task, struct rq *rq)
 	return lowest_rq;
 }
=20
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p =3D plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu !=3D task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(task_current_donor(rq, p));
-	BUG_ON(p->nr_cpus_allowed <=3D 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task

