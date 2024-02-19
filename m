Return-Path: <stable+bounces-20672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8AE85AAEB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33161F214FB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7240481CB;
	Mon, 19 Feb 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNizYapV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7B45952
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367084; cv=none; b=s5EuoN/O61RkBtisOj4gHHFRzcqVc/LEQwKolSncPE+WyKDdffSqHm2/gtQsJWDRMzxtPHFWLdTf5/9DANkw144IKelifjzQ/kkxj2cNRLvlZ/M/Dm+zNWI1Pev+BPgQtn+hfJjyXVZHYyc0KwhxPmqnP1EqaVOVKLQpNXQy8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367084; c=relaxed/simple;
	bh=OCu0actnU0bCfsb3v7hLR9mbEB8epj2X5Nuqjx0cJ1g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gPyfcNO1c7nr5pC88+W0jvk/bpvt7Ij0UiYpSa5M6uXJHxUugBlTHbMeedUKDgqlHkTvZ8mUeg24vzdLmkovJpmeXcDK0H3xdpdki/UHU2n1xno9IeYF+KRZgDNzzNRDNboy6lIpnnlyCMORiesVlNpKftEc6VJ/ZvDLD6dollc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNizYapV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D66C433C7;
	Mon, 19 Feb 2024 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708367084;
	bh=OCu0actnU0bCfsb3v7hLR9mbEB8epj2X5Nuqjx0cJ1g=;
	h=Subject:To:Cc:From:Date:From;
	b=VNizYapVUkMtnIsbWgWU89ZwqZHhnAACnjvYuxu+EpNItXRz6gGCh2Ep8ScEj//WR
	 rEDCM+7rnzF+FgS9rdnsSrH7sM07xanTRiF0dZaM7HJ65XoIhy64Ab2c4H82p/NiGl
	 Ei2tdrusgc+exxtLo2+Qw6XJ4Tyc6+2c0hdKRWhw=
Subject: FAILED: patch "[PATCH] x86/fpu: Stop relying on userspace for info to fault in xsave" failed to apply to 5.15-stable tree
To: avagin@google.com,bogomolov@google.com,dave.hansen@linux.intel.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:24:41 +0100
Message-ID: <2024021941-reprimand-grudge-7734@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d877550eaf2dc9090d782864c96939397a3c6835
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021941-reprimand-grudge-7734@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d877550eaf2d ("x86/fpu: Stop relying on userspace for info to fault in xsave buffer")
c03098d4b9ad ("Merge tag 'gfs2-v5.15-rc5-mmap-fault' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d877550eaf2dc9090d782864c96939397a3c6835 Mon Sep 17 00:00:00 2001
From: Andrei Vagin <avagin@google.com>
Date: Mon, 29 Jan 2024 22:36:03 -0800
Subject: [PATCH] x86/fpu: Stop relying on userspace for info to fault in xsave
 buffer

Before this change, the expected size of the user space buffer was
taken from fx_sw->xstate_size. fx_sw->xstate_size can be changed
from user-space, so it is possible construct a sigreturn frame where:

 * fx_sw->xstate_size is smaller than the size required by valid bits in
   fx_sw->xfeatures.
 * user-space unmaps parts of the sigrame fpu buffer so that not all of
   the buffer required by xrstor is accessible.

In this case, xrstor tries to restore and accesses the unmapped area
which results in a fault. But fault_in_readable succeeds because buf +
fx_sw->xstate_size is within the still mapped area, so it goes back and
tries xrstor again. It will spin in this loop forever.

Instead, fault in the maximum size which can be touched by XRSTOR (taken
from fpstate->user_size).

[ dhansen: tweak subject / changelog ]

Fixes: fcb3635f5018 ("x86/fpu/signal: Handle #PF in the direct restore path")
Reported-by: Konstantin Bogomolov <bogomolov@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240130063603.3392627-1-avagin%40google.com

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 558076dbde5b..247f2225aa9f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -274,12 +274,13 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				     bool fx_only, unsigned int size)
+static bool restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
 
+	/* Restore enabled features only. */
+	xrestore &= fpu->fpstate->user_xfeatures;
 retry:
 	fpregs_lock();
 	/* Ensure that XFD is up to date */
@@ -309,7 +310,7 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
 		if (ret != X86_TRAP_PF)
 			return false;
 
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, fpu->fpstate->user_size))
 			goto retry;
 		return false;
 	}
@@ -339,7 +340,6 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	struct user_i387_ia32_struct env;
 	bool success, fx_only = false;
 	union fpregs_state *fpregs;
-	unsigned int state_size;
 	u64 user_xfeatures = 0;
 
 	if (use_xsave()) {
@@ -349,17 +349,14 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			return false;
 
 		fx_only = !fx_sw_user.magic1;
-		state_size = fx_sw_user.xstate_size;
 		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures = XFEATURE_MASK_FPSSE;
-		state_size = fpu->fpstate->user_size;
 	}
 
 	if (likely(!ia32_fxstate)) {
 		/* Restore the FPU registers directly from user memory. */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 	}
 
 	/*


