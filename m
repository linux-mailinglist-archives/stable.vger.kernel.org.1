Return-Path: <stable+bounces-208404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E675D21F9A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 02:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D86FB301B5BC
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047228641E;
	Thu, 15 Jan 2026 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtgnqG4P"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498629ACC6
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439645; cv=none; b=NIIFKQXs3Ks+U6J69p6+5aRLtNWEG8CIXv7U1nzVVlOVhPKKdAh7LERl5+UsnYo36oPK4z+ytCQFCjiD70FVGB87cW98qeVxQ1PCXsGHqxxuPzhF3Hx0t8rJ/ztNvgkbiG5hMaOgc3prAWzU6+qVjyn9HgY95LIvx5AoB3AiEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439645; c=relaxed/simple;
	bh=FhTOmmi6gnSSLVnyBr/gDx4uaArPGwCmaY2IJPjijuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWiPeV9cXb7LBH66Jh9LCucIZj9GaqdGUCJBnMY55J+tOJkmITC37g9t+BnUAp5zzxI//NO+H9LZMf+NgjJwWaVBPV2FDF30QlqPrU0Rmu3J4UbwHr04NMWq1IU2WEyVUVX5TompnrBIu/RR6LUh1OVCkBSXwplyWbXXrGRUrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtgnqG4P; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768439638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrdFcAsC8FiX1Peqg4gjJ2+Ki+Tm5p09T6ZYsAHHLkU=;
	b=FtgnqG4PjkcBNQ7yhBSvavt2zRWIuveyzqyN1ELxbTsxzNf7TW2lvkk/kxDzn7nQGr34sX
	+ELLYC1+Mn+c5SnG3bA1px00lM2B02aLyxOVeh+WoK9me9hy4akZViEAQmjQ5XBGgPKiav
	Pv9zYM5DMsSi5GuJJZL+Qm8lGseemio=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 17/26] KVM: nSVM: Add missing consistency check for hCR0.PG and NP_ENABLE
Date: Thu, 15 Jan 2026 01:13:03 +0000
Message-ID: <20260115011312.3675857-18-yosry.ahmed@linux.dev>
In-Reply-To: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From the APM Volume #2, 15.25.3 (24593—Rev. 3.42—March 2024):

	If VMRUN is executed with hCR0.PG cleared to zero and NP_ENABLE
	set to 1 , VMRUN terminates with #VMEXIT(VMEXIT_INVALID).

Add the consistency check by plumbing L1's CR0 to
nested_vmcb_check_controls().

Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index eb4a633a668d..72db46b5126d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -343,7 +343,8 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 }
 
 static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
-				       struct vmcb_ctrl_area_cached *control)
+				       struct vmcb_ctrl_area_cached *control,
+				       unsigned long l1_cr0)
 {
 	if (CC(!vmcb12_is_intercept(control, INTERCEPT_VMRUN)))
 		return false;
@@ -354,6 +355,8 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	if (nested_npt_enabled(to_svm(vcpu))) {
 		if (CC(!kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
 			return false;
+		if (CC(!(l1_cr0 & X86_CR0_PG)))
+			return false;
 	}
 
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
@@ -951,7 +954,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 	enter_guest_mode(vcpu);
 
 	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
-	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
+	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl,
+					svm->vmcb01.ptr->save.cr0))
 		return -EINVAL;
 
 	if (nested_npt_enabled(svm))
@@ -1882,7 +1886,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	ret = -EINVAL;
 	__nested_copy_vmcb_control_to_cache(vcpu, &ctl_cached, ctl);
-	if (!nested_vmcb_check_controls(vcpu, &ctl_cached))
+	/* 'save' contains L1 state saved from before VMRUN */
+	if (!nested_vmcb_check_controls(vcpu, &ctl_cached, save->cr0))
 		goto out_free;
 
 	/*
-- 
2.52.0.457.g6b5491de43-goog


