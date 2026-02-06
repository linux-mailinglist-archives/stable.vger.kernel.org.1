Return-Path: <stable+bounces-214710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEPINbw8hmnzLAQAu9opvQ
	(envelope-from <stable+bounces-214710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:10:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485E10279F
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D00113023A4B
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E95429824;
	Fri,  6 Feb 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JvWNnrHU"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8642E007
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404962; cv=none; b=PRH9jg6Pu1fF2ptCOjhliwz2Uy1kcW3tViOia0IZt7D/en3epvLyA4GTtn+fgACk618NVPzqtlQqkZKsCCaAfbEnoy4HTxwKMQVX5r6W/UBuG1gXMQ7ZNfZJlpyCIe7q362t0KM9SptiLwcMSWqQjH/ujngGgbfIHfcJJrinn4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404962; c=relaxed/simple;
	bh=C1p3AS10bD2YZcL4D4GSYH8HHE9oRzO3xY0/ZBrpO8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=befwdgxjoB8aUcKOEzgB4qwjR42Om0VvqSIxapAwP22LqB7llr/65vqyeoLDsYGnQl7fUBFf5SkCi9pyRk7VGeqTPR1hloXn7Z7eqW+ONu/ZGmSWrDrhf9Zi+6U2cOR1p/D3Jm2nE11+AOZAd7EsBuM4MeU5ZUAPKOKjYZFq4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JvWNnrHU; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISg/b9mfa1uKSqpI8riZeaTxNIhO0uVtXR2GrmQhhSI=;
	b=JvWNnrHULM1ItCiAxXfGGn4yl/lzvJ5htbmBoxoks6glRX7gkeAKrdY4LZFxv6ZnaeOczM
	KzfcCc5sh9TaHOP8zGXqD/2OoLcpodQxUzPfy7iEplqTFFXt0sWU0UOGu++bYE3I1u9E/5
	5PXZlBN7Sj+mFrH8s6CqMzcFkyxQFtQ=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 07/26] KVM: nSVM: Triple fault if restore host CR3 fails on nested #VMEXIT
Date: Fri,  6 Feb 2026 19:08:32 +0000
Message-ID: <20260206190851.860662-8-yosry.ahmed@linux.dev>
In-Reply-To: <20260206190851.860662-1-yosry.ahmed@linux.dev>
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214710-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5485E10279F
X-Rspamd-Action: no action

If loading L1's CR3 fails on a nested #VMEXIT, nested_svm_vmexit()
returns an error code that is ignored by most callers, and continues to
run L1 with corrupted state. A sane recovery is not possible in this
case, and HW behavior is to cause a shutdown. Inject a triple fault
instead.

From the APM:
	Upon #VMEXIT, the processor performs the following actions in
	order to return to the host execution context:

	...
	if (illegal host state loaded, or exception while loading
	    host state)
		shutdown
	else
		execute first host instruction following the VMRUN

Remove the return value of nested_svm_vmexit(), which is mostly
unchecked anyway.

Fixes: d82aaef9c88a ("KVM: nSVM: use nested_svm_load_cr3() on guest->host switch")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++------
 arch/x86/kvm/svm/svm.c    | 11 ++---------
 arch/x86/kvm/svm/svm.h    |  6 +++---
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 830341b0e1f8..33e6e1e77aac 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1118,7 +1118,7 @@ void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	to_vmcb->save.sysenter_eip = from_vmcb->save.sysenter_eip;
 }
 
-int nested_svm_vmexit(struct vcpu_svm *svm)
+void nested_svm_vmexit(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	gpa_t vmcb12_gpa = svm->nested.vmcb12_gpa;
@@ -1140,7 +1140,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
-		return 1;
+		return;
 	}
 
 	/* Give the current vmcb to the guest */
@@ -1302,8 +1302,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	nested_svm_uninit_mmu_context(vcpu);
 
-	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
-		return 1;
+	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true)) {
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+		return;
+	}
 
 	/*
 	 * Drop what we picked up for L2 via svm_complete_interrupts() so it
@@ -1328,8 +1330,6 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	 */
 	if (kvm_apicv_activated(vcpu->kvm))
 		__kvm_vcpu_update_apicv(vcpu);
-
-	return 0;
 }
 
 static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d93414db6559..a534c08fbe61 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2234,13 +2234,9 @@ static int emulate_svm_instr(struct kvm_vcpu *vcpu, int opcode)
 		[SVM_INSTR_VMSAVE] = vmsave_interception,
 	};
 	struct vcpu_svm *svm = to_svm(vcpu);
-	int ret;
 
 	if (is_guest_mode(vcpu)) {
-		/* Returns '1' or -errno on failure, '0' on success. */
-		ret = nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
-		if (ret)
-			return ret;
+		nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
 		return 1;
 	}
 	return svm_instr_handlers[opcode](vcpu);
@@ -4792,7 +4788,6 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_host_map map_save;
-	int ret;
 
 	if (!is_guest_mode(vcpu))
 		return 0;
@@ -4812,9 +4807,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
 	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
 
-	ret = nested_svm_simple_vmexit(svm, SVM_EXIT_SW);
-	if (ret)
-		return ret;
+	nested_svm_simple_vmexit(svm, SVM_EXIT_SW);
 
 	/*
 	 * KVM uses VMCB01 to store L1 host state while L2 runs but
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 44d767cd1d25..7629cb37c930 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -793,14 +793,14 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu);
 void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save);
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
-int nested_svm_vmexit(struct vcpu_svm *svm);
+void nested_svm_vmexit(struct vcpu_svm *svm);
 
-static inline int nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
+static inline void nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 {
 	svm->vmcb->control.exit_code	= exit_code;
 	svm->vmcb->control.exit_info_1	= 0;
 	svm->vmcb->control.exit_info_2	= 0;
-	return nested_svm_vmexit(svm);
+	nested_svm_vmexit(svm);
 }
 
 int nested_svm_exit_handled(struct vcpu_svm *svm);
-- 
2.53.0.rc2.204.g2597b5adb4-goog


