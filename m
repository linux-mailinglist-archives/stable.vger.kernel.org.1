Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56917BC792
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbjJGMfC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjJGMfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:35:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49063B9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:35:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E35C433C7;
        Sat,  7 Oct 2023 12:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696682099;
        bh=6eG0/SpRJhcw2L5pjTGDxa2eoDxpxufCW0+LecSy+zU=;
        h=Subject:To:Cc:From:Date:From;
        b=cLQ3kgfUFv8IIjFJize+h4Bjx6FmaO055h6NNZYfSHzUf3pSbMEz+YCDOwzz9gAJc
         ypdbqR3BPqw/JlLBt3QhsJ8Pp4HSBqkMcgE0Kr6JRoJ08WdND0ZweoN1KOWYrzaADU
         1z2Ape867JZTL2yAl+VmZwFTp4wVl0qPDlewuCNw=
Subject: FAILED: patch "[PATCH] arm64: errata: Add Cortex-A520 speculative unprivileged load" failed to apply to 4.19-stable tree
To:     robh@kernel.org, will@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:34:47 +0200
Message-ID: <2023100747-florist-sneak-25ba@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 471470bc7052d28ce125901877dd10e4c048e513
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100747-florist-sneak-25ba@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

471470bc7052 ("arm64: errata: Add Cortex-A520 speculative unprivileged load workaround")
cce8365fc47b ("arm64: errata: Group all Cortex-A510 errata together")
6df696cd9bc1 ("arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2")
52b603628a2c ("Merge branch kvm-arm64/parallel-access-faults into kvmarm/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 471470bc7052d28ce125901877dd10e4c048e513 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Sep 2023 14:41:52 -0500
Subject: [PATCH] arm64: errata: Add Cortex-A520 speculative unprivileged load
 workaround

Implement the workaround for ARM Cortex-A520 erratum 2966298. On an
affected Cortex-A520 core, a speculatively executed unprivileged load
might leak data from a privileged load via a cache side channel. The
issue only exists for loads within a translation regime with the same
translation (e.g. same ASID and VMID). Therefore, the issue only affects
the return to EL0.

The workaround is to execute a TLBI before returning to EL0 after all
loads of privileged data. A non-shareable TLBI to any address is
sufficient.

The workaround isn't necessary if page table isolation (KPTI) is
enabled, but for simplicity it will be. Page table isolation should
normally be disabled for Cortex-A520 as it supports the CSV3 feature
and the E0PD feature (used when KASLR is enabled).

Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230921194156.1050055-2-robh@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index e96f057ea2a0..f47f63bcf67c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -71,6 +71,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..78f20e632712 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1037,6 +1037,19 @@ config ARM64_ERRATUM_2645198
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2966298
+	bool "Cortex-A520: 2966298: workaround for speculatively executed unprivileged load"
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A520 erratum 2966298.
+
+	  On an affected Cortex-A520 core, a speculatively executed unprivileged
+	  load might leak data from a privileged level via a cache side channel.
+
+	  Work around this problem by executing a TLBI before returning to EL0.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index be66e94a21bd..5706e74c5578 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -730,6 +730,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.cpu_enable = cpu_clear_bf16_from_user_emulation,
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_2966298
+	{
+		.desc = "ARM erratum 2966298",
+		.capability = ARM64_WORKAROUND_2966298,
+		/* Cortex-A520 r0p0 - r0p1 */
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
+	},
+#endif
 #ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
 	{
 		.desc = "AmpereOne erratum AC03_CPU_38",
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6ad61de03d0a..a6030913cd58 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -428,6 +428,10 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+alternative_if ARM64_WORKAROUND_2966298
+	tlbi	vale1, xzr
+	dsb	nsh
+alternative_else_nop_endif
 alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index c3f06fdef609..dea3dc89234b 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -84,6 +84,7 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
+WORKAROUND_2966298
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE

