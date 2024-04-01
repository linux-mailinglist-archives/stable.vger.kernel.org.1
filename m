Return-Path: <stable+bounces-35204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C98942E3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C74D28376B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE2481D1;
	Mon,  1 Apr 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eRpbcsC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA912EB0B;
	Mon,  1 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990637; cv=none; b=cVdFLj+sGQOLHgNQuO8aJRLjPcW9hOx5nyPhH6ODDZxi00NNebMSOjBMhWSNbcv6L0bBine6r7gCTe4gYw2BavEeNEgNfNvFPsicgg3vaUCLBgYwvWcP3SP2ZJCUSUasSs7jbq5PaocUpL/gpMkPdNaLTeIlZz6OcMgdVjKnw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990637; c=relaxed/simple;
	bh=VUNeQIUpjuFmsmAaMXvkI93ruRNTJgJQdEvsFipQl0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qB0Y62mKnStJyuSKEF07ApuZXZ3qctC1PA7TKDHsxbTrrgnzCf5BT1IW37sBhJW9vXdU995AhS9ghXZ/7TpbPrK8rE45O8/kFKSMk7BizsjgA5ZYCp7eEgM0IixjihRqpDjkoPy7MUF9nWCT7VkDk4kdjML3QU18K2R2eluOWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eRpbcsC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2FDC433F1;
	Mon,  1 Apr 2024 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990637;
	bh=VUNeQIUpjuFmsmAaMXvkI93ruRNTJgJQdEvsFipQl0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRpbcsC/cqikTSjHmk2SyqKPbYcDPHw+xK8MNkgeGBiMvkCzV+pOdnjnXFib8E9Hi
	 q87bvCctnMavtYuYJZ5mC61vgwB3Q63Kos5oX4k5lsuf7Rr8meNXE6D7j//maHkkHz
	 VGCk4rcwBO9iSxXmvWYKQOKPh337gd6B4QDaafOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.1 003/272] KVM: x86: Update KVM-only leaf handling to allow for 100% KVM-only leafs
Date: Mon,  1 Apr 2024 17:43:13 +0200
Message-ID: <20240401152530.357225902@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Sean Christopherson <seanjc@google.com>

commit 047c7229906152fb85c23dc18fd25a00cd7cb4de upstream.

Rename kvm_cpu_cap_init_scattered() to kvm_cpu_cap_init_kvm_defined() in
anticipation of adding KVM-only CPUID leafs that aren't recognized by the
kernel and thus not scattered, i.e. for leafs that are 100% KVM-defined.

Adjust/add comments to kvm_only_cpuid_leafs and KVM_X86_FEATURE to
document how to create new kvm_only_cpuid_leafs entries for scattered
features as well as features that are entirely unknown to the kernel.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20221125125845.1182922-3-jiaxi.chen@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c         |    8 ++++----
 arch/x86/kvm/reverse_cpuid.h |   18 +++++++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -535,9 +535,9 @@ static __always_inline void __kvm_cpu_ca
 }
 
 static __always_inline
-void kvm_cpu_cap_init_scattered(enum kvm_only_cpuid_leafs leaf, u32 mask)
+void kvm_cpu_cap_init_kvm_defined(enum kvm_only_cpuid_leafs leaf, u32 mask)
 {
-	/* Use kvm_cpu_cap_mask for non-scattered leafs. */
+	/* Use kvm_cpu_cap_mask for leafs that aren't KVM-only. */
 	BUILD_BUG_ON(leaf < NCAPINTS);
 
 	kvm_cpu_caps[leaf] = mask;
@@ -547,7 +547,7 @@ void kvm_cpu_cap_init_scattered(enum kvm
 
 static __always_inline void kvm_cpu_cap_mask(enum cpuid_leafs leaf, u32 mask)
 {
-	/* Use kvm_cpu_cap_init_scattered for scattered leafs. */
+	/* Use kvm_cpu_cap_init_kvm_defined for KVM-only leafs. */
 	BUILD_BUG_ON(leaf >= NCAPINTS);
 
 	kvm_cpu_caps[leaf] &= mask;
@@ -656,7 +656,7 @@ void kvm_set_cpu_caps(void)
 		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
 	);
 
-	kvm_cpu_cap_init_scattered(CPUID_12_EAX,
+	kvm_cpu_cap_init_kvm_defined(CPUID_12_EAX,
 		SF(SGX1) | SF(SGX2)
 	);
 
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -7,9 +7,9 @@
 #include <asm/cpufeatures.h>
 
 /*
- * Hardware-defined CPUID leafs that are scattered in the kernel, but need to
- * be directly used by KVM.  Note, these word values conflict with the kernel's
- * "bug" caps, but KVM doesn't use those.
+ * Hardware-defined CPUID leafs that are either scattered by the kernel or are
+ * unknown to the kernel, but need to be directly used by KVM.  Note, these
+ * word values conflict with the kernel's "bug" caps, but KVM doesn't use those.
  */
 enum kvm_only_cpuid_leafs {
 	CPUID_12_EAX	 = NCAPINTS,
@@ -18,6 +18,18 @@ enum kvm_only_cpuid_leafs {
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
 };
 
+/*
+ * Define a KVM-only feature flag.
+ *
+ * For features that are scattered by cpufeatures.h, __feature_translate() also
+ * needs to be updated to translate the kernel-defined feature into the
+ * KVM-defined feature.
+ *
+ * For features that are 100% KVM-only, i.e. not defined by cpufeatures.h,
+ * forego the intermediate KVM_X86_FEATURE and directly define X86_FEATURE_* so
+ * that X86_FEATURE_* can be used in KVM.  No __feature_translate() handling is
+ * needed in this case.
+ */
 #define KVM_X86_FEATURE(w, f)		((w)*32 + (f))
 
 /* Intel-defined SGX sub-features, CPUID level 0x12 (EAX). */



