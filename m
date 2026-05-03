Return-Path: <stable+bounces-242740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENH7CbQ892k2dwIAu9opvQ
	(envelope-from <stable+bounces-242740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:16:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09D4B59D2
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 297773005D16
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE42C08BC;
	Sun,  3 May 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcSkEqf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C816A956
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810609; cv=none; b=gqew2KFBrdpOq6XzYi0s1nIPfpkLSFIbZs4l0iiK5+RSlCLXtk4aTOaZXZmU/WRtiTxAgxGOkCIEV0l+HzrN6FxRTF7rktUvkV74RcGPagVRbKEWACipl0wBJx1d8UW0h+rTlK/2ZWDJSqFMKGTtre/RZwY5z8X3v2tBnmfB/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810609; c=relaxed/simple;
	bh=iPv/m2ijlFIfBpqQ+aaKU3kG/xreEQOXXqK6Nnd546o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HMhTiSRTte03OFlAHHaRJutJg1xX8yqvbGkbJqztMIuO193A7wDSyW0i4cxgbohxW+QWKtFWQAfNmfKI5KW9fMy2/wpaLxOwBEX5s+eufC4y6G00oUtEXHr8QWXsgdUWPHXsSbWCp6jLr5vUaXyMk2OHiz5BxP1norQzYF9JAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcSkEqf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B939C2BCB4;
	Sun,  3 May 2026 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810609;
	bh=iPv/m2ijlFIfBpqQ+aaKU3kG/xreEQOXXqK6Nnd546o=;
	h=Subject:To:Cc:From:Date:From;
	b=hcSkEqf/CJhge6pp+MeUlqPRZKF+2uvvFmTCcRmnbT/KqntUQf7Zs4/xjpouCXAnP
	 Ui9xRjKDp3x/FYcVJ6dMKCl+j57pmIqPtCHv9+A7U1LBTyyCVPB9DCJKZ1HcHi981L
	 imJuXmX6uMfyVZSy095OdScmHZpzAQh7tN+xtWq0=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Refactor writing vmcb12 on nested #VMEXIT as a" failed to apply to 6.6-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:16:38 +0200
Message-ID: <2026050338-relenting-fracture-6b66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B09D4B59D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242740-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dcf3648ab71437b504abbfdc4e74622a0f1a56e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050338-relenting-fracture-6b66@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dcf3648ab71437b504abbfdc4e74622a0f1a56e3 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:01 +0000
Subject: [PATCH] KVM: nSVM: Refactor writing vmcb12 on nested #VMEXIT as a
 helper

Move mapping vmcb12 and updating it out of nested_svm_vmexit() into a
helper, no functional change intended.

CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-8-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d419fd516fa9..8c01916cb154 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1124,36 +1124,20 @@ void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	to_vmcb->save.sysenter_eip = from_vmcb->save.sysenter_eip;
 }
 
-int nested_svm_vmexit(struct vcpu_svm *svm)
+static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu = &svm->vcpu;
-	struct vmcb *vmcb01 = svm->vmcb01.ptr;
+	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
-	struct vmcb *vmcb12;
 	struct kvm_host_map map;
+	struct vmcb *vmcb12;
 	int rc;
 
 	rc = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map);
-	if (rc) {
-		if (rc == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
+	if (rc)
+		return rc;
 
 	vmcb12 = map.hva;
 
-	/* Exit Guest-Mode */
-	leave_guest_mode(vcpu);
-	svm->nested.vmcb12_gpa = 0;
-	WARN_ON_ONCE(svm->nested.nested_run_pending);
-
-	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
-
-	/* in case we halted in L2 */
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
-	/* Give the current vmcb to the guest */
-
 	vmcb12->save.es     = vmcb02->save.es;
 	vmcb12->save.cs     = vmcb02->save.cs;
 	vmcb12->save.ss     = vmcb02->save.ss;
@@ -1190,10 +1174,48 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	if (nested_vmcb12_has_lbrv(vcpu))
+		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
+
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
 	vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
 	vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;
 
+	trace_kvm_nested_vmexit_inject(vmcb12->control.exit_code,
+				       vmcb12->control.exit_info_1,
+				       vmcb12->control.exit_info_2,
+				       vmcb12->control.exit_int_info,
+				       vmcb12->control.exit_int_info_err,
+				       KVM_ISA_SVM);
+
+	kvm_vcpu_unmap(vcpu, &map);
+	return 0;
+}
+
+int nested_svm_vmexit(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct vmcb *vmcb01 = svm->vmcb01.ptr;
+	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
+	int rc;
+
+	rc = nested_svm_vmexit_update_vmcb12(vcpu);
+	if (rc) {
+		if (rc == -EINVAL)
+			kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
+
+	/* Exit Guest-Mode */
+	leave_guest_mode(vcpu);
+	svm->nested.vmcb12_gpa = 0;
+	WARN_ON_ONCE(svm->nested.nested_run_pending);
+
+	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+
+	/* in case we halted in L2 */
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
+
 	if (!kvm_pause_in_guest(vcpu->kvm)) {
 		vmcb01->control.pause_filter_count = vmcb02->control.pause_filter_count;
 		vmcb_mark_dirty(vmcb01, VMCB_INTERCEPTS);
@@ -1238,9 +1260,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	if (!nested_exit_on_intr(svm))
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
-	if (nested_vmcb12_has_lbrv(vcpu)) {
-		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
-	} else {
+	if (!nested_vmcb12_has_lbrv(vcpu)) {
 		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
 		vmcb_mark_dirty(vmcb01, VMCB_LBR);
 	}
@@ -1296,15 +1316,6 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	svm->vcpu.arch.dr7 = DR7_FIXED_1;
 	kvm_update_dr7(&svm->vcpu);
 
-	trace_kvm_nested_vmexit_inject(vmcb12->control.exit_code,
-				       vmcb12->control.exit_info_1,
-				       vmcb12->control.exit_info_2,
-				       vmcb12->control.exit_int_info,
-				       vmcb12->control.exit_int_info_err,
-				       KVM_ISA_SVM);
-
-	kvm_vcpu_unmap(vcpu, &map);
-
 	nested_svm_transition_tlb_flush(vcpu);
 
 	nested_svm_uninit_mmu_context(vcpu);


