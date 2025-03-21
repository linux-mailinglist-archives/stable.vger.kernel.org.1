Return-Path: <stable+bounces-125714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDEA6B212
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E1B48107D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30091448F2;
	Fri, 21 Mar 2025 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAHPBi+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92C1DFF7;
	Fri, 21 Mar 2025 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516033; cv=none; b=r5EbW0PKgjXo3YMLDgYzgwNSYBY1WvrZymymsoZ9aAPHekE08pRut51Hh2/Qbxr+TsvtCpAuZ2GjDvq8bKphqI8zpS97wgdRn2sJQcFL4JggZjIk/XKL1mojfVqnE/dxVIi4XobwTzWKg6/4EgpmJ7xidCdmtd2mPPnEwywSrSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516033; c=relaxed/simple;
	bh=TxL5oq+g4aisEn0NzMv/yMWV2fn7uSYmXwefFCudbjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IM9l2poy35yXcx84i7OoAqF3H107ynilhgg59WKT5MkLXvl3oqVfPerkkWrN38qy+YV6+EVG8Cu/BsZApSBLDdUi3PoJFJgIM6ET5Z2UXbcWvy1jFovzwpaGMcEdLCvYD3be+j+r+D300i7mbuai7R7Y/pYx9f31GO/9sDFybb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAHPBi+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77963C4CEED;
	Fri, 21 Mar 2025 00:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742516033;
	bh=TxL5oq+g4aisEn0NzMv/yMWV2fn7uSYmXwefFCudbjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fAHPBi+7L74IWJYC79endkEBXJZnGGQB2vzjjYqJIsOZdq2/jzowmNo0iRFPVGZEN
	 mA9F05Fcvodkw58kCobEu9BGcdwvNz4SxHH9+VeWAxdTekkw0b2rcBKKtKoLm71FTd
	 yQVt1qPm9KvoEv6oiT+ErfQYK2CLPswN1EvKrzPFxUqa6X6xhuEyMrhVZ5er3SXhCg
	 cGh1n5z6gfh1yvSuYRvtqcNOEdLvJUBQDNbZSOk+HfnW0ZbFud28Gomnz59Yza9apb
	 mlIgznEiW13ZShv3q3sKhQA45CU4HmZNO+36i52pYrwZW4EIk0P8agWoyRo4Vj83e5
	 fnIUnyGPy6Vvw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 21 Mar 2025 00:13:04 +0000
Subject: [PATCH 6.12 v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-stable-sve-6-12-v2-8-417ca2278d18@kernel.org>
References: <20250321-stable-sve-6-12-v2-0-417ca2278d18@kernel.org>
In-Reply-To: <20250321-stable-sve-6-12-v2-0-417ca2278d18@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=11549; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HToMeE+PHYgE/dGsLaSmZ5TLR8LKg8yZLMm+x3ahetc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn3K8jWkjGaBfSpfdzk1MuVCgH1BMIJ/FwhYO7DiSg
 cVZT2byJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ9yvIwAKCRAk1otyXVSH0LxBB/
 4p/J/Tq9YuuYSehx/3aDgyV0FZGMuW0sGP/Ej0G1bIh1bU0z6Cp1nW/b7YVSMB7TP8mnfT3DEe0pYF
 PE0tA7je0GUHahHk+w2OOojk+P1JImVdrsU/Rzp1iAnrPtFf4rcducjCiEk1Qtg0o797+kl0wRdghL
 je2QkbuVsxWnn3CCbsZQAMtsPttAUG7KUoCPJo26dML+50OZAYIBsPIpbFrEI1eRl/NvcDjqoqik/S
 XMInhLKwMnTHkYybJOu2/BAt4YDyYc7+9e0x6/3Zd6IhrhZ4jn5vB6b6oXJVr8W14lr+0lioh5RTIf
 9tt5YhlkNZM/0RQXykH5xv9guEXMZf
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/fpsimd.c                 | 30 -----------------
 arch/arm64/kvm/hyp/entry.S              |  5 +++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 59 +++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  9 ++---
 arch/arm64/kvm/hyp/nvhe/switch.c        | 33 +++++++++++++++---
 arch/arm64/kvm/hyp/vhe/switch.c         |  4 +++
 6 files changed, 100 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index f64724197958e0d8a4ec17deb1f9826ce3625eb7..3cbb999419af7bb31ce9cec2baafcad00491610a 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -136,36 +136,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 	local_irq_save(flags);
 
 	if (guest_owns_fp_regs()) {
-		if (vcpu_has_sve(vcpu)) {
-			u64 zcr = read_sysreg_el1(SYS_ZCR);
-
-			/*
-			 * If the vCPU is in the hyp context then ZCR_EL1 is
-			 * loaded with its vEL2 counterpart.
-			 */
-			__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr;
-
-			/*
-			 * Restore the VL that was saved when bound to the CPU,
-			 * which is the maximum VL for the guest. Because the
-			 * layout of the data when saving the sve state depends
-			 * on the VL, we need to use a consistent (i.e., the
-			 * maximum) VL.
-			 * Note that this means that at guest exit ZCR_EL1 is
-			 * not necessarily the same as on guest entry.
-			 *
-			 * ZCR_EL2 holds the guest hypervisor's VL when running
-			 * a nested guest, which could be smaller than the
-			 * max for the vCPU. Similar to above, we first need to
-			 * switch to a VL consistent with the layout of the
-			 * vCPU's SVE state. KVM support for NV implies VHE, so
-			 * using the ZCR_EL1 alias is safe.
-			 */
-			if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
-				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
-						       SYS_ZCR_EL1);
-		}
-
 		/*
 		 * Flush (save and invalidate) the fpsimd/sve state so that if
 		 * the host tries to use fpsimd/sve, it's not using stale data
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 4433a234aa9ba242f43b943d22011b5ddacd8af7..9f4e8d68ab505cf4a7aa8673643d9b47ca1bc7cb 100644
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
index c1ab31429a0e5fab97cd06c3b7b6e378170bd99d..cc9cb63959463a7ddb35d868b17e485b1223d507 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -344,6 +344,65 @@ static inline void __hyp_sve_save_host(void)
 			 true);
 }
 
+static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs())
+		return;
+
+	if (vcpu_has_sve(vcpu)) {
+		/* A guest hypervisor may restrict the effective max VL. */
+		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
+			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
+		else
+			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
+		write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+		zcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu));
+		write_sysreg_el1(zcr_el1, SYS_ZCR);
+	}
+}
+
+static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs())
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
+		__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr_el1;
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
 static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 {
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 4e757a77322c9efc59cdff501745f7c80d452358..75f7e386de75bc3d329a0e94ca50a043813979fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -5,6 +5,7 @@
  */
 
 #include <hyp/adjust_pc.h>
+#include <hyp/switch.h>
 
 #include <asm/pgtable-types.h>
 #include <asm/kvm_asm.h>
@@ -177,7 +178,9 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 		pkvm_put_hyp_vcpu(hyp_vcpu);
 	} else {
 		/* The host is fully trusted, run its vCPU directly. */
+		fpsimd_lazy_switch_to_guest(host_vcpu);
 		ret = __kvm_vcpu_run(host_vcpu);
+		fpsimd_lazy_switch_to_host(host_vcpu);
 	}
 
 out:
