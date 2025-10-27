Return-Path: <stable+bounces-191330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E10C11DF1
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 23:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365DD189F4D3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48032E142;
	Mon, 27 Oct 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dnwQEVDM"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE532C944;
	Mon, 27 Oct 2025 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605055; cv=none; b=mIFwQ9fx3bjZ+WiLboy3+mfKs3AMyDrpRuuwt/3VZkvOjxkJNXjBHGB2kawuOrUszO59oXVJ7k0zVgplB2zpj3KhGt5urvw+dQsc+doOan0kgQUxiZMjfLRWYWhoAsW4aR+CwScxDWq1hwchP0oILsXbgvAwxZYgINXAHFe6OgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605055; c=relaxed/simple;
	bh=mv/138SExd+SnpMkX/Nl2TNAvtJy01cvP+WCYiYdv8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LyUBavHZOd/vGggr4NkfYSDte05ZRXaekLKulsU33uUCLizewfeLgLnjD2TatQ33ndVPV2mKrJomP/56SfZLFASK989sywt+BSHENm0qvbJ8tXzG1GtMuVD0OVL/j79RQWM6wwk1NHdnLaFeX4gpT3qILdbbYljVe54UzbV1Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dnwQEVDM; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 40673C0003F1;
	Mon, 27 Oct 2025 15:44:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 40673C0003F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1761605047;
	bh=mv/138SExd+SnpMkX/Nl2TNAvtJy01cvP+WCYiYdv8w=;
	h=From:To:Cc:Subject:Date:From;
	b=dnwQEVDM+R7UZIolto0h+fAz+PZW9OnFa/6sE7ggFukmQw8FDuWG3aZcnHoO2BYZk
	 ysyV5/pzQyEEyy5zq1aXgtn8Z5pv3a9ToeAipIasl9cb596/5FIyuNTQhud9A+UxTH
	 l9r90QYhkpKF+qWe8bDrm4I3jgI+I4XjBQnkM4v4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id CE3EB1800051E;
	Mon, 27 Oct 2025 15:44:06 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 5.10] sched/deadline: only set free_cpus for online runqueues
Date: Mon, 27 Oct 2025 15:43:45 -0700
Message-Id: <20251027224351.2893946-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 382748c05e58a9f1935f5a653c352422375566ea ]

Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
to reflect rd->online") introduced the cpudl_set/clear_freecpu
functions to allow the cpu_dl::free_cpus mask to be manipulated
by the deadline scheduler class rq_on/offline callbacks so the
mask would also reflect this state.

Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
from cpudl_find()") removed the check of the cpu_active_mask to
save some processing on the premise that the cpudl::free_cpus
mask already reflected the runqueue online state.

Unfortunately, there are cases where it is possible for the
cpudl_clear function to set the free_cpus bit for a CPU when the
deadline runqueue is offline. When this occurs while a CPU is
connected to the default root domain the flag may retain the bad
state after the CPU has been unplugged. Later, a different CPU
that is transitioning through the default root domain may push a
deadline task to the powered down CPU when cpudl_find sees its
free_cpus bit is set. If this happens the task will not have the
opportunity to run.

One example is outlined here:
https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com

Another occurs when the last deadline task is migrated from a
CPU that has an offlined runqueue. The dequeue_task member of
the deadline scheduler class will eventually call cpudl_clear
and set the free_cpus bit for the CPU.

This commit modifies the cpudl_clear function to be aware of the
online state of the deadline runqueue so that the free_cpus mask
can be updated appropriately.

It is no longer necessary to manage the mask outside of the
cpudl_set/clear functions so the cpudl_set/clear_freecpu
functions are removed. In addition, since the free_cpus mask is
now only updated under the cpudl lock the code was changed to
use the non-atomic __cpumask functions.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 kernel/sched/cpudeadline.c | 34 +++++++++-------------------------
 kernel/sched/cpudeadline.h |  4 +---
 kernel/sched/deadline.c    |  8 ++++----
 3 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8cb06c8c7eb1..fd28ba4e1a28 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -166,12 +166,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
  * cpudl_clear - remove a CPU from the cpudl max-heap
  * @cp: the cpudl max-heap context
  * @cpu: the target CPU
+ * @online: the online state of the deadline runqueue
  *
  * Notes: assumes cpu_rq(cpu)->lock is locked
  *
  * Returns: (void)
  */
