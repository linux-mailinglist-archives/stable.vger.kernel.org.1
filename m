Return-Path: <stable+bounces-59378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C6931E0D
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 02:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB6C1F221F1
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC17196;
	Tue, 16 Jul 2024 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpvD5BYU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A12191
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721089733; cv=none; b=laBQxqbUq5t5zUToQUbcQ2K+2imYL/ZnbhKBO+at9rvRKq3vGwjPU/NrWqpdcXrfzwiIAIGSLQwVECbKgo909BS9KzdGJRxbtJsOBNFBumewqox85dsDMlBHbZBP6LpWWPshRn6s0+wTYVl8yjQ7qAwpVd2RHUekMH93J1opfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721089733; c=relaxed/simple;
	bh=GIFgbUjQP3Vz277VyMSIYFasUvcxMEYHx+8CqkkMukA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n9iUBciom4NFvMVaCpXE/3VPDdpsSfBzhGNxIHe2Vi2131aPjsRh+Ze0rz/+6X9kYrxAz3gVbnlbA4ZqGTWpQY0DaQo/qXkulcMgJPk85nCXM6lvSnL4Wwrs7Ix6E2GSDymEUWMRKPMJzvK3yCqPvH+VzcbrDoIBIqW+icz+L9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpvD5BYU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3960528a12.0
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721089731; x=1721694531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+6TDAsVIX+6TyoCKalzwlmSqVWfMv5WGuuuki+ewUo=;
        b=xpvD5BYU5QA5f7FzkJHxLFI56wDT2pEvBK0QrqMF7jGgeXdcLA/H9zKu/6nUw0GVng
         XgTfThSahzDAAoZ+kEb/F/cRB4/K7RLXgqkFTsj+HT58WteacOfPGIIMfTmn/98rt5Z4
         iBkYpZLHg1D7cMeI0HjFyDFYj8cMXamgtvTBORY9tJTgcw/soiS73Z1pSWnpYDUt3hL/
         nuWRGofJ5Uj3i+XCoyFOqEQU9A+Z8DCqLc/UaHegdE9sdqIZYx+PJEuz/Qqzp284Na2J
         /Rl3q8DHRjoIM6SnFcMfyDkQUghEUszkpEWmaYgj3dte4S/KqGobYltxy8QjRDpzgsG5
         Le6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721089731; x=1721694531;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+6TDAsVIX+6TyoCKalzwlmSqVWfMv5WGuuuki+ewUo=;
        b=c+fQwiGyaD5pYPIhYY87+ZxaRVAEpHI8j4tXfqOqmiXPYlOS3Kpj+l3Sg4OYlJSPXM
         AjINxuUqdE+ysi5XKyhpbXUVrHVCn+mJFOuUnvtTfT8j5ga3Dap4AWUebo+JljEBxx96
         IuYHlP+zyxq7wY4PHFtKu7gRqu/K9zhDVg95r8Aw3UYzWaen1FoqSldSyQAOBLcSFop8
         /RRYwJJ5H626mzdGgXKuVdmRS0eXNApxJfNtFnz37cnO3iVo3I4EXieUNALrEcs4I1n4
         vr9hotwdf9vsTszfvSwqBYi8RC8hdwHofX/A2y19YsMZXB5T6SKzL42uhtq3aNI3WK/q
         mTYQ==
X-Gm-Message-State: AOJu0Yyc6XA9WVqQZc6rcTTafQbhrwkGUtkNQED10oA0NBLkxmpbFZvU
	X6JqRkcz1s07bg8ge+Jx9/w9CPZeO8HiwDGOVuY1NqyJ2i9aqNygmblAtYlJGlPYGjH0ccB/PMT
	ziMd6TCYeR2n404RyynIKwvevCJk0/GaNynCh9iUpjayIFxcq6fwmkwYgJtZa1VQF42hDNvDu4X
	+oLo1IGrpsGsmGeG92Kn1TRehrjXCXB1k/2PVR
