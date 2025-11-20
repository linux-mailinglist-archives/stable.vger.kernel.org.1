Return-Path: <stable+bounces-195286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C010BC752CA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0C9334641A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC04633AD84;
	Thu, 20 Nov 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wd6Dq2t2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CE2EB85E
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653861; cv=none; b=S0T3t2ma7cysSdVR0Vl1/p58NrufJdPwd+rzHeNSG49yrXw4ZLlv/Zl/HAA4UAbaIoJbRTeTD3vUceYWtY34emGGfSsry+ee6jeny/hPVr/G9m198H/JfZBufl20+fXe3mnthCyFQ9ivWMtcdIreNd4biCKOCGinj3FC4bJNS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653861; c=relaxed/simple;
	bh=XuhOrQ/5fffqVUt1LpeiCH02s/a6eOEEyRoswqHiNos=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fn0j4SErCxTXYDFqhGg0ZI2XLANiFobaER1qySJGYLEQQFIS27NQu2jIyKNS/8PELWLKhBT+aroLYiUc7phwuMO76r+FBs/wMoGwiMqbrULoZE+GTgyfj1eKy1Y9GmbirIHSpr8IAPMl5efFl4/ta1w6lWdpft1dpD2SXy1N9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wd6Dq2t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAA7C4CEF1;
	Thu, 20 Nov 2025 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653861;
	bh=XuhOrQ/5fffqVUt1LpeiCH02s/a6eOEEyRoswqHiNos=;
	h=Subject:To:Cc:From:Date:From;
	b=Wd6Dq2t2d3AAXWJb/w4C3eRsipw/a/n9p+RUNum3D6MQjh8l9KzOHdbzZJmKXJbUI
	 q1M/JbbpYeURRHOheYIwsGhIe1ALufBJVTcwRM+OjSexYfY7TIMRBVx48AOhJWCuTH
	 4vIT8ujgtiEVSXdPphLuwy8jTDyRnfxK1HFSPZf4=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Always recalculate LBR MSR intercepts in" failed to apply to 6.1-stable tree
To: yosry.ahmed@linux.dev,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:50:48 +0100
Message-ID: <2025112048-equation-nursery-dd67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fbe5e5f030c22ae717ee422aaab0e00ea84fab5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112048-equation-nursery-dd67@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbe5e5f030c22ae717ee422aaab0e00ea84fab5e Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry.ahmed@linux.dev>
Date: Sat, 8 Nov 2025 00:45:20 +0000
Subject: [PATCH] KVM: nSVM: Always recalculate LBR MSR intercepts in
 svm_update_lbrv()

svm_update_lbrv() is called when MSR_IA32_DEBUGCTLMSR is updated, and on
nested transitions where LBRV is used. It checks whether LBRV enablement
needs to be changed in the current VMCB, and if it does, it also
recalculate intercepts to LBR MSRs.

However, there are cases where intercepts need to be updated even when
LBRV enablement doesn't. Example scenario:
- L1 has MSR_IA32_DEBUGCTLMSR cleared.
- L1 runs L2 without LBR_CTL_ENABLE (no LBRV).
- L2 sets DEBUGCTLMSR_LBR in MSR_IA32_DEBUGCTLMSR, svm_update_lbrv()
  sets LBR_CTL_ENABLE in VMCB02 and disables intercepts to LBR MSRs.
- L2 exits to L1, svm_update_lbrv() is not called on this transition.
- L1 clears MSR_IA32_DEBUGCTLMSR, svm_update_lbrv() finds that
  LBR_CTL_ENABLE is already cleared in VMCB01 and does nothing.
- Intercepts remain disabled, L1 reads to LBR MSRs read the host MSRs.

Fix it by always recalculating intercepts in svm_update_lbrv().

Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251108004524.1600006-3-yosry.ahmed@linux.dev
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 39538098002b..53201f13a43c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -806,25 +806,29 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
-void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
-	svm_recalc_lbr_msr_intercepts(vcpu);
 
 	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
 	if (is_guest_mode(vcpu))
 		svm_copy_lbrs(svm->vmcb, svm->vmcb01.ptr);
 }
 
-static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
+void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+{
+	__svm_enable_lbrv(vcpu);
+	svm_recalc_lbr_msr_intercepts(vcpu);
+}
+
+static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
 	svm->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
-	svm_recalc_lbr_msr_intercepts(vcpu);
 
 	/*
 	 * Move the LBR msrs back to the vmcb01 to avoid copying them
@@ -853,13 +857,18 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
 			    (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
 
-	if (enable_lbrv == current_enable_lbrv)
-		return;
+	if (enable_lbrv && !current_enable_lbrv)
+		__svm_enable_lbrv(vcpu);
+	else if (!enable_lbrv && current_enable_lbrv)
+		__svm_disable_lbrv(vcpu);
 
-	if (enable_lbrv)
-		svm_enable_lbrv(vcpu);
-	else
-		svm_disable_lbrv(vcpu);
+	/*
+	 * During nested transitions, it is possible that the current VMCB has
+	 * LBR_CTL set, but the previous LBR_CTL had it cleared (or vice versa).
+	 * In this case, even though LBR_CTL does not need an update, intercepts
+	 * do, so always recalculate the intercepts here.
+	 */
+	svm_recalc_lbr_msr_intercepts(vcpu);
 }
 
 void disable_nmi_singlestep(struct vcpu_svm *svm)


