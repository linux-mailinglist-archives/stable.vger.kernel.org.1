Return-Path: <stable+bounces-242748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEuqA9o892k2dwIAu9opvQ
	(envelope-from <stable+bounces-242748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:17:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F584B5A0A
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619BB3007F69
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70B39936E;
	Sun,  3 May 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JI2So0OJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182C16A956
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810644; cv=none; b=PkBMbNNGj8DIASGFf81YdgpwxNK6ousbn0gclXjZnM3KBywzlBXb9BZI5xv4bPVTQCeXnWUldzJ6YdVzmw9Bm61fNhL91C6AGs+8g2DTBvlyko/rts38JGtO5yJlgwTaryC7Ztt5oOM7Xn6WMMOowGIU/z2flSRkGpHnmlkfVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810644; c=relaxed/simple;
	bh=kFoFiwP7pMVAhCD2wmSWjCdXa+Zw50UZcG/U0jPTn34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GHad0RUVrOTKktq1ntZWJC4ByBtBH0iG3SxEVvIO7HsmrJ/OnkcywzlgDY8jesj0tPDeLKMHhdT+XFjcaiHeJw6V+Qjr4uyiKVYKhZWOEeWyw55Kg6OgY4iPQ/0zw4BRfXuy9m8a9MjYFm1/ZuKoOG0/XPemzlSSDsG9IYhJ7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JI2So0OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B621C2BCB4;
	Sun,  3 May 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810643;
	bh=kFoFiwP7pMVAhCD2wmSWjCdXa+Zw50UZcG/U0jPTn34=;
	h=Subject:To:Cc:From:Date:From;
	b=JI2So0OJTSWnUEyCFgIWmuB8cklt3IaOZ5ZskJdwWJGZiNP+u78H2lVz3eQDu1m4v
	 JY6Pjm06MX/Y6yF2r0l/Q3S5SHFYhCtrr+SjQKbENE1jZGfE5udLh1cSa9Gb1SqVxo
	 IPqhEh8UPC9E9EwvCd0iWzVUbM3R7CIf6QSmdGv0=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Triple fault if restore host CR3 fails on nested" failed to apply to 6.1-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:17:13 +0200
Message-ID: <2026050313-brim-recess-6f4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83F584B5A0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242748-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d291ef0585ed880ed4dd71ea1a5965e0a65fb53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050313-brim-recess-6f4b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d291ef0585ed880ed4dd71ea1a5965e0a65fb53 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:03 +0000
Subject: [PATCH] KVM: nSVM: Triple fault if restore host CR3 fails on nested
 #VMEXIT

If loading L1's CR3 fails on a nested #VMEXIT, nested_svm_vmexit()
returns an error code that is ignored by most callers, and continues to
run L1 with corrupted state. A sane recovery is not possible in this
case, and HW behavior is to cause a shutdown. Inject a triple fault
instead, and do not return early from nested_svm_vmexit(). Continue
cleaning up the vCPU state (e.g. clear pending exceptions), to handle
the failure as gracefully as possible.

From the APM:

  Upon #VMEXIT, the processor performs the following actions in order to
  return to the host execution context:

  ...

  if (illegal host state loaded, or exception while loading host state)
      shutdown
  else
      execute first host instruction following the VMRUN

Remove the return value of nested_svm_vmexit(), which is mostly
unchecked anyway.

Fixes: d82aaef9c88a ("KVM: nSVM: use nested_svm_load_cr3() on guest->host switch")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-10-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 30c99bbe9927..5e0feeb50ba3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1192,12 +1192,11 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-int nested_svm_vmexit(struct vcpu_svm *svm)
+void nested_svm_vmexit(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
-	int rc;
 
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
@@ -1316,9 +1315,8 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	nested_svm_uninit_mmu_context(vcpu);
 
-	rc = nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true);
-	if (rc)
-		return 1;
+	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
 	/*
 	 * Drop what we picked up for L2 via svm_complete_interrupts() so it
@@ -1343,8 +1341,6 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	 */
 	if (kvm_apicv_activated(vcpu->kvm))
 		__kvm_vcpu_update_apicv(vcpu);
-
-	return 0;
 }
 
 static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e97c56df41f6..7efa71709292 100644
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
@@ -4871,7 +4867,6 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_host_map map_save;
-	int ret;
 
 	if (!is_guest_mode(vcpu))
 		return 0;
@@ -4891,9 +4886,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
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


