Return-Path: <stable+bounces-67919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C6952FC1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C508128A03E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263CB7DA78;
	Thu, 15 Aug 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mN6j9kCw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87781DA4E;
	Thu, 15 Aug 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728931; cv=none; b=Jz1tV6zVM1Og+zQE1Q2bOqp7V9+nrS3ZGOEwKKapq3vWeCcwdpx4DoQgZ49wNKkWtfh/InlAtguoj2y/+OThkEyXFvc7R5M/RsafaHLsEn0h0C6Pbm7X2i10wKVmbmj4L0O8typ6BuC+e/4Yp0c1Zdi3Rpn/owPjBQFYlaoWJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728931; c=relaxed/simple;
	bh=f1KrxnsmAx32rQfbF5ndHZTWqIl+MDZMkZRXZj6qP14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/2zUuLRLDQ9WTsytToUxJFbnK7XZDNBRPiPWkLpmuMg3RfivHRp4PJj6t/zJtIXYctfFfm6DdIfuKzSFVxpymtggndOnTx9Pafcgtmucajkwj3QiU/OsaD3keET9x9P5qu5BDBJTie3GmKH0nKwpe2y/qIMvaCBi4Q5bq26r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mN6j9kCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEEFC32786;
	Thu, 15 Aug 2024 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728931;
	bh=f1KrxnsmAx32rQfbF5ndHZTWqIl+MDZMkZRXZj6qP14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mN6j9kCwgLRk4W5h7o29jRqr7MN3/HNQ5l+vO9wK2RAb/0WHgpXHajfn7g8pvn1Pa
	 xBJ4/JGV7yAj8Y3++Pk5neufYh2EjfWb+M90K4nV+S4yFhXDpCAC4Kt5Md2b7ibUaN
	 jKA3iyXBHbi7MCZ5L0ZAfUmtSCiU7snfDX8gmi5c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 157/196] arm64: errata: Expand speculative SSBS workaround
Date: Thu, 15 Aug 2024 15:24:34 +0200
Message-ID: <20240815131858.080911705@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
2.43.0




