Return-Path: <stable+bounces-195288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F3C7522B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DAECC2BACA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236235502C;
	Thu, 20 Nov 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfdKy82X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01309340A63
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653870; cv=none; b=UNtGm4drYoWu8uGK4lRIYaZhe62uFU71RoFs/LacUwJIx2WknfeP0RgNftZ5JWeoIdkZ5ziERCzEKM7jt6J45R8fPVCQbUoapXpktJyoRtTTMxzHPtoBfr/jDoe27Lbz0IyhC+T7jmPnTLYBuSvrMzdgid43Z+8b+W8nF0MYP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653870; c=relaxed/simple;
	bh=igmgNGoUAhqd6FLAMfuv2F91s8w9aEEQPNLfMoS09Vc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XlQ8Jh+O20AHkgi+YL/D/5cabQ8Nd8edVbZ3PqnwEE5bJPdej6ngYzZfG9//GKu3/JY5wnlnT25ly561NnFuvJJVJ0oYktIrcPoadV9aOTDhNObDfkHqINvTKDctIHxA7vGUkYEX99V41SshY35jimOenjJlMxmzs7yR5wFQ0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfdKy82X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67419C4CEF1;
	Thu, 20 Nov 2025 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653869;
	bh=igmgNGoUAhqd6FLAMfuv2F91s8w9aEEQPNLfMoS09Vc=;
	h=Subject:To:Cc:From:Date:From;
	b=cfdKy82X3VcPgtG0f4Gy7JqOVVuO9qflioFF8avE4o0UnscZ9i9RIsMCGHPqvZ8/B
	 e6OtbAgQCa1pgGDmptWSWIPMoecsZtkiJn6WO09RFStYQTjaqwM0gpMvjIIaKGVgts
	 yI7/h9C6wBvknNyLH4jtkPTVOFR57XvRAie2GRtU=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Fix and simplify LBR virtualization handling with" failed to apply to 6.12-stable tree
To: yosry.ahmed@linux.dev,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:50:59 +0100
Message-ID: <2025112058-passenger-nerd-c32d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8a4821412cf2c1429fffa07c012dd150f2edf78c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112058-passenger-nerd-c32d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a4821412cf2c1429fffa07c012dd150f2edf78c Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry.ahmed@linux.dev>
Date: Sat, 8 Nov 2025 00:45:21 +0000
Subject: [PATCH] KVM: nSVM: Fix and simplify LBR virtualization handling with
 nested

The current scheme for handling LBRV when nested is used is very
complicated, especially when L1 does not enable LBRV (i.e. does not set
LBR_CTL_ENABLE_MASK).

To avoid copying LBRs between VMCB01 and VMCB02 on every nested
transition, the current implementation switches between using VMCB01 or
VMCB02 as the source of truth for the LBRs while L2 is running. If L2
enables LBR, VMCB02 is used as the source of truth. When L2 disables
LBR, the LBRs are copied to VMCB01 and VMCB01 is used as the source of
truth. This introduces significant complexity, and incorrect behavior in
some cases.

For example, on a nested #VMEXIT, the LBRs are only copied from VMCB02
to VMCB01 if LBRV is enabled in VMCB01. This is because L2's writes to
MSR_IA32_DEBUGCTLMSR to enable LBR are intercepted and propagated to
VMCB01 instead of VMCB02. However, LBRV is only enabled in VMCB02 when
L2 is running.

This means that if L2 enables LBR and exits to L1, the LBRs will not be
propagated from VMCB02 to VMCB01, because LBRV is disabled in VMCB01.

There is no meaningful difference in CPUID rate in L2 when copying LBRs
on every nested transition vs. the current approach, so do the simple
and correct thing and always copy LBRs between VMCB01 and VMCB02 on
nested transitions (when LBRV is disabled by L1). Drop the conditional
LBRs copying in __svm_{enable/disable}_lbrv() as it is now unnecessary.

VMCB02 becomes the only source of truth for LBRs when L2 is running,
regardless of LBRV being enabled by L1, drop svm_get_lbr_vmcb() and use
svm->vmcb directly in its place.

Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251108004524.1600006-4-yosry.ahmed@linux.dev
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a6443feab252..da6e80b3ac35 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -677,11 +677,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 		 */
 		svm_copy_lbrs(vmcb02, vmcb12);
 		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
