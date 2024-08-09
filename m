Return-Path: <stable+bounces-66243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03B94CEE4
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822051C21CE3
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33018CBFA;
	Fri,  9 Aug 2024 10:44:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398CE1922EA
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200273; cv=none; b=nLD7T/Ej6BT4a8MG6Zqq4goCZSJiKTo2hYMLqx3riSuJJvlpPM3BsLR8T1A1H1BKVNCIyZKcmp3ufd3hILa/6iMivEFz+2xzFAt/dqGgw7dYVS4EJj064UEJsvZIBTMj07S9XuazU0AadpxlosE1QIqtdCaDtWPz4Qgvb1F2xJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200273; c=relaxed/simple;
	bh=8o2l/lBt2Ru3InqY2u3/V9VZrBmDqLhbmr8ETiJcU9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdBPS0iJqzIePHnNykdg0cyUiwJpQB3GNJLVf1IBblCOX6aYkkpFMDXkBtlbzIfJaJBtzdyxRR6Z9QHa868inxMt/SrkUaLUSQWf+diWM2XpYqggughVJ+03I/l24VPoAiM7wKZMz9meX0SUrmU/wAoSsa3m7zviZ2SMeLfLFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B65C313D5;
	Fri,  9 Aug 2024 03:44:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1BB63F766;
	Fri,  9 Aug 2024 03:44:30 -0700 (PDT)
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
Subject: [PATCH 4.19.y 11/14] arm64: errata: Expand speculative SSBS workaround
Date: Fri,  9 Aug 2024 11:43:53 +0100
Message-Id: <20240809104356.3503412-12-mark.rutland@arm.com>
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

[ Upstream commit 75b3c43eab594bfbd8184ec8ee1a6b820950819a ]

A number of Arm Ltd CPUs suffer from errata whereby an MSR to the SSBS
special-purpose register does not affect subsequent speculative
instructions, permitting speculative store bypassing for a window of
time.

We worked around this for Cortex-X4 and Neoverse-V3, in commit:

  7187bb7d0b5c7dfa ("arm64: errata: Add workaround for Arm errata 3194386 and 3312417")

... as per their Software Developer Errata Notice (SDEN) documents:

* Cortex-X4 SDEN v8.0, erratum 3194386:
  https://developer.arm.com/documentation/SDEN-2432808/0800/

* Neoverse-V3 SDEN v6.0, erratum 3312417:
  https://developer.arm.com/documentation/SDEN-2891958/0600/

Since then, similar errata have been published for a number of other Arm Ltd
CPUs, for which the mitigation is the same. This is described in their
respective SDEN documents:

* Cortex-A710 SDEN v19.0, errataum 3324338
  https://developer.arm.com/documentation/SDEN-1775101/1900/?lang=en

* Cortex-A720 SDEN v11.0, erratum 3456091
  https://developer.arm.com/documentation/SDEN-2439421/1100/?lang=en

* Cortex-X2 SDEN v19.0, erratum 3324338
  https://developer.arm.com/documentation/SDEN-1775100/1900/?lang=en

* Cortex-X3 SDEN v14.0, erratum 3324335
  https://developer.arm.com/documentation/SDEN-2055130/1400/?lang=en

* Cortex-X925 SDEN v8.0, erratum 3324334
  https://developer.arm.com/documentation/109108/800/?lang=en

* Neoverse-N2 SDEN v17.0, erratum 3324339
  https://developer.arm.com/documentation/SDEN-1982442/1700/?lang=en

* Neoverse-V2 SDEN v9.0, erratum 3324336
  https://developer.arm.com/documentation/SDEN-2332927/900/?lang=en

Note that due to shared design lineage, some CPUs share the same erratum
number.

Add these to the existing mitigation under CONFIG_ARM64_ERRATUM_3194386.
As listing all of the erratum IDs in the runtime description would be
unwieldy, this is reduced to:

	"SSBS not fully self-synchronizing"

... matching the description of the errata in all of the SDENs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240603111812.1514101-6-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: fix conflicts and renames ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 7 +++++++
 arch/arm64/Kconfig                     | 9 ++++++++-
 arch/arm64/kernel/cpu_errata.c         | 9 ++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index c7bdac13e3071..8e978776f799e 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -61,8 +61,15 @@ stable kernels.
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
+| ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
+| ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 747d055627362..a46fe8d14e56d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -532,12 +532,19 @@ config ARM64_ERRATUM_1742098
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_3194386
-	bool "Cortex-X4/Neoverse-V3: workaround for MSR SSBS not self-synchronizing"
+	bool "Cortex-{A720,X4,X925}/Neoverse-V3: workaround for MSR SSBS not self-synchronizing"
 	default y
 	help
 	  This option adds the workaround for the following errata:
 
+	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A720 erratum 3456091
+	  * ARM Cortex-X2 erratum 3324338
+	  * ARM Cortex-X3 erratum 3324335
 	  * ARM Cortex-X4 erratum 3194386
+	  * ARM Cortex-X925 erratum 3324334
+	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
 
 	  On affected cores "MSR SSBS, #0" instructions may not affect
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 61d3929fafae4..487bab3948f8f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -709,8 +709,15 @@ static struct midr_range broken_aarch32_aes[] = {
 
 #ifdef CONFIG_ARM64_ERRATUM_3194386
 static const struct midr_range erratum_spec_ssbs_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	{}
 };
 #endif
@@ -926,7 +933,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_3194386
 	{
-		.desc = "ARM errata 3194386, 3312417",
+		.desc = "SSBS not fully self-synchronizing",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
 		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
 	},
-- 
2.30.2


