Return-Path: <stable+bounces-80640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538298EE20
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7A51F2220A
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062015443D;
	Thu,  3 Oct 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mU2AWwR1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618913D25E
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954956; cv=none; b=h2C6M8IIFB7nocFA2izdoFbtpNBH06TbnewSV2J1lJ+C+Qfv2qKO26hf0EuPT69cSYU30UnCe+MQqYlLeUEfSR/sUFKdb121Na9nZNLVP/2MjdtTmrNVhfOzsWvba5r6rWRqMNwWZpbkscHFfDEEwW1MjM3Hn0oq0NUOoXUM+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954956; c=relaxed/simple;
	bh=nVjOl7FI7A+n6tLkR5VVKYp4Rl4H/IYpRVFdm6TrJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnS0/RIb8Mbyxeok6bELJJqytaMEsOn5p0qM8wgKewJ2w6/ATDQefMDoOKMGaEzpxuUs2puIKBwFVjMdWW0RXY6A6xo72CPs+xUh8CASTZTu6ApVFkadbq92g+63h4eavWO+yHllGSzE757TisaKlqmbhkug6E3VzEz0qsODoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mU2AWwR1; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9aec89347so55193785a.0
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727954952; x=1728559752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDA9NUNx9gSo2kRmc35eR3BkbtLwu7lBmRWMEDqyb+0=;
        b=mU2AWwR1UDJQtdwPB9DSE4kyOnvtN01w5WPy6SU78AH16VRnn9LV2VmtAatoWDzuo0
         sUtuKZZH8pUkSle68iPhu2WMJ/Z9R3ji9ppOPBCgUaMuEv3G+jt5IVmEa6I050ic4SsQ
         neYjbVR2XiG4hwYZDoyOi1aGj/qlZ/LEgUnZqyhT0MFOhT2c2toeNu591cTOmFmTjkzm
         ykPT8rqMBm1KQktTvqA4nkjlTWWpGxwLwQ5fng2gVneUY366Ya1PYJ2TyWNQw8oDwM9H
         HmwvKfhraO8F10c+hLWnZH7ETt0yrmhzy5CeZUi/eyWVOrZI5x6d5Hzb7hYSHMTPozYf
         ipcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727954952; x=1728559752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDA9NUNx9gSo2kRmc35eR3BkbtLwu7lBmRWMEDqyb+0=;
        b=aq3G9yH3Sgyduy2ZKCDUhL+FPzCwbjlSS7K8y0I1DmrKgAbQ4AOjr3C41mwAEQ5u8l
         0X+fhaPYEY4tWkrdbdcoQObOytbF7RN8fPSGJPBqdzeI9+34pzKh9DBREClWsBDjYmIB
         00p6AbQLyCUk7zgkm8oV2jTJ4fKDz4XMiOI9A1amlqkdkEZ1SuVklKv0VNgd74eAL38z
         LFi1A9zZJsiOJL0g7M3z3ruUEBZH+75j1wjQHdkWiDIEnVWP39aqsvrAxJLgOa+/gGU5
         aqKWM2G1uXuIVnh1UrJgejisKb8DEm2sZPMcOzMqMGL8RAdP+Ge70Xf1PuZYJXvkxz0b
         MAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkUH4Q7ADnSSuwNjIv/RX44TTO6SjdyQ/y3UBt4XGri0Qv1kcNj1VzA1gmT/D7FsfOA8RH3pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gVU+fSEKRWJtUBIfD/fYHB7qcwCkPtplbgTGOK5IXfCwCz+/
	8tQc7Edh2lgsIN1PWe7vu9Bf49exfDTrVAvi+YpWuqN0xsgotGqHGH52jatjQp0Sg62K2fi+n6O
	2
X-Google-Smtp-Source: AGHT+IGKBdcVDcUfhjcWU4LPho1BuvRf7cARd5UtflWnLAlYg+l9fMr57836UwiyVyTmk44DF5CG8g==
X-Received: by 2002:a05:6214:2b8d:b0:6cb:2cfa:3b9d with SMTP id 6a1803df08f44-6cb819d6288mr66848376d6.14.1727954952255;
        Thu, 03 Oct 2024 04:29:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb935cce42sm5674286d6.37.2024.10.03.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:29:10 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Brandon Duffany <brandon@buildbuddy.io>,
	stable@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH] sched: psi: fix bogus pressure spikes from aggregation race
