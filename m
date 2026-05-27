Return-Path: <stable+bounces-254563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NieMkjdFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:02:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74695E3C8D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E0FE300CF3E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE711A9B46;
	Wed, 27 May 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agb/nErt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE76306486;
	Wed, 27 May 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883319; cv=none; b=BGZYKJ0bssHtc6gGC5evu/JxljSsVZhgIiGLHEF5ZaWBWaU/ItoKaTWuTx+cdxZ8uOvxlC5LApiNWab+T8wI7SBKq4vaiY67IWPiNRJcJNvQzvA2bodNH67+qD30QGk9Sv2JFloU61fNbdbruhAv+yeCFvP6KDrqAb/+t1rmALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883319; c=relaxed/simple;
	bh=5xFXlXG3oqkJILjvPdnfuxISbwPG5lu67mOGmJv2AWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq9ZUGEeVX3KcXXQfmoJPNhKOT2UZ2qvqo/cySVx6zHLA848Tgzr2lXsHozmkbvMROwIfFVtqu04nze1Zbxsu2M1GPIUnRy7f0sbAI8oEW4HywtghzkHuJBtR4v1u2XNE4nhsvFNW9bBa2pgl0uDAysuqUPUChl+OE3rmjfQAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agb/nErt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529591F000E9;
	Wed, 27 May 2026 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883317;
	bh=lyr9UqoBVAjosBV4jZAwzj/bvflOcj78amTFSrgLqoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=agb/nErtVVac94wMykae+k+AdnwNJ7QcqhnfHGJNmLHaPgJzxu5DmBpR+bIqtD/aq
	 84z9I2VhQp6xCLVMI/8HcALXdIvcdtdcElzD23OakmbpnRLo/tW2rOMvWRojTUUYyV
	 Bikcnvwn7RNhUSlzAgMq3ehxEhCLG5Smdf+yK2dWY6vGaa8PWpbg98jvmspGD2z51y
	 bMbPJJROvyA+EDcFpZlc9ZBAmvpveGCP1rYnVXUMvJ5euGFfIthH2zj3oBmY9lVU6u
	 Eg0kJG7stkCgdLbJsNNB7g09+FY3cx69zt6FBg1BSaPbdPRek/ypyFU1gELNj9GBjj
	 yWWFzvMIFnVyg==
Date: Wed, 27 May 2026 14:01:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Message-ID: <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
 <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="j3ezp33mpunnwnqz"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+,5:+,6:+,7:+,8:+,9:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,xmission.com:email]
