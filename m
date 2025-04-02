Return-Path: <stable+bounces-127463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F9A798BF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F218963E4
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ECE1F78F3;
	Wed,  2 Apr 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGn6XzPx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801491F3B82;
	Wed,  2 Apr 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636093; cv=none; b=qszbiRZYAUQGPBxw75+Qb6w5Psxni9fyrUlVKIAeWTdMgl7BaesM6Cow7fyUjgedXnHiplro7RNHCV/qOIj2S9FjWrmZ31wuc811f3pCMERWnYRUhrWnBdkSDbik5/oqcL2240bjRgYjhvtpuHq6kkboreBlWosAC0P1MoUgEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636093; c=relaxed/simple;
	bh=ZKoFePMNCshD50hjfLmDWFxIxGgrZ+11urqHkfqB0ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIBGmLL0Nq6xMi8B3hb42qGKuxV4dbIOLeCr8fHuQOTUexuL+6rtRbigESGOwDuaesoEMmQn6vSzLtjPP+a7pfdo7gnYgdJZ2v68eVTvjbDZO9aLu/2ueczdcLq3WUbWSjZMJ3oj9JbqymvM2iFF8jNJ1WpXQNj/CRX5dgyXNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGn6XzPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471C3C4CEEA;
	Wed,  2 Apr 2025 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636092;
	bh=ZKoFePMNCshD50hjfLmDWFxIxGgrZ+11urqHkfqB0ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OGn6XzPx4TcwpUs3iN+Md2hSJ2Kl2yl28yMwhsHyjhS5Ao/qCcGPK4yaBW3UKsM5i
	 pRBmMyGqcMNri0y9I/d5AzJb4A6hnxujtAyy33HL3sRth9qURAO/M3EeH7U7uZZpv4
	 Y/GI9xxMcGlxzB7g/wqg20uYrARy0Re3DsdxZ5DAUeJR3jc11zAptvADUp6GHA9D9X
	 3q7NjXOrvhfRZsg3VPjYtGeu67YqB1gLcK3gL6npgZ1BrZ2YS/xYrrpaWClTvRUvyI
	 c7NFrNZmb4jYnzjmPtq7RNJPxlhjIMwmLJTHCrTGVPgdR0q1TtrOmZHA5/tNtmILXi
	 dhyu5HgcAP56g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Apr 2025 00:20:25 +0100
Subject: [PATCH 5.15 v2 10/10] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-stable-sve-5-15-v2-10-30a36a78a20a@kernel.org>
References: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
In-Reply-To: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12846; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6f4SDNyGZNLjxVE6DsFNZSv+dF8z3VxQEDFwAdXgt+k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn7cZTlkQ2EOmbCIh4woiatw9A9PdcFC+tCJFXXZnk
 HqArbLeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+3GUwAKCRAk1otyXVSH0N0dB/
 9LEhebA/h60KA51Q6gMJMvj5iBHX3bGyN2F+oNvJDZRdU6y6DrLwgJtDB1wRwFaFVB9DqrveE4gP5S
 Xty6hgbOhClgMNajmQBI6CeV48h4hWfrVT5hC7NPKYU+lLOGE7s6lpGkfqufjAspjk3m2a+o/7OF0r
 zzu2L7idQqqkbwcGTZ3C4cjpFUwjyIRJRnii30Reuydhp9uDr5XIvXfwmgbSOwQAbmg9ZudN5YWa37
 3lpRj7kIuoXLtgYHGtN2qOcPq1wDM3LNLuVzyIk1OIY0QgOFvMECfW7I5FuBIxgG+ilHiwXc120BDZ
 mK87avWBQ2olDiscKHEjOcJpij/gO2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 59419f10045bc955d2229819c7cf7a8b0b9c5b59 ]

In non-protected KVM modes, while the guest FPSIMD/SVE/SME state is live on the
CPU, the host's active SVE VL may differ from the guest's maximum SVE VL:

* For VHE hosts, when a VM uses NV, ZCR_EL2 contains a value constrained
  by the guest hypervisor, which may be less than or equal to that
  guest's maximum VL.

  Note: in this case the value of ZCR_EL1 is immaterial due to E2H.

* For nVHE/hVHE hosts, ZCR_EL1 contains a value written by the guest,
  which may be less than or greater than the guest's maximum VL.

  Note: in this case hyp code traps host SVE usage and lazily restores
  ZCR_EL2 to the host's maximum VL, which may be greater than the
  guest's maximum VL.

