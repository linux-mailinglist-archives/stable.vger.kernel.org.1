Return-Path: <stable+bounces-249656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HvSCJ+kDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:57:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75C5835B8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CD6C3045ABF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F063DDDD7;
	Tue, 19 May 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOvHGkC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA713DB32A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213467; cv=none; b=nCdvpm/fki37vpzLK9uIPCHm2OCNGSc25I68UXHrku2CzoB/saA//JUyCFCujH0SfMh0R13uX8KZvOW+Xs8Hdu5FznTcDVgi8kpSd+5JK+SbnVDTLooFphBvkSO+VKoCDvm5h3zt2ctYsU7kQBIV+OVlbDc0UKplrbSV9ox+e4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213467; c=relaxed/simple;
	bh=CxhxUNccYeN/UZae4LYUDNAqA6k3+rcL/ufVTGRhKec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+gDuXggriug0o7BeWGm3fHNLiS2i+zvCrIVsi+rwkmA8PLw+EDNgeRMlWiE6NUsnDEGFC605bZ0MMmjQ8kCQCCEMQpulr5jJ0E5LnPqnE9URortcHHgxxbJe+9DB9OW5mPfuSWoUUrgjjwlH1nATals59LFq7UBjsQCI8ggWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOvHGkC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4542C2BCC6;
	Tue, 19 May 2026 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779213466;
	bh=CxhxUNccYeN/UZae4LYUDNAqA6k3+rcL/ufVTGRhKec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOvHGkC/DCcBKF2uPB1L7nNec6cDN4Ixsml/ptKFoeh/pdEnII0S+Nej41HDjJFEk
	 +ySXlbmmkYTcTsYZ/H845KFfvkarb+pQQMD5wnIdsYHlh5mM9u/Tg+wYwf+HlApD51
	 TRd4kixvFxcX17yuNAYaOGBQIdURVPUh/1hylwhNxJbleYFbpeQXTgPXlNoGE9XDhd
	 O7EWJo9iIP8zGJN2hIk/CajB6usPOORwBozNQdI8ql7eWy2vhzYXJtl7YIG6GT4AjG
	 UwAOTZTp35QrBqBGAmo2kWEnMfy1M2Tkg3mzcrIjq1KJuR9bx2JVEKbY6qcI4mLWYa
	 FIyxXy2fGuRQA==
Date: Tue, 19 May 2026 19:57:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Qualys Security Advisory <qsa@qualys.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field
 post-exit
Message-ID: <20260519-anfahren-absuchen-715be2b88075@brauner>
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
 <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
 <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
 <CAG48ez0Gz_GghVeVzaixAQRNYBdWHYEj3K6FXBSzc+8WNsFxtA@mail.gmail.com>
 <20260519-gehversuche-lokomotive-cd720c53bab1@brauner>
 <20260519-lehrling-backt-261d022de809@brauner>
 <CAHk-=wj+NgoDH3GSicJ140SV8OoDd71pLmL3fgFEsTcgoMC6Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nz3gimyp3ud3qlus"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+NgoDH3GSicJ140SV8OoDd71pLmL3fgFEsTcgoMC6Og@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249656-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB75C5835B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--nz3gimyp3ud3qlus
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, May 19, 2026 at 09:35:06AM -0700, Linus Torvalds wrote:
> On Tue, 19 May 2026 at 08:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > One thing I played with is to move dumpability and exec namespace into
> > struct task_exec_state which hangs around until the task is freed.
> 
> I like that just because it would actually make *sense* to have some
> kind of "this is the state that we got at execve time", and just share
> it across all processes that started from that execve.
> 
> But I'd go much further than you presumably did - I'd not tie it to
> 'struct mm_struct' AT ALL. Even a regular fork() would just keep the
> "this is the execve() that started this all".
> 
> Because I'm not 100% convinced we really want to synchronize any of
> this with 'struct mm_struct'. Yes, it's what the historical behavior
> is, but does it really make a lot of sense?
> 
> In reality, all "normal" programs will either share nothing, or share
> everything. And in many ways, 'struct mm_struct' is not really special
> wrt any of the other things we're sharing. Certainly not for anything
> that uses
> 
>     ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> 
> which literally has nothing to do with the mm.
> 
> For that one, it would actually make more sense to have dumpability
> flag be about 'struct files_struct' (or 'struct fs_struct'). But
> keeping it all in some "this was the exec that gave us the original
> rules" would actually make a *lot* more sense, even if it then got
> shared between fork() cases.
> 
> Because imaging that you had a setuid process that started out with
> elevated privileges, and then forked a lot of helpers. Those helpers
> still have information that may be privileged, and if they do a
> 'setreuid()' to drop privileges, that information may still be valid.
> 
> Only when it really does a new exec has it changed "domains".
> 
> Now *that* would actually make a ton of sense to me. And perhaps more
> importantly, that kind of "this is the state we got at execve time"
> could then contain the actual execve credentials and namespace, so
> then ptrace_may_access() could really use *that* information, and not
> the odd hodgepodge of "mm->dumpable" and "cred->user_ns" and
> "mm->user_ns".
> 
> Again: what makes "cred->user_ns" and "mm->user_ns" so special - and
> we use both of them for different cred tests - but then we happily
> cross pid namespaces, for example, as long as the kernel mapping is
> the same?
> 
> So I think having a "exec context" would make a *lot* of sense. And be
> quite conceptually simple: it would basically be a subset of our
> existing 'bprm', except it would be attached to the thread, and then
> clone - all forms of it - would just increase the refcount on it.
> 
> Yes, this would be *very* different from the current 'tied to 'struct
> mm_struct'" model, and very visibly so across fork(), but I really
> think it would finally make all of it make *sense*.
> 
> Think of the fundamental race of a suid binary that then does a
> fork(), drops privileges in the child, and does an 'execve()'. The
> child process really has a *lot* of potentially very sensitive
> information in its mm, but currently we think it's all accessible to
> the user that matches the dropped privileges. Isn't that fundamentally
> wrong? Having a exec_state would fix it very naturally..

