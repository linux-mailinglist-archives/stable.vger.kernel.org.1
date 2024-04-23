Return-Path: <stable+bounces-40663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C628AE6E2
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B401F23BE8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53486AC2;
	Tue, 23 Apr 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m5pP9WIM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD885C48
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876537; cv=none; b=DVRH8bL2iLRsXa/Fx94apwLamse3HR1fqFdib+nhnl1jqF4mLBFisoLoOxuQNRFkVcKPGQANJ3dproR1kbkE4fTwAJxyPdzcEyhWNnFM/U1EzIeTFtWl8UboPQs+C0+a0JRBEPqKyK4YaxW9jxhOxSUCmYxdisrnHoQBHwrLxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876537; c=relaxed/simple;
	bh=+oxCg8wYCsBoNf8qARhFiiXtFHEh6+T2Qsizkmxp9gk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CZGJaiWP/hFhdRcKiaTnMzpXW9R8mJlZ8Zl9GdmaW5AXcmjkzru5qe0Dkdu3aPlJNq1UhzfLWlBeDly9RAFTfyHEOst8Ya8pH1EmUPCvlTIJMNsy9SXtVppq4oFwi6lrtrKyTD+VDHSVbJlLwWqPrCbxKuG9tSPWR0PBNFfSD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m5pP9WIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0F0C116B1;
	Tue, 23 Apr 2024 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876536;
	bh=+oxCg8wYCsBoNf8qARhFiiXtFHEh6+T2Qsizkmxp9gk=;
	h=Subject:To:Cc:From:Date:From;
	b=m5pP9WIMiplNSrgwt1nzX8owBReKuwR378qb/jrSmc2y2VLPkhFktyXA4AvIDKWMK
	 T1tmRl+Et1JvRmpzzSPnp8uBNBjuxe6eLXND/PcBRyplQcsxgLnxZgwJGC2z40bdbf
	 NLw0TlHlNfc0kkW+eIeXOi3sn6fkvt3uwfqx2w9g=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Set enable bits for GP counters in" failed to apply to 6.1-stable tree
To: seanjc@google.com,babu.moger@amd.com,dapeng1.mi@linux.intel.com,like.xu.linux@gmail.com,mizhang@google.com,sandipan.das@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:48:47 -0700
Message-ID: <2024042347-polar-gains-eb8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x de120e1d692d73c7eefa3278837b1eb68f90728a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042347-polar-gains-eb8f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

