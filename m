Return-Path: <stable+bounces-225632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI1YH04+uGmxawEAu9opvQ
	(envelope-from <stable+bounces-225632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:30:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F1929E46B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B593149695
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127393D1CB1;
	Mon, 16 Mar 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kimvFNoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98893D5223
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681606; cv=none; b=WoQeog6D4x4Lc5TMAfMoNCLFT0SIJom8w/Hbql6AaIEw1tHlaMm/YLRTZIHbFUeDz374OFygJKk5GpNZfcdpaDRnphlKKOgQRw4FgD9kD0Umxb7taryJLijXqtOcrlt1Yljl28l/xbsojN4vjldBahUYjRLfdqRwWWKaxeFm3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681606; c=relaxed/simple;
	bh=FFO2QOWIjU0fVIFz5SWl7KN/qXD2EJ69/aIvS/pcrps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f892Otng9/kLxuURznSNCeK35JXlfnvuESWdmri3JzV1k+6cNSeD9rU2tdh0kkzKUXHFvzjVzDqBmcUT/MNueyvbMzteltrsFVaB4oiSrGaxTjS9wHNwWYcbehJ+7rp7tE+BqOX9mECWpKbGivX/eOgv/tXXsSU3SO2nkRSb7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kimvFNoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D772C2BC9E;
	Mon, 16 Mar 2026 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681606;
	bh=FFO2QOWIjU0fVIFz5SWl7KN/qXD2EJ69/aIvS/pcrps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kimvFNoKdciv7lj9rVUVPgLHbeTt50qG9YnixQ9dBMY7RKI9ituP6E2ElV0mIY3Nc
	 93v6Ao1M6vDYf2iA3Ys+HoayBuQGpIBo26xXCqTUexp8wF4Gygu8yZQCyJv1OF7D5m
	 p8ZqBY9RoxeiLNFEqlYgtZKkPZqqMFZuCbj1051edLr2Hi9E5t9DQsogTj/todNVLX
	 hoIIlC1H/Tv5i/XxMifnmwa2dd9a0XdNN2HqkkJJH+M5HtA8eVLu8OuaWfJLvukyDg
	 fNyYsNm2b5uDZfvgI8ufTuo7FZasftcOghIsfBPKxbPt2uPTO2GTQC6SCVOi5L26kb
	 5cABRfYH+xuIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/8] KVM: x86: Quirk initialization of feature MSRs to KVM's max configuration
Date: Mon, 16 Mar 2026 13:19:57 -0400
Message-ID: <20260316172003.1024253-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316172003.1024253-1-sashal@kernel.org>
References: <2026031659-scroll-setting-4687@gregkh>
 <20260316172003.1024253-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225632-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 27F1929E46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit dcb988cdac85bad177de86fbf409524eda4f9467 ]

Add a quirk to control KVM's misguided initialization of select feature
MSRs to KVM's max configuration, as enabling features by default violates
KVM's approach of letting userspace own the vCPU model, and is actively
problematic for MSRs that are conditionally supported, as the vCPU will
end up with an MSR value that userspace can't restore.  E.g. if the vCPU
is configured with PDCM=0, userspace will save and attempt to restore a
non-zero PERF_CAPABILITIES, thanks to KVM's meddling.

Link: https://lore.kernel.org/r/20240802185511.305849-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/virt/kvm/api.rst  | 22 ++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/svm/svm.c          |  4 +++-
 arch/x86/kvm/vmx/vmx.c          |  9 ++++++---
 arch/x86/kvm/x86.c              |  8 +++++---
 6 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index edc070c6e19b2..061ec93d9ecb7 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8107,6 +8107,28 @@ KVM_X86_QUIRK_SLOT_ZAP_ALL          By default, for KVM_X86_DEFAULT_VM VMs, KVM
                                     or moved memslot isn't reachable, i.e KVM
                                     _may_ invalidate only SPTEs related to the
                                     memslot.
