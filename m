Return-Path: <stable+bounces-68845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE6953446
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5883F1F29237
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B619DFB9;
	Thu, 15 Aug 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LASf1VSR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105463C;
	Thu, 15 Aug 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731845; cv=none; b=oLmtuU2ikmrZ972ZXfTS+3JIWs4eEw4zpO44j0GI1IfybccGb8fcGN9/EiyWCnJN9AsYYdrgedcf2i39yIh3ATwbvlIP1w/cBkJV8ntDGnEPJTk6x3qT0abeklEBZlc9q7QcBrROHCAkYmmHxmC8nExQAUl8lKlrcSnhqUrnDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731845; c=relaxed/simple;
	bh=u0/RA+pvYNFHZov/5UpP6cMHcu/XdR41skJW/Ap+ZV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK6tn8xEkxbbUrC8Gfv+QUa5TIHWncm5YVuLE0vlpbG+DgZv6Z37j/EpLGxKWoX2R471WINhQ8/jj27vnJIWgr/aI4MoDgH9DQSBjpuZa4xGYbnTPipHq+a0tHsFtVkD36Bj5PgO86YLXRtR60KLiyM2AiOyJrhC+joglLuV5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LASf1VSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AB8C32786;
	Thu, 15 Aug 2024 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731844;
	bh=u0/RA+pvYNFHZov/5UpP6cMHcu/XdR41skJW/Ap+ZV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LASf1VSREjC9pTkISSEzNoNaB0uu+3HOCwQvOqBE+4kC1NnHIXr8GDqh1sTJQ5tNr
	 iGt2fBslziJHmON93q8Qow1NBbWw43hfinFw94A4KWKTJoK51xlicsVTSKhOjOZ2kX
	 +XXegFnj5XnGn+FpeC1kp8s4R1ViqG3h3MbliefU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Morse <james.morse@arm.com>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.4 255/259] arm64: cpufeature: Fix the visibility of compat hwcaps
Date: Thu, 15 Aug 2024 15:26:28 +0200
Message-ID: <20240815131912.720512261@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Daniel Kachhap <amit.kachhap@arm.com>

commit 85f1506337f0c79a4955edfeee86a18628e3735f upstream.

Commit 237405ebef58 ("arm64: cpufeature: Force HWCAP to be based on the
sysreg visible to user-space") forced the hwcaps to use sanitised
user-space view of the id registers. However, the ID register structures
used to select few compat cpufeatures (vfp, crc32, ...) are masked and
hence such hwcaps do not appear in /proc/cpuinfo anymore for PER_LINUX32
personality.

Add the ID register structures explicitly and set the relevant entry as
visible. As these ID registers are now of type visible so make them
available in 64-bit userspace by making necessary changes in register
emulation logic and documentation.

While at it, update the comment for structure ftr_generic_32bits[] which
lists the ID register that use it.

Fixes: 237405ebef58 ("arm64: cpufeature: Force HWCAP to be based on the sysreg visible to user-space")
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Link: https://lore.kernel.org/r/20221103082232.19189-1-amit.kachhap@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/cpu-feature-registers.rst |   38 ++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c                |   42 ++++++++++++++++++++------
 2 files changed, 70 insertions(+), 10 deletions(-)

--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -92,7 +92,7 @@ operation if the source belongs to the s
 
 The infrastructure emulates only the following system register space::
 
-	Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7
+	Op0=3, Op1=0, CRn=0, CRm=0,2,3,4,5,6,7
 
 (See Table C5-6 'System instruction encodings for non-Debug System
 register accesses' in ARMv8 ARM DDI 0487A.h, for the list of
@@ -167,6 +167,42 @@ infrastructure:
      | EL0                          | [3-0]   |    n    |
      +------------------------------+---------+---------+
 
+  10) MVFR0_EL1 - AArch32 Media and VFP Feature Register 0
+
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | FPDP                         | [11-8]  |    y    |
+     +------------------------------+---------+---------+
+
+  11) MVFR1_EL1 - AArch32 Media and VFP Feature Register 1
+
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | SIMDFMAC                     | [31-28] |    y    |
+     +------------------------------+---------+---------+
+     | SIMDSP                       | [19-16] |    y    |
+     +------------------------------+---------+---------+
+     | SIMDInt                      | [15-12] |    y    |
+     +------------------------------+---------+---------+
+     | SIMDLS                       | [11-8]  |    y    |
+     +------------------------------+---------+---------+
+
+  12) ID_ISAR5_EL1 - AArch32 Instruction Set Attribute Register 5
+
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | CRC32                        | [19-16] |    y    |
+     +------------------------------+---------+---------+
+     | SHA2                         | [15-12] |    y    |
+     +------------------------------+---------+---------+
+     | SHA1                         | [11-8]  |    y    |
+     +------------------------------+---------+---------+
+     | AES                          | [7-4]   |    y    |
+     +------------------------------+---------+---------+
+
 
   3) MIDR_EL1 - Main ID Register
 
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -292,6 +292,30 @@ static const struct arm64_ftr_bits ftr_i
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_mvfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPROUND_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSHVEC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSQRT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPDIVIDE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPTRAP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPDP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_SIMD_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
+static const struct arm64_ftr_bits ftr_mvfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDFMAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPHP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDHP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDSP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDINT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDLS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPDNAN_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPFTZ_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_mvfr2[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* FPMisc */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),		/* SIMDMisc */
@@ -307,10 +331,10 @@ static const struct arm64_ftr_bits ftr_d
 
 static const struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_CRC32_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA1_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_AES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SEVL_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -350,7 +374,7 @@ static const struct arm64_ftr_bits ftr_z
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
  * 0. Covers the following 32bit registers:
- * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ * id_isar[1-3], id_mmfr[1-3]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
@@ -405,8 +429,8 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
 
 	/* Op1 = 0, CRn = 0, CRm = 3 */
-	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
-	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_mvfr0),
+	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_mvfr1),
 	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
 
 	/* Op1 = 0, CRn = 0, CRm = 4 */
@@ -2182,7 +2206,7 @@ static void __maybe_unused cpu_enable_cn
 
 /*
  * We emulate only the following system register space.
- * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
+ * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 2 - 7]
  * See Table C5-6 System instruction encodings for System register accesses,
  * ARMv8 ARM(ARM DDI 0487A.f) for more details.
  */
@@ -2192,7 +2216,7 @@ static inline bool __attribute_const__ i
 		sys_reg_CRn(id) == 0x0 &&
 		sys_reg_Op1(id) == 0x0 &&
 		(sys_reg_CRm(id) == 0 ||
-		 ((sys_reg_CRm(id) >= 4) && (sys_reg_CRm(id) <= 7))));
+		 ((sys_reg_CRm(id) >= 2) && (sys_reg_CRm(id) <= 7))));
 }
 
 /*



