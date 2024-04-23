Return-Path: <stable+bounces-41087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6128AFA46
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A998D1C22099
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C71465A7;
	Tue, 23 Apr 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwf2apqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD99146A62;
	Tue, 23 Apr 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908668; cv=none; b=EMvjd8oHtz18FKyFg50RhmVaHG14aYKzbfWkb+YugB8mm1vGTZsvjbLO7vzOm3xtTLUQ9fSCTu+j8TtsuIlSG9VvHlQD+dssvJnZWY8Pt+sGDGX5X/SdQzl6L902Gy+8lFKEHqKCweNlQmVgZk0XoSyzo9qdyQWPtOrk2xE18yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908668; c=relaxed/simple;
	bh=Rha12CiWDi1P8bi2AoD9OUxrH9pNLWbuYDi0d3aUc/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+XFpYma6Cz81cRfq7BvuWfptK34seWElSp/UB4lQ1HARUhHCEr5LkFp4qL2EM1j4GCOF4qqEfxX4bKNVYQAkk+anOzATzmDtdSmdz590WN6WGerAmmVHb5rXEMeVqVcxsIn8V1TzYfge7blSBIlasGgdcDoy2cgjOo+9lHhfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwf2apqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754DAC116B1;
	Tue, 23 Apr 2024 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908668;
	bh=Rha12CiWDi1P8bi2AoD9OUxrH9pNLWbuYDi0d3aUc/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwf2apqcCOijwA0Pwtb99yZTaGpSqBBUeT+yk4RPtlHPAcNUN8a9k73LhUY+2znXH
	 jz2poXeS1PpLl+gUAXKdfcZClNP9t+F4JCpBZQLfPi5ib7Rm1rwWNMshBV8e80xKjj
	 70pgvduBYtSFx2Pekc5bZ8ENBywPkA+BsM/RRwko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Like Xu <like.xu.linux@gmail.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhang Xiong <xiong.y.zhang@intel.com>,
	Lv Zhiyuan <zhiyuan.lv@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Jim Mattson <jmattson@google.com>,
	Like Xu <likexu@tencent.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6 130/158] KVM: x86/pmu: Disable support for adaptive PEBS
Date: Tue, 23 Apr 2024 14:39:27 -0700
Message-ID: <20240423213859.935607882@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
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

commit 9e985cbf2942a1bb8fcef9adc2a17d90fd7ca8ee upstream.

Drop support for virtualizing adaptive PEBS, as KVM's implementation is
architecturally broken without an obvious/easy path forward, and because
exposing adaptive PEBS can leak host LBRs to the guest, i.e. can leak
host kernel addresses to the guest.

Bug #1 is that KVM doesn't account for the upper 32 bits of
IA32_FIXED_CTR_CTRL when (re)programming fixed counters, e.g
fixed_ctrl_field() drops the upper bits, reprogram_fixed_counters()
stores local variables as u8s and truncates the upper bits too, etc.

Bug #2 is that, because KVM _always_ sets precise_ip to a non-zero value
for PEBS events, perf will _always_ generate an adaptive record, even if
the guest requested a basic record.  Note, KVM will also enable adaptive
PEBS in individual *counter*, even if adaptive PEBS isn't exposed to the
guest, but this is benign as MSR_PEBS_DATA_CFG is guaranteed to be zero,
i.e. the guest will only ever see Basic records.

Bug #3 is in perf.  intel_pmu_disable_fixed() doesn't clear the upper
bits either, i.e. leaves ICL_FIXED_0_ADAPTIVE set, and
intel_pmu_enable_fixed() effectively doesn't clear ICL_FIXED_0_ADAPTIVE
either.  I.e. perf _always_ enables ADAPTIVE counters, regardless of what
KVM requests.

Bug #4 is that adaptive PEBS *might* effectively bypass event filters set
by the host, as "Updated Memory Access Info Group" records information
that might be disallowed by userspace via KVM_SET_PMU_EVENT_FILTER.

Bug #5 is that KVM doesn't ensure LBR MSRs hold guest values (or at least
zeros) when entering a vCPU with adaptive PEBS, which allows the guest
to read host LBRs, i.e. host RIPs/addresses, by enabling "LBR Entries"
records.

Disable adaptive PEBS support as an immediate fix due to the severity of
the LBR leak in particular, and because fixing all of the bugs will be
non-trivial, e.g. not suitable for backporting to stable kernels.

Note!  This will break live migration, but trying to make KVM play nice
with live migration would be quite complicated, wouldn't be guaranteed to
work (i.e. KVM might still kill/confuse the guest), and it's not clear
that there are any publicly available VMMs that support adaptive PEBS,
let alone live migrate VMs that support adaptive PEBS, e.g. QEMU doesn't
support PEBS in any capacity.

Link: https://lore.kernel.org/all/20240306230153.786365-1-seanjc@google.com
Link: https://lore.kernel.org/all/ZeepGjHCeSfadANM@google.com
Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: stable@vger.kernel.org
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhang Xiong <xiong.y.zhang@intel.com>
Cc: Lv Zhiyuan <zhiyuan.lv@intel.com>
Cc: Dapeng Mi <dapeng1.mi@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Acked-by: Like Xu <likexu@tencent.com>
Link: https://lore.kernel.org/r/20240307005833.827147-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx/vmx.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7858,8 +7858,28 @@ static u64 vmx_get_perf_capabilities(voi
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-		if ((perf_cap & PERF_CAP_PEBS_FORMAT) < 4)
-			perf_cap &= ~PERF_CAP_PEBS_BASELINE;
+
+		/*
+		 * Disallow adaptive PEBS as it is functionally broken, can be
+		 * used by the guest to read *host* LBRs, and can be used to
+		 * bypass userspace event filters.  To correctly and safely
+		 * support adaptive PEBS, KVM needs to:
+		 *
+		 * 1. Account for the ADAPTIVE flag when (re)programming fixed
+		 *    counters.
+		 *
+		 * 2. Gain support from perf (or take direct control of counter
+		 *    programming) to support events without adaptive PEBS
+		 *    enabled for the hardware counter.
+		 *
+		 * 3. Ensure LBR MSRs cannot hold host data on VM-Entry with
+		 *    adaptive PEBS enabled and MSR_PEBS_DATA_CFG.LBRS=1.
+		 *
+		 * 4. Document which PMU events are effectively exposed to the
+		 *    guest via adaptive PEBS, and make adaptive PEBS mutually
+		 *    exclusive with KVM_SET_PMU_EVENT_FILTER if necessary.
+		 */
+		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
 	return perf_cap;



