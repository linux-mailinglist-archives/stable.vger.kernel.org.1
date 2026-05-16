Return-Path: <stable+bounces-249015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLWAINWkCGpVzQMAu9opvQ
	(envelope-from <stable+bounces-249015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:09:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF8955CC4B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D7F9300A757
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0730EF63;
	Sat, 16 May 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag5kydUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B2381AF
	for <stable@vger.kernel.org>; Sat, 16 May 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951378; cv=none; b=Anl6jLi4KD8qCaXMSgckYc+HdSfpnXShE9pGUW+YvL8qlhNzq2rib5szCETi/5jyzI6WgdthmP87d/quh6erH5owwk8dzpssl/ZwNLN8KOSU4U/XXcAujQRlsrHua0QNnBDJ3X3w7tOAKZenXor3qWs2jjUwnu805Rv35jAVZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951378; c=relaxed/simple;
	bh=avja1c3muB5aNK53/UaHaJfeVEZuRT7fYut3+BUNLt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fidJ9q6HQSW5KHit4idYjGoCjNewDuHPaKnWcLG4PhYWOqiifO7Oqot1p0bukfeB0t8ozjBYe6CkRsvap8q6PKEUkZUi+d9vK48fAN9ZQ1P/j3y3WQwWfKxcf8jLzPJprnC/H4WaKtw1lb76E5o4RAq/VNAo6wtKG/td/xSMNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag5kydUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A291C19425;
	Sat, 16 May 2026 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951378;
	bh=avja1c3muB5aNK53/UaHaJfeVEZuRT7fYut3+BUNLt8=;
	h=From:Date:Subject:To:Cc:From;
	b=ag5kydUmTpTQAKdVMN7SdKDY8miGTuSmSg0iUg2aUknsWndOET1pt+xdlPKKsdK51
	 qtkxDISjzJdGbVCjLIUEKYu3Hto2roT+diyoidN5F2Ett0ijdtoICAZfK3JEUTjpaS
	 +PORvzyzp8DL6P/+Nv0Gh8Ar/Z70wy+oqvUT7u2gzdI3zzdTqRpr5vaxrGqJF4y1Vc
	 HSMV39zKuZjMjLxFXnjDEv31fCbbYK2QXc5zMP0q2gTdQROxlFnmAmCuGh72qs+gfQ
	 BsuZYKRNOZZg62iFlwfjXWXeZT3KlM+GNjPPFxcdVjessb1/sI4RqnnC/4NJn0e8MG
	 8jFrWpXKpL+9w==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 16 May 2026 19:09:16 +0200
Subject: [PATCH] ptrace: keep task's mm around in separate exit_mm field
 post-exit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
X-B4-Tracking: v=1; b=H4sIALukCGoC/yWM4Q6CIBRGX8XxOxoXBKVXaa1d4JLU1AZWbs53T
 +vn+fads7BCOVFhp2phmd6ppHHYAA4V8x0ON+IpbMykkEZoMPwz5genOU3XvucaHerohAkNsE1
 5Zopp/uXOlz+Xl7uTn/bG/nBYiLuMg+/2qccyUT4aCyboRqgQokXVRojGS+8bq1QLKGsiC7U3b
 F2/J0rfXLIAAAA=
X-Change-ID: 20260516-work-exit_mm-5aba5fb06d71
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
 Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
 Qualys Security Advisory <qsa@qualys.com>, Oleg Nesterov <oleg@redhat.com>, 
 Kees Cook <kees@kernel.org>, Minchan Kim <minchan@kernel.org>, 
 linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=9270; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5crXcMUcBASVL5GsYJiuXu/2zYrar/6ATXgspyBQxe0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRxLDmXfvfNurNPitNt3n+1czlh+WbZhsmJyak/FdJmq
 274atTwvqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi4byMDLv/lijZu3VK7nma
 NzWxdILp//SdCc+DT7kdlbZ8kVp36yzDPxsH+1TdF357t01OYZ2dV3P1RTh3GetyKZu9T7LkhPP
 3MwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: EBF8955CC4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249015-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jann Horn <jannh@google.com>

__ptrace_may_access() checks can happen on target tasks that are in the
middle of do_exit(), past exit_mm(). At that point, the ->mm pointer has
been NULLed out, and the mm_struct has been mmput().

Unfortunately, the mm_struct contains the dumpability and the user_ns in
which the task last went through execve(), and we need those for
__ptrace_may_access(). Currently, that problem is handled by failing open:
If the ->mm is gone, we assume that the task was dumpable. In some edge
cases, this could potentially expose access to things like
/proc/$pid/fd/$fd of originally non-dumpable processes.
(exit_files() comes after exit_mm(), so the file descriptor table is still
there when we've gone through exit_mm().)

I believe that this patch may be the least bad option to fix this - keep
the mm_struct (but not process memory) around with an mmgrab() reference
from exit_mm() until the task goes away completely.

Note that this moves free_task() down in order to make mmdrop_async()
available without a forward declaration.

Christian Brauner (Amutable) <brauner@kernel.org> says:

I massaged the patch a bit and rewrote parts of the commit message.

The cached task->user_dumpable bit introduced by commit 31e62c2ebbfd
("ptrace: slightly saner 'get_dumpable() logic'") is removed here: the
mmgrab'd exit_mm reference supplies the real dumpable flag and the
original user_ns. exit_mm() now publishes ->exit_mm before clearing ->mm
so that task_still_dumpable() readers cannot observe both NULL on a user
task.

Cc: stable@vger.kernel.org
Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace permission checks")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
In 2020 Jann actually pointed to the exact bug class that the recent
ptrace bug used and asked for a architecturally very clean fix to be
merged but it never got anywhere.

In the off-list ptrace discussion I brought up my intention to have this
merged on top. So this rebases Jann's patch [1] which addresses the root
cause directly: stash an mmgrab() reference to the mm_struct in
task->exit_mm during exit_mm(), and release it via mmdrop_async() in
free_task(). The pinned mm_struct keeps the address space metadata
(flags, user_ns) reachable for the full lifetime of the task_struct
without keeping the actual memory mappings alive. ptrace_may_access()
then simply takes the exit_mm into account. The exit_mm field is
separate and none of the other in-kernel callers need to change so
there's no regression risks.

Beyond ptrace, the fact that task->mm isn't accessible post-exit anymore
causes complications for other series. Minchan Kim's recent
PROCESS_MRELEASE_REAP_KILL series [2] describes the same shape from the
OOM-reaper side: process_mrelease() racing against do_exit() ends up with
task->mm and falls over with -ESRCH, deferring reclamation indefinitely
under Android LMKD pressure. That series works around it by moving the
SIGKILL injection into process_mrelease() itself, but the underlying
issue is identical: callers legitimately need to reach the mm of a task
after exit. That whole patch becomes rather simple with this fix.

Note that I had already brought this up with some mm folks that were
involved in the ptrace issue off-list.

Also note that the upstream patch has at least two regressions. Reading
the exit status from /proc/<pid>/stat and opening
/proc/<pid>/ns/{pid,user} of a zombie. The latter I've used multiple
times from inside a container for non-dumpable tasks for nested and
non-nested containers. Afaict, both will now be denied because we resort
to checking in the initial userns for non-dumpable tasks. And tools like
Incus do nested containers so I also suspect that anything that relies
on looking at the userns or pidns of zombies risks spurious failures.

I think we should do the clean thing and let ptrace look at the actual
mm state post exit. Keep it in a separate field and there's no
regression risk for users that expect task->mm itself to be NULL post
exit.

[1] https://lore.kernel.org/r/20201016024019.1882062-2-jannh@google.com
[2] https://lore.kernel.org/r/20260511214226.937793-1-minchan@kernel.org
---
 include/linux/sched.h |  4 +---
 kernel/exit.c         |  3 ++-
 kernel/fork.c         | 64 ++++++++++++++++++++++++++-------------------------
 kernel/ptrace.c       | 20 +++++++++++-----
 4 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee06cba5c6f5..7cefeb6cbba7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -961,6 +961,7 @@ struct task_struct {
 
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
+	struct mm_struct		*exit_mm;
 
 	int				exit_state;
 	int				exit_code;
@@ -1002,9 +1003,6 @@ struct task_struct {
 	unsigned			sched_rt_mutex:1;
 #endif
 
-	/* Save user-dumpable when mm goes away */
-	unsigned			user_dumpable:1;
-
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/exit.c b/kernel/exit.c
index f50d73c272d6..9af227c23e2b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -571,7 +571,8 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
-	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
+	mmgrab(mm);
+	current->exit_mm = mm;
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/fork.c b/kernel/fork.c
index 5f3fdfdb14c7..f43ea7f5888a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -528,37 +528,6 @@ void put_task_stack(struct task_struct *tsk)
 }
 #endif
 
-void free_task(struct task_struct *tsk)
-{
-#ifdef CONFIG_SECCOMP
-	WARN_ON_ONCE(tsk->seccomp.filter);
-#endif
-	release_user_cpus_ptr(tsk);
-	scs_release(tsk);
-
-#ifndef CONFIG_THREAD_INFO_IN_TASK
-	/*
-	 * The task is finally done with both the stack and thread_info,
-	 * so free both.
-	 */
-	release_task_stack(tsk);
-#else
-	/*
-	 * If the task had a separate stack allocation, it should be gone
-	 * by now.
-	 */
-	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) != 0);
-#endif
-	rt_mutex_debug_task_free(tsk);
-	ftrace_graph_exit_task(tsk);
-	arch_release_task_struct(tsk);
-	if (tsk->flags & PF_KTHREAD)
-		free_kthread_struct(tsk);
-	bpf_task_storage_free(tsk);
-	free_task_struct(tsk);
-}
-EXPORT_SYMBOL(free_task);
-
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	struct file *exe_file;
@@ -775,6 +744,39 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
+void free_task(struct task_struct *tsk)
+{
+#ifdef CONFIG_SECCOMP
+	WARN_ON_ONCE(tsk->seccomp.filter);
+#endif
+	release_user_cpus_ptr(tsk);
+	scs_release(tsk);
+
+#ifndef CONFIG_THREAD_INFO_IN_TASK
+	/*
+	 * The task is finally done with both the stack and thread_info,
+	 * so free both.
+	 */
+	release_task_stack(tsk);
+#else
+	/*
+	 * If the task had a separate stack allocation, it should be gone
+	 * by now.
+	 */
+	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) != 0);
+#endif
+	rt_mutex_debug_task_free(tsk);
+	ftrace_graph_exit_task(tsk);
+	arch_release_task_struct(tsk);
+	if (tsk->flags & PF_KTHREAD)
+		free_kthread_struct(tsk);
+	bpf_task_storage_free(tsk);
+	if (tsk->exit_mm)
+		mmdrop_async(tsk->exit_mm);
+	free_task_struct(tsk);
+}
+EXPORT_SYMBOL(free_task);
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 130043bfc209..2955a59c18cf 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -272,18 +272,26 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 	return ns_capable(ns, CAP_SYS_PTRACE);
 }
 