I failed to actually append the thing I intended to append...
So for completeness sake I'm resending it here.

--nz3gimyp3ud3qlus
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-sched-introduce-struct-task_exec_state.patch"

 arch/arm64/kernel/mte.c          | 13 ++++--
 drivers/firmware/efi/efi.c       |  1 -
 fs/coredump.c                    | 22 ++++-----
 fs/exec.c                        | 62 +++++++++++++++++++------
 fs/pidfs.c                       | 22 ++++-----
 fs/proc/base.c                   | 41 ++++++++--------
 include/linux/binfmts.h          |  2 +
 include/linux/coredump.h         |  4 ++
 include/linux/mm_types.h         |  9 ++--
 include/linux/sched.h            |  7 +--
 include/linux/sched/coredump.h   | 50 +++++++-------------
 include/linux/sched/exec_state.h | 22 +++++++++
 init/init_task.c                 | 10 ++++
 kernel/cred.c                    |  2 +-
 kernel/exit.c                    |  1 -
 kernel/fork.c                    | 80 +++++++++++++++++++++++++++++---
 kernel/kthread.c                 |  1 -
 kernel/ptrace.c                  | 32 ++++++-------
 kernel/sys.c                     |  6 +--
 mm/init-mm.c                     |  1 -
 20 files changed, 248 insertions(+), 140 deletions(-)
 create mode 100644 include/linux/sched/exec_state.h

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6874b16d0657..76bc51cd0564 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/prctl.h>
 #include <linux/sched.h>
+#include <linux/sched/exec_state.h>
 #include <linux/sched/mm.h>
 #include <linux/string.h>
 #include <linux/swap.h>
@@ -531,22 +532,26 @@ static int access_remote_tags(struct task_struct *tsk, unsigned long addr,
 			      struct iovec *kiov, unsigned int gup_flags)
 {
 	struct mm_struct *mm;
+	bool allowed;
 	int ret;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
 		return -EPERM;
 
-	if (!tsk->ptrace || (current != tsk->parent) ||
-	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
-	     !ptracer_capable(tsk, mm->user_ns))) {
+	rcu_read_lock();
+	allowed = tsk->ptrace && (current == tsk->parent) &&
+		  ((get_dumpable(tsk) == TASK_DUMPABLE_OWNER) ||
+		   ptracer_capable(tsk, tsk->exec_state->user_ns));
+	rcu_read_unlock();
+
+	if (!allowed) {
 		mmput(mm);
 		return -EPERM;
 	}
 
 	ret = __access_remote_tags(mm, addr, kiov, gup_flags);
 	mmput(mm);
-
 	return ret;
 }
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d04be38f1750..ae78bc021b41 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -73,7 +73,6 @@ struct mm_struct efi_mm = {
 	MMAP_LOCK_INITIALIZER(efi_mm)
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
-	.user_ns		= &init_user_ns,
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock		= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.mm_cid.lock),
 #endif
diff --git a/fs/coredump.c b/fs/coredump.c
index bb6fdb1f458e..dae8a0dec219 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -395,8 +395,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 							  cred->gid));
 				break;
 			case 'd':
-				err = cn_printf(cn, "%d",
-					__get_dumpable(cprm->mm_flags));
+				err = cn_printf(cn, "%d", cprm->dumpable);
 				break;
 			/* signal that caused the coredump */
 			case 's':
