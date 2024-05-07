Return-Path: <stable+bounces-43407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350048BF282
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DEB287395
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677A52101BB;
	Tue,  7 May 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+WXHscD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502A2101B1;
	Tue,  7 May 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123626; cv=none; b=IldFJ9YmH4z8qECnIgQvC5b8/7s9FP7g61LOPF594YYgKNsdETOMmB0IqgKWzOG5FxS4M7jJLZf9//mj+Tvux7+gpP+k/jhUkuaiUGvHQCTUwLjB+FonAKOAIeHxoh4EpQekxmaDgPva9o097Ose2OGfE+rAaqFnkmg0BerDgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123626; c=relaxed/simple;
	bh=QAmPSuJ7DFViSqGNovF2d0aiyRf2MxtZwGHfiycteqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg+axY3SfgOhgI+YjD9ZwFc9e+/Anl0mYWDYru9mrPkTUt6Rxuz3CzNUkNCx3P4V4SIEtxXMACUn7+HoRXwsxPhIyb+p0mqj+WAfw/wwZ7ThitQPYazwPP8Do+dAkru8o7bZJQv4IYFoy0ZKFJzSbfEu6yeDX3MdN4eNr7V2N+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+WXHscD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB26BC3277B;
	Tue,  7 May 2024 23:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123626;
	bh=QAmPSuJ7DFViSqGNovF2d0aiyRf2MxtZwGHfiycteqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+WXHscDwpgTzSEgZRa5cgbCqrjAPjQMkIBT8LdrL6EfiEJYq+iXvM2qsZCSPn/dR
	 9xnGIYiWjaPT1ZgXpeDomlN4l+CntCizsiGkQQg0yboPaTcap9S70gqNlpR7we81X/
	 FEsD3fdC0dijbSRvCn2g48CLPw+IEHNNi+vlRBNJmCTJvAEqM7z4FIQaB0AUUDU0u6
	 6q983CtpBOt+i6F5hp3vrQps2JBhygaZoyIkIwBLWEfTBBHegcUDEHeVJBt4hNZNw5
	 zGK/nP1GsmPR08LmmOWNLkJvE7Kq7XNnnIs1BKNUl/R00w5Xm7+paJRfzpOALqg9y3
	 e2j4rZkk6jP/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>,
	syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	tj@kernel.org,
	edumazet@google.com,
	CruzZhao@linux.alibaba.com,
	pabeni@redhat.com
Subject: [PATCH AUTOSEL 5.15 07/15] softirq: Fix suspicious RCU usage in __do_softirq()
Date: Tue,  7 May 2024 19:13:16 -0400
Message-ID: <20240507231333.394765-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 1dd1eff161bd55968d3d46bc36def62d71fb4785 ]

Currently, the condition "__this_cpu_read(ksoftirqd) == current" is used to
invoke rcu_softirq_qs() in ksoftirqd tasks context for non-RT kernels.

This works correctly as long as the context is actually task context but
this condition is wrong when:

     - the current task is ksoftirqd
     - the task is interrupted in a RCU read side critical section
     - __do_softirq() is invoked on return from interrupt

Syzkaller triggered the following scenario:

  -> finish_task_switch()
    -> put_task_struct_rcu_user()
      -> call_rcu(&task->rcu, delayed_put_task_struct)
        -> __kasan_record_aux_stack()
          -> pfn_valid()
            -> rcu_read_lock_sched()
              <interrupt>
                __irq_exit_rcu()
                -> __do_softirq)()
                   -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
                     __this_cpu_read(ksoftirqd) == current)
                     -> rcu_softirq_qs()
                       -> RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))

The rcu quiescent state is reported in the rcu-read critical section, so
the lockdep warning is triggered.

Fix this by splitting out the inner working of __do_softirq() into a helper
function which takes an argument to distinguish between ksoftirqd task
context and interrupted context and invoke it from the relevant call sites
with the proper context information and use that for the conditional
invocation of rcu_softirq_qs().

Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240427102808.29356-1-qiang.zhang1211@gmail.com
Link: https://lore.kernel.org/lkml/8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop/T/#mea8aba4abfcb97bbf499d169ce7f30c4cff1b0e3
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/softirq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e991..dc60f0c66a25f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -512,7 +512,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -567,8 +567,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -588,6 +587,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -918,7 +922,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;
-- 
2.43.0