@@ -486,12 +489,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_SMC64:
 		handle_host_smc(host_ctxt);
 		break;
-	case ESR_ELx_EC_SVE:
-		cpacr_clear_set(0, CPACR_ELx_ZEN);
-		isb();
-		sve_cond_update_zcr_vq(sve_vq_from_vl(kvm_host_sve_max_vl) - 1,
-				       SYS_ZCR_EL2);
-		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
 		handle_host_mem_abort(host_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index ee74006c47bc44ca1d9bdf1ce7d4d8a41cf8e494..a1245fa838319544f3770a05a58eeed5233f0324 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -40,6 +40,9 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
+	if (!guest_owns_fp_regs())
+		__activate_traps_fpsimd32(vcpu);
+
 	if (has_hvhe()) {
 		val |= CPACR_ELx_TTA;
 
@@ -48,6 +51,8 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 			if (vcpu_has_sve(vcpu))
 				val |= CPACR_ELx_ZEN;
 		}
+
+		write_sysreg(val, cpacr_el1);
 	} else {
 		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
 
@@ -62,12 +67,32 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 
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
+	if (has_hvhe()) {
+		u64 val = CPACR_ELx_FPEN;
+
+		if (cpus_have_final_cap(ARM64_SVE))
+			val |= CPACR_ELx_ZEN;
+		if (cpus_have_final_cap(ARM64_SME))
+			val |= CPACR_ELx_SMEN;
+
+		write_sysreg(val, cpacr_el1);
+	} else {
+		u64 val = CPTR_NVHE_EL2_RES1;
+
+		if (!cpus_have_final_cap(ARM64_SVE))
+			val |= CPTR_EL2_TZ;
+		if (!cpus_have_final_cap(ARM64_SME))
+			val |= CPTR_EL2_TSM;
 
-	kvm_write_cptr_el2(val);
+		write_sysreg(val, cptr_el2);
+	}
 }
 
 static void __activate_traps(struct kvm_vcpu *vcpu)
@@ -120,7 +145,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
-	kvm_reset_cptr_el2(vcpu);
+	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 46c1f5caf007331cdbbc806a184e9b4721042fc0..496abfd3646b9858e95e06a79edec11eee3a5893 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -462,6 +462,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	fpsimd_lazy_switch_to_guest(vcpu);
+
 	/*
 	 * Note that ARM erratum 1165522 requires us to configure both stage 1
 	 * and stage 2 translation for the guest context before we clear
@@ -486,6 +488,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__deactivate_traps(vcpu);
 
+	fpsimd_lazy_switch_to_host(vcpu);
+
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	if (guest_owns_fp_regs())

-- 
2.39.5


