Return-Path: <stable+bounces-66242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9994CEE5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D220B22079
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC9191F94;
	Fri,  9 Aug 2024 10:44:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B9191F65
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200271; cv=none; b=DK8H3rkPpV5X5eFcJSW6SuQx8mY7wHYx8NdwJi/KUC6uuYYMJ3ei3mB6zUzqdoa8lvKSlJglqJU0aNts+WTCREzqMH8GHZFw+N2G5hewM1i2s2IBLkS0HG1Z4rc1XQFF3sOkfe3hhyaOsMQv8DpcupAtBLASGaQqfJkCI/W3x9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200271; c=relaxed/simple;
	bh=raYZabMnig1Iy/bhCP8rP0s8VQBwT7aBKdhCj8qTP/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpNxfrRVyGF2eSTeZ5BLQZPr8/vjRxrVI9WltBiRqUnJ5EJjEVSAk+GcFi8XpqkHa1KpbnMkoeuY2r0vY8TUOY6vkGzsGqeExOEbOrTkTToLob5J/vPBR289aBFG4WLalxcKpp9fyMgVygmVNOLrvJLe8auR2CgqKuzwwvnKl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBB781684;
	Fri,  9 Aug 2024 03:44:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D74973F766;
	Fri,  9 Aug 2024 03:44:28 -0700 (PDT)
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
Subject: [PATCH 4.19.y 10/14] arm64: errata: Unify speculative SSBS errata logic
Date: Fri,  9 Aug 2024 11:43:52 +0100
Message-Id: <20240809104356.3503412-11-mark.rutland@arm.com>
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
[ Mark: fix conflicts & renames, drop unneeded cpucaps.h ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  2 +-
 arch/arm64/Kconfig                     | 28 ++++----------------------
 arch/arm64/kernel/cpu_errata.c         | 10 +++------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index e242e96648ed7..c7bdac13e3071 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,7 +63,7 @@ stable kernels.
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
-| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3312417       |
+| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2816ee3bfd989..747d055627362 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -531,34 +531,14 @@ config ARM64_ERRATUM_1742098
 
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
-
-	  On affected cores "MSR SSBS, #0" instructions may not affect
-	  subsequent speculative instructions, which may permit unexepected
-	  speculative store bypassing.
-
-	  Work around this problem by placing a speculation barrier after
-	  kernel changes to SSBS. The presence of the SSBS special-purpose
-	  register is hidden from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such
-	  that userspace will use the PR_SPEC_STORE_BYPASS prctl to change
-	  SSBS.
+	  This option adds the workaround for the following errata:
 
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
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 667ee52e8cb0f..61d3929fafae4 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -354,7 +354,7 @@ void arm64_set_ssbd_mitigation(bool state)
 		 * CPUs could mis-speculate branches and bypass a conditional
 		 * barrier.
 		 */
-		if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS))
+		if (IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386))
 			spec_bar();
 
 		return;
@@ -707,14 +707,10 @@ static struct midr_range broken_aarch32_aes[] = {
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
@@ -928,7 +924,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 	},
 #endif
-#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS
+#ifdef CONFIG_ARM64_ERRATUM_3194386
 	{
 		.desc = "ARM errata 3194386, 3312417",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
-- 
2.30.2


