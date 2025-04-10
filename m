Return-Path: <stable+bounces-132038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87229A8377A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 05:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E12F19E6151
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3E1F0E49;
	Thu, 10 Apr 2025 03:56:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A0B1E9B3C
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257373; cv=none; b=kJt7+ZrytacWIAcDeUf5zaedCMGzR9oIOm20X1oUOqtlMUG7nikx4E0xT66g/YWagRXeltb9J45U5CypiU1NhwupAeylRJUIgkM9VCFrOwq5hdQqD50IAdZlxeP0N+n8cK2v2Y5D1s0pwBz+V4xfuJ3OPOSl1/KxIxKS74waDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257373; c=relaxed/simple;
	bh=1DHP8c5mX13hTO7CXSGKTae91rr2YIO8NEsuHX1TNUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gBAfIpuWPR3CNWDD4E5CqDsoLAzhw/5F3zBbcygPbUrUfaHmKrTeq9lGCgAZyCx/6/E/pAiEA2nZ8Wspc/YR6BjkfKIoBT/jQxh9DeJ3VBUzXj7rL2neF3NrYDS6sdvKWAyKn67k1T5gyWUg2Q4Ovuo0AFuG0D0n4M7n2PVvVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C2E152B;
	Wed,  9 Apr 2025 20:56:11 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27E813F6A8;
	Wed,  9 Apr 2025 20:56:08 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.12.y 8/8] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Thu, 10 Apr 2025 09:25:43 +0530
Message-Id: <20250410035543.1518500-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250410035543.1518500-1-anshuman.khandual@arm.com>
References: <20250410035543.1518500-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_PMUv3p9 registers such as PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1
access from EL1 requires appropriate EL2 fine grained trap configuration
via FEAT_FGT2 based trap control registers HDFGRTR2_EL2 and HDFGWTR2_EL2.
Otherwise such register accesses will result in traps into EL2.

Add a new helper __init_el2_fgt2() which initializes FEAT_FGT2 based fine
grained trap control registers HDFGRTR2_EL2 and HDFGWTR2_EL2 (setting the
bits nPMICNTR_EL0, nPMICFILTR_EL0 and nPMUACR_EL1) to enable access into
PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 registers.

Also update booting.rst with SCR_EL3.FGTEn2 requirement for all FEAT_FGT2
based registers to be accessible in EL2.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.linux.dev
Fixes: 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
Fixes: d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
Tested-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250227035119.2025171-1-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[cherry picked from commit 858c7bfcb35e1100b58bb63c9f562d86e09418d9]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/booting.rst | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/el2_setup.h   | 25 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..15bcd1b4003a 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -285,6 +285,12 @@ Before jumping into the kernel, the following conditions must be met:
 
     - SCR_EL3.FGTEn (bit 27) must be initialised to 0b1.
 
+  For CPUs with the Fine Grained Traps 2 (FEAT_FGT2) extension present:
+
+  - If EL3 is present and the kernel is entered at EL2:
+
+    - SCR_EL3.FGTEn2 (bit 59) must be initialised to 0b1.
+
   For CPUs with support for HCRX_EL2 (FEAT_HCX) present:
 
   - If EL3 is present and the kernel is entered at EL2:
@@ -379,6 +385,22 @@ Before jumping into the kernel, the following conditions must be met:
 
     - SMCR_EL2.EZT0 (bit 30) must be initialised to 0b1.
 
+  For CPUs with the Performance Monitors Extension (FEAT_PMUv3p9):
+
+ - If EL3 is present:
+
+    - MDCR_EL3.EnPM2 (bit 7) must be initialised to 0b1.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - HDFGRTR2_EL2.nPMICNTR_EL0 (bit 2) must be initialised to 0b1.
+    - HDFGRTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
+    - HDFGRTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
+
+    - HDFGWTR2_EL2.nPMICNTR_EL0 (bit 2) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
+
   For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
 
   - If the kernel is entered at EL1 and EL2 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index e0ffdf13a18b..bdbe9e08664a 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -215,6 +215,30 @@
 .Lskip_fgt_\@:
 .endm
 
+.macro __init_el2_fgt2
+	mrs	x1, id_aa64mmfr0_el1
+	ubfx	x1, x1, #ID_AA64MMFR0_EL1_FGT_SHIFT, #4
+	cmp	x1, #ID_AA64MMFR0_EL1_FGT_FGT2
+	b.lt	.Lskip_fgt2_\@
+
+	mov	x0, xzr
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	cmp	x1, #ID_AA64DFR0_EL1_PMUVer_V3P9
+	b.lt	.Lskip_pmuv3p9_\@
+
+	orr	x0, x0, #HDFGRTR2_EL2_nPMICNTR_EL0
+	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
+	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
+.Lskip_pmuv3p9_\@:
+	msr_s   SYS_HDFGRTR2_EL2, x0
+	msr_s   SYS_HDFGWTR2_EL2, x0
+	msr_s   SYS_HFGRTR2_EL2, xzr
+	msr_s   SYS_HFGWTR2_EL2, xzr
+	msr_s   SYS_HFGITR2_EL2, xzr
+.Lskip_fgt2_\@:
+.endm
+
 .macro __init_el2_nvhe_prepare_eret
 	mov	x0, #INIT_PSTATE_EL1
 	msr	spsr_el2, x0
@@ -240,6 +264,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_cptr
 	__init_el2_fgt
+	__init_el2_fgt2
 .endm
 
 #ifndef __KVM_NVHE_HYPERVISOR__
-- 
2.30.2


