Return-Path: <stable+bounces-164873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1BB13354
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B12A3A1A9C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E44438B;
	Mon, 28 Jul 2025 03:08:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17D1EA7C4
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672132; cv=none; b=LVe/e8XLz3N4LbDjPKPBzdBpl4c8aMu7raT+tzd6T/Gn/5BN5gX+rUZHwL4bD29rksh/b/6d/sg5Jlf4KX6hoT9XtHCY+/rk/V6V7PdKoDIkjZFG/25Q/sE2XWAb1pQaMZpC68f3+C2k3BHUKU5XOLeL2502jWcOrnoto4xKjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672132; c=relaxed/simple;
	bh=2MakXecy/aMkFyEP//fUFP2lwfm2Ln+V5XFONAYzQp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5cQXqqfqepVwy0ml9v0FrEmddez+DKHBQXGxAk0rxwDB0ShGCP3+HOURAode6wVV7wX4x/01HDnpsYE2hECYVl53RRO95A+EWwaAYMJxPcqEvDWDO7FRTo+z6gT91gpGJ1Vh6gfWDkAUtEo7IpdrqHe4ZOkfv3gMM4H7TCfWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4br3N16pV9zKHMjv
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C5E3C1A1561
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:48 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCXExS56YZokj7rBg--.58859S4;
	Mon, 28 Jul 2025 11:08:48 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	pavel@ucw.cz
Cc: stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH 6.6 2/5] freezer,sched: Use saved_state to reduce some spurious wakeups
Date: Mon, 28 Jul 2025 02:54:41 +0000
Message-Id: <20250728025444.34009-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728025444.34009-1-chenridong@huaweicloud.com>
References: <2025072421-deviate-skintight-bbd5@gregkh>
 <20250728025444.34009-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExS56YZokj7rBg--.58859S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy8tr1rGF1rtF1rXr1xGrg_yoWxuF4fpa
	93Wr47Kw4vqw1Iqr47Jw4kXF98Gw4vqw15Wr9Ikry8AF4Yga1Fvrn7try3Jr4UtrWIkFy5
	tw4jvwnaka1DJaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4
	MKtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Elliot Berman <quic_eberman@quicinc.com>

[ Upstream commit 8f0eed4a78a81668bc78923ea09f51a7a663c2b0 ]

After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
always woken up on the thaw path. Prior to that commit, tasks could ask
freezer to consider them "frozen enough" via freezer_do_not_count(). The
commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
allows freezer to immediately mark the task as TASK_FROZEN without
waking up the task.  This is efficient for the suspend path, but on the
thaw path, the task is always woken up even if the task didn't need to
wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
these tasks are capable of handling of the wakeup, we can observe a
power/perf impact from the extra wakeup.

We observed on Android many tasks wait in the TASK_FREEZABLE state
(particularly due to many of them being binder clients). We observed
nearly 4x the number of tasks and a corresponding linear increase in
latency and power consumption when thawing the system. The latency
increased from ~15ms to ~50ms.

Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
If the task was running before entering TASK_FROZEN state
(__refrigerator()) or if the task received a wake up for the saved
state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
can be re-used because freezer would not stomp on the rtlock wait flow:
TASK_RTLOCK_WAIT isn't considered freezable.

Reported-by: Prakash Viswalingam <quic_prakashv@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/freezer.c    | 41 +++++++++++++++++++----------------------
 kernel/sched/core.c | 21 +++++++++++++--------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6fca64..c450fa8b8b5e 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -71,7 +71,11 @@ bool __refrigerator(bool check_kthr_stop)
 	for (;;) {
 		bool freeze;
 
+		raw_spin_lock_irq(&current->pi_lock);
 		set_current_state(TASK_FROZEN);
+		/* unstale saved_state so that __thaw_task() will wake us up */
+		current->saved_state = TASK_RUNNING;
+		raw_spin_unlock_irq(&current->pi_lock);
 
 		spin_lock_irq(&freezer_lock);
 		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
@@ -129,6 +133,7 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
 #endif
 
+	p->saved_state = p->__state;
 	WRITE_ONCE(p->__state, TASK_FROZEN);
 	return TASK_FROZEN;
 }
