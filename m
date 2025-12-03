Return-Path: <stable+bounces-199906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B031CA1155
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 797293006478
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2439131355B;
	Wed,  3 Dec 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSbWhJWn"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5363317706
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787377; cv=none; b=u+w7FkdJLM4extGTfGZQt5Ye32qnfRNWwu263sQMo/uD3U6Sb8K1u/XKzPoO7Jox7Oca7YNuS4E7QDpwFMCKytvcVZGuezRr4Q5cw9feL6NdcPCemyR2jBDN0g0m5UcNkAc7x3OkYtPozrDQlGLnp9CD0qkcfLTocVRwAzF9NKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787377; c=relaxed/simple;
	bh=Mdv4ha1gLeeRCZgIiSRrpr6M8zV6CzRSSmus2o+DOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ7W1Agc357zL05+sDdvuzyUzumBFQ9PDJ5mlACHyANruXp6IC7+jcOQJlfEL+Wq8DUXw0rAxLapRAv/9uFdge0AFsmJxlB1nTjhN1gdKYyfTl8u+8fhjZ3MLZtry4ubs2MtulmOCaFl5sEJI+L6GKCJKTjdjF/PbrQHH+6yS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eSbWhJWn; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764787373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Vk7OEI/5qFavSRfNvjUWpoyjbDOAgiy1w7ds90fEyQ=;
	b=eSbWhJWn1crQyJCeqiPn+ZiLwvLJHpXB9q5K+A2T/YMx+wXbMXrqGk4TnzEpcBmFiwQaOJ
	45pJKN7cyZqInm1TaWV4St3tStyT01pC34B3Uw7fRPgtfsfKH20/sq874I8lnu+KBEEt82
	YOAEO5RjQ7c/sPmSu5V7MsVQmuE2Tu4=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 6.6.y 4/4] KVM: SVM: Fix redundant updates of LBR MSR intercepts
Date: Wed,  3 Dec 2025 18:42:20 +0000
Message-ID: <20251203184220.2693264-4-yosry.ahmed@linux.dev>
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

Don't update the LBR MSR intercept bitmaps if they're already up-to-date,
as unconditionally updating the intercepts forces KVM to recalculate the
MSR bitmaps for vmcb02 on every nested VMRUN.  The redundant updates are
functionally okay; however, they neuter an optimization in Hyper-V
nested virtualization enlightenments and this manifests as a self-test
failure.

In particular, Hyper-V lets L1 mark "nested enlightenments" as clean, i.e.
tell KVM that no changes were made to the MSR bitmap since the last VMRUN.
The hyperv_svm_test KVM selftest intentionally changes the MSR bitmap
"without telling KVM about it" to verify that KVM honors the clean hint,
correctly fails because KVM notices the changed bitmap anyway:

  ==== Test Assertion Failure ====
  x86/hyperv_svm_test.c:120: vmcb->control.exit_code == 0x081
  pid=193558 tid=193558 errno=4 - Interrupted system call
     1	0x0000000000411361: assert_on_unhandled_exception at processor.c:659
     2	0x0000000000406186: _vcpu_run at kvm_util.c:1699
     3	 (inlined by) vcpu_run at kvm_util.c:1710
     4	0x0000000000401f2a: main at hyperv_svm_test.c:175
     5	0x000000000041d0d3: __libc_start_call_main at libc-start.o:?
     6	0x000000000041f27c: __libc_start_main_impl at ??:?
     7	0x00000000004021a0: _start at ??:?
  vmcb->control.exit_code == SVM_EXIT_VMMCALL

Do *not* fix this by skipping svm_hv_vmcb_dirty_nested_enlightenments()
when svm_set_intercept_for_msr() performs a no-op change.  changes to
the L0 MSR interception bitmap are only triggered by full CPUID updates
and MSR filter updates, both of which should be rare.  Changing
svm_set_intercept_for_msr() risks hiding unintended pessimizations
like this one, and is actually more complex than this change.

Fixes: fbe5e5f030c2 ("KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251112013017.1836863-1-yosry.ahmed@linux.dev
[Rewritten commit message based on mailing list discussion. - Paolo]
Reviewed-by: Sean Christopherson <seanjc@google.com>
Tested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3fa05f96fc08dff5e846c2cc283a249c1bf029a1)

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 6 ++++++
 arch/x86/kvm/svm/svm.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c5d66ded7ebb..097abdd1973b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1014,6 +1014,9 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool intercept = !(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK);
 
+	if (intercept == svm->lbr_msrs_intercepted)
+		return;
+
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP,
 			     !intercept, !intercept);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP,
@@ -1026,6 +1029,8 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 	if (sev_es_guest(vcpu->kvm))
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_DEBUGCTLMSR,
 				     !intercept, !intercept);
+
+	svm->lbr_msrs_intercepted = intercept;
 }
 
 static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
@@ -1470,6 +1475,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	}
 
 	svm->x2avic_msrs_intercepted = true;
+	svm->lbr_msrs_intercepted = true;
 
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 81f00177f501..a73340a5c699 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -288,6 +288,7 @@ struct vcpu_svm {
 	bool guest_state_loaded;
 
 	bool x2avic_msrs_intercepted;
+	bool lbr_msrs_intercepted;
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
-- 
2.52.0.158.g65b55ccf14-goog


