Return-Path: <stable+bounces-199907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DFCA1158
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 033D23002508
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D8313E22;
	Wed,  3 Dec 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XLKfegII"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D44257459
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787378; cv=none; b=N5ga/SDiTU4AqkEsBFGBLJvsaTiFkRXmkhg+qsbJafdhId3FvR4dRFgkG7NVz/R/Nu9L2WA0co45KFaQSeODmBu56L8qPTbu3c/mlNZ7vg/eGSXY6OEHum07SizA4fOzhHGtwD1ehTniWxSxM0eOhRafqmiwz1VAtJ/uXsEfoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787378; c=relaxed/simple;
	bh=QuzOpPeocTPGfP5e1/xPzfJQzyFlT5xFCe1OiTzaZlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCiR/kAktPOKEmIawCnYHnrpY+yDCdQMzBANpnHxrc7XllMJCRv0cKfbr0NUBSeyWz2w6pD+kLizEXbZ6MYrpNjadfVGYdmu+KgExu7sg18r0yCb21GVRUsewEKbdj4sLTUHzg/wQ7110YsYMXL/5YYQVuY8dLcO53WmAAk18kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XLKfegII; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764787372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZPLzjPAzyRurEk08w8CVhOU5Lc/ii4Zqx54pKM+Epg=;
	b=XLKfegIImYEiyACAT0ReKCC8XvE/EgV+w2pJ00xcCkZCwZXYaFItpenv2t23UoK5N+19zD
	Myi3OPPzMatT1rtiabzLFsFdAZAq1yEzCAgyDiN0oOwKQwiqmLdLDl2VC4EBpZRFgHFNTq
	2JaZfjyX4tR0vD1PwrKPZkWMBePL12s=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 6.6.y 3/4] KVM: nSVM: Fix and simplify LBR virtualization handling with nested
Date: Wed,  3 Dec 2025 18:42:19 +0000
Message-ID: <20251203184220.2693264-3-yosry.ahmed@linux.dev>
In-Reply-To: <20251203184220.2693264-1-yosry.ahmed@linux.dev>
References: <2025112059-labrador-contently-dd98@gregkh>
 <20251203184220.2693264-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
(cherry picked from commit 8a4821412cf2c1429fffa07c012dd150f2edf78c)

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 20 ++++++-----------
 arch/x86/kvm/svm/svm.c    | 47 +++++++++------------------------------
 2 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e3f3e30fc89c..1577e6063da7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -600,11 +600,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
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
@@ -729,11 +728,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 			svm->soft_int_next_rip = vmcb12_rip;
 	}
 
-	vmcb02->control.virt_ext            = vmcb01->control.virt_ext &
-					      LBR_CTL_ENABLE_MASK;
-	if (guest_can_use(vcpu, X86_FEATURE_LBRV))
-		vmcb02->control.virt_ext  |=
-			(svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK);
+	/* LBR_CTL_ENABLE_MASK is controlled by svm_update_lbrv() */
 
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		vmcb02->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
@@ -1064,13 +1059,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
 	if (unlikely(guest_can_use(vcpu, X86_FEATURE_LBRV) &&
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
index 9254e662c78c..c5d66ded7ebb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1030,13 +1030,7 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 
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
@@ -1047,36 +1041,15 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 
 static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_svm *svm = to_svm(vcpu);
-
 	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
-
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
 			    (is_guest_mode(vcpu) && guest_can_use(vcpu, X86_FEATURE_LBRV) &&
 			    (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
 
@@ -2921,19 +2894,19 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -3202,10 +3175,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
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
-- 
2.52.0.158.g65b55ccf14-goog


