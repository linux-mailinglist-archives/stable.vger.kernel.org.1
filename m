Return-Path: <stable+bounces-114720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29569A2F996
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64F9162F3A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59B25C702;
	Mon, 10 Feb 2025 19:53:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB024C68D
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217206; cv=none; b=iddZk7ClrVZN2SbxjXBiDk6qcKT/J2wN2AP1TSaTPVg62o2AppkpVgvdeCZCgRIIfObZBpV3WmZn+QeKNcxuKkoMOOxtpey/sOV17iJU3SuVf2T5x0D5CgRbXEnQ4nDyGM38BJmgLc8wfkfUyCDWrYn3RjauEbavQ1A6e7mj9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217206; c=relaxed/simple;
	bh=kXcKLYCDAiNQpQqrpNthVUzfR2xJWaa3jwQGOrTjGeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqoTd5PgnqnncHCZlmEkaOR9LpDorAMfiHXSP+4my8afHkHPo5TC0a+q00fizJj6r4djI2qyjic6Qq3UKIKxXIx8QQ9joeWFfRqLam/xPwe+UyuZgpk2dgP41m3fyRHCyMVPxtBA8UW16qzib2mrqLQ7tGFFDcw68Z8Vp3T/oJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 137171477;
	Mon, 10 Feb 2025 11:53:46 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93B203F58B;
	Mon, 10 Feb 2025 11:53:21 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	eauger@redhat.com,
	eric.auger@redhat.com,
	fweimer@redhat.com,
	jeremy.linton@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com,
	stable@vger.kernel.org,
	tabba@google.com,
	wilco.dijkstra@arm.com,
	will@kernel.org
Subject: [PATCH v3 5/8] KVM: arm64: Refactor CPTR trap deactivation
Date: Mon, 10 Feb 2025 19:52:23 +0000
Message-Id: <20250210195226.1215254-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250210195226.1215254-1-mark.rutland@arm.com>
References: <20250210195226.1215254-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For historical reasons, the VHE and nVHE/hVHE implementations of
__activate_cptr_traps() pair with a common implementation of
__kvm_reset_cptr_el2(), which ideally would be named
__deactivate_cptr_traps().

Rename __kvm_reset_cptr_el2() to __deactivate_cptr_traps(), and split it
into separate VHE and nVHE/hVHE variants so that each can be paired with
its corresponding implementation of __activate_cptr_traps().

At the same time, fold kvm_write_cptr_el2() into its callers. This
makes it clear in-context whether a write is made to the CPACR_EL1
encoding or the CPTR_EL2 encoding, and removes the possibility of
confusion as to whether kvm_write_cptr_el2() reformats the sysreg fields
as cpacr_clear_set() does.

In the nVHE/hVHE implementation of __activate_cptr_traps(), placing the
sysreg writes within the if-else blocks requires that the call to
__activate_traps_fpsimd32() is moved earlier, but as this was always
called before writing to CPTR_EL2/CPACR_EL1, this should not result in a
functional change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_emulate.h | 42 ----------------------------
 arch/arm64/kvm/hyp/nvhe/switch.c     | 35 ++++++++++++++++++++---
 arch/arm64/kvm/hyp/vhe/switch.c      | 12 +++++++-
 3 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 47f2cf408eeda..78ec1ef2cfe82 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -605,48 +605,6 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 					 __cpacr_to_cptr_set(clr, set));\
 	} while (0)
 
-static __always_inline void kvm_write_cptr_el2(u64 val)
-{
-	if (has_vhe() || has_hvhe())
-		write_sysreg(val, cpacr_el1);
-	else
-		write_sysreg(val, cptr_el2);
-}
-
-/* Resets the value of cptr_el2 when returning to the host. */
-static __always_inline void __kvm_reset_cptr_el2(struct kvm *kvm)
-{
-	u64 val;
-
-	if (has_vhe()) {
-		val = (CPACR_EL1_FPEN | CPACR_EL1_ZEN_EL1EN);
-		if (cpus_have_final_cap(ARM64_SME))
-			val |= CPACR_EL1_SMEN_EL1EN;
-	} else if (has_hvhe()) {
-		val = CPACR_EL1_FPEN;
-
-		if (!kvm_has_sve(kvm) || !guest_owns_fp_regs())
-			val |= CPACR_EL1_ZEN;
-		if (cpus_have_final_cap(ARM64_SME))
-			val |= CPACR_EL1_SMEN;
-	} else {
-		val = CPTR_NVHE_EL2_RES1;
-
-		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
-			val |= CPTR_EL2_TZ;
-		if (!cpus_have_final_cap(ARM64_SME))
-			val |= CPTR_EL2_TSM;
-	}
-
-	kvm_write_cptr_el2(val);
-}
-
-#ifdef __KVM_NVHE_HYPERVISOR__
-#define kvm_reset_cptr_el2(v)	__kvm_reset_cptr_el2(kern_hyp_va((v)->kvm))
-#else
-#define kvm_reset_cptr_el2(v)	__kvm_reset_cptr_el2((v)->kvm)
-#endif
-
 /*
  * Returns a 'sanitised' view of CPTR_EL2, translating from nVHE to the VHE
  * format if E2H isn't set.
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 7a2d189176249..5d79f63a4f861 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -39,6 +39,9 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
+	if (!guest_owns_fp_regs())
+		__activate_traps_fpsimd32(vcpu);
+
 	if (has_hvhe()) {
 		val |= CPACR_EL1_TTA;
 
@@ -47,6 +50,8 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 			if (vcpu_has_sve(vcpu))
 				val |= CPACR_EL1_ZEN;
 		}
+
+		write_sysreg(val, cpacr_el1);
 	} else {
 		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
 
@@ -61,12 +66,34 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 
 		if (!guest_owns_fp_regs())
 			val |= CPTR_EL2_TFP;
+
+		write_sysreg(val, cptr_el2);
 	}
+}
 
-	if (!guest_owns_fp_regs())
-		__activate_traps_fpsimd32(vcpu);
+static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
 
-	kvm_write_cptr_el2(val);
+	if (has_hvhe()) {
+		u64 val = CPACR_EL1_FPEN;
+
+		if (!kvm_has_sve(kvm) || !guest_owns_fp_regs())
+			val |= CPACR_EL1_ZEN;
+		if (cpus_have_final_cap(ARM64_SME))
+			val |= CPACR_EL1_SMEN;
+
+		write_sysreg(val, cpacr_el1);
+	} else {
+		u64 val = CPTR_NVHE_EL2_RES1;
+
+		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
+			val |= CPTR_EL2_TZ;
+		if (!cpus_have_final_cap(ARM64_SME))
+			val |= CPTR_EL2_TSM;
+
+		write_sysreg(val, cptr_el2);
+	}
 }
 
 static void __activate_traps(struct kvm_vcpu *vcpu)
@@ -119,7 +146,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
-	kvm_reset_cptr_el2(vcpu);
+	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index e8a07d4bb546b..4748b1947ffa0 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -136,6 +136,16 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(val, cpacr_el1);
 }
 
+static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
+{
+	u64 val = CPACR_EL1_FPEN | CPACR_EL1_ZEN_EL1EN;
+
+	if (cpus_have_final_cap(ARM64_SME))
+		val |= CPACR_EL1_SMEN_EL1EN;
+
+	write_sysreg(val, cpacr_el1);
+}
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
@@ -207,7 +217,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 
-	kvm_reset_cptr_el2(vcpu);
+	__deactivate_cptr_traps(vcpu);
 
 	if (!arm64_kernel_unmapped_at_el0())
 		host_vectors = __this_cpu_read(this_cpu_vector);
-- 
2.30.2


