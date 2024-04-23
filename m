Return-Path: <stable+bounces-40661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA078AE6E3
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8090FB20F52
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8885C4E;
	Tue, 23 Apr 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+bDJrwR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889782C60
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876530; cv=none; b=rSoVhbPU4IVoxAzqusEpsxhSZNfsGpGA4t2n5EDrrboTF1lM+FARzqeOQCEMIQ7ePdN+vVNm9rbaqI2xUZ8fnyj4OWZepKvI7rkZM60WU2n3Vof+s/MuUPcXQWyGgBslt8r5u7THaXzzpKrW3qPumnN4Q4xRl6VO00ce3Is9OfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876530; c=relaxed/simple;
	bh=UQNTUq/KJgQGI6GMNPVZ+HQGPrLnoPNGVcvrp2Su9N4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OwoB8fBjIbAAI/+a4uy0zMd3Qco894q8UdblXT6ELYkpWKFD1W6vwk/5Sgg9lT2TlqQmhYaqDqs5+ZPESEI1MVGutBoH30ZPS6oW7FdckOTt+CSQS5tziEOniCmjPmRHdgJ5l2y4BORR8zD3XwmDepDTwIeJRcC9rjr4ScGYcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+bDJrwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB448C116B1;
	Tue, 23 Apr 2024 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876529;
	bh=UQNTUq/KJgQGI6GMNPVZ+HQGPrLnoPNGVcvrp2Su9N4=;
	h=Subject:To:Cc:From:Date:From;
	b=W+bDJrwRpClx5ihxvX5mnnCXT7SmtgSvFeAPBoCNTpyxUsBY/p44bOaPXZPnWjy17
	 zHa0as5NaNHk0vQ0ikx5gC8RoT+p/FDO8uEXDMGo1VMwsrB7cu/K2hS6M3BIRfmzfa
	 yqbTLZqx31gFebzKCSnCAOnLgipNBTq1neiCheCA=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Set enable bits for GP counters in" failed to apply to 6.8-stable tree
To: seanjc@google.com,babu.moger@amd.com,dapeng1.mi@linux.intel.com,like.xu.linux@gmail.com,mizhang@google.com,sandipan.das@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:48:40 -0700
Message-ID: <2024042340-retrieval-unhook-57b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x de120e1d692d73c7eefa3278837b1eb68f90728a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042340-retrieval-unhook-57b9@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

de120e1d692d ("KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"")
f933b88e2015 ("KVM: x86/pmu: Zero out PMU metadata on AMD if PMU is disabled")

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