Date: Thu,  3 Oct 2024 07:29:05 -0400
Message-ID: <20241003112905.1617308-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Brandon reports sporadic, non-sensical spikes in cumulative pressure
time (total=) when reading cpu.pressure at a high rate. This is due to
a race condition between reader aggregation and tasks changing states.

While it affects all states and all resources captured by PSI, in
practice it most likely triggers with CPU pressure, since scheduling
events are so frequent compared to other resource events.

The race context is the live snooping of ongoing stalls during a
pressure read. The read aggregates per-cpu records for stalls that
have concluded, but will also incorporate ad-hoc the duration of any
active state that hasn't been recorded yet. This is important to get
timely measurements of ongoing stalls. Those ad-hoc samples are
calculated on-the-fly up to the current time on that CPU; since the
stall hasn't concluded, it's expected that this is the minimum amount
of stall time that will enter the per-cpu records once it does.

The problem is that the path that concludes the state uses a CPU clock
read that is not synchronized against aggregators; the clock is read
outside of the seqlock protection. This allows aggregators to race and
snoop a stall with a longer duration than will actually be recorded.

With the recorded stall time being less than the last snapshot
remembered by the aggregator, a subsequent sample will underflow and
observe a bogus delta value, resulting in an erratic jump in pressure.

Fix this by moving the clock read of the state change into the seqlock
protection. This ensures no aggregation can snoop live stalls past the
time that's recorded when the state concludes.

Reported-by: Brandon Duffany <brandon@buildbuddy.io>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219194
Link: https://lore.kernel.org/lkml/20240827121851.GB438928@cmpxchg.org/
Fixes: df77430639c9 ("psi: Reduce calls to sched_clock() in psi")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 kernel/sched/psi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..84dad1511d1e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -769,12 +769,13 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
-			     unsigned int clear, unsigned int set, u64 now,
+			     unsigned int clear, unsigned int set,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	u32 state_mask;
+	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -789,6 +790,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * SOME and FULL time these may have resulted in.
 	 */
 	write_seqcount_begin(&groupc->seq);
+	now = cpu_clock(cpu);
 
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
@@ -899,18 +901,15 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	now = cpu_clock(cpu);
-
 	group = task_psi_group(task);
 	do {
-		psi_group_change(group, cpu, clear, set, now, true);
+		psi_group_change(group, cpu, clear, set, true);
 	} while ((group = group->parent));
 }
 
@@ -919,7 +918,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 {
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
-	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -936,7 +934,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				break;
 			}
 
-			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
 		} while ((group = group->parent));
 	}
 
@@ -974,7 +972,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		do {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, now, wake_clock);
+			psi_group_change(group, cpu, clear, set, wake_clock);
 		} while ((group = group->parent));
 
 		/*
@@ -986,7 +984,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, now, wake_clock);
+				psi_group_change(group, cpu, clear, set, wake_clock);
 		}
 	}
 }
@@ -997,8 +995,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now, irq;
 	s64 delta;
+	u64 irq;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1011,7 +1009,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	if (prev && task_psi_group(prev) == group)
 		return;
 
-	now = cpu_clock(cpu);
 	irq = irq_time_read(cpu);
 	delta = (s64)(irq - rq->psi_irq_time);
 	if (delta < 0)
@@ -1019,12 +1016,15 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	rq->psi_irq_time = irq;
 
 	do {
+		u64 now;
+
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
+		now = cpu_clock(cpu);
 
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
@@ -1223,11 +1223,9 @@ void psi_cgroup_restart(struct psi_group *group)
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 		struct rq_flags rf;
-		u64 now;
 
 		rq_lock_irq(rq, &rf);
-		now = cpu_clock(cpu);
-		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_group_change(group, cpu, 0, 0, true);
 		rq_unlock_irq(rq, &rf);
 	}
 }
-- 
2.46.2