X-Rspamd-Queue-Id: C74695E3C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--j3ezp33mpunnwnqz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 26, 2026 at 08:22:38PM +0200, Jann Horn wrote:
> On Mon, May 25, 2026 at 9:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > I have added a couple more people who might be interested.
> >
> > Kees Cook because as you have structured this it is an exec problem.
> >
> > Oleg Nesterov as he is knowledgable about ptrace.
> >
> > Jann Horn <jannh@google.com> writes:
> >
> > > My understanding is that procfs is effectively maintained by the VFS
> > > maintainers (though scripts/get_maintainer.pl claims that there are
> > > no maintainers for procfs because the VFS entry only claims files
> > > directly in fs/, and the procfs entry has no maintainers listed on
> > > it).
> > >
> > > In procfs, most uses of ptrace_may_access() should use
> > > exec_update_lock to avoid TOCTOU issues with concurrent privileged
> > > execve() (like setuid binary execution).
> > >
> > > This series doesn't fix all the remaining issues in procfs, but it fixes
> > > the easy cases for now; I will probably follow up with fixes for the
> > > gnarlier cases later unless someone else wants to do that.
> > >
> > > I have checked that procfs files still work with these changes and that
> > > CONFIG_PROVE_LOCKING=y doesn't generate any warnings.
> > >
> > > (checkpatch complains about missing argument names in
> > > proc_op::proc_get_link, but that was already the case before my
> > > patch.)
> >
> >
> > I think I finally have my context paged back in so I can intelligently
> > say something about this series.
> >
> > The scenario you are worried about is when exec gains privileges,
> > and we read through proc and authenticate with the old credentials
> > instead of the new credentials.
> >
> > Question 1.
> >
> > Assuming the executable is world readable (which they generally are)
> > is there anything that becomes accessible in that race that was
> > not already accessible?
> 
> I believe so - the gnarliest example I am thinking of is:
> Memfds are always mode 0777 or 0666 (see __shmem_file_setup, which
> sets S_IRWXUGO), so their access control is purely based on being able
> to pathwalk to the memfd's inode. If you can race
> open(/proc/$pid/fd/$n) with the process $pid going through setuid
> execution and calling memfd_create(), you should be able to get
> read+write access to the memfd created by the setuid binary that was
> supposed to be private.
> 
> (But I have not tested that and don't know if there are actually any
> setuid binaries that happen to use memfds.)
> 
> > Question 2.
> >
> > How does this race compare to racing with setresuid?
> > Do we need to fix the setresuid case as well?
> 
> Which setresuid case? setresuid clears the dumpable flag and has a
> memory barrier that is supposed to make that properly ordered against
> ptrace_may_access(); so setresuid() should normally not cause a task
> to become traceable, though that could maybe happen in weird
> scenarios.
> 
> I think another case we should probably care about is what happens if
> a process which is only protected against ptrace by being non-dumpable
> goes through execve() - it shouldn't be possible to access resources
> associated with the pre-execve state while checking against the
> post-execve dumpability. It might be important for this that the
> do_close_on_exec() logic currently happens after committing the
> dumpable state in exec_mmap()...
> 
> > Question 3.
> > Do we care about the case when a privileged process calls a setuid
> > process and drops privileges?
> 
> I don't understand the question. Hmm - do you mean a case where a
> process with ruid=1000, euid=0, suid=1000 does execve() on a setuid
> 1000 binary? I think we probably don't specifically care about that...
> 
> I think another scenario that we ideally might want to care about is
> what happens if a process which runs with a normal user's UIDs, but is
> non-dumpable, goes through execve() of a normal binary while another
> process tries to inspect its FDs or address space layout - it probably
> shouldn't be possible to get information about the pre-execve MM and
> O_CLOEXEC file descriptors.
> 
> > Question 4.
> > Is it possible to use a seq_lock instead of reader writer semaphore?
> > Or is that only for non-sleeping readers?
> 
> Linux seqcounts are 32-bit, which means they are always kind of dodgy,
> but they are particularly dodgy if a reader can be forced to sleep for
> an extended amount of time. I don't see a reason why we couldn't, in
> general, use a 64-bit sequence count for readers that may need to
> sleep while reading.

I have a patch series for this that I started working after merging your
series for precisely this reason: performance. It's a few days old now.
I've tried various approaches and I started with a simple 32-bit counter
as the POC. See appended (untested) patches.

--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-exec-bump-exec_update_seq-across-the-exec_update_loc.patch"

From 6e3972c2f8d33216f6fa500618807fc75c6c1355 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:16:13 +0200
Subject: [PATCH 1/8] exec: bump exec_update_seq across the exec_update_lock
 write side

execve() (exec_mmap() -> begin_new_exec() -> setup_new_exec()) and
Landlock TSYNC are the only writers of exec_update_lock. Bump
exec_update_seq to odd for the duration of each write-held section, the
way mmap_lock maintains mm->mm_lock_seq:

 - exec: exec_update_seq_begin() right after down_write_killable() in
   exec_mmap(); exec_update_seq_end() before each matching up_write() (the
   exec_mmap() error path, the begin_new_exec() error path, and the normal
   release in setup_new_exec()). Every acquire reaches exactly one of
   those releases, so the seqcount is even whenever the lock is not held
   for writing.
 - Landlock: begin after down_write_trylock(), end before up_write().

The bump uses the non-preempt-disabling do_raw_write_seqcount_*() helpers,
so the sleeping exec and TSYNC write sections are unaffected.

No reader consults exec_update_seq yet: no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c                 | 4 ++++
 security/landlock/tsync.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 824b46c069ae..1915acb0b44d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -859,6 +859,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
 	if (ret)
 		return ret;
