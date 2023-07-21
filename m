Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA675C961
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGUOOL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjGUOOE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73F5FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5770D61B68
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B612C433C8;
        Fri, 21 Jul 2023 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689948840;
        bh=CYoJV7vuUIAinL4Gg6oV34ukJxPdr9iGzluBDXSXpUA=;
        h=Subject:To:Cc:From:Date:From;
        b=pQDu6CCCbwf6+PBoirFyYe/GWeAFg+l3bND47w59c+lGEwDJUX9TChRoFfdOGPuwX
         EKWY1mWrf99KaJ3vMYyqpl0HG7f13yRuWnZ75NcVJB3LH10yO3CjDPl9gzpxyV3Jnk
         pet/CXnu4jKMmoHzAQ+NchJ39mcYvcxrU5CtREu0=
Subject: FAILED: patch "[PATCH] arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at" failed to apply to 4.19-stable tree
To:     oliver.upton@linux.dev, catalin.marinas@arm.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:13:51 +0200
Message-ID: <2023072151-ditzy-judge-9d51@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 6df696cd9bc1ceed0e92e36908f88bbd16d18255
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072151-ditzy-judge-9d51@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

6df696cd9bc1 ("arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2")
1dfc3e905089 ("KVM: arm64: Condition HW AF updates on config option")
1bdb0fbb2e27 ("arm64: errata: remove BF16 HWCAP due to incorrect result on Cortex-A510")
e89d120c4b72 ("arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly")
44b3834b2eed ("arm64: errata: Remove AES hwcap for COMPAT tasks")
39fdb65f52e9 ("arm64: errata: Add Cortex-A510 to the repeat tlbi list")
1dd498e5e26a ("KVM: arm64: Workaround Cortex-A510's single-step and PAC trap errata")
297ae1eb23b0 ("arm64: cpufeature: List early Cortex-A510 parts as having broken dbm")
708e8af4924e ("arm64: errata: Add detection for TRBE trace data corruption")
3bd94a8759de ("arm64: errata: Add detection for TRBE invalid prohibited states")
607a9afaae09 ("arm64: errata: Add detection for TRBE ignored system register writes")
83bb2c1a01d7 ("KVM: arm64: Save PSTATE early on exit")
d7e0a795bf37 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6df696cd9bc1ceed0e92e36908f88bbd16d18255 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Fri, 9 Jun 2023 22:01:02 +0000
Subject: [PATCH] arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at
 stage-2

AmpereOne has an erratum in its implementation of FEAT_HAFDBS that
required disabling the feature on the design. This was done by reporting
the feature as not implemented in the ID register, although the
corresponding control bits were not actually RES0. This does not align
well with the requirements of the architecture, which mandates these
bits be RES0 if HAFDBS isn't implemented.

The kernel's use of stage-1 is unaffected, as the HA and HD bits are
only set if HAFDBS is detected in the ID register. KVM, on the other
hand, relies on the RES0 behavior at stage-2 to use the same value for
VTCR_EL2 on any cpu in the system. Mitigate the non-RES0 behavior by
leaving VTCR_EL2.HA clear on affected systems.

Cc: stable@vger.kernel.org
Cc: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Darren Hart <darren@os.amperecomputing.com>
Acked-by: D Scott Phillips <scott@os.amperecomputing.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230609220104.1836988-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 9e311bc43e05..cd46e2b20a81 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -52,6 +52,9 @@ stable kernels.
 | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..0987c637fbf2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -406,6 +406,25 @@ menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
 
+config AMPERE_ERRATUM_AC03_CPU_38
+        bool "AmpereOne: AC03_CPU_38: Certain bits in the Virtualization Translation Control Register and Translation Control Registers do not follow RES0 semantics"
+	default y
+	help
+	  This option adds an alternative code sequence to work around Ampere
+	  erratum AC03_CPU_38 on AmpereOne.
+
+	  The affected design reports FEAT_HAFDBS as not implemented in
+	  ID_AA64MMFR1_EL1.HAFDBS, but (V)TCR_ELx.{HA,HD} are not RES0
+	  as required by the architecture. The unadvertised HAFDBS
+	  implementation suffers from an additional erratum where hardware
+	  A/D updates can occur after a PTE has been marked invalid.
+
+	  The workaround forces KVM to explicitly set VTCR_EL2.HA to 0,
+	  which avoids enabling unadvertised hardware Access Flag management
+	  at stage-2.
+
+	  If unsure, say Y.
+
 config ARM64_WORKAROUND_CLEAN_CACHE
 	bool
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 307faa2b4395..be66e94a21bd 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -729,6 +729,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
 		.cpu_enable = cpu_clear_bf16_from_user_emulation,
 	},
+#endif
+#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
+	{
+		.desc = "AmpereOne erratum AC03_CPU_38",
+		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 5282cb9ca4cf..32d92ce4bae5 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -611,10 +611,18 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 #ifdef CONFIG_ARM64_HW_AFDBM
 	/*
 	 * Enable the Hardware Access Flag management, unconditionally
-	 * on all CPUs. The features is RES0 on CPUs without the support
-	 * and must be ignored by the CPUs.
+	 * on all CPUs. In systems that have asymmetric support for the feature
+	 * this allows KVM to leverage hardware support on the subset of cores
+	 * that implement the feature.
+	 *
+	 * The architecture requires VTCR_EL2.HA to be RES0 (thus ignored by
+	 * hardware) on implementations that do not advertise support for the
+	 * feature. As such, setting HA unconditionally is safe, unless you
+	 * happen to be running on a design that has unadvertised support for
+	 * HAFDBS. Here be dragons.
 	 */
-	vtcr |= VTCR_EL2_HA;
+	if (!cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_38))
+		vtcr |= VTCR_EL2_HA;
 #endif /* CONFIG_ARM64_HW_AFDBM */
 
 	/* Set the vmid bits */
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 40ba95472594..9f9a2d6652eb 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -77,6 +77,7 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
+WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE

