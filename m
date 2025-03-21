Return-Path: <stable+bounces-125699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB7A6B1F2
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9497948811F
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933833FE;
	Fri, 21 Mar 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGuqgGgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538B1CF8B;
	Fri, 21 Mar 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515846; cv=none; b=j6R3SCZeX/45G41WHM6SFUzy5T07ddWepjFf9hTGF16nodWflVjWIcHMg4l6s9koTwuhNAQ0wsmEiBQTmC7xzCYKad56QDzQ25cUiidYYqSsOwm1NDOVh5Jaxd3MsATDyfPLgDVUO1TT9T0Uj01LPgq9nwdRVfnVzcIEIrCzBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515846; c=relaxed/simple;
	bh=tOwLNJGuoclDCJFfIwBo5Rq9l6EWSbzQnW22bOhJ3Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUz24CJefCvLbdXCtlH6kw661qVpf35j/mzIXe6689nD/RXuMrnUP9ame7D3hX6huRM+ToaiCLvP8FnsnF4r1HA7B3X0e5+bXwQp+PakEWyXIRfsrnlsUtj/LEnRXHoyXorjcaoj3PIKADfetn16H2PWMVMhOQlqWBgcjA7HCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGuqgGgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A02C4CEEF;
	Fri, 21 Mar 2025 00:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742515845;
	bh=tOwLNJGuoclDCJFfIwBo5Rq9l6EWSbzQnW22bOhJ3Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XGuqgGgDOlE286mGiglg3vUXMyt4eeuVxhQ0kuDDCuXNzscml4QPHkYHns0ZfLX3L
	 S+SP4qUsWMxA4wvTxLAxTfagz0R6pSzAzg/WJQLl4yLihMpbu2QKO1JXPJYhGnmJso
	 jGWQia0tDOLRAuQ31WRxiMre3axQO3F+Vc5pi83powignDMUK3CnSWWqlHsh80dcVy
	 lrBP1gaodHGGagSnXIBw+qSh4n66zvJxqF7HhE7EBPrv4PIM/lCXHt43ViVRNUaaxF
	 gLH5vzvY7RMYkHGsg8L7ljep5iBZyGIFnLGRoxHBxmF0TPweR+0UoU/8Dm/OPnSNU+
	 +xDfinuBp1aOA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 21 Mar 2025 00:10:11 +0000
Subject: [PATCH 6.13 v2 2/8] KVM: arm64: Unconditionally save+flush host
 FPSIMD/SVE/SME state
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-stable-sve-6-13-v2-2-3150e3370c40@kernel.org>
References: <20250321-stable-sve-6-13-v2-0-3150e3370c40@kernel.org>
In-Reply-To: <20250321-stable-sve-6-13-v2-0-3150e3370c40@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Eric Auger <eauger@redhat.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Eric Auger <eric.auger@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Fuad Tabba <tabba@google.com>, Jeremy Linton <jeremy.linton@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=6408; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eSs9USTWP3aXbjRozqprmSkIPf1vVJd8O/dZ9UErDyY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn3K51FCNdGIGP+WXASgka+q+T/2muoEvjkSPoePI0
 fDl2ccuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ9yudQAKCRAk1otyXVSH0DMaB/
 0SxDQipABMl5eULsHIxxm8arQweejFHElMfImNdrCxwK1HLOzSbbtRkVk10grSljo0qvpNGfGU9mIj
 t80fRc25+KoMM/op1GjagPiBsvi8YmdyOS0wMyxGqp087U0+GpPSagKItMR0J5a86gZvtK5Lmgo/3/
 UFDUVS+AZDr3EmJGbUe6j8DmlvWGfx4JEg9gUjKm1dpRvIbNwlmZdZhCgxbt1S//52zhBvAqHB6yUp
 PN9iVR41dPT31PeOB5eJ3YekxAEajYlc7pCmYDubZa0z6TjJW7fFrfSdUNoF09Mf+K2CVuSa2WF8/Z
 zRWR2pbSrKoTndf1aHnT0SIjJ/TfKi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit fbc7e61195e23f744814e78524b73b59faa54ab4 ]

There are several problems with the way hyp code lazily saves the host's
FPSIMD/SVE state, including:

* Host SVE being discarded unexpectedly due to inconsistent
  configuration of TIF_SVE and CPACR_ELx.ZEN. This has been seen to
  result in QEMU crashes where SVE is used by memmove(), as reported by
  Eric Auger:

  https://issues.redhat.com/browse/RHEL-68997

* Host SVE state is discarded *after* modification by ptrace, which was an
  unintentional ptrace ABI change introduced with lazy discarding of SVE state.

