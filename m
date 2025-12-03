Return-Path: <stable+bounces-199904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0751CA1460
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E39DE32DB48C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058C3093C3;
	Wed,  3 Dec 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQIBuQGY"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D93164C5
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787375; cv=none; b=SqkFKB1MPCw2bPHdCTyxT3OJ2RpL7vQCHJGSUT+sAQk7QEVXToyDPoQspbsrGI2qDk2DyfINSsneu00Rj5tmS2Jl2WD62+4TttPUmy2YkZgg6YVMbXP/rEHRxFU7SS6foKoa+jYRs7ZedRms/t79my014rGmyUI4YVYheg4j2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787375; c=relaxed/simple;
	bh=n0tJua9+02fHhH5qeSOeuS2+p3nHuh5vtuietnNo9fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGNPKlYZyJz2zNBeT6Vfuue8dEazPqRYuBOgNafeqG7ZSfprq2QKGjJD3eNqdBz3DVP2PUl1KizetwuvYSCbnun+LIjX45Ck4NupZxx0YNlT4aHuaBsYCPdTENMhjMPkAYTvO87JtSd5sxjyNGJSBo+TQRF1tvqHBfIViIEtc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQIBuQGY; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764787369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQUv+WGjmXGw1sOpM5UH7nCy5ZT8LQ0vahCvp0Opnpk=;
	b=PQIBuQGY3OcTQq1CUIWEU0VlOCJbFp8MqLeQyx8FQZJhlAxwEABN09NWy+XmM1cVmaAJDd
	GBbdrCQKVF/lkyCJ0CQ+TwOql+baa0trCOK5EGEfl5JdjiPseJKTGR7wbukTbc7gqrkoYM
	F/tyaj49LG9d0GHaYCWYt3q4tFZOWUc=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 6.6.y 1/4] KVM: SVM: Introduce svm_recalc_lbr_msr_intercepts()
Date: Wed,  3 Dec 2025 18:42:17 +0000
Message-ID: <20251203184220.2693264-1-yosry.ahmed@linux.dev>
In-Reply-To: <2025112059-labrador-contently-dd98@gregkh>
References: <2025112059-labrador-contently-dd98@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a helper updating the intercepts for LBR MSRs, similar to the
one introduced upstream by commit 160f143cc131 ("KVM: SVM: Manually
recalc all MSR intercepts on userspace MSR filter change"). The main
difference is that this version uses set_msr_interception(), which has
inverted polarity compared to svm_set_intercept_for_msr().

This is intended to simplify incoming backports. No functional changes
intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 99180d0af3ea..d0bfcf737512 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1009,18 +1009,31 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
-void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	bool intercept = !(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK);
 
-	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 1, 1);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP,
+			     !intercept, !intercept);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP,
+			     !intercept, !intercept);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP,
+			     !intercept, !intercept);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP,
+			     !intercept, !intercept);
 
 	if (sev_es_guest(vcpu->kvm))
-		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_DEBUGCTLMSR, 1, 1);
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_DEBUGCTLMSR,
+				     !intercept, !intercept);
+}
+
+void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
+	svm_recalc_lbr_msr_intercepts(vcpu);
 
 	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
 	if (is_guest_mode(vcpu))
@@ -1034,10 +1047,7 @@ static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
 	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
 
 	svm->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP, 0, 0);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 0, 0);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 0, 0);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 0, 0);
+	svm_recalc_lbr_msr_intercepts(vcpu);
 
 	/*
 	 * Move the LBR msrs back to the vmcb01 to avoid copying them
-- 
2.52.0.158.g65b55ccf14-goog