This can be the case between exiting a guest and kvm_arch_vcpu_put_fp().
If a softirq is taken during this period and the softirq handler tries
to use kernel-mode NEON, then the kernel will fail to save the guest's
FPSIMD/SVE state, and will pend a SIGKILL for the current thread.

This happens because kvm_arch_vcpu_ctxsync_fp() binds the guest's live
FPSIMD/SVE state with the guest's maximum SVE VL, and
fpsimd_save_user_state() verifies that the live SVE VL is as expected
before attempting to save the register state:

| if (WARN_ON(sve_get_vl() != vl)) {
|         force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
|         return;
| }

Fix this and make this a bit easier to reason about by always eagerly
switching ZCR_EL{1,2} at hyp during guest<->host transitions. With this
happening, there's no need to trap host SVE usage, and the nVHE/nVHE
__deactivate_cptr_traps() logic can be simplified to enable host access
to all present FPSIMD/SVE/SME features.

In protected nVHE/hVHE modes, the host's state is always saved/restored
by hyp, and the guest's state is saved prior to exit to the host, so
from the host's PoV the guest never has live FPSIMD/SVE/SME state, and
the host's ZCR_EL1 is never clobbered by hyp.

Fixes: 8c8010d69c132273 ("KVM: arm64: Save/restore SVE state for nVHE")
Fixes: 2e3cf82063a00ea0 ("KVM: arm64: nv: Ensure correct VL is loaded before saving SVE state")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250210195226.1215254-9-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ v6.6 lacks pKVM saving of host SVE state, pull in discovery of maximum
  host VL separately -- broonie ]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       |  1 +
 arch/arm64/include/asm/kvm_hyp.h        |  7 +++++
 arch/arm64/kvm/fpsimd.c                 | 19 ++++++------
 arch/arm64/kvm/hyp/entry.S              |  5 +++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 55 +++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  9 +++---
 arch/arm64/kvm/hyp/nvhe/switch.c        | 31 ++++++++++---------
 arch/arm64/kvm/hyp/vhe/switch.c         |  4 +++
 arch/arm64/kvm/reset.c                  |  3 ++
 9 files changed, 106 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2e0952134e2e..6d7b6b5d076d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -64,6 +64,7 @@ enum kvm_mode kvm_get_mode(void);
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern unsigned int kvm_sve_max_vl;
+extern unsigned int kvm_host_sve_max_vl;
 int kvm_arm_init_sve(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 657d0c94cf82..308df86f9a4b 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -117,5 +117,12 @@ void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 
 extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
+extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
+
+static inline bool guest_owns_fp_regs(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.flags & KVM_ARM64_FP_ENABLED;
+}
+
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 1360ddd4137b..cfda503c8b3f 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -129,15 +129,16 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 	local_irq_save(flags);
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
-		if (vcpu_has_sve(vcpu)) {
-			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-
-			/* Restore the VL that was saved when bound to the CPU */
-			if (!has_vhe())
-				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
-						       SYS_ZCR_EL1);
-		}
-
+		/*
+		 * Flush (save and invalidate) the fpsimd/sve state so that if
+		 * the host tries to use fpsimd/sve, it's not using stale data
+		 * from the guest.
+		 *
+		 * Flushing the state sets the TIF_FOREIGN_FPSTATE bit for the
+		 * context unconditionally, in both nVHE and VHE. This allows
+		 * the kernel to restore the fpsimd/sve state, including ZCR_EL1
+		 * when needed.
+		 */
 		fpsimd_save_and_flush_cpu_state();
 	}
 
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 435346ea1504..d8c94c45cb2f 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -44,6 +44,11 @@ alternative_if ARM64_HAS_RAS_EXTN
 alternative_else_nop_endif
 	mrs	x1, isr_el1
 	cbz	x1,  1f
+
+	// Ensure that __guest_enter() always provides a context
+	// synchronization event so that callers don't need ISBs for anything
+	// that would usually be synchonized by the ERET.
+	isb
 	mov	x0, #ARM_EXCEPTION_IRQ
 	ret
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index cc102e46b0e2..797544662a95 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -215,6 +215,61 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
 }
 
