Return-Path: <stable+bounces-66207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15894CE77
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC1C282D17
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CF191F8D;
	Fri,  9 Aug 2024 10:18:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082A41C6E
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198681; cv=none; b=fcJf1bSupkj5FLxd93CEvHiGvy6JujCLtdNgULpA4KaugIQHwX/rDoykWQvhzC1ZnyL3IQAZeGqdw8Qpr4TNG19zquxXtG7zoMlyw1suEgcvmr9A6jARU9uS4ZNUKCz+RQ35w4pv+f868LZiPeCoLS9aexYkifx48i0M9tCAtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198681; c=relaxed/simple;
	bh=BfOaLLG8sz0W/Fk6cI9PBeCweLA11DtuX/jARf9CLF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/4qwCCibT+1SJ2BQn04PisrSUqXWy9gFCfpO+Vd79/7mghD6HCFocltmlBhOaqSb4XESnJzEXicOWEDX77awWebOujMwyNDIfN4E2NNUjMKPCIUzVTcP5rXzRRhgkPvAEZ4HaGp0UmyBtHXfdsYeE2zLiZXw25JnobkYlZPvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589781691;
	Fri,  9 Aug 2024 03:18:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DA9D3F766;
	Fri,  9 Aug 2024 03:17:58 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org
Subject: [PATCH 5.10.y 08/13] arm64: cputype: Add Cortex-X925 definitions
Date: Fri,  9 Aug 2024 11:17:34 +0100
Message-Id: <20240809101739.3477931-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809101739.3477931-1-mark.rutland@arm.com>
References: <20240809101739.3477931-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit fd2ff5f0b320f418288e7a1f919f648fbc8a0dfc ]

Add cputype definitions for Cortex-X925. These will be used for errata
detection in subsequent patches.

These values can be found in Table A-285 ("MIDR_EL1 bit descriptions")
in issue 0001-05 of the Cortex-X925 TRM, which can be found at:

  https://developer.arm.com/documentation/102807/0001/?lang=en

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240603111812.1514101-4-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 4f08438344e2a..35162c15ed6c6 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -89,6 +89,7 @@
 #define ARM_CPU_PART_CORTEX_A720	0xD81
 #define ARM_CPU_PART_CORTEX_X4		0xD82
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
+#define ARM_CPU_PART_CORTEX_X925	0xD85
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -146,6 +147,7 @@
 #define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
 #define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
+#define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.30.2


