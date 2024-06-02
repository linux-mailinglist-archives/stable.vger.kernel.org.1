Return-Path: <stable+bounces-47837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C78D7696
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B23E2815FA
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E43BB47;
	Sun,  2 Jun 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Zg6yPH7m"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608F44366
	for <stable@vger.kernel.org>; Sun,  2 Jun 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717341775; cv=none; b=tR9tEaf009b0C4ocx4B1BgsjJsOvXbjTblhZZtbE2LmKKboKRjtAG7JQEmIw0Jo7eQLs4YyHCoJU8epFg6/QIr3PVxGCk42gkkNqDU3tIdtAqrxVi7psvvFcC47XEmJbfsu3q+Wxx9PS2z7Kw5KZCfXC9I1WGXEIaIJK5QcLntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717341775; c=relaxed/simple;
	bh=KGbENDXOBg7ScetY5lHnZvFnMEzk9bFkBmKq9TKb++g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYA6U4lRjBqATzjtrnVvdQB6jIQIT6Kr66YU5e8HU1ujM5EQ+vyNGZjWZ2fz/HvtYmE7KSttzK9DpkLSyskTTIHpA9M/fcqzr95sctpLAclxAOTSo1O4nBeNGTVvBKOhAtG9U9phMZfltMg8iluZvw1S/vZ+WAm3cgNXkBTfkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Zg6yPH7m; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jVWPGZp83bz9pAzmiPWn1QK9itDG3EVooZTf6JxoI6k=; b=Zg6yPH7mTGYjpuKj4s/pZgdhPQ
	bBySQ/8eWdW5JqW3QQ93jQ1MRSoctC4Exm2A3qf/IEWIs9LioFphD6jEqqc79TRnWFlVnq4kzohs4
	l4R4kmXlMgIpMu66ba50l0z5UbZCNETg1ypYhoFozyXq2056+n+nEamod5LK5EsBjlg0GSuIH2uEG
	GmOyI2p3uc74VloZE6OnHiaOvp6hCusnWwkK4agwEsHxPNmBkV3wNsTRxlJJyNatFAzEkw/UXbHn0
	3sQx8TaV8Aa/YA+KmYscm69mZbgsMyUTavjznZ2jHD2FkVxfmqa164odp1pLOaxONVDAYhaqbEwu5
	+QwEhRZQ==;
Received: from [189.79.117.74] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sDn2e-00FvcV-7w; Sun, 02 Jun 2024 17:22:40 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	x86@kernel.org
Subject: [PATCH 5.4.y] x86/mm: Remove broken vsyscall emulation code from the page fault code
Date: Sun,  2 Jun 2024 12:18:42 -0300
Message-ID: <20240602152233.78240-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 02b670c1f88e78f42a6c5aee155c7b26960ca054 upstream.

The syzbot-reported stack trace from hell in this discussion thread
actually has three nested page faults:

  https://lore.kernel.org/r/000000000000d5f4fc0616e816d4@google.com

... and I think that's actually the important thing here:

 - the first page fault is from user space, and triggers the vsyscall
   emulation.

 - the second page fault is from __do_sys_gettimeofday(), and that should
   just have caused the exception that then sets the return value to
   -EFAULT

 - the third nested page fault is due to _raw_spin_unlock_irqrestore() ->
   preempt_schedule() -> trace_sched_switch(), which then causes a BPF
   trace program to run, which does that bpf_probe_read_compat(), which
   causes that page fault under pagefault_disable().

It's quite the nasty backtrace, and there's a lot going on.

The problem is literally the vsyscall emulation, which sets

        current->thread.sig_on_uaccess_err = 1;

and that causes the fixup_exception() code to send the signal *despite* the
exception being caught.

And I think that is in fact completely bogus.  It's completely bogus
exactly because it sends that signal even when it *shouldn't* be sent -
like for the BPF user mode trace gathering.

In other words, I think the whole "sig_on_uaccess_err" thing is entirely
broken, because it makes any nested page-faults do all the wrong things.

Now, arguably, I don't think anybody should enable vsyscall emulation any
more, but this test case clearly does.

