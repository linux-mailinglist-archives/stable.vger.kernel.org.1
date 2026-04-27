Return-Path: <stable+bounces-241269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBQwF+wm72lE8AAAu9opvQ
	(envelope-from <stable+bounces-241269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:05:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CFA46F8AC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EB8E30234EA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087AF3A9D95;
	Mon, 27 Apr 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNhFpwXA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FF3A0E99;
	Mon, 27 Apr 2026 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280421; cv=none; b=iM6f3Nr0WFhVNGfEYi4MJm19JnkJo/nvRcP9SA81skkaxrh+M4XRmx+Z/8gBGI1+80nQ4DQRO9VDyjXvsYp5fFPvqdm7XOuTL2NUoE3UAVnyLMllg6zkDsmSa9QG/AKiA2Kjdc0AoaRrEpUFRwxo4PKrlWzpl9YL2RTlhAHPoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280421; c=relaxed/simple;
	bh=1Y5MnRG/1o8wFsR2/x7ymmXvutjdTzy2CcOaCVPodt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aspi8b7X2A/2DSaJDj/yesPKhs7GlsrhTRcF10slGilg1kVP3u9g1K/wB1RyoyrnAXRWPXjSh6mwKi/3K/YTioVzjq9AWmtfoCJnNZTEq4AedU+RkZZUTaMJyR/wePmuXu4MF7uKzTOQw1yPyfsXwGIb1LMzz6E7/vABtgUPHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNhFpwXA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777280421; x=1808816421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Y5MnRG/1o8wFsR2/x7ymmXvutjdTzy2CcOaCVPodt4=;
  b=CNhFpwXAjh/EtVUUjy+U6zI0sQKFLqdx4u8CiogvKdtXNoMeGXeZwjie
   mvmgJ4fQurqSq1/dQk0anDg2HzAUFpfvioPwv1iN8j9gd5CncuLbaIfrc
   h7Q3BaDzWrpzTkerQ/he0yB+f1MNEEmvxqNIB5TTJ7yMEj70gwQxSgPr/
   65uoFjmWeiz8oLXUzs5BQfFDaRuWLnb+51HrbTVoNKSw9OcSxvjvk21vx
   d/u1YYkcT3DZIabObpEggZEiwncH7SzvFvMbPmX8iFOijLnojAt/YyJTd
   Qqc8BNy70vWECAbhOf25tjQigEihHsP4W2OxQbVztB5isqxT2bJPYIfJY
   Q==;
X-CSE-ConnectionGUID: SpFaqobxSkq2g6zCsRR9jg==
X-CSE-MsgGUID: urwG5uudRIetY+5L4dwmvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88476340"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88476340"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:00:21 -0700
X-CSE-ConnectionGUID: NVAG3SZ8QfWiSZesu8wTKg==
X-CSE-MsgGUID: F0L2+HZQR5+P/CccpFKD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233850615"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 02:00:17 -0700
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
Subject: [Patch v3 2/4] perf/x86/intel: Disable PMI for self-reloaded ACR events
Date: Mon, 27 Apr 2026 16:55:11 +0800
Message-Id: <20260427085513.3728672-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
References: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2CFA46F8AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241269-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

On platforms with Auto Counter Reload (ACR) support, such as NVL, a
"NMI received for unknown reason 30" warning is observed when running
multiple events in a group with ACR enabled:

  $ perf record -e '{instructions/period=20000,acr_mask=0x2/u,\
    cycles/period=40000,acr_mask=0x3/u}' ./test

The warning occurs because the Performance Monitoring Interrupt (PMI)
is enabled for the self-reloaded event (the cycles event in this case).
According to the Intel SDM, the overflow bit
(IA32_PERF_GLOBAL_STATUS.PMCn_OVF) is never set for self-reloaded events.
Since the bit is not set, the perf NMI handler cannot identify the source
of the interrupt, leading to the "unknown reason" message.

Furthermore, enabling PMI for self-reloaded events is unnecessary and
can lead to extraneous records that pollute the user's requested data.

Disable the interrupt bit for all events configured with ACR self-reload.

Reported-by: Andi Kleen <ak@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 17 +++++++++++++----
 arch/x86/events/perf_event.h | 10 ++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1a2c268018a2..c1841fa89908 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3118,11 +3118,11 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	intel_set_masks(event, idx);
 
 	/*
-	 * Enable IRQ generation (0x8), if not PEBS,
-	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
-	 * if requested:
+	 * Enable IRQ generation (0x8), if not PEBS and self-reloaded
+	 * ACR event, and enable ring-3 counting (0x2) and ring-0
+	 * counting (0x1) if requested:
 	 */
-	if (!event->attr.precise_ip)
+	if (!event->attr.precise_ip && !is_acr_self_reload_event(event))
 		bits |= INTEL_FIXED_0_ENABLE_PMI;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |= INTEL_FIXED_0_USER;
@@ -3306,6 +3306,15 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
 		static_call_cond(intel_pmu_enable_event_ext)(event);
+		/*
+		 * For self-reloaded ACR event, don't enable PMI since
+		 * HW won't set overflow bit in GLOBAL_STATUS. Otherwise,
+		 * the PMI would be recognized as a suspicious NMI.
+		 */
+		if (is_acr_self_reload_event(event))
+			hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
+		else if (!event->attr.precise_ip)
+			hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..524668dcf4cc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -137,6 +137,16 @@ static inline bool is_acr_event_group(struct perf_event *event)
 	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
 }
 
+static inline bool is_acr_self_reload_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->idx < 0)
+		return false;
+
+	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
-- 
2.34.1


