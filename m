Return-Path: <stable+bounces-59379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16C931E10
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39112280F35
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 00:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65228136A;
	Tue, 16 Jul 2024 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAOzu08Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864281E
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721090458; cv=none; b=pPvcm6lnXMYRDlH7xLUfOYvmvrMHF7QcFUZA1OCM59LZ+B+1deXnQLklEnqtJhK/1Wcfx6Z53Gbbb3KEC5b9O/b9Ciu1i7EiwN8lmnJ675CtmE6Xp/vkHjQhovsu6VRGtK3PcQU1LTez6mxjtHXLflepRCKgzbyz6NNjrp9OdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721090458; c=relaxed/simple;
	bh=PILS42D4ycoLws60Fv+D4w67bQyWtVMrUFZPlF+oeP4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bK1lOYvSOugH0cEctozvt6BhJoINn5RhXaGmAg4nfn3itIMr49I5dKhGjHl/z1GQ20QmEb/kazXgrvExeeZ5pC6HSNO2S7oPrCdGUnowMyTGxW2BjCZWEyjx299XVdtaoDalOMnAdX4F2MoWG0xzwlSYO/BaS2ppOpO+YXfHFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAOzu08Q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-781cc721188so3941844a12.0
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 17:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721090456; x=1721695256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nF/s5da7+QmopDwYkHabPwflMAhA5q2V/O/NyA7ZyyY=;
        b=aAOzu08Qwf7HyntF7ledKbvspyhpd6BQFK+M0/IVHwZBRpidZomN5JKGckNcwDRYxt
         tfkC35Vusf+VUT19tZUatOo6hR0SnS6sHMhV2tkJ9S3xA08nzLC4EGoe0KAj88RES46U
         yupcTPp6A2jxhCAwpnCzqx2kXDmbGL4jxgo+oFXSnFE+tyP5sfFdSKvSkpAswBEpO0HA
         ftjqK1p1dm/NlmwCqHJrNRvSFyL4pQMbiAs2vQsucdUxzavVV4bBg3f3OKO73RgxOGOm
         fhtb5stw3JjNwCvhdxOeQTxpdGeA6plaD74u70Iqnnh3KspEDXaCksrljVcoESqXo5A7
         v3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721090456; x=1721695256;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nF/s5da7+QmopDwYkHabPwflMAhA5q2V/O/NyA7ZyyY=;
        b=dRA5GjCJ8koNPU95JFLxUaAqjydqrYcyvrjWgG/nty5JeDPE0QdeAaw0yoBnVcZw4N
         mbaf61dJ1+jCAMEE906hwIj6Pc0CwYSGCT6O3zzq6YifkH84As70x3BZgwTjd1CzCY1J
         aF37aCz+Fw0eavZq0thTwiPkfEkr/2ElahLkQI61DHKGZOuRaeIfPFC1baK34s3ERUmW
         2yhzbT70dWzFYM7RLKS47YSOb3xKYkIJZWHXp+IVLT6ROJUnOkwyRjo6ChVYzu3R9bXT
         VE4/bdnv6hviC12Tv3nWf/yrZAywk6AddddHgYYQ0LFmYkbwabN93Day22lo9dVi3Aju
         5JBA==
X-Gm-Message-State: AOJu0YyyaXvvFZ7BcdQOmAJyweroqhcubrf0xhk+GiolEhuQieJCBKtJ
	aAx51Fm2fXsaHwvuwWSuKu8tmL+xgvycdlHhe2vKums3wrRmG/1POUMh0E51vfMPSFxgZGpHgli
	zHJTLcHvM6mRWBLzIcC4bTFg9uXqFIQy9xEC2097xVN6h3ekbPuB+aKKQfRpy7c8+8bjIS0hUhe
	wbNQ0xaE5AxjhmAeC0JD+pyoFzNcgqlg/G+ISH
X-Google-Smtp-Source: AGHT+IF0EJYQtftwQFcl30JKpNgxynj+zF2RRNCyxQgkby28FQwA95FrjflTwTFWhp7Qs8fjPUckiG+AjZgl
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:5c59:0:b0:6ea:87eb:9493 with SMTP id
 41be03b00d2f7-795c1cbcff3mr1583a12.2.1721090455171; Mon, 15 Jul 2024 17:40:55
 -0700 (PDT)
Date: Mon, 15 Jul 2024 17:40:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716004050.515306-1-jstultz@google.com>
Subject: [PATCH 6.1] sched: Move psi_account_irqtime() out of
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
[jstultz: Fixed up minor collisions w/ 6.1-stable]
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c  |  7 +++++--
 kernel/sched/psi.c   | 21 ++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 kernel/sched/stats.h | 11 ++++++++---
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d71234729edb..cac41c49bd2f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -701,7 +701,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
@@ -5500,7 +5499,7 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5512,6 +5511,9 @@ void scheduler_tick(void)
 
 	rq_lock(rq, &rf);
 
+	curr = rq->curr;
+	psi_account_irqtime(rq, curr, NULL);
+
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
@@ -6550,6 +6552,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
+		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 80d8c10e9363..81dbced92df5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -785,6 +785,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	enum psi_states s;
 	u32 state_mask;
 
+	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
@@ -1003,19 +1004,29 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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
index b62d53d7c264..81d9698f0a1e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1084,6 +1084,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 84a188913cc9..b49a96fad1d2 100644
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
@@ -206,7 +210,8 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
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