I think we should just make the "send SIGSEGV" be something that the
vsyscall emulation does on its own, not this broken per-thread state for
something that isn't actually per thread.

The x86 page fault code actually tried to deal with the "incorrect nesting"
by having that:

                if (in_interrupt())
                        return;

which ignores the sig_on_uaccess_err case when it happens in interrupts,
but as shown by this example, these nested page faults do not need to be
about interrupts at all.

IOW, I think the only right thing is to remove that horrendously broken
code.

The attached patch looks like the ObviouslyCorrect(tm) thing to do.

NOTE! This broken code goes back to this commit in 2011:

  4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation faults")

... and back then the reason was to get all the siginfo details right.
Honestly, I do not for a moment believe that it's worth getting the siginfo
details right here, but part of the commit says:

    This fixes issues with UML when vsyscall=emulate.

... and so my patch to remove this garbage will probably break UML in this
situation.

I do not believe that anybody should be running with vsyscall=emulate in
2024 in the first place, much less if you are doing things like UML. But
let's see if somebody screams.

Reported-and-tested-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
[gpiccoli: Backport the patch due to differences in the trees. The main changes
between 5.4.y and 5.15.y are due to renaming the fixup function, by
commit 6456a2a69ee1 ("x86/fault: Rename no_context() to kernelmode_fixup_or_oops()"),
and on processor.h thread_struct due to commit cf122cfba5b1 ("kill uaccess_try()").

Following 2 commits cause divergence in the diffs too (in the removed lines):
cd072dab453a ("x86/fault: Add a helper function to sanitize error code")
d4ffd5df9d18 ("x86/fault: Fix wrong signal when vsyscall fails with pkey").]
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hi folks, this was backported by AUTOSEL up to 5.15.y; I'm manually submitting
the backport to 5.4.y and 5.10.y. I've detailed a bit the changes necessary
due to other nonrelated missing patches, but these are really simple and
non-intrusive. Nevertheless, I've explicitely CCed x86 ML to be sure the
maintainers are aware of the backport, and if anybody thinks we shouldn't
do it for these (very) old releases, please respond here.

Cheers,


Guilherme


 arch/x86/entry/vsyscall/vsyscall_64.c | 28 ++-------------------------
 arch/x86/include/asm/processor.h      |  1 -
 arch/x86/mm/fault.c                   | 27 +-------------------------
 3 files changed, 3 insertions(+), 53 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e7c596dea947..86e5a1c1055f 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
 
 static bool write_ok_or_segv(unsigned long ptr, size_t size)
 {
-	/*
-	 * XXX: if access_ok, get_user, and put_user handled
-	 * sig_on_uaccess_err, this could go away.
-	 */
-
 	if (!access_ok((void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
@@ -120,10 +115,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -172,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
@@ -233,12 +224,8 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto do_ret;  /* skip requested */
 
 	/*
-	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
-	 * preserve that behavior to make writing exploits harder.
+	 * With a real vsyscall, page faults cause SIGSEGV.
 	 */
-	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
-	current->thread.sig_on_uaccess_err = 1;
-
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
@@ -261,23 +248,12 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 	}
 
-	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
-
 check_fault:
 	if (ret == -EFAULT) {
 		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall fault (exploit attempt?)");
-
-		/*
-		 * If we failed to generate a signal for any reason,
-		 * generate one here.  (This should be impossible.)
-		 */
-		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
-				 !sigismember(&tsk->pending.signal, SIGSEGV)))
-			goto sigsegv;
-
-		return true;  /* Don't emulate the ret. */
+		goto sigsegv;
 	}
 
 	regs->ax = ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9cbd86cf0deb..087df5edef78 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -487,7 +487,6 @@ struct thread_struct {
 
 	mm_segment_t		addr_limit;
 
-	unsigned int		sig_on_uaccess_err:1;
 	unsigned int		uaccess_err:1;	/* uaccess failed */
 
 	/* Floating point and extended processor state */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c494c8c05824..21383ef7b506 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -743,33 +743,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	}
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			set_signal_archinfo(address, error_code);
-
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
-	}
 
 #ifdef CONFIG_VMAP_STACK
 	/*
-- 
2.45.1