-void cpudl_clear(struct cpudl *cp, int cpu)
+void cpudl_clear(struct cpudl *cp, int cpu, bool online)
 {
 	int old_idx, new_cpu;
 	unsigned long flags;
@@ -184,7 +185,7 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 	if (old_idx == IDX_INVALID) {
 		/*
 		 * Nothing to remove if old_idx was invalid.
-		 * This could happen if a rq_offline_dl is
+		 * This could happen if rq_online_dl or rq_offline_dl is
 		 * called for a CPU without -dl tasks running.
 		 */
 	} else {
@@ -195,9 +196,12 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 		cp->elements[new_cpu].idx = old_idx;
 		cp->elements[cpu].idx = IDX_INVALID;
 		cpudl_heapify(cp, old_idx);
-
-		cpumask_set_cpu(cpu, cp->free_cpus);
 	}
+	if (likely(online))
+		__cpumask_set_cpu(cpu, cp->free_cpus);
+	else
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
+
 	raw_spin_unlock_irqrestore(&cp->lock, flags);
 }
 
@@ -228,7 +232,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 		cp->elements[new_idx].cpu = cpu;
 		cp->elements[cpu].idx = new_idx;
 		cpudl_heapify_up(cp, new_idx);
-		cpumask_clear_cpu(cpu, cp->free_cpus);
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
 	} else {
 		cp->elements[old_idx].dl = dl;
 		cpudl_heapify(cp, old_idx);
@@ -237,26 +241,6 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 	raw_spin_unlock_irqrestore(&cp->lock, flags);
 }
 
-/*
- * cpudl_set_freecpu - Set the cpudl.free_cpus
- * @cp: the cpudl max-heap context
- * @cpu: rd attached CPU
- */
-void cpudl_set_freecpu(struct cpudl *cp, int cpu)
-{
-	cpumask_set_cpu(cpu, cp->free_cpus);
-}
-
-/*
- * cpudl_clear_freecpu - Clear the cpudl.free_cpus
- * @cp: the cpudl max-heap context
- * @cpu: rd attached CPU
- */
-void cpudl_clear_freecpu(struct cpudl *cp, int cpu)
-{
-	cpumask_clear_cpu(cpu, cp->free_cpus);
-}
-
 /*
  * cpudl_init - initialize the cpudl structure
  * @cp: the cpudl max-heap context
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index 0adeda93b5fb..ecff718d94ae 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -18,9 +18,7 @@ struct cpudl {
 #ifdef CONFIG_SMP
 int  cpudl_find(struct cpudl *cp, struct task_struct *p, struct cpumask *later_mask);
 void cpudl_set(struct cpudl *cp, int cpu, u64 dl);
-void cpudl_clear(struct cpudl *cp, int cpu);
+void cpudl_clear(struct cpudl *cp, int cpu, bool online);
 int  cpudl_init(struct cpudl *cp);
-void cpudl_set_freecpu(struct cpudl *cp, int cpu);
-void cpudl_clear_freecpu(struct cpudl *cp, int cpu);
 void cpudl_cleanup(struct cpudl *cp);
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6548bd90c5c3..85e4ef476686 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1414,7 +1414,7 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 	if (!dl_rq->dl_nr_running) {
 		dl_rq->earliest_dl.curr = 0;
 		dl_rq->earliest_dl.next = 0;
-		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpudl_clear(&rq->rd->cpudl, rq->cpu, rq->online);
 	} else {
 		struct rb_node *leftmost = dl_rq->root.rb_leftmost;
 		struct sched_dl_entity *entry;
@@ -2349,9 +2349,10 @@ static void rq_online_dl(struct rq *rq)
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
 
-	cpudl_set_freecpu(&rq->rd->cpudl, rq->cpu);
 	if (rq->dl.dl_nr_running > 0)
 		cpudl_set(&rq->rd->cpudl, rq->cpu, rq->dl.earliest_dl.curr);
+	else
+		cpudl_clear(&rq->rd->cpudl, rq->cpu, true);
 }
 
 /* Assumes rq->lock is held */
@@ -2360,8 +2361,7 @@ static void rq_offline_dl(struct rq *rq)
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
 
-	cpudl_clear(&rq->rd->cpudl, rq->cpu);
-	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
+	cpudl_clear(&rq->rd->cpudl, rq->cpu, false);
 }
 
 void __init init_sched_dl_class(void)
-- 
2.34.1


