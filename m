Return-Path: <stable+bounces-66233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495CA94CEDC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AD1B21FD5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C831922DB;
	Fri,  9 Aug 2024 10:44:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED7191F65
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200255; cv=none; b=OuxphWId8jy0TU//PuCIQcVmoGK8oMnkN+Y/vBzSD6QXpbFAz1F1+0bvlLW5RMTA4Mq5LQeWTkOtXKDlD6cSg+H7/KxMvXD9FDxKgNQMMaD82Y4+vgLvJAQ2H9S4QZsro4YFFyR6OJdfYWlNyHi8+zABgvUFhHuiSJmPa1QsrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200255; c=relaxed/simple;
	bh=vGZyAkyoK0fglO3L/L7oprLCVGkZPWiBRPqBeY71zEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYlaPnWJHN2Fyr5VouaPglnUo4NMHVEQ3qoVJ0/Z7G8qP+sEA5pG/X7ol2RzIXJU8hpXP9EUd+2aqobeKNXUBNwob1mbxu1+F+LivhVecEdrwRnGocfRKZiuvQwHxmF1KsFYMKRHFIx+fnL9VDnuP6oe2nkXZ39bVLiISNmxbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E826A1684;
	Fri,  9 Aug 2024 03:44:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D32C23F766;
	Fri,  9 Aug 2024 03:44:11 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	will@kernel.org
Subject: [PATCH 4.19.y 01/14] arm64: Add support for SB barrier and patch in over DSB; ISB sequences
Date: Fri,  9 Aug 2024 11:43:43 +0100
Message-Id: <20240809104356.3503412-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809104356.3503412-1-mark.rutland@arm.com>
References: <20240809104356.3503412-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit bd4fb6d270bc423a9a4098108784f7f9254c4e6d ]

We currently use a DSB; ISB sequence to inhibit speculation in set_fs().
Whilst this works for current CPUs, future CPUs may implement a new SB
barrier instruction which acts as an architected speculation barrier.

On CPUs that support it, patch in an SB; NOP sequence over the DSB; ISB
sequence and advertise the presence of the new instruction to userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
[ Mark: fixup conflicts ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/assembler.h  | 13 +++++++++++++
 arch/arm64/include/asm/barrier.h    |  4 ++++
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/sysreg.h     |  6 ++++++
 arch/arm64/include/asm/uaccess.h    |  3 +--
 arch/arm64/include/uapi/asm/hwcap.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 12 ++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  1 +
 8 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index fc3d26c954a40..efabe6c476aa0 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -133,6 +133,19 @@
 	hint	#22
 	.endm
 
+/*
+ * Speculation barrier
+ */
+	.macro	sb
+alternative_if_not ARM64_HAS_SB
+	dsb	nsh
+	isb
+alternative_else
+	SB_BARRIER_INSN
+	nop
+alternative_endif
+	.endm
+
 /*
  * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
  * of bounds.
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 822a9192c5511..f66bb04fdf2dd 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -34,6 +34,10 @@
 #define psb_csync()	asm volatile("hint #17" : : : "memory")
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
+#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
+						 SB_BARRIER_INSN"nop\n",	\
+						 ARM64_HAS_SB))
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 61fd28522d74f..a7e2378df3d1c 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -56,7 +56,8 @@
 #define ARM64_WORKAROUND_1542419		35
 #define ARM64_SPECTRE_BHB			36
 #define ARM64_WORKAROUND_1742098		37
+#define ARM64_HAS_SB				38
 
-#define ARM64_NCAPS				38
+#define ARM64_NCAPS				39
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0a8342de5796a..8f015c20f3e0e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -97,6 +97,11 @@
 #define SET_PSTATE_SSBS(x) __emit_inst(0xd5000000 | REG_PSTATE_SSBS_IMM | \
 				       (!!x)<<8 | 0x1f)
 
+#define __SYS_BARRIER_INSN(CRm, op2, Rt) \
+	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
+
+#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
+
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
 #define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
 #define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
@@ -528,6 +533,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64isar1 */
+#define ID_AA64ISAR1_SB_SHIFT		36
 #define ID_AA64ISAR1_LRCPC_SHIFT	20
 #define ID_AA64ISAR1_FCMA_SHIFT		16
 #define ID_AA64ISAR1_JSCVT_SHIFT	12
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2f..3c3bf4171f3b6 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -46,8 +46,7 @@ static inline void set_fs(mm_segment_t fs)
 	 * Prevent a mispredicted conditional call to set_fs from forwarding
 	 * the wrong address limit to access_ok under speculation.
 	 */
-	dsb(nsh);
-	isb();
+	spec_bar();
 
 	/* On user-mode return, check fs is correct */
 	set_thread_flag(TIF_FSCHECK);
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 2bcd6e4f34740..7784f7cba16cf 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -49,5 +49,6 @@
 #define HWCAP_ILRCPC		(1 << 26)
 #define HWCAP_FLAGM		(1 << 27)
 #define HWCAP_SSBS		(1 << 28)
+#define HWCAP_SB		(1 << 29)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d7e73a7963d1b..3f6a2187d0911 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -144,6 +144,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_LRCPC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FCMA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_JSCVT_SHIFT, 4, 0),
@@ -1361,6 +1362,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_ssbs,
 	},
 #endif
+	{
+		.desc = "Speculation barrier (SB)",
+		.capability = ARM64_HAS_SB,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.field_pos = ID_AA64ISAR1_SB_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
 	{},
 };
 
@@ -1415,6 +1426,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_FCMA),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_LRCPC),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ILRCPC),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SB),
 	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 36bd58d8ca11f..9d013e7106a99 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -82,6 +82,7 @@ static const char *const hwcap_str[] = {
 	"ilrcpc",
 	"flagm",
 	"ssbs",
+	"sb",
 	NULL
 };
 
-- 
2.30.2


