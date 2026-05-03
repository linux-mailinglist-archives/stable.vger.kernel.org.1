Return-Path: <stable+bounces-242771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DDxOak992k2dwIAu9opvQ
	(envelope-from <stable+bounces-242771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:20:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622084B5AC4
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B1743006B4A
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20DB3ACF19;
	Sun,  3 May 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3R7yK78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8016A956
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810852; cv=none; b=pjKQioMw0e23TIU/G20EYeT3k8nCsI5Ec7g2tN2W3Q+PXXr81bKnz/ksGZaV/J0Yd5rPgEN/hz/VRbIAj8wwi5uDXNFwaVjjdKeO14dSjHBRYnJRePO+Vj9BkQz6KelwsjOLMH9mYqhKnAfvQTAwdODKFLyb4sHlcD+KmoEBbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810852; c=relaxed/simple;
	bh=N7fvQaIYKxtrF4JirO/ovbhhcWvdZDyB1vfpNwkUDfY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eJWHh+mHMtwnHgl0Ten0QrUFHgfyU2fT/cIKCqKEqNZYXWXctFwaHZa5R92IL2ndfG36Zd7dqFdYh8vptu3YLn/b5v3+mvomjIktKbrJbJNkfyPwzi3UnTjCixovtth4FU/sMs9uh75poPckAxan950/VfmgJmE6MUAd+fhFP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3R7yK78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C946C2BCB4;
	Sun,  3 May 2026 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810852;
	bh=N7fvQaIYKxtrF4JirO/ovbhhcWvdZDyB1vfpNwkUDfY=;
	h=Subject:To:Cc:From:Date:From;
	b=o3R7yK789Wwq7gzhto9j38ejxeiq/OLfTrZWbyOGEdPHMwnU3wFoBKJReNog1MqWD
	 /Z8W9d/USOYXBXE6OPfPG9cU+RYdgqM4WKjDM/cFmLhAf5BCiciwXwsOb5+pfl1XNO
	 HDpfN2bnyA2zKpAL2FC/oadQ1WiOBlEe3O6SATF4=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers" failed to apply to 6.12-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:20:37 +0200
Message-ID: <2026050337-bony-ensure-fe23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 622084B5AC4
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
	TAGGED_FROM(0.00)[bounces-242771-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b786e34cde42922dace620e6f56f0858edae2311
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050337-bony-ensure-fe23@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b786e34cde42922dace620e6f56f0858edae2311 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:07 +0000
Subject: [PATCH] KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers

The wrappers provide little value and make it harder to see what KVM is
checking in the normal flow. Drop them.

Opportunistically fixup comments referring to the functions, adding '()'
to make it clear it's a reference to a function.

No functional change intended.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-14-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d0037f01fb98..0d447d044101 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -339,8 +339,8 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 	    kvm_vcpu_is_legal_gpa(vcpu, addr + size - 1);
 }
 
-static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
-					 struct vmcb_ctrl_area_cached *control)
+static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
+				       struct vmcb_ctrl_area_cached *control)
 {
 	if (CC(!vmcb12_is_intercept(control, INTERCEPT_VMRUN)))
 		return false;
@@ -367,8 +367,8 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 }
 
 /* Common checks that apply to both L1 and L2 state.  */
-static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
-				     struct vmcb_save_area_cached *save)
+static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
+				   struct vmcb_save_area_cached *save)
 {
 	if (CC(!(save->efer & EFER_SVME)))
 		return false;
@@ -402,22 +402,6 @@ static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	struct vmcb_save_area_cached *save = &svm->nested.save;
-
-	return __nested_vmcb_check_save(vcpu, save);
-}
-
-static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
-
-	return __nested_vmcb_check_controls(vcpu, ctl);
-}
-
 /*
  * If a feature is not advertised to L1, clear the corresponding vmcb12
  * intercept.
@@ -469,7 +453,7 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
-	/* Copy asid here because nested_vmcb_check_controls will check it.  */
+	/* Copy asid here because nested_vmcb_check_controls() will check it */
 	to->asid           = from->asid;
 	to->msrpm_base_pa &= ~0x0fffULL;
 	to->iopm_base_pa  &= ~0x0fffULL;
@@ -1030,8 +1014,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
-	if (!nested_vmcb_check_save(vcpu) ||
-	    !nested_vmcb_check_controls(vcpu)) {
+	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
+	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl)) {
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_info_1  = 0;
 		vmcb12->control.exit_info_2  = 0;
@@ -1877,12 +1861,12 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	ret = -EINVAL;
 	__nested_copy_vmcb_control_to_cache(vcpu, &ctl_cached, ctl);
-	if (!__nested_vmcb_check_controls(vcpu, &ctl_cached))
+	if (!nested_vmcb_check_controls(vcpu, &ctl_cached))
 		goto out_free;
 
 	/*
 	 * Processor state contains L2 state.  Check that it is
-	 * valid for guest mode (see nested_vmcb_check_save).
+	 * valid for guest mode (see nested_vmcb_check_save()).
 	 */
 	cr0 = kvm_read_cr0(vcpu);
         if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
@@ -1896,7 +1880,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
-	    !__nested_vmcb_check_save(vcpu, &save_cached))
+	    !nested_vmcb_check_save(vcpu, &save_cached))
 		goto out_free;
 
 


