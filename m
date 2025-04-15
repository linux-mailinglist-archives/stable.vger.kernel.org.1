Return-Path: <stable+bounces-132691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E2A89326
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 06:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242273AA630
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5A270EBF;
	Tue, 15 Apr 2025 04:58:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28A2459F4
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693081; cv=none; b=tP5YBEqjxsEvKITDPSB8t0bLENgm9cfQi01HIonJJT7ybZd8mZ/umUGE7aTYt5b0zJJCVdT7OtcKUbZXD+SgZViPHgwsoHruq5Enyh60aP55NJ9xWL1nasS9D8A4GMo63jAokqndBzTT3j9CQtiHVKo5r3l/eC0ZHSiBeP1Wyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693081; c=relaxed/simple;
	bh=JTAGeFO7n/emXaozii/glyigL+kb+o7kvpVYEGs2jAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcO30XfZomCt2VF5Ptpk/DkE5QnbP3DPbwIkGhV6Ce7IpTmdWxhOdf0lU2lVWPJrcJ2BibBc0rWIp6POCFFyV+oCzdwHcP92FI4hSaTFRnCvJMRB0mO0BsNNbWaUTrFdhy6VXfpdNF/KG9771R8hlS43hKYvK8ahwE0pTbQES8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AA1A15A1;
	Mon, 14 Apr 2025 21:57:57 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.49.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A7613F66E;
	Mon, 14 Apr 2025 21:57:55 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH V2 6.12.y 7/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Tue, 15 Apr 2025 10:27:28 +0530
Message-Id: <20250415045728.2248935-8-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415045728.2248935-1-anshuman.khandual@arm.com>
References: <20250415045728.2248935-1-anshuman.khandual@arm.com>
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
(cherry picked from commit 858c7bfcb35e1100b58bb63c9f562d86e09418d9)
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/booting.rst | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/el2_setup.h   | 25 +++++++++++++++++++++++++
 arch/arm64/tools/sysreg              |  1 +
 3 files changed, 48 insertions(+)

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
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 18b42f5af442..362bcfa0aed1 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1238,6 +1238,7 @@ UnsignedEnum	11:8	PMUVer
 	0b0110	V3P5
 	0b0111	V3P7
 	0b1000	V3P8
+	0b1001	V3P9
 	0b1111	IMP_DEF
 EndEnum
 UnsignedEnum	7:4	TraceVer
-- 
2.30.2


