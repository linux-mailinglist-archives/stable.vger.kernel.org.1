Return-Path: <stable+bounces-226319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BWxLJmIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:00:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D92AEC56
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE8EF311D70E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDE3EAC6F;
	Tue, 17 Mar 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v400vHKk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D03179A3;
	Tue, 17 Mar 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766186; cv=none; b=q/11vhi0eThGl5Fwbyv0s/ytYlmhKqPo+ig8fyUJJodccv5LrL9b1qdsQPaewL1KBlaGRkcwWCdDfqLeJYqChgpBu+wNOi4/XnrylG02yiM+uRfL6UxJPkfdldja2jxm8MbEiokSbtEZN4nWdT4Ya/rqMXweCeB2lgVtAdOj+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766186; c=relaxed/simple;
	bh=dh9ysXpHxRQBqWo1NO42CUcHi6EpVTlGfV9KgYHM4r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdFiYG0diLDlQiVaMH3wNje0ytyvPMX8gbRFqV2CQASOponm+B6dkVmu9loNFdT3uxaEuabuRAl8iwgrFiXgxUy8lmxb7Nf8xFz53J2oji3DPHX/clKriROMcluoI8+r2Ae9oo26jGxPflZ5Otn6XE1mGwwTHlGPxNZysFU8hgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v400vHKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3EFC4CEF7;
	Tue, 17 Mar 2026 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766186;
	bh=dh9ysXpHxRQBqWo1NO42CUcHi6EpVTlGfV9KgYHM4r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v400vHKkQgVCO7wni4EvjD4tPchjab42AinZX9SHLjTON2CUgXlF5Iyy9xiuuQZ5b
	 CHGdXKGWL1YeT8MyjVVRMsJuAAyGOJOSY7vtEGJlDq7PPvVJQ4FV8V9FrN/WsbJFJg
	 vK+geQ3hl+xUVe6LCNqpZ0I+YCj3UnBKIT7GeN+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 188/378] sched/mmcid: Avoid full tasklist walks
Date: Tue, 17 Mar 2026 17:32:25 +0100
Message-ID: <20260317163013.922908954@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226319-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E8D92AEC56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 192d852129b1b7c4f0ddbab95d0de1efd5ee1405 ]

Chasing vfork()'ed tasks on a CID ownership mode switch requires a full
task list walk, which is obviously expensive on large systems.

Avoid that by keeping a list of tasks using a mm MMCID entity in mm::mm_cid
and walk this list instead. This removes the proven to be flaky counting
logic and avoids a full task list walk in the case of vfork()'ed tasks.

Fixes: fbd0e71dc370 ("sched/mmcid: Provide CID ownership mode fixup functions")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260310202526.183824481@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rseq_types.h |  6 ++++-
 kernel/fork.c              |  1 +
 kernel/sched/core.c        | 54 +++++++++-----------------------------
 3 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index ef0811379c540..a612959c5b17f 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -103,10 +103,12 @@ struct rseq_data { };
  * @active:	MM CID is active for the task
  * @cid:	The CID associated to the task either permanently or
  *		borrowed from the CPU
+ * @node:	Queued in the per MM MMCID list
  */
 struct sched_mm_cid {
 	unsigned int		active;
 	unsigned int		cid;
+	struct hlist_node	node;
 };
 
 /**
@@ -127,6 +129,7 @@ struct mm_cid_pcpu {
  * @work:		Regular work to handle the affinity mode change case
  * @lock:		Spinlock to protect against affinity setting which can't take @mutex
  * @mutex:		Mutex to serialize forks and exits related to this mm
+ * @user_list:		List of the MM CID users of a MM
  * @nr_cpus_allowed:	The number of CPUs in the per MM allowed CPUs map. The map
  *			is growth only.
  * @users:		The number of tasks sharing this MM. Separate from mm::mm_users
@@ -147,13 +150,14 @@ struct mm_mm_cid {
 
 	raw_spinlock_t		lock;
 	struct mutex		mutex;
+	struct hlist_head	user_list;
 
 	/* Low frequency modified */
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
 	unsigned int		pcpu_thrs;
 	unsigned int		update_deferred;
-}____cacheline_aligned_in_smp;
+} ____cacheline_aligned;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_mm_cid { };
 struct sched_mm_cid { };
