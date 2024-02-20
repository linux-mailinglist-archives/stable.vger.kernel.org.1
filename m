Return-Path: <stable+bounces-20871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CC85C4C9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE25B2438C
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83561350F9;
	Tue, 20 Feb 2024 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WvGvqL39"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A4768F1
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457264; cv=none; b=GF5nuXAr6X0uHnslL7JqihTCMq7uTDXvXUeCj/8loXVYRcaHYh73YDJqbj3/EKILKSTqjjujszVZNYoHCWWELVdCeBanxRxdwdlMKBkCl4zpymFDa0u1/nn2QRuOoW56ss//y99KjR7GKRq3mGcTKdq9SwdZqEmyYok2oZNbiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457264; c=relaxed/simple;
	bh=5sZWDALrpUsLrUG8zCA6NDC+XG7QiF4C28g0NDWG0OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRSN6Yb/qodHIoQ6+Ff0sNSvwY6iDY/bh6EkadD17wepnwlRYA6ppvpK4BTf7UUmTcSPoooL9yjSkRhBFa/6/Ynb+uSowC8EKr7BNb872zpltqGtqO/WNvZbdSEc02JQOTLa73Exw4j6toZjsGnheWYMDUu/yBb9FoWYFb21w+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WvGvqL39; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.160.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7787B20B2000;
	Tue, 20 Feb 2024 11:27:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7787B20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708457262;
	bh=1AcPb4JPfiU2ali82LG8ii5yCNloOb1rFpZHKWmuMTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvGvqL39wMfRVo9iOM7HN0GL6zdpX1wyeVDbVmGUNCXlHPOjyblUEUQ4bcSZs+n1c
	 rNSGnpaW9p0VIp8vxhvHyMkB5dAlG+cGo+ULlHIdcylvMOIgNgvTQa9xo30z7RMSY4
	 GCW4dohQkW75lZsmWr4tt7QDjwhpo0StpY/qGjtw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.1.y] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata
Date: Tue, 20 Feb 2024 19:27:34 +0000
Message-Id: <20240220192734.2842132-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024021947-naturist-unlovely-367a@gregkh>
References: <2024021947-naturist-unlovely-367a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit fb091ff394792c018527b3211bbdfae93ea4ac02 upstream

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
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arm64/silicon-errata.rst | 7 +++++++
 arch/arm64/include/asm/cputype.h       | 4 ++++
 arch/arm64/kernel/cpu_errata.c         | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index d9fce65b2f04..27135b9c07ac 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -221,3 +221,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2067961        | ARM64_ERRATUM_2067961       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7dce9c0aa783..af3a678a76b3 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -61,6 +61,7 @@
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
 #define ARM_CPU_IMP_AMPERE		0xC0
+#define ARM_CPU_IMP_MICROSOFT		0x6D
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -128,6 +129,8 @@
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
+#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -179,6 +182,7 @@
 #define MIDR_APPLE_M1_ICESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_MAX)
 #define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 61f22e9c92b4..74584597bfb8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -390,6 +390,7 @@ static const struct midr_range erratum_1463225[] = {
 static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2139208
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2119858
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -403,6 +404,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 static const struct midr_range tsb_flush_fail_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2067961
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2054223
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -415,6 +417,7 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
 static struct midr_range trbe_write_out_of_range_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2253138
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2224489
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
-- 
2.34.1