@@ -869,11 +868,11 @@ static inline void coredump_sock_shutdown(struct file *file) { }
 static inline bool coredump_socket(struct core_name *cn, struct coredump_params *cprm) { return false; }
 #endif
 
-/* cprm->mm_flags contains a stable snapshot of dumpability flags. */
+/* cprm->dumpable is the snapshot of task dumpability at dump start. */
 static inline bool coredump_force_suid_safe(const struct coredump_params *cprm)
 {
 	/* Require nonrelative corefile path and be extra careful. */
-	return __get_dumpable(cprm->mm_flags) == SUID_DUMP_ROOT;
+	return cprm->dumpable == TASK_DUMPABLE_ROOT;
 }
 
 static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
@@ -1085,7 +1084,7 @@ static inline bool coredump_skip(const struct coredump_params *cprm,
 		return true;
 	if (!binfmt->core_dump)
 		return true;
-	if (!__get_dumpable(cprm->mm_flags))
+	if (cprm->dumpable == TASK_DUMPABLE_OFF)
 		return true;
 	return false;
 }
@@ -1170,14 +1169,9 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
 		.limit = rlimit(RLIMIT_CORE),
-		/*
-		 * We must use the same mm->flags while dumping core to avoid
-		 * inconsistency of bit flags, since this flag is not protected
-		 * by any locks.
-		 *
-		 * Note that we only care about MMF_DUMP* flags.
-		 */
-		.mm_flags = __mm_flags_get_dumpable(mm),
+		/* Snapshot MMF_DUMP_FILTER_* (unlocked) and dumpable for the dump. */
+		.mm_flags = __mm_flags_get_word(mm),
+		.dumpable = get_dumpable(current),
 		.vma_meta = NULL,
 		.cpu = raw_smp_processor_id(),
 	};
@@ -1419,7 +1413,7 @@ EXPORT_SYMBOL(dump_align);
 
 void validate_coredump_safety(void)
 {
-	if (suid_dumpable == SUID_DUMP_ROOT &&
+	if (suid_dumpable == TASK_DUMPABLE_ROOT &&
 	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != '@') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
diff --git a/fs/exec.c b/fs/exec.c
index ba12b4c466f6..e9695ecefd18 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
+#include <linux/sched/exec_state.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
@@ -263,6 +264,9 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	if (!mm)
 		goto err;
 
+	/* Staged for would_dump() narrowing; consumed by begin_new_exec(). */
+	bprm->user_ns = get_user_ns(current_user_ns());
+
 	/* Save current stack limit for all calculations made during exec. */
 	task_lock(current->group_leader);
 	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
@@ -834,10 +838,11 @@ EXPORT_SYMBOL(read_code);
  * On success, this function returns with exec_update_lock
  * held for writing.
  */
-static int exec_mmap(struct mm_struct *mm)
+static int exec_mmap(struct mm_struct *mm, struct task_exec_state *new_es)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
+	struct task_exec_state *old_es;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
@@ -870,6 +875,7 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->active_mm = mm;
 	tsk->mm = mm;
 	mm_init_cid(mm, tsk);
+	old_es = rcu_replace_pointer(tsk->exec_state, new_es, true);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
@@ -884,6 +890,7 @@ static int exec_mmap(struct mm_struct *mm)
 		local_irq_enable();
 	lru_gen_add_mm(mm);
 	task_unlock(tsk);
+	put_task_exec_state(old_es);
 	lru_gen_use_mm(mm);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
@@ -1091,6 +1098,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
+	struct task_exec_state *new_exec_state;
 	int retval;
 
 	/* Once we are committed compute the creds */
@@ -1141,13 +1149,22 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (bprm->have_execfd)
 		would_dump(bprm, bprm->executable);
 
+	/* Allocate before exec_mmap() commits so failure is reversible. */
+	new_exec_state = alloc_task_exec_state(bprm->user_ns);
+	if (!new_exec_state) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
 	/*
 	 * Release all of the old mmap stuff
 	 */
 	acct_arg_size(bprm, 0);
-	retval = exec_mmap(bprm->mm);
-	if (retval)
+	retval = exec_mmap(bprm->mm, new_exec_state);
+	if (retval) {
+		put_task_exec_state(new_exec_state);
 		goto out;
+	}
 
 	bprm->mm = NULL;
 
@@ -1210,9 +1227,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
 	    !(uid_eq(current_euid(), current_uid()) &&
 	      gid_eq(current_egid(), current_gid())))
-		set_dumpable(current->mm, suid_dumpable);
+		set_dumpable(suid_dumpable);
 	else
-		set_dumpable(current->mm, SUID_DUMP_USER);
+		set_dumpable(TASK_DUMPABLE_OWNER);
 
 	perf_event_exec();
 
@@ -1261,7 +1278,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * wait until new credentials are committed
 	 * by commit_creds() above
 	 */
-	if (get_dumpable(me->mm) != SUID_DUMP_USER)
+	if (get_dumpable(me) != TASK_DUMPABLE_OWNER)
 		perf_event_exit_task(me);
 	/*
 	 * cred_guard_mutex must be held at least to this point to prevent
@@ -1298,14 +1315,14 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
-		/* Ensure mm->user_ns contains the executable */
-		user_ns = old = bprm->mm->user_ns;
+		/* Ensure bprm->user_ns contains the executable. */
+		user_ns = old = bprm->user_ns;
 		while ((user_ns != &init_user_ns) &&
 		       !privileged_wrt_inode_uidgid(user_ns, idmap, inode))
 			user_ns = user_ns->parent;
 
 		if (old != user_ns) {
-			bprm->mm->user_ns = get_user_ns(user_ns);
+			bprm->user_ns = get_user_ns(user_ns);
 			put_user_ns(old);
 		}
 	}
