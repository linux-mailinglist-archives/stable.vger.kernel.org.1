Return-Path: <stable+bounces-201093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9956FCBF963
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C420030142C6
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102B33A71A;
	Mon, 15 Dec 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixKmQ+ne"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3E33B6D3
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826955; cv=none; b=rS19kXOM9cE6Ez8YrvDqroBioPqR/HCtnLpqC+CA7VuxQ0gZq8VzNyEEl6f9zQ103K1+mvCC/dPK4AS6LlPD+12LgGuAOTUhtZ6S4FE4EHKXFB/3dVOITzr6/a8j0F7WvIXHS17ayALJr2Eut3+SuA6L2bck7duQDAAxpX4KRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826955; c=relaxed/simple;
	bh=vqmGtyNcxZBUMmzKTGuhJCdCvmt1hUpklV+9z4JMl2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4PG6sRY6tgyrqtqiwd29flcPcXV9y1LphsFvTms6xN8atYE7l3GiQ8YcWQUaPVaY0iWszjDEXofpHsqHHTykyCwr+cju/IJwLifzQpruO2zGTP69QcMCCtozdLi1tNt2IbWvaeoI3HhI/5eghkTlZ4H0ot1/G3Dl0W6tUgNAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixKmQ+ne; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765826946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGC+3I5jdDiVSdip2yon18Xgyc7ruVlajqlB/AAYT/0=;
	b=ixKmQ+neE0WHZlXSgpOlFrcv2U/YEMm2Y/eNi0QRIMx2HILg3XFrF2YywYFKuVrG13Cw7G
	k7DDSh+Z7uVZaUkOBCwDPQhBDeKwNwanq+b5WOf89TO/mo0Iwxh/Bd7wW5p1F377TPIyQB
	3efAh/5wm1LWNVm0+TvbOABByBUWQD4=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 14/26] KVM: nSVM: Clear EVENTINJ field in VMCB12 on nested #VMEXIT
Date: Mon, 15 Dec 2025 19:27:09 +0000
Message-ID: <20251215192722.3654335-16-yosry.ahmed@linux.dev>
In-Reply-To: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
References: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

According to the APM, from the reference of the VMRUN instruction:

	Upon #VMEXIT, the processor performs the following actions in
	order to return to the host execution context:
	...
	clear EVENTINJ field in VMCB

KVM correctly cleared EVENTINJ (i.e. event_inj and event_inj_err) on
nested #VMEXIT before commit 2d8a42be0e2b ("KVM: nSVM: synchronize VMCB
controls updated by the processor on every vmexit"). That commit made
sure the fields are synchronized between VMCB02 and KVM's cached VMCB12
on every L2->L0 #VMEXIT, such that they are serialized correctly on
save/restore.

However, the commit also incorrectly copied the fields from KVM's cached
VMCB12 to L1's VMCB12 on nested #VMEXIT. Go back to clearing the fields,
and so in __nested_svm_vmexit() instead of nested_svm_vmexit(), such
that it also applies to #VMEXITs caused by a failed VMRUN.

Fixes: 2d8a42be0e2b ("KVM: nSVM: synchronize VMCB controls updated by the processor on every vmexit")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 632e941febaf..b4074e674c9d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -937,7 +937,7 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 	return 0;
 }
 
-static void __nested_svm_vmexit(struct vcpu_svm *svm)
+static void __nested_svm_vmexit(struct vcpu_svm *svm, struct vmcb *vmcb12)
 {
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
@@ -949,6 +949,10 @@ static void __nested_svm_vmexit(struct vcpu_svm *svm)
 	svm_set_gif(svm, false);
 	vmcb01->control.exit_int_info = 0;
 
+	/* event_inj is cleared on #VMEXIT */
+	vmcb12->control.event_inj = 0;
+	vmcb12->control.event_inj_err = 0;
+
 	nested_svm_uninit_mmu_context(vcpu);
 	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true)) {
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
@@ -973,7 +977,7 @@ static void nested_svm_failed_vmrun(struct vcpu_svm *svm, struct vmcb *vmcb12)
 	vmcb12->control.exit_code_hi = -1u;
 	vmcb12->control.exit_info_1 = 0;
 	vmcb12->control.exit_info_2 = 0;
-	__nested_svm_vmexit(svm);
+	__nested_svm_vmexit(svm, vmcb12);
 }
 
 int nested_svm_vmrun(struct kvm_vcpu *vcpu)
@@ -1156,8 +1160,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
-	vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
-	vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;
 
 	if (!kvm_pause_in_guest(vcpu->kvm)) {
 		vmcb01->control.pause_filter_count = vmcb02->control.pause_filter_count;
@@ -1259,8 +1261,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 				       vmcb12->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
-	kvm_vcpu_unmap(vcpu, &map);
-
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/*
@@ -1282,7 +1282,9 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	 * Potentially queues an exception, so it needs to be after
 	 * kvm_clear_exception_queue() is called above.
 	 */
-	__nested_svm_vmexit(svm);
+	__nested_svm_vmexit(svm, vmcb12);
+
+	kvm_vcpu_unmap(vcpu, &map);
 }
 
 static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
-- 
2.52.0.239.gd5f0c6e74e-goog