@@ -170,42 +175,34 @@ bool freeze_task(struct task_struct *p)
 }
 
 /*
- * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
- * state in p->jobctl. If either of them got a wakeup that was missed because
- * TASK_FROZEN, then their canonical state reflects that and the below will
- * refuse to restore the special state and instead issue the wakeup.
+ * Restore the saved_state before the task entered freezer. For typical task
+ * in the __refrigerator(), saved_state == TASK_RUNNING so nothing happens
+ * here. For tasks which were TASK_NORMAL | TASK_FREEZABLE, their initial state
+ * is restored unless they got an expected wakeup (see ttwu_state_match()).
+ * Returns 1 if the task state was restored.
  */
-static int __set_task_special(struct task_struct *p, void *arg)
+static int __restore_freezer_state(struct task_struct *p, void *arg)
 {
-	unsigned int state = 0;
+	unsigned int state = p->saved_state;
 
-	if (p->jobctl & JOBCTL_TRACED)
-		state = TASK_TRACED;
-
-	else if (p->jobctl & JOBCTL_STOPPED)
-		state = TASK_STOPPED;
-
-	if (state)
+	if (state != TASK_RUNNING) {
 		WRITE_ONCE(p->__state, state);
+		return 1;
+	}
 
-	return state;
+	return 0;
 }
 
 void __thaw_task(struct task_struct *p)
 {
-	unsigned long flags, flags2;
+	unsigned long flags;
 
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
 
-	if (lock_task_sighand(p, &flags2)) {
-		/* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
-		bool ret = task_call_func(p, __set_task_special, NULL);
-		unlock_task_sighand(p, &flags2);
-		if (ret)
-			goto unlock;
-	}
+	if (task_call_func(p, __restore_freezer_state, NULL))
+		goto unlock;
 
 	wake_up_state(p, TASK_FROZEN);
 unlock:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab6550fadecd..1b5e4389f788 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2251,7 +2251,7 @@ int task_state_match(struct task_struct *p, unsigned int state)
 
 	/*
 	 * Serialize against current_save_and_set_rtlock_wait_state() and
-	 * current_restore_rtlock_saved_state().
+	 * current_restore_rtlock_saved_state(), and __refrigerator().
 	 */
 	raw_spin_lock_irq(&p->pi_lock);
 	match = __task_state_match(p, state);
@@ -4034,13 +4034,17 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * The caller holds p::pi_lock if p != current or has preemption
  * disabled when p == current.
  *
- * The rules of PREEMPT_RT saved_state:
+ * The rules of saved_state:
  *
  *   The related locking code always holds p::pi_lock when updating
  *   p::saved_state, which means the code is fully serialized in both cases.
  *
- *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
- *   bits set. This allows to distinguish all wakeup scenarios.
+ *   For PREEMPT_RT, the lock wait and lock wakeups happen via TASK_RTLOCK_WAIT.
+ *   No other bits set. This allows to distinguish all wakeup scenarios.
+ *
+ *   For FREEZER, the wakeup happens via TASK_FROZEN. No other bits set. This
+ *   allows us to prevent early wakeup of tasks before they can be run on
+ *   asymmetric ISA architectures (eg ARMv9).
  */
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
@@ -4056,10 +4060,11 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	/*
 	 * Saved state preserves the task state across blocking on
-	 * an RT lock.  If the state matches, set p::saved_state to
-	 * TASK_RUNNING, but do not wake the task because it waits
-	 * for a lock wakeup. Also indicate success because from
-	 * the regular waker's point of view this has succeeded.
+	 * an RT lock or TASK_FREEZABLE tasks.  If the state matches,
+	 * set p::saved_state to TASK_RUNNING, but do not wake the task
+	 * because it waits for a lock wakeup or __thaw_task(). Also
+	 * indicate success because from the regular waker's point of
+	 * view this has succeeded.
 	 *
 	 * After acquiring the lock the task will restore p::__state
 	 * from p::saved_state which ensures that the regular
-- 
2.34.1