@@ -1375,6 +1392,8 @@ static void free_bprm(struct linux_binprm *bprm)
 		acct_arg_size(bprm, 0);
 		mmput(bprm->mm);
 	}
+	if (bprm->user_ns)
+		put_user_ns(bprm->user_ns);
 	free_arg_pages(bprm);
 	if (bprm->cred) {
 		/* in case exec fails before de_thread() succeeds */
@@ -1906,14 +1925,29 @@ void set_binfmt(struct linux_binfmt *new)
 EXPORT_SYMBOL(set_binfmt);
 
 /*
- * set_dumpable stores three-value SUID_DUMP_* into mm->flags.
+ * Store TASK_DUMPABLE_* on current->exec_state.  All callers
+ * (commit_creds, begin_new_exec, prctl(PR_SET_DUMPABLE)) act on the
+ * running task, which guarantees ->exec_state is allocated and cannot
+ * be replaced under us.
  */
-void set_dumpable(struct mm_struct *mm, int value)
+void set_dumpable(enum task_dumpable value)
 {
-	if (WARN_ON((unsigned)value > SUID_DUMP_ROOT))
-		return;
+	struct task_exec_state *es;
+
+	if (WARN_ON(value > TASK_DUMPABLE_ROOT))
+		value = TASK_DUMPABLE_OFF;
+
+	es = rcu_dereference_protected(current->exec_state, true);
+	WRITE_ONCE(es->dumpable, value);
+}
+
+enum task_dumpable get_dumpable(struct task_struct *task)
+{
+	struct task_exec_state *es;
 
-	__mm_flags_set_mask_dumpable(mm, value);
+	guard(rcu)();
+	es = rcu_dereference(task->exec_state);
+	return READ_ONCE(es->dumpable);
 }
 
 static inline struct user_arg_ptr native_arg(const char __user *const __user *p)
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1cce4f34a051..0d6d0152de0b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -338,14 +338,14 @@ static inline bool pid_in_current_pidns(const struct pid *pid)
 	return false;
 }
 
