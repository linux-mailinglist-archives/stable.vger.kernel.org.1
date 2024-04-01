Return-Path: <stable+bounces-34789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0E8940DA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7ED1C21387
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A443AD6;
	Mon,  1 Apr 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vb4ie0Ql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CF3F8F4;
	Mon,  1 Apr 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989302; cv=none; b=t+gI55DtNeRcsYLdQ1vw/9CJECCu4iyZxw/9INW4DylqK3P0UjaXBM6l6cwa3nv8veBR3e2Jbdg7FZLpMzzsupsjWVmSTDc1gyWnPrLRSuBXgc+Vh/X+CypQS6lkRt41tiNW0KC6hbgflw/YcS5I2aWzvNtVlyN6T8cT3AYopdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989302; c=relaxed/simple;
	bh=oBgSFXq9F/sA66W4jN1bIPqSRcZ4Yb2sGO+k0QESssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obZBWblNRJ5YKRFWijN5B/ZDIMlA2psGYtU7+1uZAkh/R/W8lriuyjkeFKOeOlIc/LqqrZE62085m5pzrTWBAC90nZjFIgto7mOM1sIBJ6DuhHR0l06spYGTqKm8Z7EpEjqkl+01zH8pjgbFcywaWCLV/IBCuls15SyxT/ZGmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vb4ie0Ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4041C433F1;
	Mon,  1 Apr 2024 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989302;
	bh=oBgSFXq9F/sA66W4jN1bIPqSRcZ4Yb2sGO+k0QESssg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vb4ie0QlbpYqXvfcJ40eIwpR/OPitdn9pHuAvOo9YnqmL0m/dksqCXCR+OlPXiwVr
	 ZYAlUanC/bx1flgb4ekgXDIVGpirLdG8OTBh4eZoD97G+iQ1QuNV7Iv6nDNhNBOZLs
	 BWUZJVeyIzZI4gwzlzt6RmXqNbbECr8OM0a4ZmZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6 001/396] KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
Date: Mon,  1 Apr 2024 17:40:50 +0200
Message-ID: <20240401152547.916910554@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit eefe5e6682099445f77f2d97d4c525f9ac9d9b07 upstream.

The low five bits {INTEL_PSFD, IPRED_CTRL, RRSBA_CTRL, DDPD_U, BHI_CTRL}
advertise the availability of specific bits in IA32_SPEC_CTRL. Since KVM
dynamically determines the legal IA32_SPEC_CTRL bits for the underlying
hardware, the hard work has already been done. Just let userspace know
that a guest can use these IA32_SPEC_CTRL bits.

The sixth bit (MCDT_NO) states that the processor does not exhibit MXCSR
Configuration Dependent Timing (MCDT) behavior. This is an inherent
property of the physical processor that is inherited by the virtual
CPU. Pass that information on to userspace.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/r/20231024001636.890236-1-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c         |   21 ++++++++++++++++++---
 arch/x86/kvm/reverse_cpuid.h |   12 ++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -677,6 +677,11 @@ void kvm_set_cpu_caps(void)
 		F(AMX_COMPLEX)
 	);
 
+	kvm_cpu_cap_init_kvm_defined(CPUID_7_2_EDX,
+		F(INTEL_PSFD) | F(IPRED_CTRL) | F(RRSBA_CTRL) | F(DDPD_U) |
+		F(BHI_CTRL) | F(MCDT_NO)
+	);
+
 	kvm_cpu_cap_mask(CPUID_D_1_EAX,
 		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
 	);
@@ -956,13 +961,13 @@ static inline int __do_cpuid_func(struct
 		break;
 	/* function 7 has additional index. */
 	case 7:
-		entry->eax = min(entry->eax, 1u);
+		max_idx = entry->eax = min(entry->eax, 2u);
 		cpuid_entry_override(entry, CPUID_7_0_EBX);
 		cpuid_entry_override(entry, CPUID_7_ECX);
 		cpuid_entry_override(entry, CPUID_7_EDX);
 
-		/* KVM only supports 0x7.0 and 0x7.1, capped above via min(). */
-		if (entry->eax == 1) {
+		/* KVM only supports up to 0x7.2, capped above via min(). */
+		if (max_idx >= 1) {
 			entry = do_host_cpuid(array, function, 1);
 			if (!entry)
 				goto out;
@@ -972,6 +977,16 @@ static inline int __do_cpuid_func(struct
 			entry->ebx = 0;
 			entry->ecx = 0;
 		}
+		if (max_idx >= 2) {
+			entry = do_host_cpuid(array, function, 2);
+			if (!entry)
+				goto out;
+
+			cpuid_entry_override(entry, CPUID_7_2_EDX);
+			entry->ecx = 0;
+			entry->ebx = 0;
+			entry->eax = 0;
+		}
 		break;
 	case 0xa: { /* Architectural Performance Monitoring */
 		union cpuid10_eax eax;
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -16,6 +16,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_EDX,
 	CPUID_8000_0007_EDX,
 	CPUID_8000_0022_EAX,
+	CPUID_7_2_EDX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
@@ -46,6 +47,14 @@ enum kvm_only_cpuid_leafs {
 #define X86_FEATURE_AMX_COMPLEX         KVM_X86_FEATURE(CPUID_7_1_EDX, 8)
 #define X86_FEATURE_PREFETCHITI         KVM_X86_FEATURE(CPUID_7_1_EDX, 14)
 
+/* Intel-defined sub-features, CPUID level 0x00000007:2 (EDX) */
+#define X86_FEATURE_INTEL_PSFD		KVM_X86_FEATURE(CPUID_7_2_EDX, 0)
+#define X86_FEATURE_IPRED_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 1)
+#define KVM_X86_FEATURE_RRSBA_CTRL	KVM_X86_FEATURE(CPUID_7_2_EDX, 2)
+#define X86_FEATURE_DDPD_U		KVM_X86_FEATURE(CPUID_7_2_EDX, 3)
+#define X86_FEATURE_BHI_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 4)
+#define X86_FEATURE_MCDT_NO		KVM_X86_FEATURE(CPUID_7_2_EDX, 5)
+
 /* CPUID level 0x80000007 (EDX). */
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
@@ -80,6 +89,7 @@ static const struct cpuid_reg reverse_cp
 	[CPUID_8000_0007_EDX] = {0x80000007, 0, CPUID_EDX},
 	[CPUID_8000_0021_EAX] = {0x80000021, 0, CPUID_EAX},
 	[CPUID_8000_0022_EAX] = {0x80000022, 0, CPUID_EAX},
+	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
 };
 
 /*
@@ -116,6 +126,8 @@ static __always_inline u32 __feature_tra
 		return KVM_X86_FEATURE_CONSTANT_TSC;
 	else if (x86_feature == X86_FEATURE_PERFMON_V2)
 		return KVM_X86_FEATURE_PERFMON_V2;
+	else if (x86_feature == X86_FEATURE_RRSBA_CTRL)
+		return KVM_X86_FEATURE_RRSBA_CTRL;
 
 	return x86_feature;
 }



