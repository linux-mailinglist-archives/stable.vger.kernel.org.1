Return-Path: <stable+bounces-66149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904E94CDFA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE911C21EB9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E9192B7F;
	Fri,  9 Aug 2024 09:51:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E434191F65
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197098; cv=none; b=t1tPIsYgTt8oqRSim56YdV1+d/44qSEacu1yeGMpGLrTcwBkezH1yvMvgpdfAmUMErTHSMspdC740kAclQJPanQ7syRL/lU4vbUDfMCOiS87c8LV2HDxBXRttP6EUr/pARG0Fzn+eO3fgl9wzs5oET2t+xpe39FXHkRhYto/ueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197098; c=relaxed/simple;
	bh=UAk8mAYjuk0/I9gVBFHnbvofsnxtAUjd+1X83ysX5/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOk7EXEVIWYbEMGAG9jmdCCjL6SGg/n/DUcpg+6gvBoG8gamMARUQIIxKWgxD/ZzGWjSdEXBvfAFaq+gHQvbN5T9H75gEyKgIslvt3pzx5uMF5WDZeMkbScLaSQgBUEs42DPtHJRMCnHD9x8+6Lv5fu0Ejs5+npfCFfZyT3puog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498651684;
	Fri,  9 Aug 2024 02:52:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D62C3F766;
	Fri,  9 Aug 2024 02:51:35 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.10.y 5/8] arm64: errata: Expand speculative SSBS workaround
Date: Fri,  9 Aug 2024 10:51:17 +0100
Message-Id: <20240809095120.3475335-6-mark.rutland@arm.com>
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
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 14 ++++++++++++++
 arch/arm64/Kconfig                          |  9 ++++++++-
 arch/arm64/kernel/cpu_errata.c              |  9 ++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 59ee2832406c2..bb83c5d8c6755 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -132,16 +132,26 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #1502854        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -156,8 +166,12 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #1619801        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fb31ff9151b9d..f580f5af4a51b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1068,12 +1068,19 @@ config ARM64_ERRATUM_3117295
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
index 5fbe14dc607f0..617424b73f8c3 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -434,8 +434,15 @@ static const struct midr_range erratum_spec_unpriv_load_list[] = {
 
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
@@ -739,7 +746,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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