+static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs(vcpu))
+		return;
+
+	if (vcpu_has_sve(vcpu)) {
+		zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
+		write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+		zcr_el1 = __vcpu_sys_reg(vcpu, ZCR_EL1);
+		write_sysreg_el1(zcr_el1, SYS_ZCR);
+	}
+}
+
+static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs(vcpu))
+		return;
+
+	/*
+	 * When the guest owns the FP regs, we know that guest+hyp traps for
+	 * any FPSIMD/SVE/SME features exposed to the guest have been disabled
+	 * by either fpsimd_lazy_switch_to_guest() or kvm_hyp_handle_fpsimd()
+	 * prior to __guest_entry(). As __guest_entry() guarantees a context
+	 * synchronization event, we don't need an ISB here to avoid taking
+	 * traps for anything that was exposed to the guest.
+	 */
+	if (vcpu_has_sve(vcpu)) {
+		zcr_el1 = read_sysreg_el1(SYS_ZCR);
+		__vcpu_sys_reg(vcpu, ZCR_EL1) = zcr_el1;
+
+		/*
+		 * The guest's state is always saved using the guest's max VL.
+		 * Ensure that the host has the guest's max VL active such that
+		 * the host can save the guest's state lazily, but don't
+		 * artificially restrict the host to the guest's max VL.
+		 */
+		if (has_vhe()) {
+			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el2(zcr_el2, SYS_ZCR);
+		} else {
+			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
+			write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el1(zcr_el1, SYS_ZCR);
+		}
+	}
+}
+
 /* Check for an FPSIMD/SVE trap and handle as appropriate */
 static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2da6aa8da868..a446883d5b9a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -19,13 +19,17 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+unsigned int kvm_host_sve_max_vl;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
 
+	fpsimd_lazy_switch_to_guest(kern_hyp_va(vcpu));
 	cpu_reg(host_ctxt, 1) =  __kvm_vcpu_run(kern_hyp_va(vcpu));
+	fpsimd_lazy_switch_to_host(kern_hyp_va(vcpu));
 }
 
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
@@ -237,11 +241,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_SMC64:
 		handle_host_smc(host_ctxt);
 		break;
-	case ESR_ELx_EC_SVE:
-		sysreg_clear_set(cptr_el2, CPTR_EL2_TZ, 0);
-		isb();
-		sve_cond_update_zcr_vq(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
-		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
 		handle_host_mem_abort(host_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c0885197f2a5..fff7491d8351 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,15 +34,13 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static bool guest_owns_fp_regs(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.flags & KVM_ARM64_FP_ENABLED;
-}
-
 static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
+	if (!guest_owns_fp_regs(vcpu))
+		__activate_traps_fpsimd32(vcpu);
+
 	/* !hVHE case upstream */
 	if (1) {
 		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
@@ -52,12 +50,22 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 
 		if (!guest_owns_fp_regs(vcpu))
 			val |= CPTR_EL2_TFP;
+
+		write_sysreg(val, cptr_el2);
 	}
+}
 
-	if (!guest_owns_fp_regs(vcpu))
-		__activate_traps_fpsimd32(vcpu);
+static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
+{
+	/* !hVHE case upstream */
+	if (1) {
+		u64 val = CPTR_NVHE_EL2_RES1;
 
-	write_sysreg(val, cptr_el2);
+		if (!cpus_have_final_cap(ARM64_SVE))
+			val |= CPTR_EL2_TZ;
+
+		write_sysreg(val, cptr_el2);
+	}
 }
 
 static void __activate_traps(struct kvm_vcpu *vcpu)
@@ -86,7 +94,6 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 static void __deactivate_traps(struct kvm_vcpu *vcpu)
 {
 	extern char __kvm_hyp_host_vector[];
-	u64 cptr;
 
 	___deactivate_traps(vcpu);
 
@@ -111,11 +118,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
-	cptr = CPTR_EL2_DEFAULT;
-	if (vcpu_has_sve(vcpu) && (vcpu->arch.flags & KVM_ARM64_FP_ENABLED))
-		cptr |= CPTR_EL2_TZ;
-
-	write_sysreg(cptr, cptr_el2);
+	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 813e6e2178c1..d8a8628a9d70 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -114,6 +114,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	fpsimd_lazy_switch_to_guest(vcpu);
+
 	/*
 	 * ARM erratum 1165522 requires us to configure both stage 1 and
 	 * stage 2 translation for the guest context before we clear
@@ -144,6 +146,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__deactivate_traps(vcpu);
 
+	fpsimd_lazy_switch_to_host(vcpu);
+
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0a3343..deb205638279 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -42,11 +42,14 @@ static u32 kvm_ipa_limit;
 				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
 
 unsigned int kvm_sve_max_vl;
+unsigned int kvm_host_sve_max_vl;
 
 int kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
 		kvm_sve_max_vl = sve_max_virtualisable_vl;
+		kvm_host_sve_max_vl = sve_max_vl;
+		kvm_nvhe_sym(kvm_host_sve_max_vl) = kvm_host_sve_max_vl;
 
 		/*
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need

-- 
2.39.5


