Return-Path: <stable+bounces-201121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C6CC072F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 02:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E848B3013EA0
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DF2652BD;
	Tue, 16 Dec 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8QMP/Qs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A8230BD5;
	Tue, 16 Dec 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848310; cv=none; b=tMYRmXs60Fk2KJ0TcjcHheZz+Rm6gEF4lhlZJ5Z4X/nMb5AItYm+PQRnHXzCnKCDXhodSwzdfsAozAOLKN1Yr12svaCceb3pJNPCwWXpg52C1jKWEJTIQvwznCnBgK2dgBfXWYGM5oR6dDJB6SkgpHE+ZWuaJwe2s5Ji3XmwBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848310; c=relaxed/simple;
	bh=YtGr61kLMc7I/r5jzFhPwfhjvXqfyibTp/a8r47rJpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rWx/lsW86MSOrj0VgGysT1ogt1fyUAopoXMiB6z63/zZMzoGheXLQkmdWdX7b5mJ+rbB7VrXyAHO4ktQ0SGZ7VI8/jLclUj71EUZclMGX+nz+ux5jPH71bv8R65qIUmJuwPkL8p2aRrpZCznfCioGEea9XkHpAOF6P+Ri/7upmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8QMP/Qs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765848309; x=1797384309;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YtGr61kLMc7I/r5jzFhPwfhjvXqfyibTp/a8r47rJpE=;
  b=j8QMP/Qs8BgdOhVJYZAQITGllH5BnJn5kqt1l3sIHFQNpBQCuOfhrlaF
   1DqzgX+nkbCoI7NmtxzU37aDwHd+tO5k+Ok00SuRhoNBYcKhVfP0GVubP
   A+550TE/NNnv910/3QO4xlUzFKmuartuWLKxgLkSiUPyCS2T/kqyQnaxD
   rR/U+yOoPj9RVlnIgQtcMwob5wC3j8itLfNw/WLyy8E92FhH5B8JhMYri
   aVjBf3MbNwLDp8JVHbyv2UAopACjHHg49Ilk9jx1Xg6HON3d9hG2gWCgj
   eWLFlZJ+K23CQBn6XD0U0Dv+0+1cGXDP+r/HRiRtPOAKVadmD+nmdYALL
   Q==;
X-CSE-ConnectionGUID: 0MBV2hF2QnSlRQozY7xfrg==
X-CSE-MsgGUID: 3AJz+gnvSTawLv7MXwyigQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="93236195"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="93236195"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 17:25:08 -0800
X-CSE-ConnectionGUID: MDfM8vCFSBu17lxTzlRlQA==
X-CSE-MsgGUID: tBfVXPSpR1yqgWO1DbeG8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="202791968"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 15 Dec 2025 17:25:04 -0800
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
Subject: [PATCH] perf/x86/intel: Add missing branch counters constraint apply
Date: Tue, 16 Dec 2025 09:21:13 +0800
Message-Id: <20251216012113.1417511-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index aad89c9d9514..7c6a0001c8e4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4364,6 +4364,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
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
@@ -4434,21 +4447,18 @@ static int intel_pmu_hw_config(struct perf_event *event)
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

base-commit: 9929dffce5ed7e2988e0274f4db98035508b16d9
-- 
2.34.1