X-Google-Smtp-Source: AGHT+IGnTgKuaGF+43mUTmJ8jtGQOR7q8Rh9SBgpQTN/Y0q4D+gZdGZITbpopuKIYkjj4y+tTHEoFVBUujKx
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:7f52:0:b0:701:d445:c8f7 with SMTP id
 41be03b00d2f7-79632b31457mr585a12.3.1721089728814; Mon, 15 Jul 2024 17:28:48
 -0700 (PDT)
Date: Mon, 15 Jul 2024 17:28:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716002835.349841-1-jstultz@google.com>
Subject: [PATCH 6.6] sched: Move psi_account_irqtime() out of
 update_rq_clock_task() hotpath
From: John Stultz <jstultz@google.com>
To: stable@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Jimmy Shiu <jimmyshiu@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"

commit ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8 upstream.

It was reported that in moving to 6.1, a larger then 10%
regression was seen in the performance of
clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).

Using a simple reproducer, I found:
5.10:
100000000 calls in 24345994193 ns => 243.460 ns per call
100000000 calls in 24288172050 ns => 242.882 ns per call
100000000 calls in 24289135225 ns => 242.891 ns per call

6.1:
100000000 calls in 28248646742 ns => 282.486 ns per call
100000000 calls in 28227055067 ns => 282.271 ns per call
100000000 calls in 28177471287 ns => 281.775 ns per call

The cause of this was finally narrowed down to the addition of
psi_account_irqtime() in update_rq_clock_task(), in commit
52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
pressure").

In my initial attempt to resolve this, I leaned towards moving
all accounting work out of the clock_gettime() call path, but it
wasn't very pretty, so it will have to wait for a later deeper
rework. Instead, Peter shared this approach:

Rework psi_account_irqtime() to use its own psi_irq_time base
for accounting, and move it out of the hotpath, calling it
instead from sched_tick() and __schedule().

In testing this, we found the importance of ensuring
psi_account_irqtime() is run under the rq_lock, which Johannes
Weiner helpfully explained, so also add some lockdep annotations
to make that requirement clear.

With this change the performance is back in-line with 5.10:
6.1+fix:
100000000 calls in 24297324597 ns => 242.973 ns per call
100000000 calls in 24318869234 ns => 243.189 ns per call
100000000 calls in 24291564588 ns => 242.916 ns per call

Reported-by: Jimmy Shiu <jimmyshiu@google.com>
Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Link: https://lore.kernel.org/r/20240618215909.4099720-1-jstultz@google.com
Fixes: 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
[jstultz: Fixed up minor collisions w/ 6.6-stable]
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c  |  7 +++++--
 kernel/sched/psi.c   | 21 ++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 kernel/sched/stats.h | 11 ++++++++---
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dcb30e304871..820880960513 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -722,7 +722,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
 	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
@@ -5641,7 +5640,7 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5653,6 +5652,9 @@ void scheduler_tick(void)
 
 	rq_lock(rq, &rf);
 
+	curr = rq->curr;
+	psi_account_irqtime(rq, curr, NULL);
+
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
@@ -6690,6 +6692,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
+		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1d0f634725a6..431971acc763 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -784,6 +784,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	enum psi_states s;
 	u32 state_mask;
 
+	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
@@ -1002,19 +1003,29 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct task_struct *task, u32 delta)
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
-	int cpu = task_cpu(task);
+	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now;
+	u64 now, irq;
+	s64 delta;
 
-	if (!task->pid)
+	if (!curr->pid)
+		return;
+
+	lockdep_assert_rq_held(rq);
+	group = task_psi_group(curr);
+	if (prev && task_psi_group(prev) == group)
 		return;
 
 	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->psi_irq_time);
+	if (delta < 0)
+		return;
+	rq->psi_irq_time = irq;
 
-	group = task_psi_group(task);
 	do {
 		if (!group->enabled)
 			continue;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 35c38daa2d3e..2e8f26a919ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1094,6 +1094,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 38f3698f5e5b..b02dfc322951 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,8 +110,12 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
-void psi_account_irqtime(struct task_struct *task, u32 delta);
-
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
+#else
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
+#endif /*CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
@@ -192,7 +196,8 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.45.2.993.g49e7a77208-goog


