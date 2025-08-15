Return-Path: <stable+bounces-169676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1FB273E5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E70B6325B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03B224247;
	Fri, 15 Aug 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFeLi6HD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1D22154D
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217578; cv=none; b=O6U0FyOdTemss+vKXkCw/pNkmpjSi9RdacvMd7EU0JK+Zo20Ic/+uz5WbsXgZ9sfFQ0P9EggkljeEWaiEeApBktqZLX08+jinjJmeBC67MPq2hS34qewb25l1peFZiDHyCXnDjb94HxtAyHxBaas8VuG7TlJFfnxHTAfn5+vcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217578; c=relaxed/simple;
	bh=7IriJ40V1j1AUUsE3s5Zz2JGaaCPbVDvJPGSHI+Yk30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jOJM2F66U+O8RThIta4VhZlm8cLAp/EZU1cKMsatWWfYLkQk/t8lQAQIjKo7pKYvxPLZPBczixoB8JV0fTkQ25TeRF8y3/6blCodGhd9+ZiDZ2IUN0Y9LfG0akGV1R348MPKKm0sv8xnuBUzImm+a4Dcj0h+CKfaFtO2C+Vo010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFeLi6HD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471754bd26so968751a12.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217576; x=1755822376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vy+pQa1LXNegts2iousNQs5afcQ/B6emlO1wnkFSccE=;
        b=tFeLi6HDHCiZE2UINs459SGQpo7Bc4mUdgC9d5zpvuPR9OSHrvwg3bE7Kvf+G5dQO2
         BH4u2C434IKFHJ4HA5HomKmM/doLVhL0+M0mkVIQPBQRmAT4SEknQuHbIEfezF/sb89S
         HL4RfwZZ1hNjRvwtU+6cBbguMv28QE/IFVO0+UJX6+I51K1/55NpMHFTCi0Q7NmFelib
         b9pCEzfmFesrBhyJW7ZlVxzt1GmKvwz8xFKAVuFadu7ujrGOjvzO0MXHk52/GmJ38z3N
         ILk6ZqaphTgCfwphv45Ee+/BI2h6UyPmdQ9QKSfQkO4ITbHEec0IO0xRUr0gR25/LKmJ
         84qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217576; x=1755822376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy+pQa1LXNegts2iousNQs5afcQ/B6emlO1wnkFSccE=;
        b=pU/lkYeBax620VhU4kEJ7GbDf4t0F4uN9sYFJGXtchTuOSTtp6C7CxgtKNcbt9WLa3
         4HLaFth87z4IaW9v2oCupkUfo8RnauQ8NziWPZxpVU2XL/ZqBFnFuNZF4cPVWs5ZzVrr
         oi851d0Wx8Gq2lYHAir2+2PJStYogWaUXT6WOrXhQLyDmZ9kACGOgC9b2EJcq9J22RkD
         /LxO0PoOoF1Tmi2X4MQEw6VxxqmwTCReJqZzwDMK9j5oKEunNZ0iKsBuJrP5WO1gulYs
         IM5TuSa/C6HoQlwDxFSkKi+ER7C9LmQOrlnMiaYhNd2/pOx6RJcJMU0KYLI6qpT+rWtQ
         QS4g==
X-Gm-Message-State: AOJu0YzVQK7Lhg3E4uC+s3DsHMn+UV/HHwMxhovEztE05AoR0dVW2RJz
	mYOR7qcArcH7hTHn2xoqEKFyeg4MjZ11nrx4EipsBV8fNMJuydAd/INJBeV2nvfduN0BJNtaSyQ
	OEDjBiqNskdXJPH1/mQCwHxkBaMncAaoXu21otBVmVv0+HYRzfqF9dnqKZgchbGyDIPcxj7xio+
	WT9hXFZ7u1ov35cGYQQImoVMVK+PVkPZzmOasF
X-Google-Smtp-Source: AGHT+IEt5p1TsxVfZkMSIbkV8aIEvprJyW9Aj4RcIjmeJYSyl8GYBGBA/2LJV6KbjYb1EAX79+L0y4bNkaA=
X-Received: from pgbfe14.prod.google.com ([2002:a05:6a02:288e:b0:b42:189a:ccef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3944:b0:240:1a3a:d7ec
 with SMTP id adf61e73a8af0-240d2dec806mr403454637.4.1755217576079; Thu, 14
 Aug 2025 17:26:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:37 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-18-seanjc@google.com>
Subject: [PATCH 6.6.y 17/20] KVM: VMX: Extract checking of guest's DEBUGCTL
 into helper
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]

Move VMX's logic to check DEBUGCTL values into a standalone helper so that
the code can be used by nested VM-Enter to apply the same logic to the
value being loaded from vmcs12.

KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
VM-Enter, as hardware may support features that KVM does not, i.e. relying
on hardware to detect invalid guest state will result in false negatives.
Unfortunately, that means applying KVM's funky suppression of BTF and LBR
to vmcs12 so as not to break existing guests.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 359c3b7f52a1..aaa767ed170e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2168,6 +2168,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
+static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
+				  bool host_initiated)
+{
+	u64 invalid;
+
+	invalid = data & ~vmx_get_supported_debugctl(vcpu, host_initiated);
+	if (invalid & (DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR)) {
+		kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+		invalid &= ~(DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR);
+	}
+	return !invalid;
+}
+
 /*
  * Writes msr value into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
@@ -2236,19 +2249,12 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		vmcs_writel(GUEST_SYSENTER_ESP, data);
 		break;
-	case MSR_IA32_DEBUGCTLMSR: {
-		u64 invalid;
-
-		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
-		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
-			kvm_pr_unimpl_wrmsr(vcpu, msr_index, data);
-			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-		}
-
-		if (invalid)
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
 			return 1;
 
+		data &= vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
+
 		if (is_guest_mode(vcpu) && get_vmcs12(vcpu)->vm_exit_controls &
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
@@ -2258,7 +2264,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.51.0.rc1.163.g2494970778-goog