* The host FPMR value can be discarded when running a non-protected VM,
  where FPMR support is not exposed to a VM, and that VM uses
  FPSIMD/SVE. In these cases the hyp code does not save the host's FPMR
  before unbinding the host's FPSIMD/SVE/SME state, leaving a stale
  value in memory.

Avoid these by eagerly saving and "flushing" the host's FPSIMD/SVE/SME
state when loading a vCPU such that KVM does not need to save any of the
host's FPSIMD/SVE/SME state. For clarity, fpsimd_kvm_prepare() is
removed and the necessary call to fpsimd_save_and_flush_cpu_state() is
placed in kvm_arch_vcpu_load_fp(). As 'fpsimd_state' and 'fpmr_ptr'
should not be used, they are set to NULL; all uses of these will be
removed in subsequent patches.

Historical problems go back at least as far as v5.17, e.g. erroneous
assumptions about TIF_SVE being clear in commit:

  8383741ab2e773a9 ("KVM: arm64: Get rid of host SVE tracking/saving")

... and so this eager save+flush probably needs to be backported to ALL
stable trees.

Fixes: 93ae6b01bafee8fa ("KVM: arm64: Discard any SVE state when entering KVM guests")
Fixes: 8c845e2731041f0f ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
Fixes: ef3be86021c3bdf3 ("KVM: arm64: Add save/restore support for FPMR")
Reported-by: Eric Auger <eauger@redhat.com>
Reported-by: Wilco Dijkstra <wilco.dijkstra@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250210195226.1215254-2-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ Mark: Handle vcpu/host flag conflict ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 25 -------------------------
 arch/arm64/kvm/fpsimd.c    | 35 ++++++++++-------------------------
 2 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8c4c1a2186cc510a7826d15ec36225857c07ed71..ec68d520b7ca70e7395bab4bc78fc9a7405d6b92 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1694,31 +1694,6 @@ void fpsimd_signal_preserve_current_state(void)
 		sve_to_fpsimd(current);
 }
 
-/*
- * Called by KVM when entering the guest.
- */
-void fpsimd_kvm_prepare(void)
-{
-	if (!system_supports_sve())
-		return;
-
-	/*
-	 * KVM does not save host SVE state since we can only enter
-	 * the guest from a syscall so the ABI means that only the
-	 * non-saved SVE state needs to be saved.  If we have left
-	 * SVE enabled for performance reasons then update the task
-	 * state to be FPSIMD only.
-	 */
-	get_cpu_fpsimd_context();
-
-	if (test_and_clear_thread_flag(TIF_SVE)) {
-		sve_to_fpsimd(current);
-		current->thread.fp_type = FP_STATE_FPSIMD;
-	}
-
-	put_cpu_fpsimd_context();
-}
-
 /*
  * Associate current's FPSIMD context with this cpu
  * The caller must have ownership of the cpu FPSIMD context before calling
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index ea5484ce1f3ba3121b6938bda15f7a8057d49051..efb54ed60fe1d1d8a904b10a4a4bd3c820d9dac5 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -54,16 +54,18 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	if (!system_supports_fpsimd())
 		return;
 
-	fpsimd_kvm_prepare();
-
 	/*
-	 * We will check TIF_FOREIGN_FPSTATE just before entering the
-	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
-	 * FP_STATE_FREE if the flag set.
+	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
+	 * that the host kernel is responsible for restoring this state upon
+	 * return to userspace, and the hyp code doesn't need to save anything.
+	 *
+	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
+	 * that PSTATE.{SM,ZA} == {0,0}.
 	 */
-	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
-	*host_data_ptr(fpsimd_state) = kern_hyp_va(&current->thread.uw.fpsimd_state);
-	*host_data_ptr(fpmr_ptr) = kern_hyp_va(&current->thread.uw.fpmr);
+	fpsimd_save_and_flush_cpu_state();
+	*host_data_ptr(fp_owner) = FP_STATE_FREE;
+	*host_data_ptr(fpsimd_state) = NULL;
+	*host_data_ptr(fpmr_ptr) = NULL;
 
 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
@@ -73,23 +75,6 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
 		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
 			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
-
-		/*
-		 * If PSTATE.SM is enabled then save any pending FP
-		 * state and disable PSTATE.SM. If we leave PSTATE.SM
-		 * enabled and the guest does not enable SME via
-		 * CPACR_EL1.SMEN then operations that should be valid
-		 * may generate SME traps from EL1 to EL1 which we
-		 * can't intercept and which would confuse the guest.
-		 *
-		 * Do the same for PSTATE.ZA in the case where there
-		 * is state in the registers which has not already
-		 * been saved, this is very unlikely to happen.
-		 */
-		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
-			*host_data_ptr(fp_owner) = FP_STATE_FREE;
-			fpsimd_save_and_flush_cpu_state();
-		}
 	}
 
 	/*

-- 
2.39.5


