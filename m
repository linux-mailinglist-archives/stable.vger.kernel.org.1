Return-Path: <stable+bounces-146030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168FAAC045B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8B3A21007
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 06:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79648221294;
	Thu, 22 May 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="H5NGUBFI"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE4221291;
	Thu, 22 May 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894006; cv=none; b=QRk/4LaPzzC0xtBCnWaIJaUTe7CzFBZ3EXEoCkImEfryAmDx9k4HEUSJYYJ7XZj5lf875jBo4ScdY8fRm7rPa+mTs3aoGmED0C0yaWw08O+QwA5rF3MyUqicWzq9rjXtIptQA5FAS17+BnymNQur+tWRIvsxCBGbk/RXqZpRQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894006; c=relaxed/simple;
	bh=3uUHyRfLJdztYTGkPTgVR06e+kcwhGsy67DGZV9gnFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fnbw2N72/Ak6BKseUxVLPoOP46STSJxrR175g7GBFBF/9y8t1J59ojrwQ1uajMSiqYHOZ/6DKm+Pjzswhy9fLD0oCj2F+9CVSjdX9GdIhUfAd7Fvs8xq7a4LPwDzsz9jK0j+VhfJK7F0SSDCB4bAGShVcuHBCZbYCoofuKFwcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=H5NGUBFI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54M65nLE2882454
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 21 May 2025 23:05:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54M65nLE2882454
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747893954;
	bh=GQTgfqy03dtf8ijZGWz/fIIJUeISRIP8iFihkxPHWMg=;
	h=From:To:Cc:Subject:Date:From;
	b=H5NGUBFIK5zY4FDUe+DbLzCAL64ab8Cyb3uFQCLT651fRUVqSMMszk0H/RpCmmm3z
	 anOmTzeSrwvdtr8KJx3NyMg4fk3f2MSbT5LxPKj/kj53CC8I5/DDBXedz0Q1S/irXc
	 6/TRSSkJBWHWaxRcq7KudlWi3qSCrggMZ734aLE6jQxVZBIdgkblfWSPFl/wBpVnSE
	 N326IAs305uU44TebfAJmUtVhB4+eLa2NEFGDwlu5Vx8+b6h29n9LXEWSSqB+Ue17r
	 qs/gMGCymkveE0kCZEmuX8PDiBcyzDtdvrZ3VlIyG5fh61G3t7XwTBUvIxxRp9dj/0
	 d+X7vvccOOwIw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        stable@vger.kernel.org
Subject: [PATCH v1 1/1] x86/fred/signal: Prevent single-step upon ERETU completion
Date: Wed, 21 May 2025 23:05:49 -0700
Message-ID: <20250522060549.2882444-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Li <xin@zytor.com>

Clear the software event flag in the augmented SS to prevent infinite
SIGTRAP handler loop if TF is used without an external debugger.

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

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/sighandling.h | 20 ++++++++++++++++++++
 arch/x86/kernel/signal_32.c        |  4 ++++
 arch/x86/kernel/signal_64.c        |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..ecb0411fe88c 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,24 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+/*
+ * To prevent infinite SIGTRAP handler loop if TF is used without an external
+ * debugger, clear the software event flag in the augmented SS, ensuring no
+ * single-step trap is pending upon ERETU completion.
+ *
+ * Note, this function should be called in sigreturn() before the original state
+ * is restored to make sure the TF is read from the entry frame.
+ */
+static __always_inline void prevent_single_step_upon_eretu(struct pt_regs *regs)
+{
+	/*
+	 * If the trap flag (TF) is set, i.e., the sigreturn() SYSCALL instruction
+	 * is being single-stepped, do not clear the software event flag in the
+	 * augmented SS, thus a debugger won't skip over the following instruction.
+	 */
+	if (IS_ENABLED(CONFIG_X86_FRED) && cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !(regs->flags & X86_EFLAGS_TF))
+		regs->fred_ss.swevent = 0;
+}
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 98123ff10506..42bbc42bd350 100644
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
index ee9453891901..d483b585c6c6 100644
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

base-commit: 6a7c3c2606105a41dde81002c0037420bc1ddf00
-- 
2.49.0


