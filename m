Return-Path: <stable+bounces-73883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B7997074F
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94182B20CF2
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B6158541;
	Sun,  8 Sep 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m/G+Q8RO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8B1531F3
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797772; cv=none; b=smMXFxYBr1aS15jpYRJFWWs3LFRTS56b4kEDwaLktE3AkwUnvUMnhaAvSKpmaNxA0m5rgDRWsdVhVZ3c19XcvQQ2IEtPkhbMZqEv52R6wMMjuxt/vQsfrpnYMQmgLvxp0W/EgekPXk3iTtt/ayGlsuafwOWuy6pJPi0d4MC/AuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797772; c=relaxed/simple;
	bh=V/uYeUuhGGLwSWliacqi+sRc+gtemW+KfUteFNZln/0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mzzJ4lkDU7Zdu3qbFiwoYy3cpyFfsh20GrXPt1ryqE+6UCOCAOapVWBqYVYjf1tnVLs03hXKbwir0MVMIjjq71NpNkn4Ij2RhVeuCb1nF5RxFiZ2TlRFGB9jfy7zq620MohUSLcjDDTl18RYFpMJNFAGqIisEga2ysV/V2w6EJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m/G+Q8RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952A0C4CEC3;
	Sun,  8 Sep 2024 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797772;
	bh=V/uYeUuhGGLwSWliacqi+sRc+gtemW+KfUteFNZln/0=;
	h=Subject:To:Cc:From:Date:From;
	b=m/G+Q8RORBCXdQ3dv84dxKCqdGA0eocK4wQ3bvoaII2h3qjx/MCkRKZpIz8anbypp
	 +bziwgiNwzNCeh6znO8zHzN+SgpwJkKqB7wf2d61tiOpu9dZpxrm/Xn1HidzTaElf4
	 B+qaetTbjRXvknYpggLC+gP96XpzILNunYDQY7/k=
Subject: FAILED: patch "[PATCH] x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported" failed to apply to 5.15-stable tree
To: levymitchell0@gmail.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:16:09 +0200
Message-ID: <2024090809-plaything-sash-1d57@gregkh>
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
git cherry-pick -x 2848ff28d180bd63a95da8e5dcbcdd76c1beeb7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090809-plaything-sash-1d57@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2848ff28d180 ("x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported")
c33f0a81a2cf ("x86/fpu: Add fpu_state_config::legacy_features")
d72c87018d00 ("x86/fpu/xstate: Move remaining xfeature helpers to core")
eda32f4f93b4 ("x86/fpu: Rework restore_regs_from_fpstate()")
daddee247319 ("x86/fpu: Mop up xfeatures_mask_uabi()")
1c253ff2287f ("x86/fpu: Move xstate feature masks to fpu_*_cfg")
2bd264bce238 ("x86/fpu: Move xstate size to fpu_*_cfg")
cd9ae7617449 ("x86/fpu/xstate: Cleanup size calculations")
617473acdfe4 ("x86/fpu: Cleanup fpu__init_system_xstate_size_legacy()")
578971f4e228 ("x86/fpu: Provide struct fpu_config")
5509cc78080d ("x86/fpu/signal: Use fpstate for size and features")
ad6ede407aae ("x86/fpu: Use fpstate in fpu_copy_kvm_uabi_to_fpstate()")
be31dfdfd75b ("x86/fpu: Use fpstate::size")
248452ce21ae ("x86/fpu: Add size and mask information to fpstate")
2dd8eedc80b1 ("x86/process: Move arch_thread_struct_whitelist() out of line")
c20942ce5128 ("x86/fpu/core: Convert to fpstate")
7e049e8b7459 ("x86/fpu/signal: Convert to fpstate")
087df48c298c ("x86/fpu: Replace KVMs xstate component clearing")
18b3fa1ad15f ("x86/fpu: Convert restore_fpregs_from_fpstate() to struct fpstate")
f83ac56acdad ("x86/fpu: Convert fpstate_init() to struct fpstate")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2848ff28d180bd63a95da8e5dcbcdd76c1beeb7b Mon Sep 17 00:00:00 2001
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Mon, 12 Aug 2024 13:44:12 -0700
Subject: [PATCH] x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

There are two distinct CPU features related to the use of XSAVES and LBR:
whether LBR is itself supported and whether XSAVES supports LBR. The LBR
subsystem correctly checks both in intel_pmu_arch_lbr_init(), but the
XSTATE subsystem does not.

The LBR bit is only removed from xfeatures_mask_independent when LBR is not
supported by the CPU, but there is no validation of XSTATE support.

If XSAVES does not support LBR the write to IA32_XSS causes a #GP fault,
leaving the state of IA32_XSS unchanged, i.e. zero. The fault is handled
with a warning and the boot continues.

Consequently the next XRSTORS which tries to restore supervisor state fails
with #GP because the RFBM has zero for all supervisor features, which does
not match the XCOMP_BV field.

As XFEATURE_MASK_FPSTATE includes supervisor features setting up the FPU
causes a #GP, which ends up in fpu_reset_from_exception_fixup(). That fails
due to the same problem resulting in recursive #GPs until the kernel runs
out of stack space and double faults.

Prevent this by storing the supported independent features in
fpu_kernel_cfg during XSTATE initialization and use that cached value for
retrieving the independent feature bits to be written into IA32_XSS.

[ tglx: Massaged change log ]

Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb17f31b06d2..de16862bf230 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -591,6 +591,13 @@ struct fpu_state_config {
 	 * even without XSAVE support, i.e. legacy features FP + SSE
 	 */
 	u64 legacy_features;
+	/*
+	 * @independent_features:
+	 *
+	 * Features that are supported by XSAVES, but not managed as part of
+	 * the FPU core, such as LBR
+	 */
+	u64 independent_features;
 };
 
 /* FPU state configuration information */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026fee5e0..1339f8328db5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -788,6 +788,9 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
+					      XFEATURE_MASK_INDEPENDENT;
+
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c53dcc..afb404cd2059 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -62,9 +62,9 @@ static inline u64 xfeatures_mask_supervisor(void)
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return fpu_kernel_cfg.independent_features & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_INDEPENDENT;
+	return fpu_kernel_cfg.independent_features;
 }
 
 /* XSAVE/XRSTOR wrapper functions */


