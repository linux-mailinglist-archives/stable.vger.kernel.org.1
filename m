Return-Path: <stable+bounces-169489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB9B25948
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B2A887F3A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4967230BCB;
	Thu, 14 Aug 2025 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5J/Yiks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459414E2E2
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136092; cv=none; b=jFn5ikytVk2Gro6T8q7J9xwD5r/F5XIe46+Sf//D36//j0VbFwLU+pNK7wEi9Kx5xTZGXmf7KsWDmWfhnhGt6F7TMNMGSQ1tacR+pHETm9bp1H4dKLXewYPhari5GYYcscqUletVa+x4S7BVu36cdl1aZ5reh/oMDqPZpijad5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136092; c=relaxed/simple;
	bh=hkrydW/BcIM0BQbS4BruH65XbFLMmCdvs7IwXiCT+M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvoUUQrdu0TIslhntqz8y936E/PPQMEZMh26lDhHZY8c1EQC+kM3PawQM3MvlHKYjIeyIClCTb10DL+jZ6zxsTIJaWmWU4ryi9Ywsb0t555qVHQl90FITvxFui6l8e3taL4v/Xdp+3MNtAKc7TsXHx9xMw6nw8dgHD/mrbDMaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5J/Yiks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9998CC4CEEB;
	Thu, 14 Aug 2025 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755136091;
	bh=hkrydW/BcIM0BQbS4BruH65XbFLMmCdvs7IwXiCT+M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5J/YiksCFwSCFFkkgxc5+9CCSvn0K/kGalyfPxUrJfPJWVVNy1a7Z9ahov6asvrW
	 ed2Al2O+Fp3UwZrgFKBDgAkr6E5wO3xEdrPcfafs+nongQUqItgf1FqVnEArOr6XIi
	 1p2mg5zzh1evq2iOVAPQ9uyL0gU9wuEFTRwv1cz76MHfLnCxKOEPd6hiaUUhg5F8oV
	 38CXdXF3L5QBtGWM9rKmM0RzOTdmvBKK2B/USGBCvZu8amNbLU0O8GGlZKMRr8t+8T
	 5uL1elJrTcskqcEplvKaHn3269CZZnOrsBLLDSiiTmmkQz8gLOhIw/ZV/C0B/PKOgW
	 dGW/pSUh3z3eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
Date: Wed, 13 Aug 2025 21:48:06 -0400
Message-Id: <20250814014806.2082726-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814014806.2082726-1-sashal@kernel.org>
References: <2025081208-gerbil-shelve-9cc8@gregkh>
 <20250814014806.2082726-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Levitsky <mlevitsk@redhat.com>

[ Upstream commit 7d0cce6cbe71af6e9c1831bff101a2b9c249c4a2 ]

Introduce vmx_guest_debugctl_{read,write}() to handle all accesses to
vmcs.GUEST_IA32_DEBUGCTL. This will allow stuffing FREEZE_IN_SMM into
GUEST_IA32_DEBUGCTL based on the host setting without bleeding the state
into the guest, and without needing to copy+paste the FREEZE_IN_SMM
logic into every patch that accesses GUEST_IA32_DEBUGCTL.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[sean: massage changelog, make inline, use in all prepare_vmcs02() cases]
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250610232010.162191-8-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c    | 10 +++++-----
 arch/x86/kvm/vmx/pmu_intel.c |  8 ++++----
 arch/x86/kvm/vmx/vmx.c       |  8 +++++---
 arch/x86/kvm/vmx/vmx.h       | 10 ++++++++++
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1b8b0642fc2d..ef20184b8b11 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2663,11 +2663,11 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl &
-						  vmx_get_supported_debugctl(vcpu, false));
+		vmx_guest_debugctl_write(vcpu, vmcs12->guest_ia32_debugctl &
+					       vmx_get_supported_debugctl(vcpu, false));
 	} else {
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.pre_vmenter_debugctl);
+		vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);
 	}
 	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
@@ -3532,7 +3532,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
-		vmx->nested.pre_vmenter_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
 	if (kvm_mpx_supported() &&
 	    (!vmx->nested.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
@@ -4806,7 +4806,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	__vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
 
 	kvm_set_dr(vcpu, 7, 0x400);
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+	vmx_guest_debugctl_write(vcpu, 0);
 
 	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
 				vmcs12->vm_exit_msr_load_count))
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bbf4509f32d0..0b173602821b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -653,11 +653,11 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
  */
 static void intel_pmu_legacy_freezing_lbrs_on_pmi(struct kvm_vcpu *vcpu)
 {
-	u64 data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+	u64 data = vmx_guest_debugctl_read();
 
 	if (data & DEBUGCTLMSR_FREEZE_LBRS_ON_PMI) {
 		data &= ~DEBUGCTLMSR_LBR;
-		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
+		vmx_guest_debugctl_write(vcpu, data);
 	}
 }
 
@@ -730,7 +730,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 
 	if (!lbr_desc->event) {
 		vmx_disable_lbr_msrs_passthrough(vcpu);
-		if (vmcs_read64(GUEST_IA32_DEBUGCTL) & DEBUGCTLMSR_LBR)
+		if (vmx_guest_debugctl_read() & DEBUGCTLMSR_LBR)
 			goto warn;
 		if (test_bit(INTEL_PMC_IDX_FIXED_VLBR, pmu->pmc_in_use))
 			goto warn;
@@ -752,7 +752,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 {
-	if (!(vmcs_read64(GUEST_IA32_DEBUGCTL) & DEBUGCTLMSR_LBR))
+	if (!(vmx_guest_debugctl_read() & DEBUGCTLMSR_LBR))
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 215fb1a1f861..0b1e034e59a3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2149,7 +2149,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
-		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		msr_info->data = vmx_guest_debugctl_read();
 		break;
 	default:
 	find_uret_msr:
@@ -2279,7 +2279,8 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
 
-		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
+		vmx_guest_debugctl_write(vcpu, data);
+
 		if (intel_pmu_lbr_is_enabled(vcpu) && !to_vmx(vcpu)->lbr_desc.event &&
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
@@ -4794,7 +4795,8 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write32(GUEST_SYSENTER_CS, 0);
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
 	vmcs_writel(GUEST_SYSENTER_EIP, 0);
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+
+	vmx_guest_debugctl_write(&vmx->vcpu, 0);
 
 	if (cpu_has_vmx_tpr_shadow()) {
 		vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, 0);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 392e66c7e5fe..c20a4185d10a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -417,6 +417,16 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
 bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
 
+static inline void vmx_guest_debugctl_write(struct kvm_vcpu *vcpu, u64 val)
+{
+	vmcs_write64(GUEST_IA32_DEBUGCTL, val);
+}
+
+static inline u64 vmx_guest_debugctl_read(void)
+{
+	return vmcs_read64(GUEST_IA32_DEBUGCTL);
+}
+
 /*
  * Note, early Intel manuals have the write-low and read-high bitmap offsets
  * the wrong way round.  The bitmaps control MSRs 0x00000000-0x00001fff and
-- 
2.39.5


