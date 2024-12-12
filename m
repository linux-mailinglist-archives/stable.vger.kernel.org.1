Return-Path: <stable+bounces-102511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CA9EF2EE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE03189EDAF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6322A7F0;
	Thu, 12 Dec 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2KiGiUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9822333D;
	Thu, 12 Dec 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021496; cv=none; b=COFfvaMVdmJGSaodF+Lf21xlzgF2TmeabXSne2h25heCywnIrfu5gc9n4yXNTp2KIj1b/T7ZUPZp2knP1Yww48usD8DlmNWYuLXSP4OlondWzicIxP5mitO5hDh+oQQkUch9p+HUk8Q9M/Gk+yfoIzFQnW0skfaIyT2YF988veU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021496; c=relaxed/simple;
	bh=6xCTj1vxM5/l9O8POH1f3HaL0DurqjGVMfsPWDfhGjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyjCEC8J3koFx8b2VeK0/ereJK9tKybEe165FJI+H7zl8tft8W2eS3QRacg7wGAhUn6Ha9LRLu8kcpwgDPuRryAf4zGyEPsTeucpQTjhHdiPShL6wvo10Xg3ZtxCtr9pCZr1uMameHycRV6U2lnYk/mkIhHmQISsLpT22lU0KBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2KiGiUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DEFC4CECE;
	Thu, 12 Dec 2024 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021495;
	bh=6xCTj1vxM5/l9O8POH1f3HaL0DurqjGVMfsPWDfhGjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2KiGiUmnXazvilfQf1cTcmASnHy3j091If3BHKBaGZrz+eLE9iXBxdw5aKDtK86q
	 Yh+IEWbd4oVDwLIG3gywKcK9spsYqi++C/CaSIINag72BhJiySSjqw1DaXISUzc0b+
	 h6FTCvrPEr79L6q8bUpfLnNY42Zd99eR01i/fhbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 754/772] arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
Date: Thu, 12 Dec 2024 16:01:39 +0100
Message-ID: <20241212144421.091283681@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 8c462d56487e3abdbf8a61cedfe7c795a54f4a78 upstream.

SMCCCv1.3 added a hint bit which callers can set in an SMCCC function ID
(AKA "FID") to indicate that it is acceptable for the SMCCC
implementation to discard SVE and/or SME state over a specific SMCCC
call. The kernel support for using this hint is broken and SMCCC calls
may clobber the SVE and/or SME state of arbitrary tasks, though FPSIMD
state is unaffected.

The kernel support is intended to use the hint when there is no SVE or
SME state to save, and to do this it checks whether TIF_FOREIGN_FPSTATE
is set or TIF_SVE is clear in assembly code:

