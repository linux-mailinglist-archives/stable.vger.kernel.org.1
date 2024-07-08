Return-Path: <stable+bounces-58222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD07792A33C
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2B1F23044
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2B824A1;
	Mon,  8 Jul 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ni3EK5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78998172D
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443091; cv=none; b=uvDlNn8hWCpCuENWOZXSyHZbLVEbn6OvH/P/haaYub0zjOigmwq0Sn8WeTae4oXmskPLWCrBclQ5Jb4b+Tc0Lph7R/Xm1RjK/buGvFBfVEUiJE9IDxLZatI0i3y9qGp9Bcf6vqRB5q2WLjB3D0pGT1srNwDNVntjo5Si1fJfbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443091; c=relaxed/simple;
	bh=24HD32PaIogGeuL1pJ8g3nt9TmSy9SGF1K+wRhGJg4Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nhLvyJl7iEkE89lVVQ/HPW3jsOZxkJ0dt52XBu1WRhpVcCN58331/BnQiOht/PwCEWLOMB+KIczsTNKnrL5u7ejjtmJwhGuPfVUwWvUW/TwFUXql8x/ucAY2DeYVrG1dIcD5pihhMCK9MMhqkYLOz6DXmouTf6n5qz0seq+VrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ni3EK5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E590C116B1;
	Mon,  8 Jul 2024 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443091;
	bh=24HD32PaIogGeuL1pJ8g3nt9TmSy9SGF1K+wRhGJg4Y=;
	h=Subject:To:Cc:From:Date:From;
	b=2ni3EK5o8wAnzW5Z32cq+BF0yqAfq4JqzH4gjspJnB/MW9UhoeMA4aXtxPqMYsy4t
	 X+Dfo08OSbQQc3exsZxg/+UdFJGjrbckl4l+Nh7fDAHWNWOULbzHRL7xFhYhYp3TcN
	 3aiYmRw/1O/Bzxq9mVWYsrG1X0ISscf/UrwhUpi8=
Subject: FAILED: patch "[PATCH] powerpc/pseries: Fix scv instruction crash with kexec" failed to apply to 5.10-stable tree
To: npiggin@gmail.com,gautam@linux.ibm.com,mpe@ellerman.id.au,sourabhjain@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:51:20 +0200
Message-ID: <2024070820-relapse-humbly-3545@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 21a741eb75f80397e5f7d3739e24d7d75e619011
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070820-relapse-humbly-3545@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

21a741eb75f8 ("powerpc/pseries: Fix scv instruction crash with kexec")
2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
e6f6390ab7b9 ("powerpc: Add missing headers")
3ba4289a3e7f ("powerpc: Simplify and move arch_randomize_brk()")
ce0091a0e060 ("powerpc/time: Fix sparse warnings")
387e220a2e5e ("powerpc/64s: Move hash MMU support code under CONFIG_PPC_64S_HASH_MMU")
20626177c9de ("powerpc: make memremap_compat_align 64s-only")
ffbe5d21d10f ("powerpc/64: pcpu setup avoid reading mmu_linear_psize on 64e or radix")
f43d2ffb47c9 ("powerpc/64s: Rename hash_hugetlbpage.c to hugetlbpage.c")
162b0889bba6 ("powerpc/64s: move THP trace point creation out of hash specific file")
3d3282fd34d8 ("powerpc/pseries: lparcfg don't include slb_size line in radix mode")
0c7cc15e9215 ("powerpc/pseries: move process table registration away from hash-specific code")
7ebc49031d04 ("powerpc: Rename PPC_NATIVE to PPC_HASH_MMU_NATIVE")
6e5772c8d9cf ("Merge tag 'x86_cc_for_v5.16_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21a741eb75f80397e5f7d3739e24d7d75e619011 Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 25 Jun 2024 23:40:47 +1000
Subject: [PATCH] powerpc/pseries: Fix scv instruction crash with kexec

kexec on pseries disables AIL (reloc_on_exc), required for scv
instruction support, before other CPUs have been shut down. This means
they can execute scv instructions after AIL is disabled, which causes an
interrupt at an unexpected entry location that crashes the kernel.

Change the kexec sequence to disable AIL after other CPUs have been
brought down.

As a refresher, the real-mode scv interrupt vector is 0x17000, and the
fixed-location head code probably couldn't easily deal with implementing
such high addresses so it was just decided not to support that interrupt
at all.

Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
Cc: stable@vger.kernel.org # v5.9+
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Closes: https://lore.kernel.org/3b4b2943-49ad-4619-b195-bc416f1d1409@linux.ibm.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://msgid.link/20240625134047.298759-1-npiggin@gmail.com
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 85050be08a23..72b12bc10f90 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -27,6 +27,7 @@
 #include <asm/paca.h>
 #include <asm/mmu.h>
 #include <asm/sections.h>	/* _end */
+#include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/svm.h>
@@ -317,6 +318,16 @@ void default_machine_kexec(struct kimage *image)
 	if (!kdump_in_progress())
 		kexec_prepare_cpus();
 
+#ifdef CONFIG_PPC_PSERIES
+	/*
+	 * This must be done after other CPUs have shut down, otherwise they
+	 * could execute the 'scv' instruction, which is not supported with
+	 * reloc disabled (see configure_exceptions()).
+	 */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE))
+		pseries_disable_reloc_on_exc();
+#endif
+
 	printk("kexec: Starting switchover sequence.\n");
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 096d09ed89f6..431be156ca9b 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -61,11 +61,3 @@ void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 	} else
 		xics_kexec_teardown_cpu(secondary);
 }
-
-void pseries_machine_kexec(struct kimage *image)
-{
-	if (firmware_has_feature(FW_FEATURE_SET_MODE))
-		pseries_disable_reloc_on_exc();
-
-	default_machine_kexec(image);
-}
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index bba4ad192b0f..3968a6970fa8 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -38,7 +38,6 @@ static inline void smp_init_pseries(void) { }
 #endif
 
 extern void pseries_kexec_cpu_down(int crash_shutdown, int secondary);
-void pseries_machine_kexec(struct kimage *image);
 
 extern void pSeries_final_fixup(void);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index cba40d9d1284..b10a25325238 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -1159,7 +1159,6 @@ define_machine(pseries) {
 	.machine_check_exception = pSeries_machine_check_exception,
 	.machine_check_log_err	= pSeries_machine_check_log_err,
 #ifdef CONFIG_KEXEC_CORE
-	.machine_kexec          = pseries_machine_kexec,
 	.kexec_cpu_down         = pseries_kexec_cpu_down,
 #endif
 #ifdef CONFIG_MEMORY_HOTPLUG


