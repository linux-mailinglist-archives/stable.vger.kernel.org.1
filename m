Return-Path: <stable+bounces-68805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10C95340E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3FB1F28563
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD5F63C;
	Thu, 15 Aug 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhTthdby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA771AC896;
	Thu, 15 Aug 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731722; cv=none; b=rZXjb8CKSVHP5lXsI/olcyDQa6Q2UUMP2s43roNC07mkgIAJ+HDLotnqarX6JT3MVaSJ+WsSClRV3sovGN2PJdVv+lOKvVkNJrWpFIFMP9t1pUc4b+LJk/JfdE/686fc6sds6B/eCMC5ufq8zUWgBtqiCM7Nsu1ao/FP+IRWW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731722; c=relaxed/simple;
	bh=vFWxjHg6/Cdq4ROZNrEp+0JYkxZPGKd3UcCUamwzc78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO9xPJtCVanZGsBg6rvyP3clFKDKnRAYZ+gHp9exTFf4CyXFvw72Ffk6LP93Fh9hCVkEwGTUSXEq3GEOCPDfanyJZviAH6fpEtF0xa1urLEiq2H5AAACqa2L0Np2IYAJO6zpde86WHnNr4X22HshcL90jp7yNSDg8a+DxkuNGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhTthdby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6E4C32786;
	Thu, 15 Aug 2024 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731722;
	bh=vFWxjHg6/Cdq4ROZNrEp+0JYkxZPGKd3UcCUamwzc78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhTthdbyU3AmEG70CUzNIatshW2MTF1BLx9/q9qRzCJoMZOOl8GfgxUgi/mxgnG+4
	 pVMk4fufX1n38LpNd6PjhQ8oeWKzxerelpla3b290V6ZD/+IJEQoZ15LmIssjKO0Z3
	 EWPYuh2DJn56OYKNsMG/SmNGltxekXhWdz1D/RSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 217/259] arm64: errata: Expand speculative SSBS workaround
Date: Thu, 15 Aug 2024 15:25:50 +0200
Message-ID: <20240815131911.150013883@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm64/silicon-errata.rst | 14 ++++++++++++++
 arch/arm64/Kconfig                     |  9 ++++++++-
 arch/arm64/kernel/cpu_errata.c         |  9 ++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index b2db2492bd131..542cb20bf0f79 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -88,14 +88,28 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
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
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1455a81ee8687..5d80f72a3459f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -591,12 +591,19 @@ config ARM64_ERRATUM_1742098
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
index 5e77a7595059b..97fabbdada62e 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -843,8 +843,15 @@ static struct midr_range broken_aarch32_aes[] = {
 
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
@@ -1040,7 +1047,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_3194386
 	{
-		.desc = "ARM errata 3194386, 3312417",
+		.desc = "SSBS not fully self-synchronizing",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
 		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
 	},
-- 
2.43.0




