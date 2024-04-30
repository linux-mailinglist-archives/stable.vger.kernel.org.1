Return-Path: <stable+bounces-42369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168C8B72A6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC14D281F01
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772B12D1E8;
	Tue, 30 Apr 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="13dYPBJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344412CD90;
	Tue, 30 Apr 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475446; cv=none; b=JGkpu805t8dDByfpcrK9rOnosXssaW8jdI3pIjc7XhtBmm5IpYLjT6FJX/sfEhPaccLAQN6eVyY1veiU+i1pefu0ZO/wCl7firT4E4S4xtMvcAKLwZCYhlDraz76nBU4cNUbzUwH9eOuJorf5YFDi9whyDxHWZmPUpa+Vc/o6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475446; c=relaxed/simple;
	bh=8pJI+sq//Wq9wO6MhXn5hCmRmKIlCWCa0G0/qOnvfA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvd9HqptGt7ScaaNauOatU5NrRE8b96KSq8M6KHGB9jNp8n/JFFjw4mMhtmXxbto5OLoK/rOuM8naA8EGBZPoQmJa86KZZ4jwYYQDW34EPdRJDRQI0HvLuHNCUkPap7SQg55SA9KWwGoDmqu0GT7f25vo6wDjipZILlKe7ninPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=13dYPBJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B1EC2BBFC;
	Tue, 30 Apr 2024 11:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475445;
	bh=8pJI+sq//Wq9wO6MhXn5hCmRmKIlCWCa0G0/qOnvfA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=13dYPBJkvFjyyfdLOvFzxYJLBpbnIpUvlOuBsjtyqqChIqaTlDdMntKMF9qA4KRh1
	 h24912ItXVK1VxPPVmLbimIHSgUr6U6paESsQ0paK3/AeMG8tjAT07RdQTgE1ohx08
	 F2HIgEEvG2IbATJrf7RWfTsWVAQYD/RiIIzB0rAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Babu Moger <babu.moger@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Like Xu <like.xu.linux@gmail.com>,
	Mingwei Zhang <mizhang@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 097/186] KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"
Date: Tue, 30 Apr 2024 12:39:09 +0200
Message-ID: <20240430103100.849408359@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit de120e1d692d73c7eefa3278837b1eb68f90728a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/pmu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index fa6f5cd70d4c8..da2d82e3a8735 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -716,8 +716,20 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
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
-- 
2.43.0




