Return-Path: <stable+bounces-220043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENwrGjt/omlI3gQAu9opvQ
	(envelope-from <stable+bounces-220043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 06:38:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D57141C06D0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 06:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F5B33072DA8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A210C2F260C;
	Sat, 28 Feb 2026 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXQXUtp1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325A33ADB3;
	Sat, 28 Feb 2026 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772257044; cv=none; b=gsa+tTQTdDWa0IwF7jnYZKbXsw8CoQTkzZL5ZFAYA+3QO0PTMR8vhcRCHfBkGHo2ML0sq0Nn2v5szj+aI4XasJ7fDNFqi++/1ePQJQZ75aaQMljrkz4eZhh0WdpDPdCMpqvczkLJOsZUNDXp1DgRkh0QvFrx6zU7IjAst5mu+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772257044; c=relaxed/simple;
	bh=Zf0G2TS1hZnEP/ac16XpA+MoRMoz8XBDzG7g7Kivs3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+bh4ay7kOkTXdYYylL07TKS2pLfacUdhiRe4szf3oYrau385mLqS9vMK/6WxX8jSQUvCgXWalltPAq57IHXhW1LpVuxoCPa0UMbzqtHMjZAmohU+izJ1IML0xVO162EK7WhcrKbQ4pH7q9uEpZIznWKYsVhpyuzmZSa9s4rnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXQXUtp1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772257044; x=1803793044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zf0G2TS1hZnEP/ac16XpA+MoRMoz8XBDzG7g7Kivs3c=;
  b=MXQXUtp1kSig9LIbLMAjyej/bjfFg20/V2w6FQWdhxyg+3pWd3ImOW9Q
   5QZ4tnwxLT0XvLUy49GDHlRGBbW7CFLh7uATK5xRDSkP1e20oeV7JYtoG
   OBcW40GufNZDDXs/HM7lmDKSpWG4wKL26WfbZRGGRUu1Wjc5oJ13zklFY
   P9aS5vc2zkpNlA5op8uNtlyE9MIM0qJ/heQIcGH7blfotL7qtH2ER61iu
   ToiK5mXqBA373jkDQlXhHlr00oHqH5IT/PONCITqqAuiPlmsQfETAKvct
   0OMiBY4Tn65QPEdRF3/iYTBag8Taf1Qf54Za+mykVnfnnU5Q4og4sy4oG
   g==;
X-CSE-ConnectionGUID: G47dTFk8QNifeCK7sVW1Hg==
X-CSE-MsgGUID: CpwGISLbSrKOdco/dzR/qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73307700"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73307700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 21:37:23 -0800
X-CSE-ConnectionGUID: nJmVYBD+QI+Ak0nV+geRsQ==
X-CSE-MsgGUID: 8dfOtU85RtCbBglGxXtD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="254921382"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 27 Feb 2026 21:37:19 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters constraint apply
Date: Sat, 28 Feb 2026 13:33:20 +0800
Message-Id: <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220043-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: D57141C06D0
X-Rspamd-Action: no action

When running the command:
'perf record -e "{instructions,instructions:p}" -j any,counter sleep 1',
a "shift-out-of-bounds" warning is reported on CWF.

[ 5231.981423][   C17] UBSAN: shift-out-of-bounds in /kbuild/src/consumer/arch/x86/events/intel/lbr.c:970:15
[ 5231.981428][   C17] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[ 5231.981436][   C17] CPU: 17 UID: 0 PID: 211871 Comm: sleep Tainted: G S      W           6.18.0-2025-12-09-intel-next-48166-g6cf574943ba3 #1 PREEMPT(none)
[ 5231.981445][   C17] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 5231.981447][   C17] Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.IPC.3544.P98.2508260307 08/26/2025
[ 5231.981449][   C17] Call Trace:
[ 5231.981453][   C17]  <NMI>
[ 5231.981455][   C17]  dump_stack_lvl+0x4b/0x70
[ 5231.981463][   C17]  ubsan_epilogue+0x5/0x2b
[ 5231.981468][   C17]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe6
[ 5231.981472][   C17]  ? __entry_text_end+0x158b/0x102259
[ 5231.981475][   C17]  intel_pmu_lbr_counters_reorder.isra.0.cold+0x2a/0xa7
[ 5231.981480][   C17]  ? __task_pid_nr_ns+0x134/0x2a0
[ 5231.981483][   C17]  ? __pfx_intel_pmu_lbr_counters_reorder.isra.0+0x10/0x10
[ 5231.981486][   C17]  ? __pfx_perf_output_sample+0x10/0x10
[ 5231.981489][   C17]  ? arch_perf_update_userpage+0x293/0x310
[ 5231.981491][   C17]  ? __pfx_arch_perf_update_userpage+0x10/0x10
[ 5231.981494][   C17]  ? local_clock_noinstr+0xd/0x100
[ 5231.981498][   C17]  ? calc_timer_values+0x2cb/0x860
[ 5231.981501][   C17]  ? perf_event_update_userpage+0x399/0x5b0
[ 5231.981505][   C17]  ? __pfx_perf_event_update_userpage+0x10/0x10
[ 5231.981508][   C17]  ? local_clock_noinstr+0xd/0x100
[ 5231.981511][   C17]  ? __perf_event_account_interrupt+0x11c/0x540
[ 5231.981514][   C17]  intel_pmu_lbr_save_brstack+0xc0/0x4c0
[ 5231.981518][   C17]  setup_arch_pebs_sample_data+0x114b/0x2400
[ 5231.981522][   C17]  ? __pfx_x86_perf_event_set_period+0x10/0x10
[ 5231.981526][   C17]  intel_pmu_drain_arch_pebs+0x64d/0xcc0
[ 5231.981530][   C17]  ? __pfx_intel_pmu_drain_arch_pebs+0x10/0x10
[ 5231.981534][   C17]  ? unwind_next_frame+0x11c5/0x1df0
[ 5231.981541][   C17]  ? intel_pmu_drain_bts_buffer+0xbf/0x6e0
[ 5231.981545][   C17]  ? __pfx_intel_pmu_drain_bts_buffer+0x10/0x10
[ 5231.981550][   C17]  handle_pmi_common+0x5c5/0xcb0
[ 5231.981553][   C17]  ? __pfx_handle_pmi_common+0x10/0x10
[ 5231.981556][   C17]  ? intel_idle+0x64/0xb0
[ 5231.981560][   C17]  ? intel_bts_interrupt+0xe5/0x4c0
[ 5231.981562][   C17]  ? __pfx_intel_bts_interrupt+0x10/0x10
[ 5231.981565][   C17]  ? intel_pmu_lbr_filter+0x27f/0x910
[ 5231.981568][   C17]  intel_pmu_handle_irq+0x2ed/0x600
[ 5231.981571][   C17]  perf_event_nmi_handler+0x219/0x280
[ 5231.981575][   C17]  ? __pfx_perf_event_nmi_handler+0x10/0x10
[ 5231.981579][   C17]  ? unwind_next_frame+0x11c5/0x1df0
[ 5231.981582][   C17]  nmi_handle.part.0+0x11b/0x3a0
[ 5231.981585][   C17]  ? unwind_next_frame+0x11c5/0x1df0
[ 5231.981588][   C17]  default_do_nmi+0x6b/0x180
[ 5231.981591][   C17]  fred_exc_nmi+0x3e/0x80
[ 5231.981594][   C17]  asm_fred_entrypoint_kernel+0x41/0x60
[ 5231.981596][   C17] RIP: 0010:unwind_next_frame+0x11c5/0x1df0
......

