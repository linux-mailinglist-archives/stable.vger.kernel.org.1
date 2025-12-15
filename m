Return-Path: <stable+bounces-201084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09784CBF8A3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44B5F3015D14
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199AD3358CA;
	Mon, 15 Dec 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvaXVoN1"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115233374B
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826897; cv=none; b=qYZFNWNI3Y9QZKxdio5VsOFZaJafS0oDA9qoV4Xbm2EDMFeAjCh1IYx+92Qe5vSKto1qaUIKymmsvmkS71bqysOOP2pkjbX+eSiJbJJfKJzJ37cELLHELFvdNYDYfLV89I926t8OV9Pgc/awxc2sHgr2tomftnlbjXXDNc9E7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826897; c=relaxed/simple;
	bh=h+iuLlFRcl6c9NLyEW1CdLyWZbKvYmk7h9fYlqoJNRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxMuzuHpzm2rZHK/8atMfCbhiJUUrpqjBr56T675HEAfPYKezqZDYd2lYF9dBI/nApyUod+N+KoarnJRXCX1myMYvtCTrpvlgOgn+HZh86ht0Dg3uOmlsrQ2JXrr77SVo80a7eLduWiEdQ0dFJ9WxO9BeApGj4YLc6f4tWWNcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvaXVoN1; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765826889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiGyeLhYElDyqRv1pQ6xp6qJfHPlEL9LQfOUQxzhz2M=;
	b=uvaXVoN1aKbMGGQZEHQhiYCZpvgKdrVfakhrX47A9GrxEvcZMRQ2rTSBew55xfdju8XCBd
	mLkQZrYz5lESHKG8raa55whw/vP1IxfMxp6ESPjZRKgJi4xU1uAzRZ+VNXxWYuYywdZOGJ
	e3YlEOY98rarXR0PDNEyeN6RqEKIk/U=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 05/26] KVM: nSVM: Triple fault if mapping VMCB12 fails on nested #VMEXIT
Date: Mon, 15 Dec 2025 19:27:00 +0000
Message-ID: <20251215192722.3654335-7-yosry.ahmed@linux.dev>
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

KVM currently injects a #GP and hopes for the best if mapping VMCB12
fails on nested #VMEXIT, and only if the failure mode is -EINVAL.
Mapping the VMCB12 could also fail if creating host mappings fails.

After the #GP is injected, nested_svm_vmexit() bails early, without
cleaning up (e.g. KVM_REQ_GET_NESTED_STATE_PAGES is set, is_guest_mode()
is true, etc). Move mapping VMCB12 a bit later, after leaving guest mode
and clearing KVM_REQ_GET_NESTED_STATE_PAGES, right before the VMCB12 is
actually used.

Instead of optionally injecting a #GP, triple fault the guest if mapping
VMCB12 fails since KVM cannot make a sane recovery. The APM states that
a #VMEXIT will triple fault if host state is illegal or an exception
occurs while loading host state, so the behavior is not entirely made
up.

Also update the WARN_ON() in svm_get_nested_state_pages() to
WARN_ON_ONCE() to avoid future user-triggeable bugs spamming kernel logs
and potentially causing issues.

Fixes: cf74a78b229d ("KVM: SVM: Add VMEXIT handler and intercepts")
CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a5a367fd8bb1..e6b87ae46783 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1078,24 +1078,14 @@ void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 int nested_svm_vmexit(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
+	gpa_t vmcb12_gpa = svm->nested.vmcb12_gpa;
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 	struct vmcb *vmcb12;
 	struct kvm_host_map map;
-	int rc;
-
-	rc = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map);
-	if (rc) {
-		if (rc == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
-
-	vmcb12 = map.hva;
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
-	svm->nested.vmcb12_gpa = 0;
 	WARN_ON_ONCE(svm->nested.nested_run_pending);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
@@ -1103,8 +1093,16 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	/* in case we halted in L2 */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 
+	svm->nested.vmcb12_gpa = 0;
+
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+		return 1;
+	}
+
 	/* Give the current vmcb to the guest */
 
+	vmcb12 = map.hva;
 	vmcb12->save.es     = vmcb02->save.es;
 	vmcb12->save.cs     = vmcb02->save.cs;
 	vmcb12->save.ss     = vmcb02->save.ss;
@@ -1259,8 +1257,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	nested_svm_uninit_mmu_context(vcpu);
 
-	rc = nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true);
-	if (rc)
+	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
 		return 1;
 
 	/*
@@ -1893,7 +1890,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
-	if (WARN_ON(!is_guest_mode(vcpu)))
+	if (WARN_ON_ONCE(!is_guest_mode(vcpu)))
 		return true;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
-- 
2.52.0.239.gd5f0c6e74e-goog


