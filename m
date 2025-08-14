Return-Path: <stable+bounces-169486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DBB25944
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 03:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD54E1BC6E8B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 01:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E17230997;
	Thu, 14 Aug 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJdDB+Kg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419822B5AD
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136003; cv=none; b=H8rv6b2elfah2piPMrLUHudeRkHrIc1/uelxOmEzKDzLARd6EXKiPrqgxl2kazxpKPE2juxlrPUoVPoiOh7QAlhW5ONyvgjdwZGK6faiTDmjxBQzo03/0PshfLB1iIvBun7L4iuLMfikP1wE66UlmpF/wIGSRlCFepR3IOpnU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136003; c=relaxed/simple;
	bh=afmLWFRWwZNrs+D9oBdsmKeZisnFMCIFC11CFcX9t6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSm49svyQetpF/3HMEVBbUQkj66hq4kAwms5vpZQ98cStkAhlVKTbqqO3DRZB141Hyc8cjPLCwMFMxOMmsp2Kzm4km1sov5vwRFy7P4tj0EqAfJmX4ZwEBAvhR3+Qr4k6f9iuuMwQxPQy6IoQb72BXmxz8MDAziigJNcSnoUZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJdDB+Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEA0C4CEF5;
	Thu, 14 Aug 2025 01:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755136003;
	bh=afmLWFRWwZNrs+D9oBdsmKeZisnFMCIFC11CFcX9t6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJdDB+Kg/WbIa80KF3uc7WI9eUMoHm2WdC/SC8wbAbgPFKMI1s9h1N8QmYtBTs/kI
	 HjVf07sw43U+VFTrmorO8/XUg35o91iTOwkBCMZf/oZOCdIYWYFSK8f/yMHRhKpAUs
	 c/KT0waiothjmSjtZR99Ufa/mGgG83WQaFJKcRs4ZshTRAFBQ7lm0UFpxcyCL/8GVn
	 SaY+h0PTikFJVKOTv94R+XMbMTC2aEhTvyq2xR7Fv3CBxLGNrkCd0+YILCGoZMsT5K
	 unKqzdmjoDUDTo9SRFY13wLG1ApvsC7WxwE1SM5emoasowUKkdKC1eRwG8MsLx/xnH
	 2Eox+RGHQ0sYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
Date: Wed, 13 Aug 2025 21:46:38 -0400
Message-Id: <20250814014638.2082457-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814014638.2082457-1-sashal@kernel.org>
References: <2025081221-finicky-ensure-b830@gregkh>
 <20250814014638.2082457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Levitsky <mlevitsk@redhat.com>

[ Upstream commit 095686e6fcb4150f0a55b1a25987fad3d8af58d6 ]

Add a consistency check for L2's guest_ia32_debugctl, as KVM only supports
a subset of hardware functionality, i.e. KVM can't rely on hardware to
detect illegal/unsupported values.  Failure to check the vmcs12 value
would allow the guest to load any harware-supported value while running L2.

Take care to exempt BTF and LBR from the validity check in order to match
KVM's behavior for writes via WRMSR, but without clobbering vmcs12.  Even
if VM_EXIT_SAVE_DEBUG_CONTROLS is set in vmcs12, L1 can reasonably expect
that vmcs12->guest_ia32_debugctl will not be modified if writes to the MSR
are being intercepted.

Arguably, KVM _should_ update vmcs12 if VM_EXIT_SAVE_DEBUG_CONTROLS is set
*and* writes to MSR_IA32_DEBUGCTLMSR are not being intercepted by L1, but
that would incur non-trivial complexity and wouldn't change the fact that
KVM's handling of DEBUGCTL is blatantly broken.  I.e. the extra complexity
is not worth carrying.

Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250610232010.162191-7-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 12 ++++++++++--
 arch/x86/kvm/vmx/vmx.c    |  5 ++---
 arch/x86/kvm/vmx/vmx.h    |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7211c71d4241..1b8b0642fc2d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2663,7 +2663,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
+		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl &
+						  vmx_get_supported_debugctl(vcpu, false));
 	} else {
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.pre_vmenter_debugctl);
@@ -3156,7 +3157,8 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
-	    CC(!kvm_dr7_valid(vmcs12->guest_dr7)))
+	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
+	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT) &&
@@ -4608,6 +4610,12 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 		(vmcs12->vm_entry_controls & ~VM_ENTRY_IA32E_MODE) |
 		(vm_entry_controls_get(to_vmx(vcpu)) & VM_ENTRY_IA32E_MODE);
 
+	/*
+	 * Note!  Save DR7, but intentionally don't grab DEBUGCTL from vmcs02.
+	 * Writes to DEBUGCTL that aren't intercepted by L1 are immediately
+	 * propagated to vmcs12 (see vmx_set_msr()), as the value loaded into
+	 * vmcs02 doesn't strictly track vmcs12.
+	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_DEBUG_CONTROLS)
 		vmcs12->guest_dr7 = vcpu->arch.dr7;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2ac86650cffc..215fb1a1f861 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2174,7 +2174,7 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 	return (unsigned long)data;
 }
 
-static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
 {
 	u64 debugctl = 0;
 
@@ -2189,8 +2189,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
-static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
-				  bool host_initiated)
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated)
 {
 	u64 invalid;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index b5758c33c60f..392e66c7e5fe 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -414,6 +414,9 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
+
 /*
  * Note, early Intel manuals have the write-low and read-high bitmap offsets
  * the wrong way round.  The bitmaps control MSRs 0x00000000-0x00001fff and
-- 
2.39.5


