Return-Path: <stable+bounces-24608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B600A869564
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D481C24CB2
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267D145323;
	Tue, 27 Feb 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbG/Z2Ez"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D911448C3;
	Tue, 27 Feb 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042490; cv=none; b=jxLtGgVPMwnwBUlhtnpD9zOEUOPzKTLeMM1IRW58srPJI+STeBLm02PefB2yv9ko96bjY8ptLiuy/SwWNKMms/guPYcPijvLIg6/k9J1RCVOTgdZ22oys7RKmqaHwCHff63r69To971Ur67s3KbIMcC0liNJSMWxt4vxGwlq77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042490; c=relaxed/simple;
	bh=AWcg2gGW/jWE9sWgNjKpnjlRofZALr6nxrZWi8BhDRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPF5X1s/b52boFdSar9N38xPc6f0dQcthsGbSQ9OOVcIAcPn3sR/Ca19qSommhM3TrNFpU88KejEved2ekktNzpErKwvoLQiodZtSOGVeqbZWh/d5t2pZpcPq9gu6weo+a0+7colLNUhE6qmmfqDIM43xj7QJb+NSXpWOgisoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbG/Z2Ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20289C433B2;
	Tue, 27 Feb 2024 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042490;
	bh=AWcg2gGW/jWE9sWgNjKpnjlRofZALr6nxrZWi8BhDRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbG/Z2Ez5VEqZKfkcgazuvXjxO5m4FYEcrOnZQEssZwiUjAgBVga55tlPzfbCsq9z
	 mpQMAGW000OArjXwscuhyoKVcpplXxtOX6DExlGCGwO73EUYTaAuwAyMDGKMJPyyO1
	 qtoHxF4YQzLlcYW9kvWJmgy68XTpUeE5Nz/H7/Cg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Bogomolov <bogomolov@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrei Vagin <avagin@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.15 015/245] x86/fpu: Stop relying on userspace for info to fault in xsave buffer
Date: Tue, 27 Feb 2024 14:23:23 +0100
Message-ID: <20240227131615.611869725@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Vagin <avagin@google.com>

commit d877550eaf2dc9090d782864c96939397a3c6835 upstream.

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
Link: https://lore.kernel.org/all/20240130063603.3392627-1-avagin%40google.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
@@ -278,7 +279,7 @@ retry:
 		if (ret != -EFAULT)
 			return -EINVAL;
 
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
@@ -303,7 +304,6 @@ retry:
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



