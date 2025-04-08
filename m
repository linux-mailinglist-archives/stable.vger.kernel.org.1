Return-Path: <stable+bounces-131836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A42A8149A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5573D7AD87B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A99254B1F;
	Tue,  8 Apr 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCXtcD3G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C38241685;
	Tue,  8 Apr 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136572; cv=none; b=iRK9v9UCY3U7dVYM2OMRGZqsggLu6Wcbo7igthZtJ3ECxPJ+GGR8OrArSkMfAOP4ljFFNx/boWinItn5IzPUP7xtmsa25f+WznICwrb4WTg8TbUWcmZOPAF1uqwk/qF7RyN3jcb11B0OqBsrphsfz5E88TWukKx6ZU5QHmt0XIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136572; c=relaxed/simple;
	bh=ZKoFePMNCshD50hjfLmDWFxIxGgrZ+11urqHkfqB0ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oF3+PvTQ4U4yCDUDLa1CEvrw6mE2/wwW5v8AzfI3Ld1dUUiMujuoWSzFfUyyTl8y4eoM8VBjc+nCgv2xK3r+PrImOz4OpVKLFi7foFtrTiJFfMNY67r2IDL3jQ722rkX42rY/lpx1wDG9D+xKnsGDrm+e+hFwNXJuyrKMWMX65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCXtcD3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD090C4CEEA;
	Tue,  8 Apr 2025 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744136572;
	bh=ZKoFePMNCshD50hjfLmDWFxIxGgrZ+11urqHkfqB0ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCXtcD3G3j7+yFsCuOS+1YSIUnuZ0nOyBKBF4D85HA4+I7qggig6kqxhrtONYdwib
	 iSq0iXY/TtVxjmDMtpIpuBCliYwryNbGJIhmeS1j1pytFH2RQns56slF8LfIk2B36j
	 xjoSw9tsIDftPb/fjwOxTCfkYBXSVB7AeZaB/SKKsLUabm0fEaufuQOnE9hw/YOn/v
	 NyOWVe/Px4kK1FmV2byxJngwDz3DJrhkpc0/hgaxlTdh37Qkkp/ncSi7Soa9TnqEF3
	 7D/KZWUft7sZjujSVvVz9fmyfDjQj5p8j7zX/5mKf9GRMScLQOP88In+5ptMj/2fgZ
	 H7YVmCuLBwANg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:10:06 +0100
Subject: [PATCH 5.15 v3 11/11] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-stable-sve-5-15-v3-11-ca9a6b850f55@kernel.org>
References: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
In-Reply-To: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9WlU3O1zh0SLnOtRX3lUXawZU1keWZGORZ6IEWWG
 RdMizqaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/VpVAAKCRAk1otyXVSH0MBXB/
 9Pr2PVDFCO5zr29dgVZ/Ly5HFO/ZZhlLXU/a6/JEKqziAg7VeOm0tukoosG+Te1HUw8LrgWiOHnPAL
 5QietVair/am1og5J2T0PxNiflL6DjLsKFChZK/HpNZPHqgduCZWjeiUpARp2JGoSCBI7/S3QxpyCa
 NS5RhT6TFZWcOWsgf88HwQgoR1E5U/uFcobPdL225b2QjRdQFMHm+FiNBM5RomgFOvakhFcqAHAhH+
 ASu65ADufKsEO+R1ujRLsqlB6pa3rNUUk5ENFnoOCwFIIz3BTCLmXt7glo+7i2gCy6+9APd6dzGc5x
 mpN4FwdK10CgIdezGZKij2mkIL3le1
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


