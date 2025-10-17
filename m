Return-Path: <stable+bounces-187157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7AFBEA720
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D75747C56
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D6330B03;
	Fri, 17 Oct 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjHMcVop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709B36997F;
	Fri, 17 Oct 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715275; cv=none; b=UlGsH48kTMFY8db4+peDBgZRgCrsm6Z0t3fNs9kUoNLjT6Z0QQs1wH9XQ0vLMphcwC4zNApWE9inbNksq4ngK5jBpZx4bCgFPk0LiyRtPrj4Bofs6UsYy+MJ10ZYilyWalMZLazHw+CqtQjzROifREVGY1pWHRnlVxyYqTcNMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715275; c=relaxed/simple;
	bh=tD1Ycpay86uGYs5bMSFPJCnwMG4sNvqZhz2uiEwEVUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvQcN3tS3mBG6Itvihgxa5gfzJvmnjnFGuVuPyu04p36Wj8YdnTxK3oP59RDBBdL/r2d5S+voJY2b5NocU6VF7Bzp6ombVLmOjODZpqdcJ8Rp3Kfp4goXxevqByH95RoDIkYtJsk2ml9qj0tK+nD4YdOBaFzgFJ6KkNf7E7EsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjHMcVop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226F3C4CEE7;
	Fri, 17 Oct 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715275;
	bh=tD1Ycpay86uGYs5bMSFPJCnwMG4sNvqZhz2uiEwEVUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjHMcVoprRPqfoUvCwt1AS0RQkIZ61QL68TT3FW1Y2J34KYA2a+2WfR/7uUcOrTDJ
	 JZO4VPtF9d3XSqnmG7cAPdHZyRKbZs9lhQMMukXm1xlH04x5mzVCX0RDIVadTRGFBK
	 cKd6PakAFbrhaLvYcR7/AQh3CnPG4GveMnCxLnJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.17 158/371] KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from SEV-ES guest
Date: Fri, 17 Oct 2025 16:52:13 +0200
Message-ID: <20251017145207.649792967@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

commit 29da8c823abffdacb71c7c07ec48fcf9eb38757c upstream.

Prior to running an SEV-ES guest, set TSC_AUX in the host save area to the
current value in hardware, as tracked by the user return infrastructure,
instead of always loading the host's desired value for the CPU.  If the
pCPU is also running a non-SEV-ES vCPU, loading the host's value on #VMEXIT
could clobber the other vCPU's value, e.g. if the SEV-ES vCPU preempted
the non-SEV-ES vCPU, in which case KVM expects the other vCPU's TSC_AUX
value to be resident in hardware.

Note, unlike TDX, which blindly _zeroes_ TSC_AUX on TD-Exit, SEV-ES CPUs
can load an arbitrary value.  Stuff the current value in the host save
area instead of refreshing the user return cache so that KVM doesn't need
to track whether or not the vCPU actually enterred the guest and thus
loaded TSC_AUX from the host save area.

Opportunistically tag tsc_aux_uret_slot as read-only after init to guard
against unexpected modifications, and to make it obvious that using the
variable in sev_es_prepare_switch_to_guest() is safe.

Fixes: 916e3e5f26ab ("KVM: SVM: Do not use user return MSR support for virtualized TSC_AUX")
Cc: stable@vger.kernel.org
Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: handle the SEV-ES case in sev_es_prepare_switch_to_guest()]
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250923153738.1875174-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |   10 ++++++++++
 arch/x86/kvm/svm/svm.c |   25 ++++++-------------------
 arch/x86/kvm/svm/svm.h |    2 ++
 3 files changed, 18 insertions(+), 19 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4618,6 +4618,16 @@ void sev_es_prepare_switch_to_guest(stru
 		hostsa->dr2_addr_mask = amd_get_dr_addr_mask(2);
 		hostsa->dr3_addr_mask = amd_get_dr_addr_mask(3);
 	}
+
+	/*
+	 * TSC_AUX is always virtualized for SEV-ES guests when the feature is
+	 * available, i.e. TSC_AUX is loaded on #VMEXIT from the host save area.
+	 * Set the save area to the current hardware value, i.e. the current
+	 * user return value, so that the correct value is restored on #VMEXIT.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_V_TSC_AUX) &&
+	    !WARN_ON_ONCE(tsc_aux_uret_slot < 0))
+		hostsa->tsc_aux = kvm_get_user_return_msr(tsc_aux_uret_slot);
 }
 
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -195,7 +195,7 @@ static DEFINE_MUTEX(vmcb_dump_mutex);
  * RDTSCP and RDPID are not used in the kernel, specifically to allow KVM to
  * defer the restoration of TSC_AUX until the CPU returns to userspace.
  */
-static int tsc_aux_uret_slot __read_mostly = -1;
+int tsc_aux_uret_slot __ro_after_init = -1;
 
 static int get_npt_level(void)
 {
@@ -577,18 +577,6 @@ static int svm_enable_virtualization_cpu
 
 	amd_pmu_enable_virt();
 
-	/*
-	 * If TSC_AUX virtualization is supported, TSC_AUX becomes a swap type
-	 * "B" field (see sev_es_prepare_switch_to_guest()) for SEV-ES guests.
-	 * Since Linux does not change the value of TSC_AUX once set, prime the
-	 * TSC_AUX field now to avoid a RDMSR on every vCPU run.
-	 */
-	if (boot_cpu_has(X86_FEATURE_V_TSC_AUX)) {
-		u32 __maybe_unused msr_hi;
-
-		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, msr_hi);
-	}
-
 	return 0;
 }
 
@@ -1423,10 +1411,10 @@ static void svm_prepare_switch_to_guest(
 		__svm_write_tsc_multiplier(vcpu->arch.tsc_scaling_ratio);
 
 	/*
-	 * TSC_AUX is always virtualized for SEV-ES guests when the feature is
-	 * available. The user return MSR support is not required in this case
-	 * because TSC_AUX is restored on #VMEXIT from the host save area
-	 * (which has been initialized in svm_enable_virtualization_cpu()).
+	 * TSC_AUX is always virtualized (context switched by hardware) for
+	 * SEV-ES guests when the feature is available.  For non-SEV-ES guests,
+	 * context switch TSC_AUX via the user_return MSR infrastructure (not
+	 * all CPUs support TSC_AUX virtualization).
 	 */
 	if (likely(tsc_aux_uret_slot >= 0) &&
 	    (!boot_cpu_has(X86_FEATURE_V_TSC_AUX) || !sev_es_guest(vcpu->kvm)))
@@ -3021,8 +3009,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		 * TSC_AUX is always virtualized for SEV-ES guests when the
 		 * feature is available. The user return MSR support is not
 		 * required in this case because TSC_AUX is restored on #VMEXIT
-		 * from the host save area (which has been initialized in
-		 * svm_enable_virtualization_cpu()).
+		 * from the host save area.
 		 */
 		if (boot_cpu_has(X86_FEATURE_V_TSC_AUX) && sev_es_guest(vcpu->kvm))
 			break;
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -52,6 +52,8 @@ extern bool x2avic_enabled;
 extern bool vnmi;
 extern int lbrv;
 
+extern int tsc_aux_uret_slot __ro_after_init;
+
 /*
  * Clean bits in VMCB.
  * VMCB_ALL_CLEAN_MASK might also need to



