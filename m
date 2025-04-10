Return-Path: <stable+bounces-132031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AACA83774
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 05:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979F67B16C4
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938A11F0E34;
	Thu, 10 Apr 2025 03:55:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9A1E9B3C
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257355; cv=none; b=myOyxhQxP5/lQQZYxozaLRN1dOHz1Y1iH6nmByqHjpFnmmk81KMBhZVzioqhwjC+0WXt+k6roGYi1P9IsR9qtXwc15HbFagYeL0nLp8GKB4g5XuU6BCvxPaaKn8/fv/fPqZRujemdmg9Lm2tY3kHaLatcKjTyzQhiVbD+Cp3PPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257355; c=relaxed/simple;
	bh=fetj8OzrVLU97bsz0NbmT58VLxuQwxCVAoxCiFEi86k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOl+84qdgDiko0uRxF3on4u4O74on9kHJL7BewZTScVNFnzV/UeXPY1J7QqRoUjBOLzBsct/0RWp6EcG5SfL9CHOjU//1UtLzrmyew6v6ea8+TK92o/PXfLTfrEahKBMTsZWpu+cUYmDIZ2qd65OmdOHVlEnYiqVcSJaUllZ6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83D1F175A;
	Wed,  9 Apr 2025 20:55:52 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 024993F6A8;
	Wed,  9 Apr 2025 20:55:49 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control
Date: Thu, 10 Apr 2025 09:25:36 +0530
Message-Id: <20250410035543.1518500-2-anshuman.khandual@arm.com>
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

From: "Rob Herring (Arm)" <robh@kernel.org>

Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counter
access is enabled with the UEN bit in PMUSERENR_EL1 register. Individual
counters are enabled/disabled in the PMUACR_EL1 register. When UEN is
set, the CR/ER bits control EL0 write access and must be set to disable
write access.

With the access controls, the clearing of unused counters can be
skipped.

KVM also configures PMUSERENR_EL1 in order to trap to EL2. UEN does not
need to be set for it since only PMUv3.5 is exposed to guests.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h   |  6 ++++++
 arch/arm64/include/asm/arm_pmuv3.h | 10 ++++++++++
 arch/arm64/tools/sysreg            |  8 ++++++++
 drivers/perf/arm_pmuv3.c           | 29 +++++++++++++++++++----------
 include/linux/perf/arm_pmuv3.h     |  1 +
 5 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index f63ba8986b24..d242b5e1ca0d 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -231,6 +231,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
 #define ARMV8_PMU_DFR_VER_V3P1      0x4
 #define ARMV8_PMU_DFR_VER_V3P4      0x5
 #define ARMV8_PMU_DFR_VER_V3P5      0x6
+#define ARMV8_PMU_DFR_VER_V3P9      0x9
 #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
 
 static inline bool pmuv3_implemented(int pmuver)
@@ -249,6 +250,11 @@ static inline bool is_pmuv3p5(int pmuver)
 	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
 }
 
+static inline bool is_pmuv3p9(int pmuver)
+{
+	return pmuver >= ARMV8_PMU_DFR_VER_V3P9;
+}
+
 static inline u64 read_pmceid0(void)
 {
 	u64 val = read_sysreg(PMCEID0);
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 468a049bc63b..8a777dec8d88 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -152,6 +152,11 @@ static inline void write_pmuserenr(u32 val)
 	write_sysreg(val, pmuserenr_el0);
 }
 
+static inline void write_pmuacr(u64 val)
+{
+	write_sysreg_s(val, SYS_PMUACR_EL1);
+}
+
 static inline u64 read_pmceid0(void)
 {
 	return read_sysreg(pmceid0_el0);
@@ -178,4 +183,9 @@ static inline bool is_pmuv3p5(int pmuver)
 	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5;
 }
 
+static inline bool is_pmuv3p9(int pmuver)
+{
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P9;
+}
+
 #endif
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8d637ac4b7c6..74fb5af91d4f 100644
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
@@ -2178,6 +2179,13 @@ Field	4	P
 Field	3:0	ALIGN
 EndSysreg
 
+Sysreg	PMUACR_EL1	3	0	9	14	4
+Res0	63:33
+Field	32	F0
+Field	31	C
+Field	30:0	P
+EndSysreg
+
 Sysreg	PMSELR_EL0	3	3	9	12	5
 Res0	63:5
 Field	4:0	SEL
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 0afe02f879b4..bb93d32b86ea 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -770,18 +770,27 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 	int i;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 
-	/* Clear any unused counters to avoid leaking their contents */
-	for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
-			    ARMPMU_MAX_HWEVENTS) {
-		if (i == ARMV8_PMU_CYCLE_IDX)
-			write_pmccntr(0);
-		else if (i == ARMV8_PMU_INSTR_IDX)
-			write_pmicntr(0);
-		else
-			armv8pmu_write_evcntr(i, 0);
+	if (is_pmuv3p9(cpu_pmu->pmuver)) {
+		u64 mask = 0;
+		for_each_set_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
+			if (armv8pmu_event_has_user_read(cpuc->events[i]))
+				mask |= BIT(i);
+		}
+		write_pmuacr(mask);
+	} else {
+		/* Clear any unused counters to avoid leaking their contents */
+		for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
+				    ARMPMU_MAX_HWEVENTS) {
+			if (i == ARMV8_PMU_CYCLE_IDX)
+				write_pmccntr(0);
+			else if (i == ARMV8_PMU_INSTR_IDX)
+				write_pmicntr(0);
+			else
+				armv8pmu_write_evcntr(i, 0);
+		}
 	}
 
-	update_pmuserenr(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR);
+	update_pmuserenr(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_UEN);
 }
 
 static void armv8pmu_enable_event(struct perf_event *event)
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 3372c1b56486..d698efba28a2 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -257,6 +257,7 @@
 #define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
 #define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
 #define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
+#define ARMV8_PMU_USERENR_UEN	(1 << 4) /* Fine grained per counter access at EL0 */
 /* Mask for writable bits */
 #define ARMV8_PMU_USERENR_MASK	(ARMV8_PMU_USERENR_EN | ARMV8_PMU_USERENR_SW | \
 				 ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_ER)
-- 
2.30.2