+	exec_update_seq_begin(tsk->signal);
 
 	if (old_mm) {
 		/*
@@ -868,6 +869,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 		 */
 		ret = mmap_read_lock_killable(old_mm);
 		if (ret) {
+			exec_update_seq_end(tsk->signal);
 			up_write(&tsk->signal->exec_update_lock);
 			return ret;
 		}
@@ -1300,6 +1302,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	return 0;
 
 out_unlock:
+	exec_update_seq_end(me->signal);
 	up_write(&me->signal->exec_update_lock);
 	if (!bprm->cred)
 		mutex_unlock(&me->signal->cred_guard_mutex);
@@ -1345,6 +1348,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * some architectures like powerpc
 	 */
 	me->mm->task_size = TASK_SIZE;
+	exec_update_seq_end(me->signal);
 	up_write(&me->signal->exec_update_lock);
 	mutex_unlock(&me->signal->cred_guard_mutex);
 
diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index c5730bbd9ed3..472c02cf71e9 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -492,6 +492,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	 */
 	if (!down_write_trylock(&current->signal->exec_update_lock))
 		return restart_syscall();
+	exec_update_seq_begin(current->signal);
 
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
@@ -614,6 +615,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 		wait_for_completion(&shared_ctx.all_finished);
 
 	tsync_works_release(&works);
+	exec_update_seq_end(current->signal);
 	up_write(&current->signal->exec_update_lock);
 	return atomic_read(&shared_ctx.preparation_error);
 }
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-exec-add-a-speculate-or-lock-helper-for-exec_update-.patch"

From 8c4daca0cc09a90e7a4acce4d650b3ea9b06a80b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:26:54 +0200
Subject: [PATCH 2/8] exec: add a speculate-or-lock helper for exec_update
 readers

The exec_update_seq readers share one control flow: try a lockless
seqcount read and fall back to exec_update_lock if a writer (exec or
Landlock TSYNC) is in flight. Rather than open-code it in every reader,
add a trio modeled on read_seqbegin_or_lock() / need_seqretry() /
done_seqretry() (seqlock.h), adapted for exec_update_seq paired with the
killable exec_update_lock:

  exec_update_read_begin_or_lock() - lockless first pass (seq even); on a
    racing writer escalate to down_read_killable() (seq odd); -EINTR if
    killed while waiting.
  exec_update_read_needs_retry()   - true if the lockless pass raced, in
    which case the caller drops any ref taken, sets seq = 1, and retries.
  exec_update_read_done()          - releases exec_update_lock if taken.

No users yet; no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/sched/signal.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 952f0368f201..0c1bb3b530e4 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -311,6 +311,36 @@ static inline bool exec_update_speculate_retry(struct signal_struct *sig,
 	return read_seqcount_retry(&sig->exec_update_seq, seq);
 }
 
+/* Speculate-or-lock exec_update reader, mirroring read_seqbegin_or_lock(). */
+static inline int exec_update_read_begin_or_killable(struct signal_struct *sig,
+						 unsigned int *seq)
+{
+	int ret;
+
+	if (!(*seq & 1)) {
+		if (exec_update_speculate_try_begin(sig, seq))
+			return 0;
+		*seq = 1;
+	}
+	ret = down_read_killable(&sig->exec_update_lock);
+	if (ret)
+		*seq = 0;
+	return ret;
+}
+
+static inline bool exec_update_read_needs_retry(struct signal_struct *sig,
+						unsigned int seq)
+{
+	return !(seq & 1) && exec_update_speculate_retry(sig, seq);
+}
+
+static inline void exec_update_read_done(struct signal_struct *sig,
+					 unsigned int seq)
+{
+	if (seq & 1)
+		up_read(&sig->exec_update_lock);
+}
+
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-mm-take-a-lock-free-exec_update_seq-fast-path-in-mm_.patch"

From 300838eeb13d5d96067d8475af29753016e83728 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:27:57 +0200
Subject: [PATCH 3/8] mm: take a lock-free exec_update_seq fast path in
 mm_access()