diff --git a/kernel/fork.c b/kernel/fork.c
index 2d79096e0fecb..5b45887435dcc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -999,6 +999,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_SCHED_MM_CID
 	tsk->mm_cid.cid = MM_CID_UNSET;
 	tsk->mm_cid.active = 0;
+	INIT_HLIST_NODE(&tsk->mm_cid.node);
 #endif
 	return tsk;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c80076fcd78f2..011fe1b2ae911 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10568,13 +10568,10 @@ static inline void mm_cid_transit_to_cpu(struct task_struct *t, struct mm_cid_pc
 	}
 }
 
-static bool mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct *mm)
+static void mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct *mm)
 {
 	/* Remote access to mm::mm_cid::pcpu requires rq_lock */
 	guard(task_rq_lock)(t);
-	/* If the task is not active it is not in the users count */
-	if (!t->mm_cid.active)
-		return false;
 	if (cid_on_task(t->mm_cid.cid)) {
 		/* If running on the CPU, put the CID in transit mode, otherwise drop it */
 		if (task_rq(t)->curr == t)
@@ -10582,51 +10579,21 @@ static bool mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct *mm
 		else
 			mm_unset_cid_on_task(t);
 	}
-	return true;
 }
 
-static void mm_cid_do_fixup_tasks_to_cpus(struct mm_struct *mm)
+static void mm_cid_fixup_tasks_to_cpus(void)
 {
-	struct task_struct *p, *t;
-	unsigned int users;
-
-	/*
-	 * This can obviously race with a concurrent affinity change, which
-	 * increases the number of allowed CPUs for this mm, but that does
-	 * not affect the mode and only changes the CID constraints. A
-	 * possible switch back to per task mode happens either in the
-	 * deferred handler function or in the next fork()/exit().
-	 *
-	 * The caller has already transferred so remove it from the users
-	 * count. The incoming task is already visible and has mm_cid.active,
-	 * but has task::mm_cid::cid == UNSET. Still it needs to be accounted
-	 * for. Concurrent fork()s might add more threads, but all of them have
-	 * task::mm_cid::active = 0, so they don't affect the accounting here.
-	 */
-	users = mm->mm_cid.users - 1;
-
-	guard(rcu)();
-	for_other_threads(current, t) {
-		if (mm_cid_fixup_task_to_cpu(t, mm))
-			users--;
-	}
+	struct mm_struct *mm = current->mm;
+	struct task_struct *t;
 
-	if (!users)
-		return;
+	lockdep_assert_held(&mm->mm_cid.mutex);
 
-	/* Happens only for VM_CLONE processes. */
-	for_each_process_thread(p, t) {
-		if (t == current || t->mm != mm)
-			continue;
-		mm_cid_fixup_task_to_cpu(t, mm);
+	hlist_for_each_entry(t, &mm->mm_cid.user_list, mm_cid.node) {
+		/* Current has already transferred before invoking the fixup. */
+		if (t != current)
+			mm_cid_fixup_task_to_cpu(t, mm);
 	}
-}
-
-static void mm_cid_fixup_tasks_to_cpus(void)
-{
-	struct mm_struct *mm = current->mm;
 
-	mm_cid_do_fixup_tasks_to_cpus(mm);
 	mm_cid_complete_transit(mm, MM_CID_ONCPU);
 }
 
@@ -10635,6 +10602,7 @@ static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *mm)
 	lockdep_assert_held(&mm->mm_cid.lock);
 
 	t->mm_cid.active = 1;
+	hlist_add_head(&t->mm_cid.node, &mm->mm_cid.user_list);
 	mm->mm_cid.users++;
 	return mm_update_max_cids(mm);
 }
@@ -10692,6 +10660,7 @@ static bool sched_mm_cid_remove_user(struct task_struct *t)
 	/* Clear the transition bit */
 	t->mm_cid.cid = cid_from_transit_cid(t->mm_cid.cid);
 	mm_unset_cid_on_task(t);
+	hlist_del_init(&t->mm_cid.node);
 	t->mm->mm_cid.users--;
 	return mm_update_max_cids(t->mm);
 }
@@ -10834,6 +10803,7 @@ void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 	mutex_init(&mm->mm_cid.mutex);
 	mm->mm_cid.irq_work = IRQ_WORK_INIT_HARD(mm_cid_irq_work);
 	INIT_WORK(&mm->mm_cid.work, mm_cid_work_fn);
+	INIT_HLIST_HEAD(&mm->mm_cid.user_list);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
 }
-- 
2.51.0




