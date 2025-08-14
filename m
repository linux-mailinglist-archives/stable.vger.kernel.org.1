Return-Path: <stable+bounces-169542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04DB265FD
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73D51886151
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E12FB977;
	Thu, 14 Aug 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcNwKxxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB5381AF
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176174; cv=none; b=JHPccQbAGpHdXnQ+jiealkjksVibqTVDca79mxmFyu/tSPGP+HAXLmwZuZRbOMHvoKMcVB0V/EwHmJfTpH3pt6Dy05RbThyoFot02eSawJ6CvraSAsO2Zh67pxmFY+OH0F61roQDFIxCBbve7e1caO5N2wcB1QQ0gQ49AWqMp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176174; c=relaxed/simple;
	bh=VMn2dyMn+AHq4U/eTqCjzQhy14SxU1q206cdQsLTQuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTcN8wl4Z4nOaCyHR8VEUZbmpG2nWTXBiu5WA+vN7/lPu9rd3xb2CkEjVKsZa0ZS2g0oObltS27ecSu+vJ1gv/TEiWKjsj7KetlCNWr3HA2L6Z/DmyLLf1jiM7J6nFM62L37Nq2FvzoYzaHfJf0JtI03CGamn82ab0jh7mXJZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcNwKxxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B16FC4CEED;
	Thu, 14 Aug 2025 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755176173;
	bh=VMn2dyMn+AHq4U/eTqCjzQhy14SxU1q206cdQsLTQuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcNwKxxb5PSc1n9YPJ9NFR15IQEt9LEmXWl+3HXdlG8lWphbT68R6wJ0OQLn7ECKp
	 4o+P/q53biBbpL/P+exnQYwRC+A3q2xnOTsgrlMn8CvZj+mauStnlBFKNsJ9BlFVNE
	 5BQctSj8FesyJTiNsvsNz976rwUnGk/C1BglS52y8N69g1KrpnkVEMUsEXrIQm+5ru
	 t4B1yViltStc2OictWDClzY/791EPu4q4kFS+iQ+k0JHwZ1gVn6WjVQ0aWV9USv1a3
	 QDgoIg5/Sy933EHqoLO8EuqxNYZemJAT39DhojDROKAnztQBeHtT+5Q7c/qlDNjnf+
	 xFdLLXywaX2OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] KVM: VMX: Extract checking of guest's DEBUGCTL into helper
Date: Thu, 14 Aug 2025 08:56:10 -0400
Message-Id: <20250814125611.2090853-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081223-parameter-cope-c338@gregkh>
References: <2025081223-parameter-cope-c338@gregkh>
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
Stable-dep-of: 095686e6fcb4 ("KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a4ebf3dfbfc..5a6d91f44705 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2188,6 +2188,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
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
@@ -2256,19 +2269,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -2278,7 +2284,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.39.5


