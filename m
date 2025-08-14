Return-Path: <stable+bounces-169539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BCEB265EA
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08261C81F99
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140B2E9EB4;
	Thu, 14 Aug 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkTTwZwn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B68E571
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175924; cv=none; b=d8DPZSg7JFJCykkpKZT1UEEnKLpld9Cr2vijA55mGdAXvivi+9gVgIatr0P0u4vJ17Iyw4ZlXSWVqzEoQDHvL8msActurKndp37NX2uEQbZ9KrNpJKRzK+mXIQpycrEj4Z9PSPsCLGXYp+taEVclw0vont2pnGlGwAE+trFbnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175924; c=relaxed/simple;
	bh=DX5PyXmvuoram2JCuG0y6yqEhrOdtnLys+r57/ddrMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eh+mk29ygzLJMsaZ5MEqzqMfcH8hnNUcSBcGMI6FqWFGen2/QFksj0B3NdVpJHFqHsa9WWzxnjsCUXjjYzlYi4Rt1KD0TUf6/KL8VOxweFFloX8R+msLtlAFjWl/BOtYXLo7vgNgzh7X6J3sXjlZdnO5TXr6QVvH3NTfU1BAlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkTTwZwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E27C4CEED;
	Thu, 14 Aug 2025 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755175924;
	bh=DX5PyXmvuoram2JCuG0y6yqEhrOdtnLys+r57/ddrMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkTTwZwn7vS2qtKsqC39I8gLDfA/sFdcL9nszb18r3mMQk4AXAeZf6a9du2mvRcXg
	 veajXEVhhGcd9yIYNbjn9Iwqdcy70et2zHaBFYNupcOCtnKtKSc9DBVuxO4h/fpXV9
	 S8KMm/+3cg5Z1L0bY9aFeveGy5wyedAN+0OtDXVHXkZMRiZsrQpOxMk+aJr/RpBLn5
	 8Z8N1QmF2qkSwHiAE9PEqoWI/BXYHfS4kGSm134SKNyxfO9iC+Jd3UH9WpdXH/+JWE
	 Z2HRrkkCD8FQ2gkiVZqofzls6X0V2kjtTpPAYDhz3o418FK8g8rOESRG4MzYr9eyJ1
	 WVspFLafhyl9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/3] KVM: VMX: Extract checking of guest's DEBUGCTL into helper
Date: Thu, 14 Aug 2025 08:51:59 -0400
Message-Id: <20250814125201.2090009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081208-petition-barcode-1e2a@gregkh>
References: <2025081208-petition-barcode-1e2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]

Move VMX's logic to check DEBUGCTL values into a standalone helper so that
the code can be used by nested VM-Enter to apply the same logic to the
value being loaded from vmcs12.

KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
VM-Enter, as hardware may support features that KVM does not, i.e. relying
on hardware to detect invalid guest state will result in false negatives.
Unfortunately, that means applying KVM's funky suppression of BTF and LBR
to vmcs12 so as not to break existing guests.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index eec0aa13e002..e812e98b06a8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2195,6 +2195,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
+static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
+				  bool host_initiated)
+{
+	u64 invalid;
+
+	invalid = data & ~vmx_get_supported_debugctl(vcpu, host_initiated);
+	if (invalid & (DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR)) {
+		kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+		invalid &= ~(DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR);
+	}
+	return !invalid;
+}
+
 /*
  * Writes msr value into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
@@ -2263,19 +2276,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		vmcs_writel(GUEST_SYSENTER_ESP, data);
 		break;
-	case MSR_IA32_DEBUGCTLMSR: {
-		u64 invalid;
-
-		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
-		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
-			kvm_pr_unimpl_wrmsr(vcpu, msr_index, data);
-			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-		}
-
-		if (invalid)
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
 			return 1;
 
+		data &= vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
+
 		if (is_guest_mode(vcpu) && get_vmcs12(vcpu)->vm_exit_controls &
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
@@ -2285,7 +2291,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.39.5