mm_access() takes exec_update_lock for read only to check
ptrace_may_access() against stable credentials before grabbing the target
mm. Convert it to exec_update_read_begin_or_lock(): the common case
resolves and access-checks the mm with no lock; a concurrent exec()/TSYNC
falls back to exec_update_lock. The shared resolve/check logic moves to
__mm_access(), and the speculative mm reference is dropped before retry.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 377125eff8a9..250a7e1125e6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1394,23 +1394,38 @@ static bool may_access_mm(struct mm_struct *mm, struct task_struct *task, unsign
 	return false;
 }
 
+static struct mm_struct *__mm_access(struct task_struct *task, unsigned int mode)
+{
+	struct mm_struct *mm = get_task_mm(task);
+
+	if (!mm)
+		return ERR_PTR(-ESRCH);
+	if (!may_access_mm(mm, task, mode)) {
+		mmput(mm);
+		return ERR_PTR(-EACCES);
+	}
+	return mm;
+}
+
 struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 {
+	struct signal_struct *sig = task->signal;
 	struct mm_struct *mm;
+	unsigned int seq = 0;
 	int err;
 
-	err =  down_read_killable(&task->signal->exec_update_lock);
+retry:
+	err = exec_update_read_begin_or_killable(sig, &seq);
 	if (err)
 		return ERR_PTR(err);
-
-	mm = get_task_mm(task);
-	if (!mm) {
-		mm = ERR_PTR(-ESRCH);
-	} else if (!may_access_mm(mm, task, mode)) {
-		mmput(mm);
-		mm = ERR_PTR(-EACCES);
-	}
-	up_read(&task->signal->exec_update_lock);
+	mm = __mm_access(task, mode);
+	if (exec_update_read_needs_retry(sig, seq)) {
+		if (!IS_ERR(mm))
+			mmput(mm);
+		seq = 1;
+		goto retry;
+	}
+	exec_update_read_done(sig, seq);
 
 	return mm;
 }
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0004-pidfd-take-a-lock-free-exec_update_seq-fast-path-in-.patch"

From 4a005bdabfb5647992f776751dcb5221b6d0da21 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:27:57 +0200
Subject: [PATCH 4/8] pidfd: take a lock-free exec_update_seq fast path in
 __pidfd_fget()

Convert __pidfd_fget() (pidfd_getfd(2)) to
exec_update_read_begin_or_lock(): check ptrace_may_access() and
fget_task() lock-free, falling back to exec_update_lock on a racing
exec()/TSYNC. The check + fget moves to pidfd_fget_access(), and a
speculative file reference is dropped before retry. The exiting-task
fixup (PF_EXITING -> ESRCH/EBADF) is unchanged.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/pid.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index fd5c2d4aa349..7ac85f417485 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -876,21 +876,32 @@ static __init int pid_namespace_sysctl_init(void)
 }
 subsys_initcall(pid_namespace_sysctl_init);
 
