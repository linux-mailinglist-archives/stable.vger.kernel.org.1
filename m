Return-Path: <stable+bounces-199905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF18CA145F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C526432E63B0
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B83164DE;
	Wed,  3 Dec 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZSVoivPx"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16363242D7C
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787375; cv=none; b=RKROEfc/D6u2cyBQBiX06we+T/CHdR4qArOGc35+q3ytN76ft71tThEaZW+NVhK8Dz2afRtDm99k6aEQEElINUGu1rrW24KYuYojK7CbeZymtmKgCphy3WoPkOkjlB9MQLqNqf8lSBOrFQoKPvjYL8ozWHDlgyqB9rL5hxDNhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787375; c=relaxed/simple;
	bh=BNEH2QCWii1/LrBhDWcxCq+BmD7w7Dr3628X6WT9SkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk/Q6cxmmjUSfGIcxONYmNAzWExIaZjdWQs0S8RqZRURgtbWRJMb8yv88bNQWdt9S8j1rqWO9l+Hg+PIywuc5MZK34QeR97CN4T5339kPRojCHKal4pQo1K7Ok5aDvhKFEyCWDyYVTv3XGM5nNLCLfHdF9uAmyKWsGe4tE5xzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZSVoivPx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764787371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8MFhTY1g2LltiOxbEIBFOl+bVoRSS/XDw0b8xv0Bvo=;
	b=ZSVoivPxrIakGhIXFAsQ7xW30xaZHXaW9fneenx2Xj7opWyYXwTJCmZKAIkyMxVLs9ADMV
	bk6fbT3s3aKinL5VQhoeALfdcHJBLrKh4+WK6wW9/spaQT6BEbSH45Nhl25eWaP9iPPH3y
	acMNqH0a1CdQ3+iaQy6tgZEAfH6R3cg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 6.6.y 2/4] KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
Date: Wed,  3 Dec 2025 18:42:18 +0000
Message-ID: <20251203184220.2693264-2-yosry.ahmed@linux.dev>
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
index d0bfcf737512..9254e662c78c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1028,26 +1028,30 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
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
@@ -1076,13 +1080,18 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
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
2.52.0.158.g65b55ccf14-goog


