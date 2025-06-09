Return-Path: <stable+bounces-152177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2D1AD234C
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B721891097
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E7218ADD;
	Mon,  9 Jun 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cEx86xsV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WTvxLTf0"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D8218589;
	Mon,  9 Jun 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485141; cv=none; b=MDSEXVVWZIR7foOUXZNLJ0ys6AxfA6PhWzzWJrV4UykVwGXlodGwav0hEXjAplml9dj54yY+PrMo3zkGPXuMR5UuwNAqNFhYkjsOpJJsTyeXdG2i/StkYaPwhB1rlSZA/UV9+HzlnXbX7nQUTvnHFzgXR1EE/ZVBb5rDGFNJxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485141; c=relaxed/simple;
	bh=5W+q5Hptcduv99qN9NdaHLgaaCJ3iv178oEWZ+kZWJQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=iuECJcaujPIDhPI3Qheh5rJORJOPx9rCqCKOdYq/LOBzAPQTLcY5fth3jmK4iWsKQL4lWH3UZgcBp2n0asAkRX7RSCjzjM8+/U+3l+uC0AxHbPkZ1J0iFhBuWkqWnvUy9aJ0Wc30rbnkFzSaxs8cIVi5sHQ9/VpyqQLXi511sSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cEx86xsV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WTvxLTf0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Jun 2025 16:05:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749485136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hGMCtXVdc5XbRYj2y+Zz/JxghJouDK8GNsgALovB+Jc=;
	b=cEx86xsVBDpSz/EAX32O8PTz5krQaK/GCOjG8sfyVpyVnxb3GN7hGUHJuX3+r7FoAkW9lS
	Q+YLZPbAGzM07x2dlE1UehUiX/vbkZiaYT1nzLBnu8C6zO1PXndGGVoRsQVdEUfUsxqlEU
	Ov5EWW1aTCXj1KyTXw5qEFTiN7Uw8bb50qpJ0tSjjUF8ltkMa98GihNkWGpxjZF9j4hO8G
	4dIErD4RtQZfiNrMAkoD5vlDadbd5/lcGN+fKYgz3gO7ZVCbdSd4hG9naSR0JKew6Bm1DC
	kxKnWH8CrsC7GvcJiI2tU3KJmNpBW/osXXMjg31eWPNO7RUuLmSD8ArxJbNenA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749485136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hGMCtXVdc5XbRYj2y+Zz/JxghJouDK8GNsgALovB+Jc=;
	b=WTvxLTf0mD3a3oWPIFbDP7zOaxD+f1LR60oiTi0xCo+iL8eoGirYBQ3pNsc0NmYthfVtyA
	AntGodmxhkQA+cBA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fred/signal: Prevent immediate repeat of single
 step trap on return from SIGTRAP handler
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174948513569.406.15537914230313321736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e34dbbc85d64af59176fe59fad7b4122f4330fe2
Gitweb:        https://git.kernel.org/tip/e34dbbc85d64af59176fe59fad7b4122f4330fe2
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Mon, 09 Jun 2025 01:40:53 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 09 Jun 2025 08:50:58 -07:00

x86/fred/signal: Prevent immediate repeat of single step trap on return from SIGTRAP handler

Clear the software event flag in the augmented SS to prevent immediate
repeat of single step trap on return from SIGTRAP handler if the trap
flag (TF) is set without an external debugger attached.

Following is a typical single-stepping flow for a user process:

1) The user process is prepared for single-stepping by setting
   RFLAGS.TF = 1.
2) When any instruction in user space completes, a #DB is triggered.
3) The kernel handles the #DB and returns to user space, invoking the
   SIGTRAP handler with RFLAGS.TF = 0.
4) After the SIGTRAP handler finishes, the user process performs a
   sigreturn syscall, restoring the original state, including
   RFLAGS.TF = 1.
5) Goto step 2.

According to the FRED specification:

A) Bit 17 in the augmented SS is designated as the software event
   flag, which is set to 1 for FRED event delivery of SYSCALL,
   SYSENTER, or INT n.
B) If bit 17 of the augmented SS is 1 and ERETU would result in
   RFLAGS.TF = 1, a single-step trap will be pending upon completion
   of ERETU.

In step 4) above, the software event flag is set upon the sigreturn
syscall, and its corresponding ERETU would restore RFLAGS.TF = 1.
This combination causes a pending single-step trap upon completion of
ERETU.  Therefore, another #DB is triggered before any user space
instruction is executed, which leads to an infinite loop in which the
SIGTRAP handler keeps being invoked on the same user space IP.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250609084054.2083189-2-xin%40zytor.com
---
 arch/x86/include/asm/sighandling.h | 22 ++++++++++++++++++++++
 arch/x86/kernel/signal_32.c        |  4 ++++
 arch/x86/kernel/signal_64.c        |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4f..8727c7e 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,26 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+/*
+ * To prevent immediate repeat of single step trap on return from SIGTRAP
+ * handler if the trap flag (TF) is set without an external debugger attached,
+ * clear the software event flag in the augmented SS, ensuring no single-step
+ * trap is pending upon ERETU completion.
+ *
+ * Note, this function should be called in sigreturn() before the original
+ * state is restored to make sure the TF is read from the entry frame.
+ */
+static __always_inline void prevent_single_step_upon_eretu(struct pt_regs *regs)
+{
+	/*
+	 * If the trap flag (TF) is set, i.e., the sigreturn() SYSCALL instruction
+	 * is being single-stepped, do not clear the software event flag in the
+	 * augmented SS, thus a debugger won't skip over the following instruction.
+	 */
+#ifdef CONFIG_X86_FRED
+	if (!(regs->flags & X86_EFLAGS_TF))
+		regs->fred_ss.swevent = 0;
+#endif
+}
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 98123ff..42bbc42 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -152,6 +152,8 @@ SYSCALL32_DEFINE0(sigreturn)
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
 	sigset_t set;
 
+	prevent_single_step_upon_eretu(regs);
+
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -175,6 +177,8 @@ SYSCALL32_DEFINE0(rt_sigreturn)
 	struct rt_sigframe_ia32 __user *frame;
 	sigset_t set;
 
+	prevent_single_step_upon_eretu(regs);
+
 	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
 
 	if (!access_ok(frame, sizeof(*frame)))
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index ee94538..d483b58 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -250,6 +250,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	sigset_t set;
 	unsigned long uc_flags;
 
+	prevent_single_step_upon_eretu(regs);
+
 	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
@@ -366,6 +368,8 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	sigset_t set;
 	unsigned long uc_flags;
 
+	prevent_single_step_upon_eretu(regs);
+
 	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
 
 	if (!access_ok(frame, sizeof(*frame)))

