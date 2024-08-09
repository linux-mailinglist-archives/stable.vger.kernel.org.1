Return-Path: <stable+bounces-66167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7F94CE24
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D81F25460
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E019413F;
	Fri,  9 Aug 2024 09:58:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E2198A02
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197508; cv=none; b=UDa+VprpEkcm91JDeZBJ24U+ciqE8RbTYEPPyeFTHfnCQEfHG+/CFJKgtgU2pvHCG2aNtDfHMSoHpk4mAyRWSm/b352uexcqD26aMM6+ZkPm1yGJqcSSpew00RYxN44De+4jM2At2qfF53HhL8y/oUVo9AjUQ+4d23fSTDmf4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197508; c=relaxed/simple;
	bh=LmVoohdLrT6d6lj2gWWfYYXsV5zHcLjYlw3TRR1L2JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rS6OVJZIhkNvWy67IyLTfzn1u60gD11qP/akhKjSK+nqixfRpNyjl0RqDquHYthSBl0OXrK5tHHvlLhtkLWOr5smBwW09RHy7OAj3tIPlO+HatMg5tXYTJbhxgJtm6dsp3Y4ue/ix6SvRBeQF/nAHQe4k1p3UGyC2wXqAnYLZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1217C1684;
	Fri,  9 Aug 2024 02:58:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6DD93F766;
	Fri,  9 Aug 2024 02:58:24 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.6.y 13/13] arm64: errata: Expand speculative SSBS workaround (again)
Date: Fri,  9 Aug 2024 10:57:45 +0100
Message-Id: <20240809095745.3476191-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809095745.3476191-1-mark.rutland@arm.com>
References: <20240809095745.3476191-1-mark.rutland@arm.com>
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
 Documentation/arch/arm64/silicon-errata.rst | 18 +++++++++++++++++
 arch/arm64/Kconfig                          | 22 +++++++++++++++------
 arch/arm64/kernel/cpu_errata.c              | 11 ++++++++++-
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 0bab767f6887c..357d6cb98161f 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -119,8 +119,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
@@ -133,6 +141,12 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
@@ -151,6 +165,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
@@ -159,6 +175,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e80812a4002bb..9e0c1ac3d13ee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1069,18 +1069,28 @@ config ARM64_ERRATUM_3117295
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
 
@@ -1088,11 +1098,11 @@ config ARM64_ERRATUM_3194386
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
index bfe324854e3b5..57b1d6a68256b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -450,15 +450,24 @@ static const struct midr_range erratum_spec_unpriv_load_list[] = {
 
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


