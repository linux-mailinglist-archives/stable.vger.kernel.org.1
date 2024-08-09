Return-Path: <stable+bounces-66151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1594CDFC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2651C221FB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44866192B8F;
	Fri,  9 Aug 2024 09:51:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215B192B76
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197101; cv=none; b=nwgIOjdV3KviIEFzS7A6MHcjCnq4IPMQeUH3hdZr626rGBMxIiO2oqhf66r3azWjvD3Z9mfxX1nTY1gQ10/r9MWpaylQhnLKZvBJF4E1mnbZkp8EjZ5LgWnyakDIYn2lTlTip3lVHemOV5dfkxsUrINLXXt0PNKADfjWySSPb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197101; c=relaxed/simple;
	bh=mzuiSb9o8D1lzj3gJnOIxPSIZbDJ1TV/ENmdqyUeAes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbXA4z5EV/RUrsbgcy+LnT6NzdKS1Nlonb6ZCo7TwdVADZusOMjYcnwPjLCMaDzOgX/mJXJAs8BDPRJhh+owRqVbpW9ddKpnEqjcIzq3d2KRqIUMAma4Q+UJFOFjxpMcdy8rzz2mAmftBTJ8ErlpfYXEdk5tssKYWiXTqFFBsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3381684;
	Fri,  9 Aug 2024 02:52:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B30823F766;
	Fri,  9 Aug 2024 02:51:38 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.10.y 7/8] arm64: cputype: Add Cortex-A725 definitions
Date: Fri,  9 Aug 2024 10:51:19 +0100
Message-Id: <20240809095120.3475335-8-mark.rutland@arm.com>
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

[ Upstream commit 9ef54a384526911095db465e77acc1cb5266b32c ]

Add cputype definitions for Cortex-A725. These will be used for errata
detection in subsequent patches.

These values can be found in the Cortex-A725 TRM:

  https://developer.arm.com/documentation/107652/0001/

... in table A-247 ("MIDR_EL1 bit descriptions").

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20240801101803.1982459-3-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5dc68ace305e5..5fd7caea44193 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -93,6 +93,7 @@
 #define ARM_CPU_PART_CORTEX_X4		0xD82
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
+#define ARM_CPU_PART_CORTEX_A725	0xD87
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -173,6 +174,7 @@
 #define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
+#define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.30.2


