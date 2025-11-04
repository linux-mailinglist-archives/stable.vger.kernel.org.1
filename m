Return-Path: <stable+bounces-192443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083EC32D97
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 21:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7081818C1EF3
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562302E9749;
	Tue,  4 Nov 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qdbHdW3d"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C62E03F0
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286412; cv=none; b=Q3DVXVq1/LY+x6TzXFgQKZctx6iKGwtBeF4xrwSLESgbHJ4XH6k1W6PmNkn36S5tRjWp5sOwvnzWBdMRu1S71g22Kc1/PbzUKywS7ornHD71JMN4MrYWJu3w5bp5XeQTX8M2L58j0ElSHlNu5HMHhw0ld1h8haHlbftwFDHLmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286412; c=relaxed/simple;
	bh=ZdzFWnzfAMTVJrGrdmWOLzOvrX4cyva0LVVwZREYBBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1fURyQNKg2+6PONSFVXh7N10Ug+KvNGCGxiqTTCk3dp3e/5Ureb5zd0OcyJIevIAmHmpShJ6ujfFcRCMG/dJ9QO+FPON/Xkwd8/7jSbMgbPmnPQc/9p2YXXdLvihQCxVpMooRYm7VBmaQ0CzmootQsp9O9l1D73Pnij8EwrgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qdbHdW3d; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762286407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRqbR3TSsnM7je14FE4SneIrmCgcOO3Mu3NX/MWpW1s=;
	b=qdbHdW3dWT4QQPbk5w1FoUjQ6oDpt9FmEJYcGJ7QtBydnULGYM1jXRlai5MQRhGHKxmqSP
	rM20UlMjubI1rBA+z21f8nJ2EPhcz1D/H+NgrmUsYju07BV3pLzFtcBqiiO2pONHeK8e6t
	oT73gbytfHTtOHmXdSZkgjISE2rV090=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 01/11] KVM: nSVM: Fix consistency checks for NP_ENABLE
Date: Tue,  4 Nov 2025 19:59:39 +0000
Message-ID: <20251104195949.3528411-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251104195949.3528411-1-yosry.ahmed@linux.dev>
References: <20251104195949.3528411-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

KVM currenty fails a nested VMRUN and injects VMEXIT_INVALID (aka
SVM_EXIT_ERR) if L1 sets NP_ENABLE and the host does not support NPTs.
On first glance, it seems like the check should actually be for
guest_cpu_cap_has(X86_FEATURE_NPT) instead, as it is possible for the
host to support NPTs but the guest CPUID to not advertise it.

However, the consistency check is not architectural to begin with. The
APM does not mention VMEXIT_INVALID if NP_ENABLE is set on a processor
that does not have X86_FEATURE_NPT. Hence, NP_ENABLE should be ignored
if X86_FEATURE_NPT is not available for L1. Apart from the consistency
check, this is currently the case because NP_ENABLE is actually copied
from VMCB01 to VMCB02, not from VMCB12.

On the other hand, the APM does mention two other consistency checks for
NP_ENABLE, both of which are missing (paraphrased):

In Volume #2, 15.25.3 (24593—Rev. 3.42—March 2024):

  If VMRUN is executed with hCR0.PG cleared to zero and NP_ENABLE set to
  1, VMRUN terminates with #VMEXIT(VMEXIT_INVALID)

In Volume #2, 15.25.4 (24593—Rev. 3.42—March 2024):

  When VMRUN is executed with nested paging enabled (NP_ENABLE = 1), the
  following conditions are considered illegal state combinations, in
  addition to those mentioned in “Canonicalization and Consistency
  Checks”:
    • Any MBZ bit of nCR3 is set.
    • Any G_PAT.PA field has an unsupported type encoding or any
    reserved field in G_PAT has a nonzero value.

Replace the existing consistency check with consistency checks on
hCR0.PG and nCR3. The G_PAT consistency check will be addressed
separately.

Pass L1's CR0 to __nested_vmcb_check_controls(). In
nested_vmcb_check_controls(), L1's CR0 is available through
kvm_read_cr0(), as vcpu->arch.cr0 is not updated to L2's CR0 until later
through nested_vmcb02_prepare_save() -> svm_set_cr0().

In svm_set_nested_state(), L1's CR0 is available in the captured save
area, as svm_get_nested_state() captures L1's save area when running L2,
and L1's CR0 is stashed in VMCB01 on nested VMRUN (in
nested_svm_vmrun()).

Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 21 ++++++++++++++++-----
 arch/x86/kvm/svm/svm.h    |  3 ++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 83de3456df708..9a534f04bdc83 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -325,7 +325,8 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 }
 
 static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
-					 struct vmcb_ctrl_area_cached *control)
+					 struct vmcb_ctrl_area_cached *control,
+					 unsigned long l1_cr0)
 {
 	if (CC(!vmcb12_is_intercept(control, INTERCEPT_VMRUN)))
 		return false;
@@ -333,8 +334,12 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	if (CC(control->asid == 0))
 		return false;
 
-	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) && !npt_enabled))
-		return false;
+	if (control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {
+		if (CC(!kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
+			return false;
+		if (CC(!(l1_cr0 & X86_CR0_PG)))
+			return false;
+	}
 
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
@@ -400,7 +405,12 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
 
-	return __nested_vmcb_check_controls(vcpu, ctl);
+	/*
+	 * Make sure we did not enter guest mode yet, in which case
+	 * kvm_read_cr0() could return L2's CR0.
+	 */
+	WARN_ON_ONCE(is_guest_mode(vcpu));
+	return __nested_vmcb_check_controls(vcpu, ctl, kvm_read_cr0(vcpu));
 }
 
 static
@@ -1832,7 +1842,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	ret = -EINVAL;
 	__nested_copy_vmcb_control_to_cache(vcpu, &ctl_cached, ctl);
-	if (!__nested_vmcb_check_controls(vcpu, &ctl_cached))
+	/* 'save' contains L1 state saved from before VMRUN */
+	if (!__nested_vmcb_check_controls(vcpu, &ctl_cached, save->cr0))
 		goto out_free;
 
 	/*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6765a5e433cea..0a2908e22d746 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -552,7 +552,8 @@ static inline bool gif_set(struct vcpu_svm *svm)
 
 static inline bool nested_npt_enabled(struct vcpu_svm *svm)
 {
-	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
+	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_NPT) &&
+		svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
 }
 
 static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
-- 
2.51.2.1026.g39e6a42477-goog


