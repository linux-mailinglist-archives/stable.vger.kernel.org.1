Return-Path: <stable+bounces-66238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6CE94CEE1
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57747B21FFF
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253E1922EA;
	Fri,  9 Aug 2024 10:44:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8E191F65
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200264; cv=none; b=TZr3CDdEZSeEFEErv7cJxPo/zUdyUzEK8b2Rsimakbn/f6FxTSvXWo+axx091I5erLCij4KQ106hzOowLP4Qr5j2iNYNIpby7l0XmwoVct9/YcP37sVU2UrJv1W0SVj/5nhqv2sbAKod6WeGAHXQssD2zHLbUOnZNsLrizl4jAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200264; c=relaxed/simple;
	bh=8MG0R5+ozRaZYPkO3Rx7uu136gfX+dcxC8pdWl9j+DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPe+pz2I0IWpNNaRPpcN0d49B/0mHMHuJTyLuMm2bUFIVm5wgmdRwPE8//GmqNw+X00OdMA8zelAeykk54YpYrHsd5fGtgcs9C/L2r1ALZ21u7Jg6kUkdL7xQcUPH3rWtlAGOhPqBRtCq8lyptckjA67f6F9dL/Ol+SqKtuEHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4677113D5;
	Fri,  9 Aug 2024 03:44:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31C413F766;
	Fri,  9 Aug 2024 03:44:21 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	will@kernel.org
Subject: [PATCH 4.19.y 06/14] arm64: errata: Add workaround for Arm errata 3194386 and 3312417
Date: Fri,  9 Aug 2024 11:43:48 +0100
Message-Id: <20240809104356.3503412-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809104356.3503412-1-mark.rutland@arm.com>
References: <20240809104356.3503412-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 7187bb7d0b5c7dfa18ca82e9e5c75e13861b1d88 ]

Cortex-X4 and Neoverse-V3 suffer from errata whereby an MSR to the SSBS
special-purpose register does not affect subsequent speculative
instructions, permitting speculative store bypassing for a window of
time. This is described in their Software Developer Errata Notice (SDEN)
documents:

* Cortex-X4 SDEN v8.0, erratum 3194386:
  https://developer.arm.com/documentation/SDEN-2432808/0800/

* Neoverse-V3 SDEN v6.0, erratum 3312417:
  https://developer.arm.com/documentation/SDEN-2891958/0600/

To workaround these errata, it is necessary to place a speculation
barrier (SB) after MSR to the SSBS special-purpose register. This patch
adds the requisite SB after writes to SSBS within the kernel, and hides
the presence of SSBS from EL0 such that userspace software which cares
about SSBS will manipulate this via prctl(PR_GET_SPECULATION_CTRL, ...).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240508081400.235362-5-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: fix conflicts & renames, drop unneeded cpucaps.h, fold in user_feature_fixup() ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  2 ++
 arch/arm64/Kconfig                     | 41 ++++++++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 +-
 arch/arm64/kernel/cpu_errata.c         | 31 +++++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 12 ++++++++
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 5329e3e00e04f..e242e96648ed7 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -61,7 +61,9 @@ stable kernels.
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
+| ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
+| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3312417       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e16f0d45b47ac..2816ee3bfd989 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -531,6 +531,47 @@ config ARM64_ERRATUM_1742098
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_SPECULATIVE_SSBS
+	bool
+
+config ARM64_ERRATUM_3194386
+	bool "Cortex-X4: 3194386: workaround for MSR SSBS not self-synchronizing"
+	select ARM64_WORKAROUND_SPECULATIVE_SSBS
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-X4 erratum 3194386.
+
+	  On affected cores "MSR SSBS, #0" instructions may not affect
+	  subsequent speculative instructions, which may permit unexepected
+	  speculative store bypassing.
+
+	  Work around this problem by placing a speculation barrier after
+	  kernel changes to SSBS. The presence of the SSBS special-purpose
+	  register is hidden from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such
+	  that userspace will use the PR_SPEC_STORE_BYPASS prctl to change
+	  SSBS.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_3312417
+	bool "Neoverse-V3: 3312417: workaround for MSR SSBS not self-synchronizing"
+	select ARM64_WORKAROUND_SPECULATIVE_SSBS
+	default y
+	help
+	  This option adds the workaround for ARM Neoverse-V3 erratum 3312417.
+
+	  On affected cores "MSR SSBS, #0" instructions may not affect
+	  subsequent speculative instructions, which may permit unexepected
+	  speculative store bypassing.
+
+	  Work around this problem by placing a speculation barrier after
+	  kernel changes to SSBS. The presence of the SSBS special-purpose
+	  register is hidden from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such
+	  that userspace will use the PR_SPEC_STORE_BYPASS prctl to change
+	  SSBS.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index a7e2378df3d1c..3588caa7e2f71 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -57,7 +57,8 @@
 #define ARM64_SPECTRE_BHB			36
 #define ARM64_WORKAROUND_1742098		37
 #define ARM64_HAS_SB				38
+#define ARM64_WORKAROUND_SPECULATIVE_SSBS	39
 
-#define ARM64_NCAPS				39
+#define ARM64_NCAPS				40
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 7edb587fec55d..667ee52e8cb0f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -344,6 +344,19 @@ void arm64_set_ssbd_mitigation(bool state)
 			asm volatile(SET_PSTATE_SSBS(0));
 		else
 			asm volatile(SET_PSTATE_SSBS(1));
+
+		/*
+		 * SSBS is self-synchronizing and is intended to affect
+		 * subsequent speculative instructions, but some CPUs can
+		 * speculate with a stale value of SSBS.
+		 *
+		 * Mitigate this with an unconditional speculation barrier, as
+		 * CPUs could mis-speculate branches and bypass a conditional
+		 * barrier.
+		 */
+		if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS))
+			spec_bar();
+
 		return;
 	}
 
@@ -694,6 +707,17 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS
+static const struct midr_range erratum_spec_ssbs_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_3194386
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_3312417
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+#endif
+	{}
+};
+#endif
 
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
@@ -903,6 +927,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		CAP_MIDR_RANGE_LIST(broken_aarch32_aes),
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS
+	{
+		.desc = "ARM errata 3194386, 3312417",
+		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
+		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 094a74b2efa79..e548f4bf3dcd6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1178,6 +1178,17 @@ static void cpu_enable_ssbs(const struct arm64_cpu_capabilities *__unused)
 }
 #endif /* CONFIG_ARM64_SSBD */
 
+static void user_feature_fixup(void)
+{
+	if (cpus_have_cap(ARM64_WORKAROUND_SPECULATIVE_SSBS)) {
+		struct arm64_ftr_reg *regp;
+
+		regp = get_arm64_ftr_reg(SYS_ID_AA64PFR1_EL1);
+		if (regp)
+			regp->user_mask &= ~GENMASK(7, 4); /* SSBS */
+	}
+}
+
 static void elf_hwcap_fixup(void)
 {
 #ifdef CONFIG_ARM64_ERRATUM_1742098
@@ -1842,6 +1853,7 @@ void __init setup_cpu_features(void)
 
 	setup_system_capabilities();
 	mark_const_caps_ready();
+	user_feature_fixup();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0()) {
-- 
2.30.2


