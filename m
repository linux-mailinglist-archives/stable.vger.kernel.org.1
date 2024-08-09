Return-Path: <stable+bounces-66246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C794CEEA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7431C21EFC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153201922FD;
	Fri,  9 Aug 2024 10:44:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EC192B7E
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200279; cv=none; b=s/oUDrDD/rcfNGi8+UjJcrkjagERT3+oOLEUBVBc8at++mOa5W6WdHkp+czTCk9Y8SvlWZN/7iZVhSn4Wax6SQ11eviFh9i+KZ5+pS0CBnfLAjuWtilzL5aXZsiGMljWAzxBDDow+GCIGjOrkwJdKshDM/fq/GCCuMwbtJ1p0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200279; c=relaxed/simple;
	bh=5oz+MNEtaN6zzadsRl0cO2LAjx+PJw311pZ/Ru3+Y6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bm1Zm8Zol6sGwXd2CxhEE8SucuVe1vbGhHIFOIOKhpnilUsv1ZaetBHgRNfw58WQhIFm44NItDh1XxuCltiNg/7HSuZeWi37ktwYrIsg5JimEgTlDy1xjRnXEAIafM1QDPv5CCAtjdu34cnWYz/R/PniuWlj/l9/KYbxwIGvsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB6F13D5;
	Fri,  9 Aug 2024 03:45:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 660823F766;
	Fri,  9 Aug 2024 03:44:36 -0700 (PDT)
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
Subject: [PATCH 4.19.y 14/14] arm64: errata: Expand speculative SSBS workaround (again)
Date: Fri,  9 Aug 2024 11:43:56 +0100
Message-Id: <20240809104356.3503412-15-mark.rutland@arm.com>
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

[ Upstream commit b0672bbe133ebb6f7be21fce1d742d52f25bcdc7 ]

A number of Arm Ltd CPUs suffer from errata whereby an MSR to the SSBS
special-purpose register does not affect subsequent speculative
instructions, permitting speculative store bypassing for a window of
time.

We worked around this for a number of CPUs in commits:

* 7187bb7d0b5c7dfa ("arm64: errata: Add workaround for Arm errata 3194386 and 3312417")
* 75b3c43eab594bfb ("arm64: errata: Expand speculative SSBS workaround")

Since then, similar errata have been published for a number of other Arm
Ltd CPUs, for which the same mitigation is sufficient. This is described
in their respective Software Developer Errata Notice (SDEN) documents:

* Cortex-A76 (MP052) SDEN v31.0, erratum 3324349
  https://developer.arm.com/documentation/SDEN-885749/3100/

* Cortex-A77 (MP074) SDEN v19.0, erratum 3324348
  https://developer.arm.com/documentation/SDEN-1152370/1900/

* Cortex-A78 (MP102) SDEN v21.0, erratum 3324344
  https://developer.arm.com/documentation/SDEN-1401784/2100/

* Cortex-A78C (MP138) SDEN v16.0, erratum 3324346
  https://developer.arm.com/documentation/SDEN-1707916/1600/

* Cortex-A78C (MP154) SDEN v10.0, erratum 3324347
  https://developer.arm.com/documentation/SDEN-2004089/1000/

* Cortex-A725 (MP190) SDEN v5.0, erratum 3456106
  https://developer.arm.com/documentation/SDEN-2832921/0500/

* Cortex-X1 (MP077) SDEN v21.0, erratum 3324344
  https://developer.arm.com/documentation/SDEN-1401782/2100/

* Cortex-X1C (MP136) SDEN v16.0, erratum 3324346
  https://developer.arm.com/documentation/SDEN-1707914/1600/

* Neoverse-N1 (MP050) SDEN v32.0, erratum 3324349
  https://developer.arm.com/documentation/SDEN-885747/3200/

* Neoverse-V1 (MP076) SDEN v19.0, erratum 3324341
  https://developer.arm.com/documentation/SDEN-1401781/1900/

Note that due to the manner in which Arm develops IP and tracks errata,
some CPUs share a common erratum number and some CPUs have multiple
erratum numbers for the same HW issue.

On parts without SB, it is necessary to use ISB for the workaround. The
spec_bar() macro used in the mitigation will expand to a "DSB SY; ISB"
sequence in this case, which is sufficient on all affected parts.

Enable the existing mitigation by adding the relevant MIDRs to
erratum_spec_ssbs_list. The list is sorted alphanumerically (involving
moving Neoverse-V3 after Neoverse-V2) so that this is easy to audit and
potentially extend again in future. The Kconfig text is also updated to
clarify the set of affected parts and the mitigation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240801101803.1982459-4-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: fix conflicts in silicon-errata.rst ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  9 +++++++++
 arch/arm64/Kconfig                     | 22 ++++++++++++++++------
 arch/arm64/kernel/cpu_errata.c         | 11 ++++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 8e978776f799e..eab3b0cf0dbe9 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -61,14 +61,23 @@ stable kernels.
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
+| ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
+| ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a46fe8d14e56d..15c7a2b6e491e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -532,18 +532,28 @@ config ARM64_ERRATUM_1742098
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_3194386
-	bool "Cortex-{A720,X4,X925}/Neoverse-V3: workaround for MSR SSBS not self-synchronizing"
+	bool "Cortex-*/Neoverse-*: workaround for MSR SSBS not self-synchronizing"
 	default y
 	help
 	  This option adds the workaround for the following errata:
 
+	  * ARM Cortex-A76 erratum 3324349
+	  * ARM Cortex-A77 erratum 3324348
+	  * ARM Cortex-A78 erratum 3324344
+	  * ARM Cortex-A78C erratum 3324346
+	  * ARM Cortex-A78C erratum 3324347
 	  * ARM Cortex-A710 erratam 3324338
 	  * ARM Cortex-A720 erratum 3456091
+	  * ARM Cortex-A725 erratum 3456106
+	  * ARM Cortex-X1 erratum 3324344
+	  * ARM Cortex-X1C erratum 3324346
 	  * ARM Cortex-X2 erratum 3324338
 	  * ARM Cortex-X3 erratum 3324335
 	  * ARM Cortex-X4 erratum 3194386
 	  * ARM Cortex-X925 erratum 3324334
+	  * ARM Neoverse-N1 erratum 3324349
 	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
 
@@ -551,11 +561,11 @@ config ARM64_ERRATUM_3194386
 	  subsequent speculative instructions, which may permit unexepected
 	  speculative store bypassing.
 
-	  Work around this problem by placing a speculation barrier after
-	  kernel changes to SSBS. The presence of the SSBS special-purpose
-	  register is hidden from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such
-	  that userspace will use the PR_SPEC_STORE_BYPASS prctl to change
-	  SSBS.
+	  Work around this problem by placing a Speculation Barrier (SB) or
+	  Instruction Synchronization Barrier (ISB) after kernel changes to
+	  SSBS. The presence of the SSBS special-purpose register is hidden
+	  from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such that userspace
+	  will use the PR_SPEC_STORE_BYPASS prctl to change SSBS.
 
 	  If unsure, say Y.
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 487bab3948f8f..e87f8d60075d7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -709,15 +709,24 @@ static struct midr_range broken_aarch32_aes[] = {
 
 #ifdef CONFIG_ARM64_ERRATUM_3194386
 static const struct midr_range erratum_spec_ssbs_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
-	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 	{}
 };
 #endif
-- 
2.30.2


