Return-Path: <stable+bounces-66204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37C94CE74
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5142828C7
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D11917CE;
	Fri,  9 Aug 2024 10:17:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EB41C6E
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198675; cv=none; b=CBFSX+xT0B6MSO6jEVwIQ3A8ZyKPSGOhOvsHiEicJudyBUv8kjpZqAfuN3uZe8NlGbUGpSxtg1qeZZc5e8wsnrk6cLnd8LT4h4aoa+6Pkqruc+fy+NvmFlQLolAvbmo7W856IARVcaCe2n5SULNtbUq0CoKKjbcYeDnQtfuu4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198675; c=relaxed/simple;
	bh=YDxOknRf2GS7PHfHsxyLoyXxtqog21LfQcOQmCryf4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5UNBQ6e33F5dkZ+SgqMBGdLoMKUbF1flY8W2qIcbGmsWLT718BrLleJr1H6D1DgBtzf6OzgSq5Z7D6vA/3NmKEYaycZy8oYb+F+kbCSggj+TYeD6UQ13OpwN3fhkU+jPQOEEx7Yp0Py+zlMZMiSY3++gr4hnuHcznwxd367aBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF461691;
	Fri,  9 Aug 2024 03:18:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F30193F766;
	Fri,  9 Aug 2024 03:17:52 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org
Subject: [PATCH 5.10.y 05/13] arm64: errata: Add workaround for Arm errata 3194386 and 3312417
Date: Fri,  9 Aug 2024 11:17:31 +0100
Message-Id: <20240809101739.3477931-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809101739.3477931-1-mark.rutland@arm.com>
References: <20240809101739.3477931-1-mark.rutland@arm.com>
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
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 41 ++++++++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 +-
 arch/arm64/kernel/cpu_errata.c         | 19 ++++++++++++
 arch/arm64/kernel/cpufeature.c         | 12 ++++++++
 arch/arm64/kernel/proton-pack.c        | 12 ++++++++
 6 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 10a26d44ef4a9..0ecb714b2c426 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -98,12 +98,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3312417       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 13cf137da999a..0d59e8ab27c88 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -691,6 +691,47 @@ config ARM64_ERRATUM_2457168
 
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
index d2080a41f6e6f..931c88182fb8b 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -69,7 +69,8 @@
 #define ARM64_SPECTRE_BHB			59
 #define ARM64_WORKAROUND_2457168		60
 #define ARM64_WORKAROUND_1742098		61
+#define ARM64_WORKAROUND_SPECULATIVE_SSBS	62
 
-#define ARM64_NCAPS				62
+#define ARM64_NCAPS				63
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 5d6f19bc628c2..3eabd809aee4a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -364,6 +364,18 @@ static struct midr_range broken_aarch32_aes[] = {
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
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -570,6 +582,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
index 11a42fcf94bfc..dc92fd590f2f9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1753,6 +1753,17 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_MTE */
 
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
@@ -2764,6 +2775,7 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 
 	setup_system_capabilities();
+	user_feature_fixup();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0()) {
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 9c0e9d9eed6e2..b40310e0bdb90 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -574,6 +574,18 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 
 	/* SCTLR_EL1.DSSBS was initialised to 0 during boot */
 	asm volatile(SET_PSTATE_SSBS(0));
+
+	/*
+	 * SSBS is self-synchronizing and is intended to affect subsequent
+	 * speculative instructions, but some CPUs can speculate with a stale
+	 * value of SSBS.
+	 *
+	 * Mitigate this with an unconditional speculation barrier, as CPUs
+	 * could mis-speculate branches and bypass a conditional barrier.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS))
+		spec_bar();
+
 	return SPECTRE_MITIGATED;
 }
 
-- 
2.30.2