de120e1d692d ("KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"")
f933b88e2015 ("KVM: x86/pmu: Zero out PMU metadata on AMD if PMU is disabled")
1647b52757d5 ("KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing")
cbb359d81a26 ("KVM: x86/pmu: Move PMU reset logic to common x86 code")
73554b29bd70 ("KVM: x86/pmu: Synthesize at most one PMI per VM-exit")
b29a2acd36dd ("KVM: x86/pmu: Truncate counter value to allowed width on write")
4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
1c2bf8a6b045 ("KVM: x86/pmu: Constrain the num of guest counters with kvm_pmu_cap")
13afa29ae489 ("KVM: x86/pmu: Provide Intel PMU's pmc_is_enabled() as generic x86 code")
c85cdc1cc1ea ("KVM: x86/pmu: Move handling PERF_GLOBAL_CTRL and friends to common x86")
30dab5c0b65e ("KVM: x86/pmu: Reject userspace attempts to set reserved GLOBAL_STATUS bits")
8de18543dfe3 ("KVM: x86/pmu: Move reprogram_counters() to pmu.h")
53550b89220b ("KVM: x86/pmu: Rename global_ovf_ctrl_mask to global_status_mask")
649bccd7fac9 ("KVM: x86/pmu: Rewrite reprogram_counters() to improve performance")
8bca8c5ce40b ("KVM: VMX: Refactor intel_pmu_{g,}set_msr() to align with other helpers")
cdd2fbf6360e ("KVM: x86/pmu: Rename pmc_is_enabled() to pmc_is_globally_enabled()")
957d0f70e97b ("KVM: x86/pmu: Zero out LBR capabilities during PMU refresh")
3a6de51a437f ("KVM: x86/pmu: WARN and bug the VM if PMU is refreshed after vCPU has run")
7e768ce8278b ("KVM: x86/pmu: Zero out pmu->all_valid_pmc_idx each time it's refreshed")
e33b6d79acac ("KVM: x86/pmu: Don't tell userspace to save MSRs for non-existent fixed PMCs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de120e1d692d73c7eefa3278837b1eb68f90728a Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 8 Mar 2024 17:36:40 -0800
Subject: [PATCH] KVM: x86/pmu: Set enable bits for GP counters in
 PERF_GLOBAL_CTRL at "RESET"

Set the enable bits for general purpose counters in IA32_PERF_GLOBAL_CTRL
when refreshing the PMU to emulate the MSR's architecturally defined
post-RESET behavior.  Per Intel's SDM:

  IA32_PERF_GLOBAL_CTRL:  Sets bits n-1:0 and clears the upper bits.

and

  Where "n" is the number of general-purpose counters available in the processor.

AMD also documents this behavior for PerfMonV2 CPUs in one of AMD's many
PPRs.

Do not set any PERF_GLOBAL_CTRL bits if there are no general purpose
counters, although a literal reading of the SDM would require the CPU to
set either bits 63:0 or 31:0.  The intent of the behavior is to globally
enable all GP counters; honor the intent, if not the letter of the law.

Leaving PERF_GLOBAL_CTRL '0' effectively breaks PMU usage in guests that
haven't been updated to work with PMUs that support PERF_GLOBAL_CTRL.
This bug was recently exposed when KVM added supported for AMD's
PerfMonV2, i.e. when KVM started exposing a vPMU with PERF_GLOBAL_CTRL to
guest software that only knew how to program v1 PMUs (that don't support
PERF_GLOBAL_CTRL).

Failure to emulate the post-RESET behavior results in such guests
unknowingly leaving all general purpose counters globally disabled (the
entire reason the post-RESET value sets the GP counter enable bits is to
maintain backwards compatibility).

The bug has likely gone unnoticed because PERF_GLOBAL_CTRL has been
supported on Intel CPUs for as long as KVM has existed, i.e. hardly anyone
is running guest software that isn't aware of PERF_GLOBAL_CTRL on Intel
PMUs.  And because up until v6.0, KVM _did_ emulate the behavior for Intel
CPUs, although the old behavior was likely dumb luck.

Because (a) that old code was also broken in its own way (the history of
this code is a comedy of errors), and (b) PERF_GLOBAL_CTRL was documented
as having a value of '0' post-RESET in all SDMs before March 2023.

Initial vPMU support in commit f5132b01386b ("KVM: Expose a version 2
architectural PMU to a guests") *almost* got it right (again likely by
dumb luck), but for some reason only set the bits if the guest PMU was
advertised as v1:

        if (pmu->version == 1) {
                pmu->global_ctrl = (1 << pmu->nr_arch_gp_counters) - 1;
                return;
        }

Commit f19a0c2c2e6a ("KVM: PMU emulation: GLOBAL_CTRL MSR should be
enabled on reset") then tried to remedy that goof, presumably because
guest PMUs were leaving PERF_GLOBAL_CTRL '0', i.e. weren't enabling
counters.

        pmu->global_ctrl = ((1 << pmu->nr_arch_gp_counters) - 1) |
                (((1ull << pmu->nr_arch_fixed_counters) - 1) << X86_PMC_IDX_FIXED);
        pmu->global_ctrl_mask = ~pmu->global_ctrl;

That was KVM's behavior up until commit c49467a45fe0 ("KVM: x86/pmu:
Don't overwrite the pmu->global_ctrl when refreshing") removed
*everything*.  However, it did so based on the behavior defined by the
SDM , which at the time stated that "Global Perf Counter Controls" is
'0' at Power-Up and RESET.

But then the March 2023 SDM (325462-079US), stealthily changed its
"IA-32 and Intel 64 Processor States Following Power-up, Reset, or INIT"
table to say:

  IA32_PERF_GLOBAL_CTRL: Sets bits n-1:0 and clears the upper bits.

Note, kvm_pmu_refresh() can be invoked multiple times, i.e. it's not a
"pure" RESET flow.  But it can only be called prior to the first KVM_RUN,
i.e. the guest will only ever observe the final value.

Note #2, KVM has always cleared global_ctrl during refresh (see commit
f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")),
i.e. there is no danger of breaking existing setups by clobbering a value
set by userspace.

Reported-by: Babu Moger <babu.moger@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20240309013641.1413400-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c397b28e3d1b..a593b03c9aed 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -775,8 +775,20 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pebs_data_cfg_mask = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
-	if (vcpu->kvm->arch.enable_pmu)
-		static_call(kvm_x86_pmu_refresh)(vcpu);
+	if (!vcpu->kvm->arch.enable_pmu)
+		return;
+
+	static_call(kvm_x86_pmu_refresh)(vcpu);
+
+	/*
+	 * At RESET, both Intel and AMD CPUs set all enable bits for general
+	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
+	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
+	 * in the global controls).  Emulate that behavior when refreshing the
+	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
+	 */
+	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
+		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)