-static __u32 pidfs_coredump_mask(unsigned long mm_flags)
+static __u32 pidfs_coredump_mask(enum task_dumpable dumpable)
 {
-	switch (__get_dumpable(mm_flags)) {
-	case SUID_DUMP_USER:
+	switch (dumpable) {
+	case TASK_DUMPABLE_OWNER:
 		return PIDFD_COREDUMP_USER;
-	case SUID_DUMP_ROOT:
+	case TASK_DUMPABLE_ROOT:
 		return PIDFD_COREDUMP_ROOT;
-	case SUID_DUMP_DISABLE:
+	case TASK_DUMPABLE_OFF:
 		return PIDFD_COREDUMP_SKIP;
 	default:
 		WARN_ON_ONCE(true);
@@ -434,13 +434,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	if ((mask & PIDFD_INFO_COREDUMP) && !kinfo.coredump_mask) {
 		guard(task_lock)(task);
-		if (task->mm) {
-			unsigned long flags = __mm_flags_get_dumpable(task->mm);
-
-			kinfo.coredump_mask = pidfs_coredump_mask(flags);
-			kinfo.mask |= PIDFD_INFO_COREDUMP;
-			/* No coredump actually took place, so no coredump signal. */
-		}
+		kinfo.coredump_mask = pidfs_coredump_mask(get_dumpable(task));
+		kinfo.mask |= PIDFD_INFO_COREDUMP;
+		/* No coredump actually took place, so no coredump signal. */
 	}
 
 	/* Unconditionally return identifiers and credentials, the rest only on request */
@@ -779,7 +775,7 @@ void pidfs_coredump(const struct coredump_params *cprm)
 	VFS_WARN_ON_ONCE(attr == PIDFS_PID_DEAD);
 
 	/* Note how we were coredumped and that we coredumped. */
-	attr->coredump_mask = pidfs_coredump_mask(cprm->mm_flags) |
+	attr->coredump_mask = pidfs_coredump_mask(cprm->dumpable) |
 			      PIDFD_COREDUMPED;
 	/* If coredumping is set to skip we should never end up here. */
 	VFS_WARN_ON_ONCE(attr->coredump_mask & PIDFD_COREDUMP_SKIP);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..c32d15f144bb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -91,6 +91,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/exec_state.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
@@ -1903,28 +1904,26 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	 * made this apply to all per process world readable and executable
 	 * directories.
 	 */
-	if (mode != (S_IFDIR|S_IRUGO|S_IXUGO)) {
-		struct mm_struct *mm;
-		task_lock(task);
-		mm = task->mm;
-		/* Make non-dumpable tasks owned by some root */
-		if (mm) {
-			if (get_dumpable(mm) != SUID_DUMP_USER) {
-				struct user_namespace *user_ns = mm->user_ns;
-
-				uid = make_kuid(user_ns, 0);
-				if (!uid_valid(uid))
-					uid = GLOBAL_ROOT_UID;
-
-				gid = make_kgid(user_ns, 0);
-				if (!gid_valid(gid))
-					gid = GLOBAL_ROOT_GID;
-			}
-		} else {
+	if (mode != (S_IFDIR|S_IRUGO|S_IXUGO) &&
+	    get_dumpable(task) != TASK_DUMPABLE_OWNER) {
+		struct user_namespace *user_ns;
+
+		/*
+		 * task->exec_state outlives exit_mm(), so zombies in a
+		 * user_ns container keep their captured user_ns here
+		 * instead of being uniformly hidden as GLOBAL_ROOT.
+		 */
+		rcu_read_lock();
+		user_ns = rcu_dereference(task->exec_state)->user_ns;
+
+		uid = make_kuid(user_ns, 0);
+		if (!uid_valid(uid))
 			uid = GLOBAL_ROOT_UID;
+
+		gid = make_kgid(user_ns, 0);
+		if (!gid_valid(gid))
 			gid = GLOBAL_ROOT_GID;
-		}
-		task_unlock(task);
+		rcu_read_unlock();
 	}
 	*ruid = uid;
 	*rgid = gid;
@@ -2965,7 +2964,7 @@ static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
 	ret = 0;
 	mm = get_task_mm(task);
 	if (mm) {
-		unsigned long flags = __mm_flags_get_dumpable(mm);
+		unsigned long flags = __mm_flags_get_word(mm);
 
 		len = snprintf(buffer, sizeof(buffer), "%08lx\n",
 			       ((flags & MMF_DUMP_FILTER_MASK) >>
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 65abd5ab8836..a8379f4eee61 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -25,6 +25,8 @@ struct linux_binprm {
 	struct page *page[MAX_ARG_PAGES];
 #endif
 	struct mm_struct *mm;
+	/* user_ns published to task->exec_state at execve, narrowed by would_dump(). */
+	struct user_namespace *user_ns;
 	unsigned long p; /* current top of mem */
 	unsigned int
 		/* Should an execfd be passed to userspace? */
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 68861da4cf7c..7b38ee2e7913 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/sched/coredump.h>
 #include <asm/siginfo.h>
 
 #ifdef CONFIG_COREDUMP
@@ -20,7 +21,10 @@ struct coredump_params {
 	const kernel_siginfo_t *siginfo;
 	struct file *file;
 	unsigned long limit;
+	/* MMF_DUMP_FILTER_* bits, snapshot of mm->flags at dump start. */
 	unsigned long mm_flags;
+	/* Snapshot of dumpable at dump start. */
+	enum task_dumpable dumpable;
 	int cpu;
 	loff_t written;
 	loff_t pos;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..9588ce3b16df 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1342,7 +1342,6 @@ struct mm_struct {
 		 */
 		struct task_struct __rcu *owner;
 #endif
-		struct user_namespace *user_ns;
 
 		/* store ref to file /proc/<pid>/exe symlink points to */
 		struct file __rcu *exe_file;
@@ -1907,11 +1906,11 @@ enum {
 /* mm flags */
 
 /*
- * The first two bits represent core dump modes for set-user-ID,
- * the modes are SUID_DUMP_* defined in linux/sched/coredump.h
+ * Bits 0 and 1 were dumpability; that moved to task->exec_state.  Reserve
+ * the bits so MMF_DUMP_FILTER_* positions stay stable for the
+ * /proc/<pid>/coredump_filter ABI.
  */
 #define MMF_DUMPABLE_BITS 2
-#define MMF_DUMPABLE_MASK (BIT(MMF_DUMPABLE_BITS) - 1)
 /* coredump filter bits */
 #define MMF_DUMP_ANON_PRIVATE	2
 #define MMF_DUMP_ANON_SHARED	3
@@ -1972,7 +1971,7 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
-#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
+#define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee06cba5c6f5..f74350f50901 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -85,6 +85,7 @@ struct seq_file;
 struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
+struct task_exec_state;
 struct task_group;
 struct task_struct;
 struct timespec64;
@@ -962,6 +963,9 @@ struct task_struct {
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
 
+	/* Exec-time state outliving exit_mm(); see <linux/sched/exec_state.h>. */
+	struct task_exec_state __rcu	*exec_state;
+
 	int				exit_state;
 	int				exit_code;
 	int				exit_signal;
@@ -1002,9 +1006,6 @@ struct task_struct {
 	unsigned			sched_rt_mutex:1;
 #endif
 
-	/* Save user-dumpable when mm goes away */
-	unsigned			user_dumpable:1;
-
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 624fda17a785..ea4abb8b3970 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -2,43 +2,25 @@
 #ifndef _LINUX_SCHED_COREDUMP_H
 #define _LINUX_SCHED_COREDUMP_H
 
-#include <linux/mm_types.h>
-
-#define SUID_DUMP_DISABLE	0	/* No setuid dumping */
-#define SUID_DUMP_USER		1	/* Dump as user of process */
-#define SUID_DUMP_ROOT		2	/* Dump as root */
-
-static inline unsigned long __mm_flags_get_dumpable(const struct mm_struct *mm)
-{
-	/*
-	 * By convention, dumpable bits are contained in first 32 bits of the
-	 * bitmap, so we can simply access this first unsigned long directly.
-	 */
-	return __mm_flags_get_word(mm);
-}
-
-static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
-{
-	__mm_flags_set_mask_bits_word(mm, MMF_DUMPABLE_MASK, value);
-}
-
-extern void set_dumpable(struct mm_struct *mm, int value);
 /*
- * This returns the actual value of the suid_dumpable flag. For things
- * that are using this for checking for privilege transitions, it must
- * test against SUID_DUMP_USER rather than treating it as a boolean
- * value.
+ * Task dumpability mode.  Gates core dump production and ptrace_attach()
+ * authorization.  The numeric values are stable ABI (suid_dumpable
+ * sysctl, prctl(PR_SET_DUMPABLE)); do not renumber.
  */
-static inline int __get_dumpable(unsigned long mm_flags)
-{
-	return mm_flags & MMF_DUMPABLE_MASK;
-}
+enum task_dumpable {
+	TASK_DUMPABLE_OFF	= 0,	/* no dump; ptrace needs CAP_SYS_PTRACE */
+	TASK_DUMPABLE_OWNER	= 1,	/* default; dump and ptrace by uid match */
+	TASK_DUMPABLE_ROOT	= 2,	/* dump as root; ptrace needs CAP_SYS_PTRACE */
+};
 
-static inline int get_dumpable(struct mm_struct *mm)
-{
-	unsigned long flags = __mm_flags_get_dumpable(mm);
+struct task_struct;
 
-	return __get_dumpable(flags);
-}
+/*
+ * Per-task dumpability lives in task->exec_state; safe to read at any
+ * point in the task's lifetime, including after exit_mm().  Writes only
+ * apply to the running task; reads work on any task.
+ */
+void set_dumpable(enum task_dumpable value);
+enum task_dumpable get_dumpable(struct task_struct *task);
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/linux/sched/exec_state.h b/include/linux/sched/exec_state.h
new file mode 100644
index 000000000000..759acc3d7a7f
--- /dev/null
+++ b/include/linux/sched/exec_state.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_EXEC_STATE_H
+#define _LINUX_SCHED_EXEC_STATE_H
+
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/sched/coredump.h>
+
+struct user_namespace;
+
+struct task_exec_state {
+	refcount_t		count;
+	enum task_dumpable	dumpable;
+	struct user_namespace	*user_ns;
+	struct rcu_head		rcu;
+};
+
+struct task_exec_state *alloc_task_exec_state(struct user_namespace *user_ns);
+struct task_exec_state *dup_task_exec_state(const struct task_exec_state *old);
+void put_task_exec_state(struct task_exec_state *es);
+
+#endif /* _LINUX_SCHED_EXEC_STATE_H */
diff --git a/init/init_task.c b/init/init_task.c
index b5f48ebdc2b6..47a651b05058 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -7,6 +7,8 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
 #include <linux/sched/ext.h>
+#include <linux/sched/exec_state.h>
+#include <linux/user_namespace.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
@@ -56,6 +58,13 @@ static struct sighand_struct init_sighand = {
 	.signalfd_wqh	= __WAIT_QUEUE_HEAD_INITIALIZER(init_sighand.signalfd_wqh),
 };
 
+/* init to 2 - one for init_task, one to ensure it is never freed */
+static struct task_exec_state init_task_exec_state = {
+	.count		= REFCOUNT_INIT(2),
+	.dumpable	= TASK_DUMPABLE_OWNER,
+	.user_ns	= &init_user_ns,
+};
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
 	[(SCS_SIZE / sizeof(long)) - 1] = SCS_END_MAGIC
@@ -113,6 +122,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
+	.exec_state	= &init_task_exec_state,
 	.restart_block	= {
 		.fn = do_no_restart_syscall,
 	},
diff --git a/kernel/cred.c b/kernel/cred.c
index 12a7b1ce5131..ac855c15b51e 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -385,7 +385,7 @@ int commit_creds(struct cred *new)
 	    !gid_eq(old->fsgid, new->fsgid) ||
 	    !cred_cap_issubset(old, new)) {
 		if (task->mm)
-			set_dumpable(task->mm, suid_dumpable);
+			set_dumpable(suid_dumpable);
 		task->pdeath_signal = 0;
 		/*
 		 * If a task drops privileges and becomes nondumpable,
diff --git a/kernel/exit.c b/kernel/exit.c
index f50d73c272d6..9a909993ab1d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -571,7 +571,6 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
-	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/fork.c b/kernel/fork.c
index 5f3fdfdb14c7..d76eb936482c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -23,6 +23,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/ext.h>
+#include <linux/sched/exec_state.h>
 #include <linux/seq_file.h>
 #include <linux/rtmutex.h>
 #include <linux/init.h>
@@ -468,6 +469,9 @@ void thread_stack_cache_init(void)
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
 
+/* SLAB cache for task_exec_state structures (one per task_struct) */
+static struct kmem_cache *task_exec_state_cachep;
+
 /* SLAB cache for sighand_struct structures (tsk->sighand) */
 struct kmem_cache *sighand_cachep;
 
@@ -555,6 +559,7 @@ void free_task(struct task_struct *tsk)
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
 	bpf_task_storage_free(tsk);
+	put_task_exec_state(tsk->exec_state);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -731,7 +736,6 @@ void __mmdrop(struct mm_struct *mm)
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
-	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
@@ -775,6 +779,46 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
+static void __free_task_exec_state(struct rcu_head *rcu)
+{
+	struct task_exec_state *es = container_of(rcu, struct task_exec_state, rcu);
+
+	put_user_ns(es->user_ns);
+	kmem_cache_free(task_exec_state_cachep, es);
+}
+
+void put_task_exec_state(struct task_exec_state *es)
+{
+	if (es && refcount_dec_and_test(&es->count))
+		call_rcu(&es->rcu, __free_task_exec_state);
+}
+
+struct task_exec_state *alloc_task_exec_state(struct user_namespace *user_ns)
+{
+	struct task_exec_state *es;
+
+	es = kmem_cache_alloc(task_exec_state_cachep, GFP_KERNEL);
+	if (!es)
+		return NULL;
+	refcount_set(&es->count, 1);
+	es->dumpable = TASK_DUMPABLE_OFF;
+	es->user_ns = get_user_ns(user_ns);
+	return es;
+}
+
+struct task_exec_state *dup_task_exec_state(const struct task_exec_state *old)
+{
+	struct task_exec_state *es;
+
+	es = kmem_cache_alloc(task_exec_state_cachep, GFP_KERNEL);
+	if (!es)
+		return NULL;
+	refcount_set(&es->count, 1);
+	es->dumpable = old->dumpable;
+	es->user_ns = get_user_ns(old->user_ns);
+	return es;
+}
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
@@ -1072,8 +1116,7 @@ static void mmap_init_lock(struct mm_struct *mm)
 #endif
 }
 
-static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
-	struct user_namespace *user_ns)
+static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p)
 {
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
@@ -1132,7 +1175,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 				     NR_MM_COUNTERS))
 		goto fail_pcpu;
 
-	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
@@ -1163,7 +1205,7 @@ struct mm_struct *mm_alloc(void)
 		return NULL;
 
 	memset(mm, 0, sizeof(*mm));
-	return mm_init(mm, current, current_user_ns());
+	return mm_init(mm, current);
 }
 EXPORT_SYMBOL_IF_KUNIT(mm_alloc);
 
@@ -1527,7 +1569,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 
 	memcpy(mm, oldmm, sizeof(*mm));
 
-	if (!mm_init(mm, tsk, mm->user_ns))
+	if (!mm_init(mm, tsk))
 		goto fail_nomem;
 
 	uprobe_start_dup_mmap();
@@ -1593,6 +1635,23 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
+static int copy_exec_state(u64 clone_flags, struct task_struct *tsk)
+{
+	struct task_exec_state *new_es = current->exec_state;
+
+	tsk->exec_state = NULL;
+
+	if (clone_flags & CLONE_VM)
+		refcount_inc(&new_es->count);
+	else
+		new_es = dup_task_exec_state(new_es);
+	if (!new_es)
+		return -ENOMEM;
+
+	tsk->exec_state = new_es;
+	return 0;
+}
+
 static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 {
 	struct fs_struct *fs = current->fs;
@@ -2090,6 +2149,7 @@ __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	RCU_INIT_POINTER(p->exec_state, NULL);
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
@@ -2122,6 +2182,10 @@ __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_PROVE_LOCKING
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
+	retval = copy_exec_state(clone_flags, p);
+	if (retval)
+		goto bad_fork_free;
+
 	retval = copy_creds(p, clone_flags);
 	if (retval < 0)
 		goto bad_fork_free;
@@ -3098,6 +3162,10 @@ void __init proc_caches_init(void)
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
+	task_exec_state_cachep = kmem_cache_create("task_exec_state",
+			sizeof(struct task_exec_state), 0,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+			NULL);
 	files_cachep = kmem_cache_create("files_cache",
 			sizeof(struct files_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 791210daf8b4..63beb59b7a3d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1619,7 +1619,6 @@ void kthread_use_mm(struct mm_struct *mm)
 
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
-	WARN_ON_ONCE(!mm->user_ns);
 
 	/*
 	 * It is possible for mm to be the same as tsk->active_mm, but
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 130043bfc209..e7ca2c768745 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
+#include <linux/sched/exec_state.h>
 #include <linux/sched/task.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
@@ -45,21 +46,21 @@ int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 		     void *buf, int len, unsigned int gup_flags)
 {
 	struct mm_struct *mm;
-	int ret;
+	bool allowed;
+	int ret = 0;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
 		return 0;
 
-	if (!tsk->ptrace ||
-	    (current != tsk->parent) ||
-	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
-	     !ptracer_capable(tsk, mm->user_ns))) {
-		mmput(mm);
-		return 0;
-	}
+	rcu_read_lock();
+	allowed = tsk->ptrace && (current == tsk->parent) &&
+		  ((get_dumpable(tsk) == TASK_DUMPABLE_OWNER) ||
+		   ptracer_capable(tsk, tsk->exec_state->user_ns));
+	rcu_read_unlock();
 
-	ret = access_remote_vm(mm, addr, buf, len, gup_flags);
+	if (allowed)
+		ret = access_remote_vm(mm, addr, buf, len, gup_flags);
 	mmput(mm);
 
 	return ret;
@@ -274,16 +275,11 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 
 static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
 {
-	struct mm_struct *mm = task->mm;
-	if (mm) {
-		if (get_dumpable(mm) == SUID_DUMP_USER)
-			return true;
-		return ptrace_has_cap(mm->user_ns, mode);
-	}
-
-	if (task->user_dumpable)
+	if (get_dumpable(task) == TASK_DUMPABLE_OWNER)
 		return true;
-	return ptrace_has_cap(&init_user_ns, mode);
+
+	guard(rcu)();
+	return ptrace_has_cap(task->exec_state->user_ns, mode);
 }
 
 /* Returns 0 on success, -errno on denial. */
diff --git a/kernel/sys.c b/kernel/sys.c
index 62e842055cc9..59f106bb9f23 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2565,14 +2565,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = put_user(me->pdeath_signal, (int __user *)arg2);
 		break;
 	case PR_GET_DUMPABLE:
-		error = get_dumpable(me->mm);
+		error = get_dumpable(me);
 		break;
 	case PR_SET_DUMPABLE:
-		if (arg2 != SUID_DUMP_DISABLE && arg2 != SUID_DUMP_USER) {
+		if (arg2 != TASK_DUMPABLE_OFF && arg2 != TASK_DUMPABLE_OWNER) {
 			error = -EINVAL;
 			break;
 		}
-		set_dumpable(me->mm, arg2);
+		set_dumpable(arg2);
 		break;
 
 	case PR_SET_UNALIGN:
diff --git a/mm/init-mm.c b/mm/init-mm.c
index c5556bb9d5f0..3e792aad7626 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -43,7 +43,6 @@ struct mm_struct init_mm = {
 	.vma_writer_wait = __RCUWAIT_INITIALIZER(init_mm.vma_writer_wait),
 	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
 #endif
-	.user_ns	= &init_user_ns,
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock = __RAW_SPIN_LOCK_UNLOCKED(init_mm.mm_cid.lock),
 #endif
-- 
2.47.3


--nz3gimyp3ud3qlus--

