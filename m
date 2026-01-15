Return-Path: <stable+bounces-208399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69273D21F5F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 02:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C0C4301C3B1
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DB275AF5;
	Thu, 15 Jan 2026 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMpm+vlS"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56C248F4E
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439636; cv=none; b=Pa2UbSQWaq8VnKKBQDdeYXBCBzVgbrP21N4I8h+rf+3fTUxHdoqEO3A1zlHwjpv8OtgiluX8NK+BunQuQJkMUqdRYAcCmqxSWtx/fjCnCDQJuS5NGg2kiz35DjdOH5h6/wz1uzjqoiVA2KNnPhW+T8P9N+9DI1P5gZqE/Y4prhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439636; c=relaxed/simple;
	bh=m5o2l7lgFNmJcT3VJ87p2Uu/LmytSoMZzA3lD3R5fSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih337Exow8khS+jbKdZfA8DEDOvvXdHjHuHMANBAss7FKpFfgPCQAhENLxp7ni/yyHMK1mClTAEPkP0uItmWudSUpivbOWoeARr5GPK88BbkTQaJtBlZ4IaiGQP50lJ12ZspH2TZ2WVm/LWrxWRO8Gzv4xUg2f5Y2cqwJA/eHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMpm+vlS; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768439624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtVei9vob9XjSXdk/KBHveFzcLTnS2073L1TnPacuR0=;
	b=gMpm+vlSFvy9h6dXqmtDxa3hiBiX5reDI0IpcxSyS9fJkL/jIjDvePf8UMsPtJmL9zd8Tj
	+sfDozcN+ZaxD6mWnpdu2zHG3z2EbvdhYKm5AU9qtQ4zonJzOnBIwlED4yRoPBUI7wk2gM
	GUZG2xuYY1HSWOPF7sJj5IVKSyxhKKU=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 10/26] KVM: nSVM: Call nested_svm_merge_msrpm() from enter_svm_guest_mode()
Date: Thu, 15 Jan 2026 01:12:56 +0000
Message-ID: <20260115011312.3675857-11-yosry.ahmed@linux.dev>
In-Reply-To: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
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
index 0915785f7770..debbce5c6511 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -960,6 +960,12 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
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
 
@@ -1039,23 +1045,18 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
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
2.52.0.457.g6b5491de43-goog


