Return-Path: <stable+bounces-161971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F6B05A5F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F211A653AE
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7032E03E1;
	Tue, 15 Jul 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA0rDKOz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127A2E0401
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583078; cv=none; b=hNep21kF6EwrdmFKkySi7A8yOKCGOPqfVMhejRsyAS9ji7gvA4vn6ZlBKAIfH6i61vbxP0YR9KCL0zfmBsvJdp+QAc/veoayF92CP+VMSxXSEUbVcifzciwOa3UBAUNtF7W1g0xwEGi5kscfrGgbDozXqUPCbHSKq+igwFAHuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583078; c=relaxed/simple;
	bh=Rhld6W4JpehZOJ0jtn16TP2om9+I+14oFp/kUsotOPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dteEDx8sCa+nESh6//feYZQ3QHojNTpmvW1hMz+bgWO39mJMT3xJs4J6HpgS09bFcoq0pgI0MdxwNxG1Wa6H/jBqfaxfJTeSSlJM7wOJxmG82azTpRZpHEiP7wxNZg+smUVuK3CIwB0qVK0ZPkeHlBCkaLaxX+wgFc7M8bYfTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA0rDKOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B55FC4CEE3;
	Tue, 15 Jul 2025 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583077;
	bh=Rhld6W4JpehZOJ0jtn16TP2om9+I+14oFp/kUsotOPA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BA0rDKOzmJJ+qIYuEqp1oUgYXpAz3Vn8bslZkgt3P59cKItHMaQduCsxJiYJQkvRq
	 dWfSo8riGiT/HGdhkwVOmwHcrbQA/uHt2dl9feyT0bvhdJCBQHQr52JDktJV9r/qtx
	 e0PjX2phhDM+rI3HohbXWl5ilNvWvDCgTudvoWeVkYFVBlTghFqmdLServQECxnRZS
	 K/0hoFssdTLM6/gbDhvzHpWVxIbItwo4eNr3URYYEssEOhzjgGYAQPbbi6tWXJBTaf
	 6+XDqA7ELMzo8cFhTfvpg90ETu4pnZ67/G1r1sKGpaGe2XmhhkMOkKWtgl7GPXHxAL
	 L7F9QCVePBWLA==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Subject: [PATCH 4/5] KVM: SVM: Advertise TSA CPUID bits to guests
Date: Tue, 15 Jul 2025 14:37:48 +0200
Message-ID: <20250715123749.4610-5-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715123749.4610-1-bp@kernel.org>
References: <20250715123749.4610-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit 31272abd5974b38ba312e9cf2ec2f09f9dd7dcba upstream.

Synthesize the TSA CPUID feature bits for guests. Set TSA_{SQ,L1}_NO on
unaffected machines.

  [ backporting notes: 5.10 doesn't have the KVM-only CPUID leafs so
    allocate a separate capability leaf for CPUID_8000_0021_ECX to avoid
    backporting the world and more. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeature.h        |  5 +++--
 arch/x86/include/asm/cpufeatures.h       |  8 ++++----
 arch/x86/include/asm/disabled-features.h |  2 +-
 arch/x86/include/asm/required-features.h |  2 +-
 arch/x86/kernel/cpu/scattered.c          |  2 --
 arch/x86/kvm/cpuid.c                     | 16 ++++++++++++++--
 arch/x86/kvm/cpuid.h                     |  1 +
 7 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 955ca6b13e35..c8e966ed7aa4 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -34,6 +34,7 @@ enum cpuid_leafs
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
 	CPUID_LNX_5,
+	CPUID_8000_0021_ECX,
 	NR_CPUID_WORDS,
 };
 
@@ -97,7 +98,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 23))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -123,7 +124,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 23))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 9dafd0c64d25..c42a3c8189d6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			22	   /* N 32-bit words worth of info */
+#define NCAPINTS			23	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -412,9 +412,9 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
-#define X86_FEATURE_TSA_SQ_NO          (21*32+11) /* "" AMD CPU not vulnerable to TSA-SQ */
-#define X86_FEATURE_TSA_L1_NO          (21*32+12) /* "" AMD CPU not vulnerable to TSA-L1 */
-#define X86_FEATURE_CLEAR_CPU_BUF_VM   (21*32+13) /* "" Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_TSA_SQ_NO          (22*32+11) /* "" AMD CPU not vulnerable to TSA-SQ */
+#define X86_FEATURE_TSA_L1_NO          (22*32+12) /* "" AMD CPU not vulnerable to TSA-L1 */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM   (22*32+13) /* "" Clear CPU buffers using VERW before VMRUN */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index e5f44a3e275c..170c87253340 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -104,6 +104,6 @@
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
 #define DISABLED_MASK21	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 23)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 1fbe53583e95..4e3cd318323b 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -104,6 +104,6 @@
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
 #define REQUIRED_MASK21	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 23)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 55c192c3be80..f1cd1b6fb99e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -41,8 +41,6 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
-	{ X86_FEATURE_TSA_SQ_NO,	CPUID_ECX,  1, 0x80000021, 0 },
-	{ X86_FEATURE_TSA_L1_NO,	CPUID_ECX,  2, 0x80000021, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8ec86d2c1a41..ab0ae4a30fd1 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -500,6 +500,15 @@ void kvm_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_mask(CPUID_8000_000A_EDX, 0);
 
+	if (cpu_feature_enabled(X86_FEATURE_VERW_CLEAR))
+		kvm_cpu_cap_set(X86_FEATURE_VERW_CLEAR);
+
+	if (cpu_feature_enabled(X86_FEATURE_TSA_SQ_NO))
+		kvm_cpu_cap_set(X86_FEATURE_TSA_SQ_NO);
+
+	if (cpu_feature_enabled(X86_FEATURE_TSA_L1_NO))
+		kvm_cpu_cap_set(X86_FEATURE_TSA_L1_NO);
+
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
@@ -879,18 +888,21 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
 	case 0x80000021:
-		entry->ebx = entry->ecx = entry->edx = 0;
+		entry->ebx = entry->edx = 0;
 		/*
 		 * Pass down these bits:
 		 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
 		 *    EAX      2      LAS, LFENCE always serializing
+		 *    EAX      5      VERW_CLEAR, mitigate TSA
 		 *    EAX      6      NSCB, Null selector clear base
 		 *
 		 * Other defined bits are for MSRs that KVM does not expose:
 		 *   EAX      3      SPCL, SMM page configuration lock
 		 *   EAX      13     PCMSR, Prefetch control MSR
 		 */
-		entry->eax &= BIT(0) | BIT(2) | BIT(6);
+		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
+		entry->eax &= BIT(0) | BIT(2) | BIT(5) | BIT(6);
+		cpuid_entry_override(entry, CPUID_8000_0021_ECX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index e25853c2eb0f..88315d43d380 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -64,6 +64,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
 	[CPUID_8000_0021_EAX] = {0x80000021, 0, CPUID_EAX},
+	[CPUID_8000_0021_ECX] = {0x80000021, 0, CPUID_ECX},
 };
 
 /*
-- 
2.43.0


