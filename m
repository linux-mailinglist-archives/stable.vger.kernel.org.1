Return-Path: <stable+bounces-228724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOlfBlBnwWliSwQAu9opvQ
	(envelope-from <stable+bounces-228724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:16:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 827432F7D4D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF79A32406DE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93E3B27ED;
	Mon, 23 Mar 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ob2kAVtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCD3B27EA;
	Mon, 23 Mar 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276951; cv=none; b=Ag5tQuqsGS6IPBOI/IX4sVNERr0zVGbSxk9ToQ1T7YeoanGrYB9CUbyUjt6aV03+qnLcyVdQHtuIujpj/4vov/frF9sfIWksMR7RJoaygjIoWpIKefbBrNTo2O/9bSrWdx0dipHwDLh3xBwe8zuFDM2uKGCpGwPwfiyXqNG0KNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276951; c=relaxed/simple;
	bh=TdrjiJQrMi3BvvNByooasOaeavu7kfNy2RJrWCnLIdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNcmJe7bF5q98d4TFIqmyWdHebcpHe3/kXjJ1qWUU13NSleFrpejulPf+bANGGPAXqYiynHuixt19d9YuAWLZ1q+jO5eDyYa263+L5xybWEnXsqWBAcQ0AfPSYSA/H+BQAWhWKR+LGUevqWIUFj6tWZqTiMaJtTVebKePLsdcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ob2kAVtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB33C4CEF7;
	Mon, 23 Mar 2026 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276950;
	bh=TdrjiJQrMi3BvvNByooasOaeavu7kfNy2RJrWCnLIdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ob2kAVtGRTcjIbKLDKoWY3l1qMr0+R2p/j5PzdmDzMRRPs7BqqbuuDNx5BE6u2VLA
	 D3fFQTq3ovWtbtCyXSB0f7uwALdMP8VlqCzNCCrNmedpNV1M9KrxzUfKusT17ONurD
	 hGqWnJJaYTZ25Uquj9zbwZcqShQnLXTn+6tl1MrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 266/460] KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM
Date: Mon, 23 Mar 2026 14:44:22 +0100
Message-ID: <20260323134533.022818164@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228724-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 827432F7D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

[ Upstream commit e2ffe85b6d2bb7780174b87aa4468a39be17eb81 ]

Add KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM to allow L1 to set
FREEZE_IN_SMM in vmcs12's GUEST_IA32_DEBUGCTL field, as permitted
prior to commit 6b1dd26544d0 ("KVM: VMX: Preserve host's
DEBUGCTLMSR_FREEZE_IN_SMM while running the guest").  Enable the quirk
by default for backwards compatibility (like all quirks); userspace
can disable it via KVM_CAP_DISABLE_QUIRKS2 for consistency with the
constraints on WRMSR(IA32_DEBUGCTL).

Note that the quirk only bypasses the consistency check.  The vmcs02 bit is
still owned by the host, and PMCs are not frozen during virtualized SMM.
In particular, if a host administrator decides that PMCs should not be
frozen during physical SMM, then L1 has no say in the matter.

Fixes: 095686e6fcb4 ("KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260205231537.1278753-1-jmattson@google.com
[sean: tag for stable@, clean-up and fix goofs in the comment and docs]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rename quirk. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/virt/kvm/api.rst  |    8 ++++++++
 arch/x86/include/asm/kvm_host.h |    3 ++-
 arch/x86/include/uapi/asm/kvm.h |    1 +
 arch/x86/kvm/vmx/nested.c       |   22 ++++++++++++++++++----
 4 files changed, 29 insertions(+), 5 deletions(-)

--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8151,6 +8151,14 @@ KVM_X86_QUIRK_IGNORE_GUEST_PAT      By d
                                     guest software, for example if it does not
                                     expose a bochs graphics device (which is
                                     known to have had a buggy driver).
+
+KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM   By default, KVM relaxes the consistency
+                                      check for GUEST_IA32_DEBUGCTL in vmcs12
+                                      to allow FREEZE_IN_SMM to be set.  When
+                                      this quirk is disabled, KVM requires this
+                                      bit to be cleared.  Note that the vmcs02
+                                      bit is still completely controlled by the
+                                      host, regardless of the quirk setting.
 =================================== ============================================
 
 7.32 KVM_CAP_MAX_VCPU_ID
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2387,7 +2387,8 @@ int memslot_rmap_alloc(struct kvm_memory
 	 KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS |	\
 	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
 	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
-	 KVM_X86_QUIRK_IGNORE_GUEST_PAT)
+	 KVM_X86_QUIRK_IGNORE_GUEST_PAT |	\
+	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM)
 
 #define KVM_X86_CONDITIONAL_QUIRKS		\
 	(KVM_X86_QUIRK_CD_NW_CLEARED |		\
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -442,6 +442,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 #define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
+#define KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (1 << 10)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3142,10 +3142,24 @@ static int nested_vmx_check_guest_state(
 	if (CC(vmcs12->guest_cr4 & X86_CR4_CET && !(vmcs12->guest_cr0 & X86_CR0_WP)))
 		return -EINVAL;
 
-	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
-	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
-	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
-		return -EINVAL;
+	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) {
+		u64 debugctl = vmcs12->guest_ia32_debugctl;
+
+		/*
+		 * FREEZE_IN_SMM is not virtualized, but allow L1 to set it in
+		 * vmcs12's DEBUGCTL under a quirk for backwards compatibility.
+		 * Note that the quirk only relaxes the consistency check.  The
+		 * vmcc02 bit is still under the control of the host.  In
+		 * particular, if a host administrator decides to clear the bit,
+		 * then L1 has no say in the matter.
+		 */
+		if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM))
+			debugctl &= ~DEBUGCTLMSR_FREEZE_IN_SMM;
+
+		if (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
+		    CC(!vmx_is_valid_debugctl(vcpu, debugctl, false)))
+			return -EINVAL;
+	}
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT) &&
 	    CC(!kvm_pat_valid(vmcs12->guest_ia32_pat)))



