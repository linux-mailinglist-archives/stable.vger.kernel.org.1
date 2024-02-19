Return-Path: <stable+bounces-20702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79B85AB5A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31847B21702
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9F1D53C;
	Mon, 19 Feb 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTZGhvj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454A5697
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368300; cv=none; b=uEBheLKoenz0oAUqN6j4ZZ6AaNU9LglW7fEtetOJvl2PTlwPAojHOAePIt3GXFkq8Xxl9zJSU4sHmkRDcsxiRGVx6/+roFeiHuwSQRV0xV2zARSpGbiedeFFkIpMjzvgpv40bPMSQShfvFQiWkYDzmbbJ4hQy1zAKsxBbaKgv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368300; c=relaxed/simple;
	bh=dEMkfzBc7hcnMNZ+KVbRCKkJVZD3750ZqSRae/IGX2M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jDRwifZOVjYIs7qMOqaePTacf7F2lX6/rC1iQg7gxCvZMA5uGkMw8vfnYBxzn5Q1EfNu8k5HsddBUJy+yGbwztf8A+dBFuasGXDbFtN9FFPXGdodcAplIcfgiGQP2L0u6k9w4dqQRrXjHrzG1jDMtuX92VAk3hbJJsMWWowryiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTZGhvj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC5C433C7;
	Mon, 19 Feb 2024 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368300;
	bh=dEMkfzBc7hcnMNZ+KVbRCKkJVZD3750ZqSRae/IGX2M=;
	h=Subject:To:Cc:From:Date:From;
	b=qTZGhvj9OTiWht7Gs48GCAWqdp4bHscIQNbPbhMRDBDLzkhSW3L2WfCXepoFB3ZoZ
	 /l2gGlgQm119ZxzTIzLADZabyUcuBL6sVxV64l5ug6bd6wHKshUD8gPr+rr75IDR+G
	 23RcJhILE9xoYwCZbQEdDhaHvIDGmV1NrvkZ3tuI=
Subject: FAILED: patch "[PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse" failed to apply to 5.15-stable tree
To: eahariha@linux.microsoft.com,anshuman.khandual@arm.com,mark.rutland@arm.com,maz@kernel.org,oliver.upton@linux.dev,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:44:48 +0100
Message-ID: <2024021948-flashing-prescribe-3dcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fb091ff394792c018527b3211bbdfae93ea4ac02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021948-flashing-prescribe-3dcf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

fb091ff39479 ("arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata")
6aeadf7896bf ("Merge tag 'docs-arm64-move' of git://git.lwn.net/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb091ff394792c018527b3211bbdfae93ea4ac02 Mon Sep 17 00:00:00 2001
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 14 Feb 2024 17:55:18 +0000
Subject: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse
 N2 errata

Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
suffers from all the same errata.

CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240214175522.2457857-1-eahariha@linux.microsoft.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index e8c2ce1f9df6..45a7f4932fe0 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -243,3 +243,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2067961        | ARM64_ERRATUM_2067961       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7c7493cb571f..52f076afeb96 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -61,6 +61,7 @@
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
 #define ARM_CPU_IMP_AMPERE		0xC0
+#define ARM_CPU_IMP_MICROSOFT		0x6D
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -135,6 +136,8 @@
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
+#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -193,6 +196,7 @@
 #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
 #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 967c7c7a4e7d..76b8dd37092a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -374,6 +374,7 @@ static const struct midr_range erratum_1463225[] = {
 static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2139208
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2119858
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -387,6 +388,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 static const struct midr_range tsb_flush_fail_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2067961
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2054223
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -399,6 +401,7 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
 static struct midr_range trbe_write_out_of_range_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2253138
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2224489
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),


