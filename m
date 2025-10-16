Return-Path: <stable+bounces-185906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AABE23F4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85ED21887EA7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1986C30505F;
	Thu, 16 Oct 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFHGiadw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C1214A79
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605001; cv=none; b=BwsOJGURg6nugmiVqKCSk+jphkDohgnI3/WjPQIeeejtpWwayTchR7xaGrvkN+4bimF+BCJDQOnfmRd1bMsTFJVNljOdJtTLKaU3s4v8D0WrFFQPR1wuN/TyTbGf3WXxtmMeRk6YbtjF3IkhbW41DJ6qy8G789LBJPrzaHjEt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605001; c=relaxed/simple;
	bh=53GSrr/tDRzhGQCPLEwlurpb91W4gY2Sz14eY3D90VM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rdps7sskh66fguQcYk5GW+WP5Ld8G/gXZLRejgsbX36GYmMe7HNmSKUBmNevmvXWlMbDGfw7ugU4WL/FNL7dLrDYEMQX50gQXpX0UYj0G6agGCkFxWzJxjYhWzChHBOMZwsJM4wtGHw/E61w2RGTepIRHz6ZwzB0ldoi3RUl75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFHGiadw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D44C4CEF1;
	Thu, 16 Oct 2025 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605001;
	bh=53GSrr/tDRzhGQCPLEwlurpb91W4gY2Sz14eY3D90VM=;
	h=Subject:To:Cc:From:Date:From;
	b=EFHGiadwgn3kwJDBMpqmhR7e5zH2z5Gk5BWpw9AAd7k6tH0vYn20vnvUxz1/aDUIC
	 jkAYMas1eiVuDQHg8tJBRSmglMMYiu9lJvNOt/djQokaAJTdSaIs2aduQxzgRPGWmA
	 3ZUZP2tTnKd4hFEZwSRgIx2QUG5a2p9hiVY1uVgU=
Subject: FAILED: patch "[PATCH] KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from" failed to apply to 6.6-stable tree
To: houwenlong.hwl@antgroup.com,jiangshan.ljs@antgroup.com,seanjc@google.com,xiaoyao.li@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:56:38 +0200
Message-ID: <2025101638-lively-electable-a835@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29da8c823abffdacb71c7c07ec48fcf9eb38757c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101638-lively-electable-a835@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29da8c823abffdacb71c7c07ec48fcf9eb38757c Mon Sep 17 00:00:00 2001
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
Date: Tue, 23 Sep 2025 08:37:38 -0700
Subject: [PATCH] KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from
 SEV-ES guest

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

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 019d920fe442..5529e4c3362b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4666,6 +4666,16 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
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
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b237b4081c91..6f486fb82144 100644
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
@@ -577,18 +577,6 @@ static int svm_enable_virtualization_cpu(void)
 
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
 
@@ -1406,10 +1394,10 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
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
@@ -3004,8 +2992,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 * TSC_AUX is always virtualized for SEV-ES guests when the
 		 * feature is available. The user return MSR support is not
 		 * required in this case because TSC_AUX is restored on #VMEXIT
-		 * from the host save area (which has been initialized in
-		 * svm_enable_virtualization_cpu()).
+		 * from the host save area.
 		 */
 		if (boot_cpu_has(X86_FEATURE_V_TSC_AUX) && sev_es_guest(vcpu->kvm))
 			break;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 10d5cbc259e1..ec3fb318ca83 100644
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


