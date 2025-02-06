Return-Path: <stable+bounces-114100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81AEA2AACC
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88093A3594
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C51C6FFF;
	Thu,  6 Feb 2025 14:11:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDF1EA7FD
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851105; cv=none; b=t5zk5xlqFsrixImbanWgootX5Kuytc35ZJfnxAH/9lvyOCvIXVId8iqZiu3uDVpvjghyK1grCf3Tt4daLNuAoV0rfxM7FfosPrQyZouWhFyLms8lu4Ozu4CTfsPL/tnx6NVi5vdjgt2eT5gahqk8g7oFA6kqTMDLl61mbccbV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851105; c=relaxed/simple;
	bh=Q6WellG5OsRcNoc4tJVQHaBZ5jItB3kpQgyA/fCvSwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dUA8LjyHfBT4h/MouXvYlySl18EAX3v6eYn7r88UP+u2k+z5UN3jq/uFq0oNAA38CalNDXf6M2+Bcb3h1UCpSMGc+V4j4wKQjlEeD4fimkSjtgK2+rtf17zmjVkF7m5O8ioD4glCCzt/wVZ9jDcEQq71/LuGBWhmFaRLZtNTc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7FD31063;
	Thu,  6 Feb 2025 06:12:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED1383F63F;
	Thu,  6 Feb 2025 06:11:40 -0800 (PST)
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
Subject: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Thu,  6 Feb 2025 14:11:02 +0000
Message-Id: <20250206141102.954688-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250206141102.954688-1-mark.rutland@arm.com>
References: <20250206141102.954688-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
happening, there's no need to trap host SVE usage, and the nVHE/nVHVE
__deactivate_cptr_traps() logic can be simplified enable host access to
all present FPSIMD/SVE/SME features.

In protected nVHE/hVHVE modes, the host's state is always saved/restored
by hyp, and the guest's state is saved prior to exit to the host, so
from the host's PoV the guest never has live FPSIMD/SVE/SME state, and
the host's ZCR_EL1 is never clobbered by hyp.

Fixes: 8c8010d69c132273 ("KVM: arm64: Save/restore SVE state for nVHE")
Fixes: 2e3cf82063a00ea0 ("KVM: arm64: nv: Ensure correct VL is loaded before saving SVE state")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/fpsimd.c                 | 30 ---------------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 51 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 13 +++----
 arch/arm64/kvm/hyp/nvhe/switch.c        |  6 +--
 arch/arm64/kvm/hyp/vhe/switch.c         |  4 ++
 5 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index f64724197958e..3cbb999419af7 100644
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
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 163867f7f7c52..bbec7cd38da33 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -375,6 +375,57 @@ static inline void __hyp_sve_save_host(void)
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
index ad1abd5493862..0c745a578aa7e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -5,6 +5,7 @@
  */
 
 #include <hyp/adjust_pc.h>
+#include <hyp/switch.h>
 
 #include <asm/pgtable-types.h>
 #include <asm/kvm_asm.h>
@@ -200,8 +201,12 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 
 		sync_hyp_vcpu(hyp_vcpu);
 	} else {
+		struct kvm_vcpu *vcpu = kern_hyp_va(host_vcpu);
+
 		/* The host is fully trusted, run its vCPU directly. */
-		ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));
+		fpsimd_lazy_switch_to_guest(vcpu);
+		ret = __kvm_vcpu_run(vcpu);
+		fpsimd_lazy_switch_to_host(vcpu);
 	}
 out:
 	cpu_reg(host_ctxt, 1) =  ret;
@@ -651,12 +656,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_SMC64:
 		handle_host_smc(host_ctxt);
 		break;
-	case ESR_ELx_EC_SVE:
-		cpacr_clear_set(0, CPACR_EL1_ZEN);
-		isb();
-		sve_cond_update_zcr_vq(sve_vq_from_vl(kvm_host_sve_max_vl) - 1,
-				       SYS_ZCR_EL2);
-		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
 		handle_host_mem_abort(host_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 324b62329c10b..eaeda9c8a1aa6 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -73,12 +73,10 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 
 static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
-
 	if (has_hvhe()) {
 		u64 val = CPACR_EL1_FPEN;
 
-		if (!kvm_has_sve(kvm) || !guest_owns_fp_regs())
+		if (cpus_have_final_cap(ARM64_SVE))
 			val |= CPACR_EL1_ZEN;
 		if (cpus_have_final_cap(ARM64_SME))
 			val |= CPACR_EL1_SMEN;
@@ -87,7 +85,7 @@ static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
 	} else {
 		u64 val = CPTR_NVHE_EL2_RES1;
 
-		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
+		if (!cpus_have_final_cap(ARM64_SVE))
 			val |= CPTR_EL2_TZ;
 		if (!cpus_have_final_cap(ARM64_SME))
 			val |= CPTR_EL2_TSM;
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index c854d84458892..647737d6e8d0b 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -579,6 +579,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	fpsimd_lazy_switch_to_guest(vcpu);
+
 	/*
 	 * Note that ARM erratum 1165522 requires us to configure both stage 1
 	 * and stage 2 translation for the guest context before we clear
@@ -603,6 +605,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__deactivate_traps(vcpu);
 
+	fpsimd_lazy_switch_to_host(vcpu);
+
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	if (guest_owns_fp_regs())
-- 
2.30.2


