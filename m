Return-Path: <stable+bounces-68808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F67953411
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783A71C26111
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17591A00DF;
	Thu, 15 Aug 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jg/j0Bmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5213214;
	Thu, 15 Aug 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731731; cv=none; b=UcdYGNizy6tADI2RE7Jqs44AzDNucpcbH384Cjk5HWVxam0YWq6XMHTkAAucAEBZnuG8gVQ0o7ctFBqZyMH1fwYVJL/BRms0M7ydmN//cMasRE2OnPnolWyXUzhVavMVwc7wYEmJJNuk98FNaDh1fL1CXLv3v+//uCUMzaiQkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731731; c=relaxed/simple;
	bh=gwBIeVL6U/ov46oYn4Mo+g1DGLuVYkgJlhPLF8bo/ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZG2weOuWj2AlNKw3Oa3QYyTsrXj1e1+r/h5/LEzT26IfeqiWHvGoKiPwd+YHJkZkrf6OkZwbBYuDyzjsbGOAKIvspz6qNUUm3oKJ8fQBdRduR5lcBuwsLP5rbI42JQGzgNqdhyul8OEFPJo35X02qjIuVBnRk7xvWEesTcf55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jg/j0Bmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3586AC4AF0A;
	Thu, 15 Aug 2024 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731731;
	bh=gwBIeVL6U/ov46oYn4Mo+g1DGLuVYkgJlhPLF8bo/ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg/j0Bmi0RioYTskTMFUDrttvedF8L6DCsgcgaiveU0fLwXEAEAMAGgLXtNuOpqsx
	 U+LW/a41zPUmDoZ2KYiE9NLDKsAxUEENsux2puq92EXW3eIUZoTyMEeINPeP5JoA2z
	 lxveyZWReu1Wtd98jGNs5BOE6cu4/T38q6RZ0Kbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 220/259] arm64: errata: Expand speculative SSBS workaround (again)
Date: Thu, 15 Aug 2024 15:25:53 +0200
Message-ID: <20240815131911.264282265@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit adeec61a4723fd3e39da68db4cc4d924e6d7f641 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm64/silicon-errata.rst | 18 ++++++++++++++++++
 arch/arm64/Kconfig                     | 22 ++++++++++++++++------
 arch/arm64/kernel/cpu_errata.c         | 11 ++++++++++-
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 542cb20bf0f79..00755541a9c50 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -88,10 +88,24 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
@@ -106,8 +120,12 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d80f72a3459f..562558e0915cb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -591,18 +591,28 @@ config ARM64_ERRATUM_1742098
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
 
@@ -610,11 +620,11 @@ config ARM64_ERRATUM_3194386
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
index 97fabbdada62e..20c8d39b71cd6 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -843,15 +843,24 @@ static struct midr_range broken_aarch32_aes[] = {
 
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
2.43.0




