Return-Path: <stable+bounces-208405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82FD21FB1
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 02:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BE41305F520
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA46275B0F;
	Thu, 15 Jan 2026 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGGOAORL"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3D265CA2
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439645; cv=none; b=h24HKInSDlQU5LsTTq8F5Sa1qTurnEepCNCUoYPh9CoyzSiDONX3FRV8bOgPxtrZ8E2fq2js75Ds9E/KX9XUQpY23pL6321ZdmGxIFnintBCTRHYfL1gQK1K21reqM+7R6oigZQyqpzXDy5fIAup9RIYB0APeKMufh3EgW+3V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439645; c=relaxed/simple;
	bh=NNy3KKalBGgQX+5SCjuQwk2g/AHfxzAtaZKdKc7dtsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACMsb9ptzPSSbIww9p7Y48H+4iizkYlU06Lm5GFUymB2b9DdNGkHcwfc96mTo12j1XlUmbBfR6G+DuPIbEvfyxsSY0tgtmlQAHS1pfUfOzlGQzKv3V0Iv3PPGAzPnxHJSF/UYUQIbKqsI5LmRAS+iKAWvDRtWtJCKBdlorGHLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGGOAORL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768439634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92IseN4WbR7/gNBYYHdL6FsvVihQVPKtL41fgiBGnsA=;
	b=uGGOAORLW8S1s/Ve8LVfYwlpA9NUGPLT4L9gDvn9GS+/lbbk2t3snvaoJHzbIiv+YJ26aH
	SpBONyNutkZrweCGOWa0+3gwc1hKmQmCZ8t0k5GC1qCygaAmVkiBQCOV1Dmdgo3mx+IBMN
	z42Hb76cRI7FlIRBLLlHstUI8aH9tkg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 15/26] KVM: nSVM: Drop the non-architectural consistency check for NP_ENABLE
Date: Thu, 15 Jan 2026 01:13:01 +0000
Message-ID: <20260115011312.3675857-16-yosry.ahmed@linux.dev>
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

KVM currenty fails a nested VMRUN and injects VMEXIT_INVALID (aka
SVM_EXIT_ERR) if L1 sets NP_ENABLE and the host does not support NPTs.
On first glance, it seems like the check should actually be for
guest_cpu_cap_has(X86_FEATURE_NPT) instead, as it is possible for the
host to support NPTs but the guest CPUID to not advertise it.

However, the consistency check is not architectural to begin with. The
APM does not mention VMEXIT_INVALID if NP_ENABLE is set on a processor
that does not have X86_FEATURE_NPT. Hence, NP_ENABLE should be ignored
if X86_FEATURE_NPT is not available for L1, so sanitize it when copying
from the VMCB12 to KVM's cache.

Apart from the consistency check, NP_ENABLE in VMCB12 is currently
ignored because the bit is actually copied from VMCB01 to VMCB02, not
from VMCB12.

Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 704e572324f2..0f2b42803cf6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -351,9 +351,6 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	if (CC(control->asid == 0))
 		return false;
 
-	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) && !npt_enabled))
-		return false;
-
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
 		return false;
@@ -434,6 +431,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	nested_svm_sanitize_intercept(vcpu, to, SKINIT);
 	nested_svm_sanitize_intercept(vcpu, to, RDPRU);
 
+	/* Always clear NP_ENABLE if the guest cannot use NPTs */
+	to->nested_ctl          = from->nested_ctl;
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
+		to->nested_ctl &= ~SVM_NESTED_CTL_NP_ENABLE;
+
 	to->iopm_base_pa        = from->iopm_base_pa;
 	to->msrpm_base_pa       = from->msrpm_base_pa;
 	to->tsc_offset          = from->tsc_offset;
@@ -448,7 +450,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->exit_info_2         = from->exit_info_2;
 	to->exit_int_info       = from->exit_int_info;
 	to->exit_int_info_err   = from->exit_int_info_err;
-	to->nested_ctl          = from->nested_ctl;
 	to->event_inj           = from->event_inj;
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
-- 
2.52.0.457.g6b5491de43-goog