+
+KVM_X86_QUIRK_STUFF_FEATURE_MSRS    By default, at vCPU creation, KVM sets the
+                                    vCPU's MSR_IA32_PERF_CAPABILITIES (0x345),
+                                    MSR_IA32_ARCH_CAPABILITIES (0x10a),
+                                    MSR_PLATFORM_INFO (0xce), and all VMX MSRs
+                                    (0x480..0x492) to the maximal capabilities
+                                    supported by KVM.  KVM also sets
+                                    MSR_IA32_UCODE_REV (0x8b) to an arbitrary
+                                    value (which is different for Intel vs.
+                                    AMD).  Lastly, when guest CPUID is set (by
+                                    userspace), KVM modifies select VMX MSR
+                                    fields to force consistency between guest
+                                    CPUID and L2's effective ISA.  When this
+                                    quirk is disabled, KVM zeroes the vCPU's MSR
+                                    values (with two exceptions, see below),
+                                    i.e. treats the feature MSRs like CPUID
+                                    leaves and gives userspace full control of
+                                    the vCPU model definition.  This quirk does
+                                    not affect VMX MSRs CR0/CR4_FIXED1 (0x487
+                                    and 0x489), as KVM does now allow them to
+                                    be set by userspace (KVM sets them based on
+                                    guest CPUID, for safety purposes).
 =================================== ============================================
 
 7.32 KVM_CAP_MAX_VCPU_ID
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c6c8c21106ef1..6821317eb8562 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2385,7 +2385,8 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT |	\
 	 KVM_X86_QUIRK_FIX_HYPERCALL_INSN |	\
 	 KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS |	\
-	 KVM_X86_QUIRK_SLOT_ZAP_ALL)
+	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
+	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS)
 
 /*
  * KVM previously used a u32 field in kvm_run to indicate the hypercall was
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index a8debbf2f7028..88585c1de416f 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -440,6 +440,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_FIX_HYPERCALL_INSN	(1 << 5)
 #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
+#define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 853a86dfc8f1b..9ceb0e8dbe3c5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1390,7 +1390,9 @@ static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
 	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
 
 	svm_init_osvw(vcpu);
-	vcpu->arch.microcode_version = 0x01000065;
+
+	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS))
+		vcpu->arch.microcode_version = 0x01000065;
 	svm->tsc_ratio_msr = kvm_caps.default_tsc_scaling_ratio;
 
 	svm->nmi_masked = false;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 412b4fb8a1435..4f4e75bb66ca3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4562,7 +4562,8 @@ vmx_adjust_secondary_exec_control(struct vcpu_vmx *vmx, u32 *exec_control,
 	 * Update the nested MSR settings so that a nested VMM can/can't set
 	 * controls for features that are/aren't exposed to the guest.
 	 */
-	if (nested) {
+	if (nested &&
+	    kvm_check_has_quirk(vmx->vcpu.kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS)) {
 		/*
 		 * All features that can be added or removed to VMX MSRs must
 		 * be supported in the first place for nested virtualization.
@@ -4853,7 +4854,8 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 
 	init_vmcs(vmx);
 
-	if (nested)
+	if (nested &&
+	    kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS))
 		memcpy(&vmx->nested.msrs, &vmcs_config.nested, sizeof(vmx->nested.msrs));
 
 	vcpu_setup_sgx_lepubkeyhash(vcpu);
@@ -4866,7 +4868,8 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
 #endif
 
-	vcpu->arch.microcode_version = 0x100000000ULL;
+	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS))
+		vcpu->arch.microcode_version = 0x100000000ULL;
 	vmx->msr_ia32_feature_control_valid_bits = FEAT_CTL_LOCKED;
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 60e2ac7ed2fc3..0c504d6fecf59 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12383,9 +12383,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_async_pf_hash_reset(vcpu);
 
-	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
-	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
-	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
+	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS)) {
+		vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
+		vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
+		vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
+	}
 	kvm_pmu_init(vcpu);
 
 	vcpu->arch.pending_external_vector = -1;
-- 
2.51.0


