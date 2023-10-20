Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7647D14FD
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjJTRju (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjJTRjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:39:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A36A3
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:39:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5547DC433C8;
        Fri, 20 Oct 2023 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697823587;
        bh=7XtoQ8bdWFvHVCJAH/4one3FzUsf3uLRDdhD+1m2ZvI=;
        h=Subject:To:Cc:From:Date:From;
        b=vjL3CEBS3ziy5IF7TS5Qy5s1fBAOwnq5e5PO2ndHZ+UzKn0acQi7JQOKSbIR7FU4D
         yW1+fcSplG4WYpOkVYsLAiWvqitWHeU3RxnBQC5liOapUNfyn5FZPqWpJXHfujuuc/
         z3IP0H1Tts/awXiM2gd7jtWMeqI0V2W4oj5ymNPc=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Truncate counter value to allowed width on" failed to apply to 6.1-stable tree
To:     rkagan@amazon.de, likexu@tencent.com, seanjc@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:39:45 +0200
Message-ID: <2023102044-ice-badass-92b5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b29a2acd36dd7a33c63f260df738fb96baa3d4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102044-ice-badass-92b5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b29a2acd36dd7a33c63f260df738fb96baa3d4f8 Mon Sep 17 00:00:00 2001
From: Roman Kagan <rkagan@amazon.de>
Date: Thu, 4 May 2023 14:00:42 +0200
Subject: [PATCH] KVM: x86/pmu: Truncate counter value to allowed width on
 write

Performance counters are defined to have width less than 64 bits.  The
vPMU code maintains the counters in u64 variables but assumes the value
to fit within the defined width.  However, for Intel non-full-width
counters (MSR_IA32_PERFCTRx) the value receieved from the guest is
truncated to 32 bits and then sign-extended to full 64 bits.  If a
negative value is set, it's sign-extended to 64 bits, but then in
kvm_pmu_incr_counter() it's incremented, truncated, and compared to the
previous value for overflow detection.

That previous value is not truncated, so it always evaluates bigger than
the truncated new one, and a PMI is injected.  If the PMI handler writes
a negative counter value itself, the vCPU never quits the PMI loop.

Turns out that Linux PMI handler actually does write the counter with
the value just read with RDPMC, so when no full-width support is exposed
via MSR_IA32_PERF_CAPABILITIES, and the guest initializes the counter to
a negative value, it locks up.

This has been observed in the field, for example, when the guest configures
atop to use perfevents and runs two instances of it simultaneously.

To address the problem, maintain the invariant that the counter value
always fits in the defined bit width, by truncating the received value
in the respective set_msr methods.  For better readability, factor the
out into a helper function, pmc_write_counter(), shared by vmx and svm
parts.

Fixes: 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Kagan <rkagan@amazon.de>
Link: https://lore.kernel.org/all/20230504120042.785651-1-rkagan@amazon.de
Tested-by: Like Xu <likexu@tencent.com>
[sean: tweak changelog, s/set/write in the helper]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 7d9ba301c090..1d64113de488 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -74,6 +74,12 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 	return counter & pmc_bitmask(pmc);
 }
 
+static inline void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
+{
+	pmc->counter += val - pmc_read_counter(pmc);
+	pmc->counter &= pmc_bitmask(pmc);
+}
+
 static inline void pmc_release_perf_event(struct kvm_pmc *pmc)
 {
 	if (pmc->perf_event) {
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index cef5a3d0abd0..373ff6a6687b 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -160,7 +160,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_PERFCTRn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
-		pmc->counter += data - pmc_read_counter(pmc);
+		pmc_write_counter(pmc, data);
 		pmc_update_sample_period(pmc);
 		return 0;
 	}
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index f2efa0bf7ae8..820d3e1f6b4f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -436,11 +436,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if (!msr_info->host_initiated &&
 			    !(msr & MSR_PMC_FULL_WIDTH_BIT))
 				data = (s64)(s32)data;
-			pmc->counter += data - pmc_read_counter(pmc);
+			pmc_write_counter(pmc, data);
 			pmc_update_sample_period(pmc);
 			break;
 		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
-			pmc->counter += data - pmc_read_counter(pmc);
+			pmc_write_counter(pmc, data);
 			pmc_update_sample_period(pmc);
 			break;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {

