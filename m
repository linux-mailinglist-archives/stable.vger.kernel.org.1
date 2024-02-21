Return-Path: <stable+bounces-23239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449D85E908
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 21:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E00B266DD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F586631;
	Wed, 21 Feb 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AD5zgsg0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXPfD9FT"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A752A8DA
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547352; cv=none; b=Q34TV4Y+V4VBQgsVxcJCzpiayguhKoM1aqnM/BQ8cuZuZrIzdFRuDkZBG69fRAVKLGwJ4J+ME53WYzO+a52rdiAaISRn+bEycjNaNfgwWni3sRN4+B375rbohSwqvcTtGBH+UKXLxXMPhu5rBfiJrbhtEDn+63ns2mupojQnhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547352; c=relaxed/simple;
	bh=eeiBaIdYDzx5DuPczwiui7GFKx888NEiUrIz1In0HyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3+FiJ+p+J5JJNLaHJ9FPeohfm43u2RvenkkJhjGK2gsJzN0WDjXL9z9q5/5tQG/MxgU+Q9wDsXKY0bd9sVv7ohV8mpX5hKtx183Xsg84noSCBMA/6r//Iga83SahUuNsvMCVLzJ7Hbld2a++gxJQmE+aB1lHYFdhqTwPyCVuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AD5zgsg0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXPfD9FT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708547349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djEX/5c6Roro+ieKTKHtuYR7XyipvDWeeeUXBEjAY4o=;
	b=AD5zgsg01JvsF50xjimxHndSZrC1gAPeMqk/XRs616OVQwXTR5/M7SPQG8YQwCtYIhGAJF
	cC238s5tbT1/JeXlnL+muZ83hT4RFR7EeMmg8LPdgBb/ATEU4NvFP6DppDC63ZPOSuu9eB
	nYhSy1mSXjplwLj8+XzU3qdqSRk0A5Lu3474IRerQKzL5FHhnUyN04Y66A4AgZ7rFGOpIN
	7kDxCMs11zROh+yDwyAtxSkMGqWu4TK3WYF0lYjS3DGFS1yJD+Lj39KM+o+8gtOOVYuijL
	vNMGUgnaX7lKm7JdigBNF8pwmFBhNXebyWjJRCuaCvGCC6O2g4o9f1bbcsdHkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708547349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djEX/5c6Roro+ieKTKHtuYR7XyipvDWeeeUXBEjAY4o=;
	b=yXPfD9FTzDloaT2+jz+jvz6Wc+5dDl3Gl7qfAHA7LIAKzJH9f+z8KwTX33tAA4Mv19fs6i
	JCwfOckHPpxrTaDw==
To: gregkh@linuxfoundation.org, avagin@google.com, bogomolov@google.com,
 dave.hansen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH linux-5.15.y] x86/fpu: Stop relying on userspace for info to
 fault in xsave
In-Reply-To: <2024021941-reprimand-grudge-7734@gregkh>
References: <2024021941-reprimand-grudge-7734@gregkh>
Date: Wed, 21 Feb 2024 21:29:08 +0100
Message-ID: <87msrtftnv.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Andrei Vagin <avagin@google.com>

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
[ tglx: Backport to 5.15 stable ]

Fixes: fcb3635f5018 ("x86/fpu/signal: Handle #PF in the direct restore path")
Reported-by: Konstantin Bogomolov <bogomolov@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240130063603.3392627-1-avagin%40google.com
---
 arch/x86/kernel/fpu/signal.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -246,12 +246,13 @@ static int __restore_fpregs_from_user(vo
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				    bool fx_only, unsigned int size)
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
 
+	/* Restore enabled features only. */
+	xrestore &= xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 retry:
 	fpregs_lock();
 	pagefault_disable();
@@ -278,7 +279,7 @@ static int restore_fpregs_from_user(void
 		if (ret != -EFAULT)
 			return -EINVAL;
 
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
@@ -303,7 +304,6 @@ static int restore_fpregs_from_user(void
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			     bool ia32_fxstate)
 {
-	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
@@ -319,7 +319,6 @@ static int __fpu_restore_sig(void __user
 			return ret;
 
 		fx_only = !fx_sw_user.magic1;
-		state_size = fx_sw_user.xstate_size;
 		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures = XFEATURE_MASK_FPSSE;
@@ -332,8 +331,7 @@ static int __fpu_restore_sig(void __user
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 	}
 
 	/*

