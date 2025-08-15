Return-Path: <stable+bounces-169657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8EB27398
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25D01CE0EBA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E754235C01;
	Fri, 15 Aug 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yo4r9KVK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435B22E3F0
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216771; cv=none; b=TGgSGHRnG5qojyOr1CeB9Q0BGA+UrN1ku1akySEokQMU6sfhdoIfnmMBmwmx5AJcjy+fXpwm6YkMnCvfDq5dDJ96ySlL+FcX6wTNBJrjQUSCQDQH9k+5v+8YIFcz4lABCS4B+R3MzgezhdSWb9bFycps8YbgK96A+9OCM971Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216771; c=relaxed/simple;
	bh=YiHyQB/qYAohXmstBYtVCc+gNJrMGrDDL1Alwq4NWxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IY5aERE31SI/OoI24F81ss7zqkBVu72D3+FuGYM4Qw1YDnh0Q1qPWf/B89iUYh1UIA5TSMroxj/ojVdvoB2n/DdFx8HO3CqPsmWIyrJueoC5QU1hwYSTmS9B/dIwBC+pgbn48Kcyjqi0VAhyKNqpPqpdGGA1eNC35I4behJc0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yo4r9KVK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267bf596so1424058a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216769; x=1755821569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=och+fjSaGItFDqW/mIp4YckXfoDV7hYGcjSSMk0M92U=;
        b=yo4r9KVKOu6QLm/7pi2meb7qOdK3vroFFc08pyfM0SLQhrYavXbK/zlwnNvsbJzwMi
         I4U+3mdaozk8WE6c3+yktKEEC9Xkto2EeK2Xn/ZixjIcwRXObE5hbNF4bH5bBGt52sb8
         0jxWeia7EKsG2yfGg5sdSV7teR5loas8YQWtERbPFjqpqPgGLA6UWVqmgCK1z42x1Dtm
         Ck7hHlpwcwbpkdEvA9QTburf+hSFbQhwYZAM8/fSFY4x8+5LIWEb6gtPg0CPkqEMg2un
         UkxYay1i19ODTMRUKE7GARhH00xfZundzmWUD5bQvyzicQsH+YuScNQM1x+6/I4eQL4I
         2aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216769; x=1755821569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=och+fjSaGItFDqW/mIp4YckXfoDV7hYGcjSSMk0M92U=;
        b=CBNU+TUUBt/A+BBKPbOjzCFoybmB51XQ23KJHwEwd/Jka5IhJlI+EroByDYQLhKqee
         P2ivf9WDyTXiizyf4O4jVrVez+uPqiR1ZoUhgyxoguFc1ZeI4Mzu4+l29K+WbVz4q02Z
         ki+Yudaqjd0WuMhpovANvXf/PfHUNnTefagzabU/UfjpXN6aPDlmmlihdQPXZLYYgwZS
         lpmPb7pdYXJ485sPZyIpzKjCQRHGALvsjqtu7ytC5XHcBn/XT5UQOSf8ge1p/RMe5WTe
         CUy93c2Nk3wZFH0xfWzDV0BYDI4Iy6sFe6k5Z4wI3kI6ZMPGDsZFsMkbmaBApWhHLLJj
         HZfg==
X-Gm-Message-State: AOJu0YwqONs+EfOPiDZf4LF3AUFOvt47+C4UAjQkvaUopGNEVIodSjG4
	RrCbvJZRaG3alYgwev5PqpjWmkro6pkvlLTCX/Go35kXaYPAe0YiId5bRV5jYOZimZGX4slFzuT
	qUt04frVdruNq4aLnQbroKDXL/7zYW7q+v164eUw+xoLp1iqLb5pPn3sSD0GKa7KkvrakpgWy+x
	hNeTrwJQ64mmIbbzBa4P+qyoTao8LzFr2Dc43c
X-Google-Smtp-Source: AGHT+IHnBqQFlSoQZIiUvaYDbCSfuOs+wL7h0mHAfHpPwBt4Jj0voWey9YcQIwrrJgBEcsHkOP+C64kXqm8=
X-Received: from pja3.prod.google.com ([2002:a17:90b:5483:b0:323:2b2a:1de5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f8f:b0:31e:f397:b5b4
 with SMTP id 98e67ed59e1d1-32341ec5658mr295776a91.22.1755216768856; Thu, 14
 Aug 2025 17:12:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:12:04 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-21-seanjc@google.com>
Subject: [PATCH 6.1.y 20/21] KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with
 getter/setter APIs
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c    | 10 +++++-----
 arch/x86/kvm/vmx/pmu_intel.c |  8 ++++----
 arch/x86/kvm/vmx/vmx.c       |  8 +++++---
 arch/x86/kvm/vmx/vmx.h       | 10 ++++++++++
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index da129e12cff9..a220770644e1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2532,11 +2532,11 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
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
@@ -3404,7 +3404,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	if (!vmx->nested.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
-		vmx->nested.pre_vmenter_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
 	if (kvm_mpx_supported() &&
 	    (!vmx->nested.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
@@ -4572,7 +4572,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	__vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
 
 	kvm_set_dr(vcpu, 7, 0x400);
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+	vmx_guest_debugctl_write(vcpu, 0);
 
 	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
 				vmcs12->vm_exit_msr_load_count))
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 220cdbe1e286..76d3ed8abf6a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -672,11 +672,11 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
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
 
@@ -746,7 +746,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 
 	if (!lbr_desc->event) {
 		vmx_disable_lbr_msrs_passthrough(vcpu);
-		if (vmcs_read64(GUEST_IA32_DEBUGCTL) & DEBUGCTLMSR_LBR)
+		if (vmx_guest_debugctl_read() & DEBUGCTLMSR_LBR)
 			goto warn;
 		if (test_bit(INTEL_PMC_IDX_FIXED_VLBR, pmu->pmc_in_use))
 			goto warn;
@@ -769,7 +769,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 {
-	if (!(vmcs_read64(GUEST_IA32_DEBUGCTL) & DEBUGCTLMSR_LBR))
+	if (!(vmx_guest_debugctl_read() & DEBUGCTLMSR_LBR))
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0b37e21d55b1..e470a294b22d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2027,7 +2027,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
-		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		msr_info->data = vmx_guest_debugctl_read();
 		break;
 	default:
 	find_uret_msr:
@@ -2161,7 +2161,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
 
-		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
+		vmx_guest_debugctl_write(vcpu, data);
+
 		if (intel_pmu_lbr_is_enabled(vcpu) && !to_vmx(vcpu)->lbr_desc.event &&
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
@@ -4751,7 +4752,8 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write32(GUEST_SYSENTER_CS, 0);
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
 	vmcs_writel(GUEST_SYSENTER_EIP, 0);
-	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
+
+	vmx_guest_debugctl_write(&vmx->vcpu, 0);
 
 	if (cpu_has_vmx_tpr_shadow()) {
 		vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, 0);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 99e3f46de2ec..b7ae263cde7b 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -445,6 +445,16 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
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
2.51.0.rc1.163.g2494970778-goog


