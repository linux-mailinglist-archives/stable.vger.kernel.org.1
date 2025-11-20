Return-Path: <stable+bounces-195433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA08C76A28
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 00:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E07B74E3CD2
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 23:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D822F7475;
	Thu, 20 Nov 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qqG53H6k"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2A2E8B6C
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682000; cv=none; b=ASO8/HM/7xHwXRbiDhejmGu82SLCR1uF/tqZSQu1eZ6jzeI1Aa+PImOE+CUZRfCb32zdhMBKWEkgIXYjjwFr52N4GXi0tP/S0gwA1YcqTOuB/KU6NptrOmkc4gr4fLEnfX91L/xG+PX6SV6G36IpKyu/VtaNJ8gl7aONlBXIi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682000; c=relaxed/simple;
	bh=uj8BiBCOAdDNaVXDUcKALAITuftA2esDdINn5xriajg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qg7FtVkJYaCYZZjfIWZRd3dmDi++y3iyCmykn9fIKpwAc4r54p/9B/cKrIMYQKgEkVh6r0GbFHABqKY+E1MyCoOGBm/MTn/8+TBZ8RkSSc2iH/rQGPa5dIUrrxDT0wZCwoR1Bz1rQEijRNcW6pXJx1togBG12d+BtN2H1rNILoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qqG53H6k; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763681996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFinHP/5jKYph4dSgOMoig7udwTjmS3RnrnAf5o2tKw=;
	b=qqG53H6kND0wxhRTjqXbDjh3auo/BYE+jLsm3LV2ASi0aZs2a0bRGwX0coC/cQ7UGkkXFk
	MDiL7o7ig4Vj/aDVMDFUnibEIYjCWjI7GsGLxawiDrp30tAA7MF1+kZtrwZ82Sv0JhWZUL
	V+fJ9mmaAMUowr1+sTPe7fojrXxQG1E=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.12.y 3/5] KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
Date: Thu, 20 Nov 2025 23:39:34 +0000
Message-ID: <20251120233936.2407119-4-yosry.ahmed@linux.dev>
In-Reply-To: <20251120233936.2407119-1-yosry.ahmed@linux.dev>
References: <2025112046-confider-smelting-6296@gregkh>
 <20251120233936.2407119-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
(cherry picked from commit fbe5e5f030c22ae717ee422aaab0e00ea84fab5e)

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1e1210e5ef45..e3e570d11b26 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1014,26 +1014,30 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 				     !intercept, !intercept);
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
@@ -1062,13 +1066,18 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 			    (is_guest_mode(vcpu) && guest_can_use(vcpu, X86_FEATURE_LBRV) &&
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
-- 
2.52.0.rc2.455.g230fcf2819-goog