The warning occurs because the second "instructions:p" event, which
involves branch counters sampling, is incorrectly programmed to fixed
counter 0 instead of the general-purpose (GP) counters 0-3 that support
branch counters sampling. Currently only GP counters 0~3 support branch
counters sampling on CWF, any event involving branch counters sampling
should be programed on GP counters 0~3. Since the counter index of fixed
counter 0 is 32, it leads to the "src" value in below code is right
shifted 64 bits and trigger the "shift-out-of-bounds" warning.

cnt = (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;

The root cause is the loss of the branch counters constraint for the
last event in the branch counters sampling event group. This results in
the second "instructions:p" event being programmed on fixed counter 0
incorrectly instead of the appropriate GP counters 0~3.

To address this, we apply the missing branch counters constraint for
the last event in the group. Additionally, we introduce a new function,
`intel_set_branch_counter_constr()`, to apply the branch counters
constraint and avoid code duplication.

Cc: stable@vger.kernel.org
Reported-by: Xudong Hao <xudong.hao@intel.com>
Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4768236c054b..4b042d71104f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
 		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
 }
 
+static inline int intel_set_branch_counter_constr(struct perf_event *event,
+						  int *num)
+{
+	if (branch_sample_call_stack(event))
+		return -EINVAL;
+	if (branch_sample_counters(event)) {
+		(*num)++;
+		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
+	}
+
+	return 0;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4698,21 +4711,18 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		 * group, which requires the extra space to store the counters.
 		 */
 		leader = event->group_leader;
-		if (branch_sample_call_stack(leader))
+		if (intel_set_branch_counter_constr(leader, &num))
 			return -EINVAL;
-		if (branch_sample_counters(leader)) {
-			num++;
-			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
-		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
 		for_each_sibling_event(sibling, leader) {
-			if (branch_sample_call_stack(sibling))
+			if (intel_set_branch_counter_constr(sibling, &num))
+				return -EINVAL;
+		}
+
+		if (event != leader) {
+			if (intel_set_branch_counter_constr(event, &num))
 				return -EINVAL;
-			if (branch_sample_counters(sibling)) {
-				num++;
-				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
-			}
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))
-- 
2.34.1