-		svm_update_lbrv(&svm->vcpu);
-
-	} else if (unlikely(vmcb01->control.virt_ext & LBR_CTL_ENABLE_MASK)) {
+	} else {
 		svm_copy_lbrs(vmcb02, vmcb01);
 	}
+	svm_update_lbrv(&svm->vcpu);
 }
 
 static inline bool is_evtinj_soft(u32 evtinj)
@@ -833,11 +832,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 			svm->soft_int_next_rip = vmcb12_rip;
 	}
 
-	vmcb02->control.virt_ext            = vmcb01->control.virt_ext &
-					      LBR_CTL_ENABLE_MASK;
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
-		vmcb02->control.virt_ext  |=
-			(svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK);
+	/* LBR_CTL_ENABLE_MASK is controlled by svm_update_lbrv() */
 
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		vmcb02->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
@@ -1189,13 +1184,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
 	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK)))
 		svm_copy_lbrs(vmcb12, vmcb02);
-		svm_update_lbrv(vcpu);
-	} else if (unlikely(vmcb01->control.virt_ext & LBR_CTL_ENABLE_MASK)) {
+	else
 		svm_copy_lbrs(vmcb01, vmcb02);
-		svm_update_lbrv(vcpu);
-	}
+
+	svm_update_lbrv(vcpu);
 
 	if (vnmi) {
 		if (vmcb02->control.int_ctl & V_NMI_BLOCKING_MASK)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 53201f13a43c..10c21e4c5406 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -808,13 +808,7 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 
 static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_svm *svm = to_svm(vcpu);
-
-	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
-
-	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
-	if (is_guest_mode(vcpu))
-		svm_copy_lbrs(svm->vmcb, svm->vmcb01.ptr);
+	to_svm(vcpu)->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
 }
 
 void svm_enable_lbrv(struct kvm_vcpu *vcpu)
@@ -825,35 +819,15 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 
 static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_svm *svm = to_svm(vcpu);
-
 	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
-	svm->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
-
-	/*
-	 * Move the LBR msrs back to the vmcb01 to avoid copying them
-	 * on nested guest entries.
-	 */
-	if (is_guest_mode(vcpu))
-		svm_copy_lbrs(svm->vmcb01.ptr, svm->vmcb);
-}
-
-static struct vmcb *svm_get_lbr_vmcb(struct vcpu_svm *svm)
-{
-	/*
-	 * If LBR virtualization is disabled, the LBR MSRs are always kept in
-	 * vmcb01.  If LBR virtualization is enabled and L1 is running VMs of
-	 * its own, the MSRs are moved between vmcb01 and vmcb02 as needed.
-	 */
-	return svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK ? svm->vmcb :
-								   svm->vmcb01.ptr;
+	to_svm(vcpu)->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
 }
 
 void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool current_enable_lbrv = svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK;
-	bool enable_lbrv = (svm_get_lbr_vmcb(svm)->save.dbgctl & DEBUGCTLMSR_LBR) ||
+	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
 			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
 			    (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
 
@@ -2733,19 +2707,19 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = svm->tsc_aux;
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
-		msr_info->data = svm_get_lbr_vmcb(svm)->save.dbgctl;
+		msr_info->data = svm->vmcb->save.dbgctl;
 		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
-		msr_info->data = svm_get_lbr_vmcb(svm)->save.br_from;
+		msr_info->data = svm->vmcb->save.br_from;
 		break;
 	case MSR_IA32_LASTBRANCHTOIP:
-		msr_info->data = svm_get_lbr_vmcb(svm)->save.br_to;
+		msr_info->data = svm->vmcb->save.br_to;
 		break;
 	case MSR_IA32_LASTINTFROMIP:
-		msr_info->data = svm_get_lbr_vmcb(svm)->save.last_excp_from;
+		msr_info->data = svm->vmcb->save.last_excp_from;
 		break;
 	case MSR_IA32_LASTINTTOIP:
-		msr_info->data = svm_get_lbr_vmcb(svm)->save.last_excp_to;
+		msr_info->data = svm->vmcb->save.last_excp_to;
 		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
@@ -3013,10 +2987,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
-		if (svm_get_lbr_vmcb(svm)->save.dbgctl == data)
+		if (svm->vmcb->save.dbgctl == data)
 			break;
 
-		svm_get_lbr_vmcb(svm)->save.dbgctl = data;
+		svm->vmcb->save.dbgctl = data;
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		svm_update_lbrv(vcpu);
 		break;


