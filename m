Return-Path: <stable+bounces-138391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A33DAA181B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AD49A43F4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F62512D8;
	Tue, 29 Apr 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtoicPBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B092472B9;
	Tue, 29 Apr 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949100; cv=none; b=pp74+wAXzfGvTqbvttSgI9cB6cHyEsBHrFC+/GVjrZ5yFJbCFuU4oBNAFT8tiM3hjaisxMa+0sx2AHOtkm4PG5PdpQfnCak2iCKofrWmFHsp6rbA/OauBzDGiFZXbXKvhyC1JyBHowwv0Pg/0XNnvoye74cA8HDMvJtNK0lMVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949100; c=relaxed/simple;
	bh=i2E0OFkVvFxkhtBYSXmLLwowDE7k5u7bU9NVCAzgKmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkdWZmzSeAyUSEjgcVFvZtwNJinZUYz6RL02YM3A4/uDQ3hc9HnC/d3AXkzkc2OoPoq9bYFT2kIAJv/x7IqoP238jjrdJRcAxWJYjCfRzRbkXYD/D99VnJhBYObZ2TVLL3HFRvm0nHwCayDHNHjrlcACjDo4zen5Jq0w0tnRFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtoicPBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D823AC4CEE3;
	Tue, 29 Apr 2025 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949100;
	bh=i2E0OFkVvFxkhtBYSXmLLwowDE7k5u7bU9NVCAzgKmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtoicPBU67/U7WPu+jIkJ7zXej3AvjORU/9wYt1wofHLHFeqvH7RsVxV1iXTGHeQY
	 YLAAcagrAbKfrnTA0yDoQ+zjpu35luhGxDHr6/T8dcccDiDEACyDUCwRjRT0iFQXwY
	 2MzHEO7OhCN5HywWB1P1bSP+pIwMt9Qror2rsCso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,  linux-kernel@vger.kernel.org, stable@vger.kernel.org,  Mark Brown" <broonie@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 186/373] KVM: arm64: Get rid of host SVE tracking/saving
Date: Tue, 29 Apr 2025 18:41:03 +0200
Message-ID: <20250429161130.810510486@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 8383741ab2e773a992f1f0f8acdca5e7a4687c49 ]

The SVE host tracking in KVM is pretty involved. It relies on a
set of flags tracking the ownership of the SVE register, as well
as that of the EL0 access.

It is also pretty scary: __hyp_sve_save_host() computes
a thread_struct pointer and obtains a sve_state which gets directly
accessed without further ado, even on nVHE. How can this even work?

The answer to that is that it doesn't, and that this is mostly dead
code. Closer examination shows that on executing a syscall, userspace
loses its SVE state entirely. This is part of the ABI. Another
thing to notice is that although the kernel provides helpers such as
kernel_neon_begin()/end(), they only deal with the FP/NEON state,
and not SVE.

Given that you can only execute a guest as the result of a syscall,
and that the kernel cannot use SVE by itself, it becomes pretty
obvious that there is never any host SVE state to save, and that
this code is only there to increase confusion.

Get rid of the TIF_SVE tracking and host save infrastructure altogether.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h       |    1 -
 arch/arm64/kvm/fpsimd.c                 |   20 +++++---------------
 arch/arm64/kvm/hyp/include/hyp/switch.h |   27 +++------------------------
 3 files changed, 8 insertions(+), 40 deletions(-)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -410,7 +410,6 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
 #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
 #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
-#define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
 #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
 #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
 #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -66,22 +66,15 @@ error:
  *
  * Here, we just set the correct metadata to indicate that the FPSIMD
  * state in the cpu regs (if any) belongs to current on the host.
- *
- * TIF_SVE is backed up here, since it may get clobbered with guest state.
- * This flag is restored by kvm_arch_vcpu_put_fp(vcpu).
  */
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(!current->mm);
+	BUG_ON(test_thread_flag(TIF_SVE));
 
-	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
-			      KVM_ARM64_HOST_SVE_IN_USE |
-			      KVM_ARM64_HOST_SVE_ENABLED);
+	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
 
-	if (test_thread_flag(TIF_SVE))
-		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_IN_USE;
-
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
 }
@@ -115,13 +108,11 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
-	bool host_has_sve = system_supports_sve();
-	bool guest_has_sve = vcpu_has_sve(vcpu);
 
 	local_irq_save(flags);
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
-		if (guest_has_sve) {
+		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
 
 			/* Restore the VL that was saved when bound to the CPU */
@@ -131,7 +122,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcp
 		}
 
 		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && host_has_sve) {
+	} else if (has_vhe() && system_supports_sve()) {
 		/*
 		 * The FPSIMD/SVE state in the CPU has not been touched, and we
 		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
@@ -145,8 +136,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcp
 			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
-	update_thread_flag(TIF_SVE,
-			   vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE);
+	update_thread_flag(TIF_SVE, 0);
 
 	local_irq_restore(flags);
 }
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -207,16 +207,6 @@ static inline bool __populate_fault_info
 	return __get_fault_info(esr, &vcpu->arch.fault);
 }
 
-static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
-{
-	struct thread_struct *thread;
-
-	thread = container_of(vcpu->arch.host_fpsimd_state, struct thread_struct,
-			      uw.fpsimd_state);
-
-	__sve_save_state(sve_pffr(thread), &vcpu->arch.host_fpsimd_state->fpsr);
-}
-
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
@@ -228,21 +218,14 @@ static inline void __hyp_sve_restore_gue
 /* Check for an FPSIMD/SVE trap and handle as appropriate */
 static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
-	bool sve_guest, sve_host;
+	bool sve_guest;
 	u8 esr_ec;
 	u64 reg;
 
 	if (!system_supports_fpsimd())
 		return false;
 
-	if (system_supports_sve()) {
-		sve_guest = vcpu_has_sve(vcpu);
-		sve_host = vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE;
-	} else {
-		sve_guest = false;
-		sve_host = false;
-	}
-
+	sve_guest = vcpu_has_sve(vcpu);
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
 	if (esr_ec != ESR_ELx_EC_FP_ASIMD &&
 	    esr_ec != ESR_ELx_EC_SVE)
@@ -269,11 +252,7 @@ static inline bool __hyp_handle_fpsimd(s
 	isb();
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
-		if (sve_host)
-			__hyp_sve_save_host(vcpu);
-		else
-			__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
-
+		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
 		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
 	}
 



