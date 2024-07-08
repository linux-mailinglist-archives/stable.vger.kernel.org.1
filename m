Return-Path: <stable+bounces-58235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB792A55A
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 17:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E9D1F219D7
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3111422C7;
	Mon,  8 Jul 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k017nLao";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6e1/oXj"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB178C9D;
	Mon,  8 Jul 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451238; cv=none; b=C0gdulT4iL6AHRb3MCrEI0yjX+OELbIqFsjc9om7yyXwtwlHKnrgY3/ENeV7pAMbeFDvYgeLsapSX1Z13LpqvlixbZPNPNcncD7zp8zIhNDchXHy+FIGaRQcnqdRiyhTLEPumd8sYyT75akQXp9eQ1pVAwCnTpWPWSU8CD9whS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451238; c=relaxed/simple;
	bh=OIcZ4yvbAqFyMbtgJuhVl5FwjY+lBaZ9k7HU+wq1Oac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LhZWZRq3CBEGxl98ikZ/0tyaVH3urBFoeSsgb1IwYxsrTnUGIULrWsTk3+MSX3rMWmk3bdiJY2/bUS1RbzfpSggP2IQkMeZ4mqUPH2R4Uljh02JCYF4Oq7kYKE26Nh5zrfDVhdJKqmOnDUl/39P/LCd0LXS7fBx23UZFc/sAiEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k017nLao; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6e1/oXj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 15:07:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720451229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1ZVjUzJvsr2xJy2juGDmmFGsxkflksjBZN9tPL+M8I=;
	b=k017nLaoLpXX85cU3qx8qBRpi478qkZlJz3Q1aHAuuqX53FpAq0MI6MyowratmLRNkdbQx
	qXC3S/lO0Z3APkCYT1bK0lMkMBHw9F9aYfmO37p+m/1jnqw1l1wJKIfM3enUW0cc4dRSKO
	ryRIMSlILix6uXtc9UNyQK/BYuv3RHUoukKEDFenozOSWD2z+GxW+EG4XG63I0ORF4LiIq
	PmEm+QWo5D98UfqTBVnjN+ryisUpCaFMKacJULR0itR31uZ4getTmf3zJ59Bt7SLUXrF5w
	30xkBB2l1eU4Eu02GOXNN2VlxjSVJnFOhOFwxKHHDgaI+K1Tl4jmqpIzIVAN5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720451229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1ZVjUzJvsr2xJy2juGDmmFGsxkflksjBZN9tPL+M8I=;
	b=Y6e1/oXj2M1KHyC6RIdJq+IQuvPiqP3YyLHCs/d2YGJKhKJXny6C8lxjJxoU4F2oONTwZm
	GFFl2Boz8VrcI5Cw==
From: "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: set_load_weight() must also call
 reweight_task() for SCHED_IDLE tasks
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, v4.15+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240624102331.GI31592@noisy.programming.kicks-ass.net>
References: <20240624102331.GI31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172045122848.2215.12289639638987417015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d329605287020c3d1c3b0dadc63d8208e7251382
Gitweb:        https://git.kernel.org/tip/d329605287020c3d1c3b0dadc63d8208e7251382
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Tue, 25 Jun 2024 15:29:58 -10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 15:59:52 +02:00

sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks

When a task's weight is being changed, set_load_weight() is called with
@update_load set. As weight changes aren't trivial for the fair class,
set_load_weight() calls fair.c::reweight_task() for fair class tasks.

However, set_load_weight() first tests task_has_idle_policy() on entry and
skips calling reweight_task() for SCHED_IDLE tasks. This is buggy as
SCHED_IDLE tasks are just fair tasks with a very low weight and they would
incorrectly skip load, vlag and position updates.

Fix it by updating reweight_task() to take struct load_weight as idle weight
can't be expressed with prio and making set_load_weight() call
reweight_task() for SCHED_IDLE tasks too when @update_load is set.

Fixes: 9059393e4ec1 ("sched/fair: Use reweight_entity() for set_user_nice()")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org # v4.15+
Link: http://lkml.kernel.org/r/20240624102331.GI31592@noisy.programming.kicks-ass.net
---
 kernel/sched/core.c  | 23 ++++++++++-------------
 kernel/sched/fair.c  |  7 +++----
 kernel/sched/sched.h |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d..7476834 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1328,27 +1328,24 @@ int tg_nop(struct task_group *tg, void *data)
 void set_load_weight(struct task_struct *p, bool update_load)
 {
 	int prio = p->static_prio - MAX_RT_PRIO;
-	struct load_weight *load = &p->se.load;
+	struct load_weight lw;
 
-	/*
-	 * SCHED_IDLE tasks get minimal weight:
-	 */
 	if (task_has_idle_policy(p)) {
-		load->weight = scale_load(WEIGHT_IDLEPRIO);
-		load->inv_weight = WMULT_IDLEPRIO;
-		return;
+		lw.weight = scale_load(WEIGHT_IDLEPRIO);
+		lw.inv_weight = WMULT_IDLEPRIO;
+	} else {
+		lw.weight = scale_load(sched_prio_to_weight[prio]);
+		lw.inv_weight = sched_prio_to_wmult[prio];
 	}
 
 	/*
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
-	} else {
-		load->weight = scale_load(sched_prio_to_weight[prio]);
-		load->inv_weight = sched_prio_to_wmult[prio];
-	}
+	if (update_load && p->sched_class == &fair_sched_class)
+		reweight_task(p, &lw);
+	else
+		p->se.load = lw;
 }
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b5838..f205e24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,15 +3835,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+void reweight_task(struct task_struct *p, const struct load_weight *lw)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct load_weight *load = &se->load;
-	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight);
-	load->inv_weight = sched_prio_to_wmult[prio];
+	reweight_entity(cfs_rq, se, lw->weight);
+	load->inv_weight = lw->inv_weight;
 }
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc..9ab5343 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2509,7 +2509,7 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
+extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);

