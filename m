Return-Path: <stable+bounces-201089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79011CBF948
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE81C301CC68
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728C33A00C;
	Mon, 15 Dec 2025 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLjom6v+"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E133971D
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826928; cv=none; b=QTtecuh8fhvvJJdyWc3FOpq3q8/lU+DtNq8PK5CAWgyljv7MVlEw2PUl0/rv7rh5YLzHGvbBwDzVpLe85hQtfekchZHIhae9kPlbJKC7biQzsiTdY+L3YBmGn+JknPjpBkweCnMF1z9cpTCFXKCxLiOI4imZNf8c7RVM08qZdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826928; c=relaxed/simple;
	bh=G/5aG6ilO/1HIWzHLixaDDvQf/ELiOu3l7OmH5i4uL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwuDUro7gzDsSjEwMFYzvYh/UL+OYGUPyBIkiNtUgkrkhA6s5TMz4kKaBnWBha3AnVdKE9n7ckHQ5DeDhQjwsCXx0VCGVuu5VusmYmU2L0dkhLGmN859Bzftwtcn3sbS8euuY2l1hWUoOo2b/VYmq9TP/mv+f6ZQmu33F9GM6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLjom6v+; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765826920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3renCjBOww4D5xaTY3cNu6rR82M1AEz57jETKzGkjd0=;
	b=TLjom6v+hgUrlw++FyuuylJHRAJXB9d/sUoCe3DssAFRjask/jc9uAgWP53QkTvDqQsiui
	LoYAKcg0zUi6EnG/g75cOHIrjSUMueDJcHJh9hEiXbvVT9bvZ2gJqPyA4Vdphxm+lXoXO4
	XvpDjrfiWDg1p/TZQg2qPvzetR/r1yA=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 10/26] KVM: nSVM: Call nested_svm_merge_msrpm() from enter_svm_guest_mode()
Date: Mon, 15 Dec 2025 19:27:05 +0000
Message-ID: <20251215192722.3654335-12-yosry.ahmed@linux.dev>
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

In preparation for unifying the VMRUN failure code paths, move calling
nested_svm_merge_msrpm() into enter_svm_guest_mode() next to the
nested_svm_load_cr3() call (the other failure path in
enter_svm_guest_mode()).

Adding more uses of the from_vmrun parameter is not pretty, but it is
plumbed all the way to nested_svm_load_cr3() so it's not going away soon
anyway.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f46e97008492..2ee9d8bef5ba 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -911,6 +911,12 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 	if (ret)
 		return ret;
 
+	if (from_vmrun) {
+		ret = nested_svm_merge_msrpm(vcpu);
+		if (ret)
+			return ret;
+	}
+
 	if (!from_vmrun)
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
@@ -990,23 +996,18 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
 	svm->nested.nested_run_pending = 1;
 
-	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
-		goto out_exit_err;
-
-	if (!nested_svm_merge_msrpm(vcpu))
-		goto out;
-
-out_exit_err:
-	svm->nested.nested_run_pending = 0;
-	svm->nmi_l1_to_l2 = false;
-	svm->soft_int_injected = false;
+	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true)) {
+		svm->nested.nested_run_pending = 0;
+		svm->nmi_l1_to_l2 = false;
+		svm->soft_int_injected = false;
 
-	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
-	svm->vmcb->control.exit_code_hi = -1u;
-	svm->vmcb->control.exit_info_1  = 0;
-	svm->vmcb->control.exit_info_2  = 0;
+		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
+		svm->vmcb->control.exit_code_hi = -1u;
+		svm->vmcb->control.exit_info_1  = 0;
+		svm->vmcb->control.exit_info_2  = 0;
 
-	nested_svm_vmexit(svm);
+		nested_svm_vmexit(svm);
+	}
 
 out:
 	kvm_vcpu_unmap(vcpu, &map);
-- 
2.52.0.239.gd5f0c6e74e-goog