+static struct file *pidfd_fget_access(struct task_struct *task, int fd)
+{
+	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
+		return ERR_PTR(-EPERM);
+	return fget_task(task, fd);
+}
+
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
 {
+	struct signal_struct *sig = task->signal;
 	struct file *file;
+	unsigned int seq = 0;
 	int ret;
 
-	ret = down_read_killable(&task->signal->exec_update_lock);
+retry:
+	ret = exec_update_read_begin_or_killable(sig, &seq);
 	if (ret)
 		return ERR_PTR(ret);
-
-	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
-		file = fget_task(task, fd);
-	else
-		file = ERR_PTR(-EPERM);
-
-	up_read(&task->signal->exec_update_lock);
+	file = pidfd_fget_access(task, fd);
+	if (exec_update_read_needs_retry(sig, seq)) {
+		if (!IS_ERR_OR_NULL(file))
+			fput(file);
+		seq = 1;
+		goto retry;
+	}
+	exec_update_read_done(sig, seq);
 
 	if (!file) {
 		/*
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0005-futex-take-a-lock-free-exec_update_seq-fast-path-in-.patch"

From 1e1d0adfe664adc4ba60f7209911f2eae90605ee Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:27:58 +0200
Subject: [PATCH 5/8] futex: take a lock-free exec_update_seq fast path in
 get_robust_list

Convert futex_get_robust_list_common() to
exec_update_read_begin_or_lock(): check ptrace_may_access() and read the
target's robust_list head lock-free, falling back to exec_update_lock on
a racing exec()/TSYNC. Nothing is referenced in the protected section, so
there is nothing to undo on retry. Read the head with READ_ONCE() since
the owner may update it concurrently.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/futex/syscalls.c | 45 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 77ad9691f6a6..ec7a174f2682 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -43,16 +43,17 @@ static inline void __user *futex_task_robust_list(struct task_struct *p, bool co
 {
 #ifdef CONFIG_COMPAT
 	if (compat)
-		return p->compat_robust_list;
+		return READ_ONCE(p->compat_robust_list);
 #endif
-	return p->robust_list;
+	return READ_ONCE(p->robust_list);
 }
 
 static void __user *futex_get_robust_list_common(int pid, bool compat)
 {
 	struct task_struct *p = current;
 	void __user *head;
-	int ret;
+	unsigned int seq = 0;
+	int err;
 
 	scoped_guard(rcu) {
 		if (pid) {
@@ -64,29 +65,27 @@ static void __user *futex_get_robust_list_common(int pid, bool compat)
 	}
 
 	/*
-	 * Hold exec_update_lock to serialize with concurrent exec()
-	 * so ptrace_may_access() is checked against stable credentials
+	 * Serialize ptrace_may_access() against a concurrent exec() credential
+	 * change; lock-free fast path with an exec_update_lock fallback.
 	 */
-	ret = down_read_killable(&p->signal->exec_update_lock);
-	if (ret)
-		goto err_put;
-
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
-
-	head = futex_task_robust_list(p, compat);
-
-	up_read(&p->signal->exec_update_lock);
+retry:
+	err = exec_update_read_begin_or_killable(p->signal, &seq);
+	if (err) {
+		head = (void __user *)ERR_PTR(err);
+		goto out;
+	}
+	if (ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		head = futex_task_robust_list(p, compat);
+	else
+		head = (void __user *)ERR_PTR(-EPERM);
+	if (exec_update_read_needs_retry(p->signal, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	exec_update_read_done(p->signal, seq);
+out:
 	put_task_struct(p);
-
 	return head;
-
-err_unlock:
-	up_read(&p->signal->exec_update_lock);
-err_put:
-	put_task_struct(p);
-	return (void __user *)ERR_PTR(ret);
 }
 
 /**
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0006-kcmp-take-a-lock-free-exec_update_seq-fast-path.patch"

From c3d5427c1ef28537a5a50ef571087b04fde518ce Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:29:17 +0200
Subject: [PATCH 6/8] kcmp: take a lock-free exec_update_seq fast path

kcmp() compares two tasks' resources after ptrace_may_access() checks on
both, today under both tasks' exec_update_locks (taken in pointer order to
avoid ABBA). Add a two-task seqcount fast path: snapshot both tasks'
exec_update_seq, run the checks and comparison, then revalidate both; on a
racing exec()/TSYNC of either task fall back to the existing ordered
double-lock (kcmp_lock). The fast path takes no lock, so it needs no
ordering. The comparison logic moves to kcmp_access() and pointer reads
use READ_ONCE(); get_file_raw_ptr() takes and drops its own reference, so
a retried comparison leaks nothing.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/kcmp.c | 106 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 40 deletions(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 7c1a65bd5f8d..8fee7a5752d4 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -132,39 +132,15 @@ static int kcmp_epoll_target(struct task_struct *task1,
 }
 #endif
 
-SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
-		unsigned long, idx1, unsigned long, idx2)
+/* Compare two tasks' resources by obfuscated pointer; caller serializes. */
+static int kcmp_access(struct task_struct *task1, struct task_struct *task2,
+		       int type, unsigned long idx1, unsigned long idx2)
 {
-	struct task_struct *task1, *task2;
 	int ret;
 
-	rcu_read_lock();
-
-	/*
-	 * Tasks are looked up in caller's PID namespace only.
-	 */
-	task1 = find_task_by_vpid(pid1);
-	task2 = find_task_by_vpid(pid2);
-	if (unlikely(!task1 || !task2))
-		goto err_no_task;
-
-	get_task_struct(task1);
-	get_task_struct(task2);
-
-	rcu_read_unlock();
-
-	/*
-	 * One should have enough rights to inspect task details.
-	 */
-	ret = kcmp_lock(&task1->signal->exec_update_lock,
-			&task2->signal->exec_update_lock);
-	if (ret)
-		goto err;
 	if (!ptrace_may_access(task1, PTRACE_MODE_READ_REALCREDS) ||
-	    !ptrace_may_access(task2, PTRACE_MODE_READ_REALCREDS)) {
-		ret = -EPERM;
-		goto err_unlock;
-	}
+	    !ptrace_may_access(task2, PTRACE_MODE_READ_REALCREDS))
+		return -EPERM;
 
 	switch (type) {
 	case KCMP_FILE: {
@@ -180,24 +156,29 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 		break;
 	}
 	case KCMP_VM:
-		ret = kcmp_ptr(task1->mm, task2->mm, KCMP_VM);
+		ret = kcmp_ptr(READ_ONCE(task1->mm), READ_ONCE(task2->mm),
+			       KCMP_VM);
 		break;
 	case KCMP_FILES:
-		ret = kcmp_ptr(task1->files, task2->files, KCMP_FILES);
+		ret = kcmp_ptr(READ_ONCE(task1->files), READ_ONCE(task2->files),
+			       KCMP_FILES);
 		break;
 	case KCMP_FS:
-		ret = kcmp_ptr(task1->fs, task2->fs, KCMP_FS);
+		ret = kcmp_ptr(READ_ONCE(task1->fs), READ_ONCE(task2->fs),
+			       KCMP_FS);
 		break;
 	case KCMP_SIGHAND:
-		ret = kcmp_ptr(task1->sighand, task2->sighand, KCMP_SIGHAND);
+		ret = kcmp_ptr(READ_ONCE(task1->sighand),
+			       READ_ONCE(task2->sighand), KCMP_SIGHAND);
 		break;
 	case KCMP_IO:
-		ret = kcmp_ptr(task1->io_context, task2->io_context, KCMP_IO);
+		ret = kcmp_ptr(READ_ONCE(task1->io_context),
+			       READ_ONCE(task2->io_context), KCMP_IO);
 		break;
 	case KCMP_SYSVSEM:
 #ifdef CONFIG_SYSVIPC
-		ret = kcmp_ptr(task1->sysvsem.undo_list,
-			       task2->sysvsem.undo_list,
+		ret = kcmp_ptr(READ_ONCE(task1->sysvsem.undo_list),
+			       READ_ONCE(task2->sysvsem.undo_list),
 			       KCMP_SYSVSEM);
 #else
 		ret = -EOPNOTSUPP;
@@ -211,10 +192,55 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 		break;
 	}
 
-err_unlock:
-	kcmp_unlock(&task1->signal->exec_update_lock,
-		    &task2->signal->exec_update_lock);
-err:
+	return ret;
+}
+
+SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
+		unsigned long, idx1, unsigned long, idx2)
+{
+	struct task_struct *task1, *task2;
+	struct signal_struct *sig1, *sig2;
+	unsigned int seq1, seq2;
+	int ret;
+
+	rcu_read_lock();
+
+	/*
+	 * Tasks are looked up in caller's PID namespace only.
+	 */
+	task1 = find_task_by_vpid(pid1);
+	task2 = find_task_by_vpid(pid2);
+	if (unlikely(!task1 || !task2))
+		goto err_no_task;
+
+	get_task_struct(task1);
+	get_task_struct(task2);
+
+	rcu_read_unlock();
+
+	sig1 = task1->signal;
+	sig2 = task2->signal;
+
+	/*
+	 * Lock-free fast path: snapshot both tasks' exec_update_seq, compare,
+	 * then revalidate both.  Falls back to taking both exec_update_locks in
+	 * a deadlock-safe order if either task is mid-exec.
+	 */
+	if (exec_update_speculate_try_begin(sig1, &seq1) &&
+	    exec_update_speculate_try_begin(sig2, &seq2)) {
+		ret = kcmp_access(task1, task2, type, idx1, idx2);
+		if (!exec_update_speculate_retry(sig1, seq1) &&
+		    !exec_update_speculate_retry(sig2, seq2))
+			goto out;
+	}
+
+	ret = kcmp_lock(&sig1->exec_update_lock, &sig2->exec_update_lock);
+	if (ret)
+		goto out;
+	ret = kcmp_access(task1, task2, type, idx1, idx2);
+	kcmp_unlock(&sig1->exec_update_lock, &sig2->exec_update_lock);
+
+out:
 	put_task_struct(task1);
 	put_task_struct(task2);
 
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0007-proc-lock-free-exec_update_seq-fast-path-for-stack-s.patch"

From 66149a0d2a4a816d9ddda938c59a4ca823e4999c Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:31:26 +0200
Subject: [PATCH 7/8] proc: lock-free exec_update_seq fast path for
 stack/syscall/personality

/proc/<pid>/{stack,syscall,personality} took exec_update_lock for read
(via lock_trace()) to check ptrace_may_access() and then read task state.
Convert all three to exec_update_read_begin_or_lock(): snapshot the
permission decision and the task state (stack trace, syscall info,
personality) in the speculative section, then emit after validation;
fall back to exec_update_lock on a racing exec()/TSYNC. With all three
callers converted, lock_trace() and unlock_trace() are removed.

Note: the stack unwind and task_current_syscall() now run inside the
speculative section and may re-run if a concurrent exec() of the target
is detected. They are idempotent (they fill a local buffer/struct and
output is emitted only after the section validates), and exec of a given
task is rare, so the bounded re-run is acceptable. /proc/<pid>/stack
stays root-only.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/base.c | 93 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 65f56136ec3f..83b851b7f9d9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -440,23 +440,6 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_KALLSYMS */
 
-static int lock_trace(struct task_struct *task)
-{
-	int err = down_read_killable(&task->signal->exec_update_lock);
-	if (err)
-		return err;
-	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_FSCREDS)) {
-		up_read(&task->signal->exec_update_lock);
-		return -EPERM;
-	}
-	return 0;
-}
-
-static void unlock_trace(struct task_struct *task)
-{
-	up_read(&task->signal->exec_update_lock);
-}
-
 #ifdef CONFIG_STACKTRACE
 
 #define MAX_STACK_TRACE_DEPTH	64
@@ -464,7 +447,10 @@ static void unlock_trace(struct task_struct *task)
 static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
+	struct signal_struct *sig = task->signal;
 	unsigned long *entries;
+	unsigned int seq = 0, i, nr_entries = 0;
+	bool allowed = false;
 	int err;
 
 	/*
@@ -486,19 +472,27 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 	if (!entries)
 		return -ENOMEM;
 
-	err = lock_trace(task);
-	if (!err) {
-		unsigned int i, nr_entries;
-
+retry:
+	err = exec_update_read_begin_or_killable(sig, &seq);
+	if (err)
+		goto out;
+	allowed = ptrace_may_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	if (allowed)
 		nr_entries = stack_trace_save_tsk(task, entries,
 						  MAX_STACK_TRACE_DEPTH, 0);
+	if (exec_update_read_needs_retry(sig, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	exec_update_read_done(sig, seq);
 
-		for (i = 0; i < nr_entries; i++) {
-			seq_printf(m, "[<0>] %pB\n", (void *)entries[i]);
-		}
-
-		unlock_trace(task);
+	if (!allowed) {
+		err = -EPERM;
+		goto out;
 	}
+	for (i = 0; i < nr_entries; i++)
+		seq_printf(m, "[<0>] %pB\n", (void *)entries[i]);
+out:
 	kfree(entries);
 
 	return err;
@@ -676,15 +670,31 @@ static int proc_pid_limits(struct seq_file *m, struct pid_namespace *ns,
 static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *task)
 {
+	struct signal_struct *sig = task->signal;
 	struct syscall_info info;
 	u64 *args = &info.data.args[0];
+	unsigned int seq = 0;
+	bool allowed = false;
+	int running = 0;
 	int res;
 
-	res = lock_trace(task);
+retry:
+	res = exec_update_read_begin_or_killable(sig, &seq);
 	if (res)
 		return res;
+	allowed = ptrace_may_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	if (allowed)
+		running = task_current_syscall(task, &info);
+	if (exec_update_read_needs_retry(sig, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	exec_update_read_done(sig, seq);
+
+	if (!allowed)
+		return -EPERM;
 
-	if (task_current_syscall(task, &info))
+	if (running)
 		seq_puts(m, "running\n");
 	else if (info.data.nr < 0)
 		seq_printf(m, "%d 0x%llx 0x%llx\n",
@@ -695,7 +705,6 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 		       info.data.nr,
 		       args[0], args[1], args[2], args[3], args[4], args[5],
 		       info.sp, info.data.instruction_pointer);
-	unlock_trace(task);
 
 	return 0;
 }
@@ -3221,12 +3230,28 @@ static const struct file_operations proc_setgroups_operations = {
 static int proc_pid_personality(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
-	int err = lock_trace(task);
-	if (!err) {
-		seq_printf(m, "%08x\n", task->personality);
-		unlock_trace(task);
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 0, personality = 0;
+	bool allowed = false;
+	int err;
+
+retry:
+	err = exec_update_read_begin_or_killable(sig, &seq);
+	if (err)
+		return err;
+	allowed = ptrace_may_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	if (allowed)
+		personality = READ_ONCE(task->personality);
+	if (exec_update_read_needs_retry(sig, seq)) {
+		seq = 1;
+		goto retry;
 	}
-	return err;
+	exec_update_read_done(sig, seq);
+
+	if (!allowed)
+		return -EPERM;
+	seq_printf(m, "%08x\n", personality);
+	return 0;
 }
 
 #ifdef CONFIG_LIVEPATCH
-- 
2.47.3


--j3ezp33mpunnwnqz
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0008-proc-take-a-lock-free-exec_update_seq-fast-path-in-d.patch"

From c981e64e0be97c0f074dc970aea7076522367640 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 May 2026 09:32:23 +0200
Subject: [PATCH 8/8] proc: take a lock-free exec_update_seq fast path in
 do_io_accounting()

/proc/<pid>/io took exec_update_lock for read to check
ptrace_may_access() before sampling the task's (or thread group's) IO
accounting. Convert it to exec_update_read_begin_or_lock(): snapshot the
accounting into a local under the speculative section (the whole-process
variant keeps its inner rcu + stats_lock), then emit after validation;
fall back to exec_update_lock on a racing exec()/TSYNC.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/base.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 83b851b7f9d9..3706c5167df0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3033,20 +3033,18 @@ static const struct file_operations proc_coredump_filter_operations = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 static int do_io_accounting(struct task_struct *task, struct seq_file *m, int whole)
 {
+	struct signal_struct *sig = task->signal;
 	struct task_io_accounting acct;
+	unsigned int seq = 0;
+	bool allowed = false;
 	int result;
 
-	result = down_read_killable(&task->signal->exec_update_lock);
+retry:
+	result = exec_update_read_begin_or_killable(sig, &seq);
 	if (result)
 		return result;
-
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
-		result = -EACCES;
-		goto out_unlock;
-	}
-
-	if (whole) {
-		struct signal_struct *sig = task->signal;
+	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (allowed && whole) {
 		struct task_struct *t;
 
 		guard(rcu)();
@@ -3056,9 +3054,17 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 				task_io_accounting_add(&acct, &t->ioac);
 
 		}
-	} else {
+	} else if (allowed) {
 		acct = task->ioac;
 	}
+	if (exec_update_read_needs_retry(sig, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	exec_update_read_done(sig, seq);
+
+	if (!allowed)
+		return -EACCES;
 
 	seq_printf(m,
 		   "rchar: %llu\n"
@@ -3075,11 +3081,8 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 		   (unsigned long long)acct.read_bytes,
 		   (unsigned long long)acct.write_bytes,
 		   (unsigned long long)acct.cancelled_write_bytes);
-	result = 0;
 
-out_unlock:
-	up_read(&task->signal->exec_update_lock);
-	return result;
+	return 0;
 }
 
 static int proc_tid_io_accounting(struct seq_file *m, struct pid_namespace *ns,
-- 
2.47.3


--j3ezp33mpunnwnqz--