|        ldr     <flags>, [<current_task>, #TSK_TI_FLAGS]
|        tbnz    <flags>, #TIF_FOREIGN_FPSTATE, 1f   // Any live FP state?
|        tbnz    <flags>, #TIF_SVE, 2f               // Does that state include SVE?
|
| 1:     orr     <fid>, <fid>, ARM_SMCCC_1_3_SVE_HINT
| 2:
|        << SMCCC call using FID >>

This is not safe as-is:

(1) SMCCC calls can be made in a preemptible context and preemption can
    result in TIF_FOREIGN_FPSTATE being set or cleared at arbitrary
    points in time. Thus checking for TIF_FOREIGN_FPSTATE provides no
    guarantee.

(2) TIF_FOREIGN_FPSTATE only indicates that the live FP/SVE/SME state in
    the CPU does not belong to the current task, and does not indicate
    that clobbering this state is acceptable.

    When the live CPU state is clobbered it is necessary to update
    fpsimd_last_state.st to ensure that a subsequent context switch will
    reload FP/SVE/SME state from memory rather than consuming the
    clobbered state. This and the SMCCC call itself must happen in a
    critical section with preemption disabled to avoid races.

(3) Live SVE/SME state can exist with TIF_SVE clear (e.g. with only
    TIF_SME set), and checking TIF_SVE alone is insufficient.

Remove the broken support for the SMCCCv1.3 SVE saving hint. This is
effectively a revert of commits:

* cfa7ff959a78 ("arm64: smccc: Support SMCCC v1.3 SVE register saving hint")
* a7c3acca5380 ("arm64: smccc: Save lr before calling __arm_smccc_sve_check()")

... leaving behind the ARM_SMCCC_VERSION_1_3 and ARM_SMCCC_1_3_SVE_HINT
definitions, since these are simply definitions from the SMCCC
specification, and the latter is used in KVM via ARM_SMCCC_CALL_HINTS.

If we want to bring this back in future, we'll probably want to handle
this logic in C where we can use all the usual FPSIMD/SVE/SME helper
functions, and that'll likely require some rework of the SMCCC code
and/or its callers.

Fixes: cfa7ff959a78 ("arm64: smccc: Support SMCCC v1.3 SVE register saving hint")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241106160448.2712997-1-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: fix conflicts in <linux/arm-smccc.h> ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/smccc-call.S |   35 +++--------------------------------
 drivers/firmware/smccc/smccc.c |    4 ----
 include/linux/arm-smccc.h      |   30 ++----------------------------
 3 files changed, 5 insertions(+), 64 deletions(-)

--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -7,48 +7,19 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
-#include <asm/thread_info.h>
-
-/*
- * If we have SMCCC v1.3 and (as is likely) no SVE state in
- * the registers then set the SMCCC hint bit to say there's no
- * need to preserve it.  Do this by directly adjusting the SMCCC
- * function value which is already stored in x0 ready to be called.
- */
-SYM_FUNC_START(__arm_smccc_sve_check)
-
-	ldr_l	x16, smccc_has_sve_hint
-	cbz	x16, 2f
-
-	get_current_task x16
-	ldr	x16, [x16, #TSK_TI_FLAGS]
-	tbnz	x16, #TIF_FOREIGN_FPSTATE, 1f	// Any live FP state?
-	tbnz	x16, #TIF_SVE, 2f		// Does that state include SVE?
-
-1:	orr	x0, x0, ARM_SMCCC_1_3_SVE_HINT
-
-2:	ret
-SYM_FUNC_END(__arm_smccc_sve_check)
-EXPORT_SYMBOL(__arm_smccc_sve_check)
 
 	.macro SMCCC instr
-	stp     x29, x30, [sp, #-16]!
-	mov	x29, sp
-alternative_if ARM64_SVE
-	bl	__arm_smccc_sve_check
-alternative_else_nop_endif
 	\instr	#0
-	ldr	x4, [sp, #16]
+	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
 	stp	x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
-	ldr	x4, [sp, #24]
+	ldr	x4, [sp, #8]
 	cbz	x4, 1f /* no quirk structure */
 	ldr	x9, [x4, #ARM_SMCCC_QUIRK_ID_OFFS]
 	cmp	x9, #ARM_SMCCC_QUIRK_QCOM_A6
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
-1:	ldp     x29, x30, [sp], #16
-	ret
+1:	ret
 	.endm
 
 /*
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -16,7 +16,6 @@ static u32 smccc_version = ARM_SMCCC_VER
 static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
 bool __ro_after_init smccc_trng_available = false;
-u64 __ro_after_init smccc_has_sve_hint = false;
 s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
 s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
 
@@ -28,9 +27,6 @@ void __init arm_smccc_version_init(u32 v
 	smccc_conduit = conduit;
 
 	smccc_trng_available = smccc_probe_trng();
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    smccc_version >= ARM_SMCCC_VERSION_1_3)
-		smccc_has_sve_hint = true;
 
 	if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
 	    (smccc_conduit != SMCCC_CONDUIT_NONE)) {
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -224,8 +224,6 @@ u32 arm_smccc_get_version(void);
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
 
-extern u64 smccc_has_sve_hint;
-
 /**
  * arm_smccc_get_soc_id_version()
  *
@@ -324,15 +322,6 @@ struct arm_smccc_quirk {
 };
 
 /**
- * __arm_smccc_sve_check() - Set the SVE hint bit when doing SMC calls
- *
- * Sets the SMCCC hint bit to indicate if there is live state in the SVE
- * registers, this modifies x0 in place and should never be called from C
- * code.
- */
-asmlinkage unsigned long __arm_smccc_sve_check(unsigned long x0);
-
-/**
  * __arm_smccc_smc() - make SMC calls
  * @a0-a7: arguments passed in registers 0 to 7
  * @res: result values from registers 0 to 3
@@ -399,20 +388,6 @@ asmlinkage void __arm_smccc_hvc(unsigned
 
 #endif
 
-/* nVHE hypervisor doesn't have a current thread so needs separate checks */
-#if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
-
-#define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
-				    ARM64_SVE)
-#define smccc_sve_clobbers "x16", "x30", "cc",
-
-#else
-
-#define SMCCC_SVE_CHECK
-#define smccc_sve_clobbers
-
-#endif
-
 #define ___count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
 
 #define __count_args(...)						\
@@ -480,7 +455,7 @@ asmlinkage void __arm_smccc_hvc(unsigned
 
 #define ___constraints(count)						\
 	: __constraint_read_ ## count					\
-	: smccc_sve_clobbers "memory"
+	: "memory"
 #define __constraints(count)	___constraints(count)
 
 /*
@@ -495,8 +470,7 @@ asmlinkage void __arm_smccc_hvc(unsigned
 		register unsigned long r2 asm("r2");			\
 		register unsigned long r3 asm("r3"); 			\
 		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
-		asm volatile(SMCCC_SVE_CHECK				\
-			     inst "\n" :				\
+		asm volatile(inst "\n" :				\
 			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
 			     __constraints(__count_args(__VA_ARGS__)));	\
 		if (___res)						\