-static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
+/*
+ * Decide whether ptrace access to @task is allowed based on its mm.
+ * Reads the dumpable flag and user_ns from ->mm, or from ->exit_mm if
+ * the task has gone through exit_mm(). Note that kernel threads may have
+ * neither.
+ */
+static bool may_access_mm(struct task_struct *task, unsigned int mode)
 {
 	struct mm_struct *mm = task->mm;
+	struct user_namespace *mm_userns = &init_user_ns;
+
+	if (!mm)
+		mm = task->exit_mm;
 	if (mm) {
 		if (get_dumpable(mm) == SUID_DUMP_USER)
 			return true;
-		return ptrace_has_cap(mm->user_ns, mode);
+		mm_userns = mm->user_ns;
 	}
 
-	if (task->user_dumpable)
-		return true;
-	return ptrace_has_cap(&init_user_ns, mode);
+	return ptrace_has_cap(mm_userns, mode);
 }
 
 /* Returns 0 on success, -errno on denial. */
@@ -350,7 +358,7 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	 * Pairs with a write barrier in commit_creds().
 	 */
 	smp_rmb();
-	if (!task_still_dumpable(task, mode))
+	if (!may_access_mm(task, mode))
 		return -EPERM;
 
 	return security_ptrace_access_check(task, mode);

---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260516-work-exit_mm-5aba5fb06d71


