Return-Path: <stable+bounces-169552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387A9B266A8
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2024A1CE02CC
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D93002BA;
	Thu, 14 Aug 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co8BPYar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED103002B5
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177110; cv=none; b=CVFhWlirQ92PnhB84BEV/0+bbKcqsrX1SlEccB31LPquzzpHQVr5MJlQXHJ23Ig8dFqc6gCRkceQ9TlbZ/gCVlIVmSevSO8bwQqIYQEwtF+LwAIYQwBAEYXxRN2up2RAd9HXz1PagPfKoWbRG4a7D60xh6BV5GftT8BDg62qIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177110; c=relaxed/simple;
	bh=nNRLMjyvUi8GqhlJzX6K+D9zanqpTStDh1ye3499xZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvjvp/1tJgrPSSDHKnVq0PlH8sH61KN/ndYfs1ywDzr0OMDI51+xj592OaD87OHB2Mla7gChPXtdG4bwjK6tyCjP90xA8qu4JOkGK5qG+lojXDEILZDhBxmdakD6R73AFhZlDhc09ANwLMiQGDbNm7c/S0A79knMEFMDVXAt/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co8BPYar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D4CC4CEF1;
	Thu, 14 Aug 2025 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755177109;
	bh=nNRLMjyvUi8GqhlJzX6K+D9zanqpTStDh1ye3499xZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Co8BPYarSaI1OqNTXyd/ENH35EN03Hf0KfK0oStQ/4pIVFeEUs94xvWYAyAjDPVBg
	 YmrOulf3OwA1vV4eRFZe0RMqNGFrBm9OvFu+6D7UkmQUaEkpNTC1VDVRRWws9K2fGu
	 cYcUsVYDEToKrwU4cAO+9U6TAIzEXqSpDAZ1xFriVWkb4QT9MV13He9yt4WDzym+DO
	 40vdxHAqa8d2eonSTv4W8zlcll1pmsqeqzYE5DwPoN4Y1bCLiOwiOJfzqsfIXT7swh
	 0DV2GD5tMuDfoRNuklH2BTmn46s1h3ZTATjhP/h9pJujIUNYnE5B47iBlvt3fPv1/0
	 +hFP4hyulKOcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
Date: Thu, 14 Aug 2025 09:11:45 -0400
Message-Id: <20250814131146.2093579-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814131146.2093579-1-sashal@kernel.org>
References: <2025081214-bonanza-germproof-173f@gregkh>
 <20250814131146.2093579-1-sashal@kernel.org>
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
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 12 ++++++++++--
 arch/x86/kvm/vmx/vmx.c    |  5 ++---
 arch/x86/kvm/vmx/vmx.h    |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d3e346a574f1..c626be098fde 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2564,7 +2564,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
+		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl &
+						  vmx_get_supported_debugctl(vcpu, false));
 	} else {
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.pre_vmenter_debugctl);
@@ -3045,7 +3046,8 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
-	    CC(!kvm_dr7_valid(vmcs12->guest_dr7)))
+	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
+	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
 		return -EINVAL;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT) &&
@@ -4435,6 +4437,12 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 		(vmcs12->vm_entry_controls & ~VM_ENTRY_IA32E_MODE) |
 		(vm_entry_controls_get(to_vmx(vcpu)) & VM_ENTRY_IA32E_MODE);
 
+	/*
+	 * Note!  Save DR7, but intentionally don't grab DEBUGCTL from vmcs02.
+	 * Writes to DEBUGCTL that aren't intercepted by L1 are immediately
+	 * propagated to vmcs12 (see vmx_set_msr()), as the value loaded into
+	 * vmcs02 doesn't strictly track vmcs12.
+	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_DEBUG_CONTROLS)
 		kvm_get_dr(vcpu, 7, (unsigned long *)&vmcs12->guest_dr7);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 48a72ad8a28f..65a1ab742c89 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2153,7 +2153,7 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 	return (unsigned long)data;
 }
 
-static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated)
 {
 	u64 debugctl = 0;
 
@@ -2168,8 +2168,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
-static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
-				  bool host_initiated)
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated)
 {
 	u64 invalid;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6be1627d888e..e61442db7cbb 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -432,6 +432,9 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
+u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
+bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
+
 /*
  * Note, early Intel manuals have the write-low and read-high bitmap offsets
  * the wrong way round.  The bitmaps control MSRs 0x00000000-0x00001fff and
-- 
2.39.5


