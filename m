Return-Path: <stable+bounces-90325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F49BE7BF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06722847F7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915111DF736;
	Wed,  6 Nov 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kYXXPpZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5B1DF267;
	Wed,  6 Nov 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895439; cv=none; b=GiIgio0GccoKBtbOqJYQ46WJpQBkGydJiINAdZ4iESgijuP2FfvMLIL8aCQLIhEfywZDpAn1sfss4xWCL2i6G9DE2fdiS7zxf/nHqCK26jq5gQ3j7Cp6DfG0OEeeum6Pyr9Fa9Q3FyU/olBwm2ACoznzLEz3gx8FkYCz2x9V9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895439; c=relaxed/simple;
	bh=OXu6mgXQY17Rzv7+JsfZSPgsxVRqLZjVTQ+HhOWs1Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIsv5Vtktr58zucSHPOGJwWT3cKqQ/s3yNWnxBNc2M5VPINxwgRMJC+5K6HODLiHGv74oVa53xOzyhzTm9sn7KMny4isDptJk5V01iVbWMTXge1IlCcs4YGp91uf/QY5sURgWuV9Sm1VRjtoPc2oOcIpyiUsgrnFT6H22yvNEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kYXXPpZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DD6C4CECD;
	Wed,  6 Nov 2024 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895439;
	bh=OXu6mgXQY17Rzv7+JsfZSPgsxVRqLZjVTQ+HhOWs1Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYXXPpZMto4dWAi86nD2j9/K+fhwD/ENRvbZ+rQ9ygHlhpqtzdWCJdefN9zLhA1JD
	 c4GalsSSlrRAD7uMUTbBn60vQQ6UO+QeznqAncYQHGtKzHeTrZkrlc6R3qBmPOrLaD
	 z/o2JDKB0ddInNZjmUPRz5uFaeNAoKPlbV9dvQvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 219/350] arm64: errata: Expand speculative SSBS workaround once more
Date: Wed,  6 Nov 2024 13:02:27 +0100
Message-ID: <20241106120326.408990825@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

[ Upstream commit 081eb7932c2b244f63317a982c5e3990e2c7fbdd ]

A number of Arm Ltd CPUs suffer from errata whereby an MSR to the SSBS
special-purpose register does not affect subsequent speculative
instructions, permitting speculative store bypassing for a window of
time.

We worked around this for a number of CPUs in commits:

* 7187bb7d0b5c7dfa ("arm64: errata: Add workaround for Arm errata 3194386 and 3312417")
* 75b3c43eab594bfb ("arm64: errata: Expand speculative SSBS workaround")
* 145502cac7ea70b5 ("arm64: errata: Expand speculative SSBS workaround (again)")

Since then, a (hopefully final) batch of updates have been published,
with two more affected CPUs. For the affected CPUs the existing
mitigation is sufficient, as described in their respective Software
Developer Errata Notice (SDEN) documents:

* Cortex-A715 (MP148) SDEN v15.0, erratum 3456084
  https://developer.arm.com/documentation/SDEN-2148827/1500/

* Neoverse-N3 (MP195) SDEN v5.0, erratum 3456111
  https://developer.arm.com/documentation/SDEN-3050973/0500/

Enable the existing mitigation by adding the relevant MIDRs to
erratum_spec_ssbs_list, and update silicon-errata.rst and the
Kconfig text accordingly.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240930111705.3352047-3-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: fix conflict in silicon-errata.rst, handle move and rename ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm64/silicon-errata.txt | 2 ++
 arch/arm64/Kconfig                     | 2 ++
 arch/arm64/kernel/cpu_errata.c         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index eab3b0cf0dbe9..a67ba12ffa035 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -66,6 +66,7 @@ stable kernels.
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
@@ -77,6 +78,7 @@ stable kernels.
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 15c7a2b6e491e..5fa1b1d3172e9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -543,6 +543,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-A78C erratum 3324346
 	  * ARM Cortex-A78C erratum 3324347
 	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A715 errartum 3456084
 	  * ARM Cortex-A720 erratum 3456091
 	  * ARM Cortex-A725 erratum 3456106
 	  * ARM Cortex-X1 erratum 3324344
@@ -553,6 +554,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-X925 erratum 3324334
 	  * ARM Neoverse-N1 erratum 3324349
 	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-N3 erratum 3456111
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e87f8d60075d7..a92530a8d7fcd 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -714,6 +714,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
@@ -724,6 +725,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
-- 
2.43.0




