Return-Path: <stable+bounces-66148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E894CDF9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ECB2847F2
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1061922F8;
	Fri,  9 Aug 2024 09:51:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D0192B7F
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197097; cv=none; b=pSpwS9kEufqrzxHMSgniybd4zJxyjwTr1iQx4QpCMPhnVjZ8PC/eOPUenEAQTnrzPS2mHDyl80i5ziU91IRP98eFXEiF+NOhyqR9vUUh3IEVpHR7MhFLo2dyZOn238/NkLWdFmLuhEqdq32YYbFChIk9eunY6Ee+Cc4V3eIylN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197097; c=relaxed/simple;
	bh=V/z95L9T9ga2UpEPnei6HXZygggpvNMJesMX6blGiQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJNCY4zKTZGayihKeA+gmtglR/n+xabcfo1mL30s9Vaugh8+H5dwUEwHUKXO4gbjv/CLfYI4xmFYmd5OwPhBWujdVV4fJIGpCEWoP9efbY5tCdDp5XyIkXjWXTe1vWxqX43KF6d3KBgJLDwNo5yv7gpDqF1zRRc0z3qbZi/Cxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B37ED13D5;
	Fri,  9 Aug 2024 02:52:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 133593F766;
	Fri,  9 Aug 2024 02:51:33 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.10.y 4/8] arm64: errata: Unify speculative SSBS errata logic
Date: Fri,  9 Aug 2024 10:51:16 +0100
Message-Id: <20240809095120.3475335-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809095120.3475335-1-mark.rutland@arm.com>
References: <20240809095120.3475335-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit ec768766608092087dfb5c1fc45a16a6f524dee2 ]

Cortex-X4 erratum 3194386 and Neoverse-V3 erratum 3312417 are identical,
with duplicate Kconfig text and some unsightly ifdeffery. While we try
to share code behind CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS, having
separate options results in a fair amount of boilerplate code, and this
will only get worse as we expand the set of affected CPUs.

To reduce this boilerplate, unify the two behind a common Kconfig
option. This removes the duplicate text and Kconfig logic, and removes
the need for the intermediate ARM64_WORKAROUND_SPECULATIVE_SSBS option.
The set of affected CPUs is described as a list so that this can easily
be extended.

I've used ARM64_ERRATUM_3194386 (matching the Neoverse-V3 erratum ID) as
the common option, matching the way we use ARM64_ERRATUM_1319367 to
cover Cortex-A57 erratum 1319537 and Cortex-A72 erratum 1319367.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240603111812.1514101-5-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 +-
 arch/arm64/Kconfig                          | 29 +++------------------
 arch/arm64/include/asm/cpucaps.h            |  2 +-
 arch/arm64/kernel/cpu_errata.c              |  8 ++----
 arch/arm64/kernel/proton-pack.c             |  2 +-
 5 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index eb8af8032c315..59ee2832406c2 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -158,7 +158,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #1619801        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3312417       |
+| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b53..fb31ff9151b9d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1067,34 +1067,14 @@ config ARM64_ERRATUM_3117295
 
 	  If unsure, say Y.
 
-config ARM64_WORKAROUND_SPECULATIVE_SSBS
-	bool
-
 config ARM64_ERRATUM_3194386
-	bool "Cortex-X4: 3194386: workaround for MSR SSBS not self-synchronizing"
-	select ARM64_WORKAROUND_SPECULATIVE_SSBS
+	bool "Cortex-X4/Neoverse-V3: workaround for MSR SSBS not self-synchronizing"
 	default y
 	help
-	  This option adds the workaround for ARM Cortex-X4 erratum 3194386.
+	  This option adds the workaround for the following errata:
 
-	  On affected cores "MSR SSBS, #0" instructions may not affect
-	  subsequent speculative instructions, which may permit unexepected
-	  speculative store bypassing.
-
-	  Work around this problem by placing a speculation barrier after
-	  kernel changes to SSBS. The presence of the SSBS special-purpose
-	  register is hidden from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such
-	  that userspace will use the PR_SPEC_STORE_BYPASS prctl to change
-	  SSBS.
-
-	  If unsure, say Y.
-
-config ARM64_ERRATUM_3312417
-	bool "Neoverse-V3: 3312417: workaround for MSR SSBS not self-synchronizing"
-	select ARM64_WORKAROUND_SPECULATIVE_SSBS
-	default y
-	help
-	  This option adds the workaround for ARM Neoverse-V3 erratum 3312417.
+	  * ARM Cortex-X4 erratum 3194386
+	  * ARM Neoverse-V3 erratum 3312417
 
 	  On affected cores "MSR SSBS, #0" instructions may not affect
 	  subsequent speculative instructions, which may permit unexepected
@@ -1108,7 +1088,6 @@ config ARM64_ERRATUM_3312417
 
 	  If unsure, say Y.
 
-
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 7529c02639332..a6e5b07b64fd5 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -59,7 +59,7 @@ cpucap_is_possible(const unsigned int cap)
 	case ARM64_WORKAROUND_REPEAT_TLBI:
 		return IS_ENABLED(CONFIG_ARM64_WORKAROUND_REPEAT_TLBI);
 	case ARM64_WORKAROUND_SPECULATIVE_SSBS:
-		return IS_ENABLED(CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS);
+		return IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386);
 	}
 
 	return true;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 828be635e7e1d..5fbe14dc607f0 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -432,14 +432,10 @@ static const struct midr_range erratum_spec_unpriv_load_list[] = {
 };
 #endif
 
-#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS
-static const struct midr_range erratum_spec_ssbs_list[] = {
 #ifdef CONFIG_ARM64_ERRATUM_3194386
+static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
-#endif
-#ifdef CONFIG_ARM64_ERRATUM_3312417
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
-#endif
 	{}
 };
 #endif
@@ -741,7 +737,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
 	},
 #endif
-#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS
+#ifdef CONFIG_ARM64_ERRATUM_3194386
 	{
 		.desc = "ARM errata 3194386, 3312417",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index baca47bd443c8..da53722f95d41 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -567,7 +567,7 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 	 * Mitigate this with an unconditional speculation barrier, as CPUs
 	 * could mis-speculate branches and bypass a conditional barrier.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS))
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386))
 		spec_bar();
 
 	return SPECTRE_MITIGATED;
-- 
2.30.2


