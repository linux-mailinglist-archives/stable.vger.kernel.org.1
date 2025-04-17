Return-Path: <stable+bounces-133097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8221A91D3B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C227A84C1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A224E4C4;
	Thu, 17 Apr 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELI7GUjE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JCxHGpTZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FE24E013;
	Thu, 17 Apr 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894904; cv=none; b=gTC3CV5abGQJA3OFHbwwzj2WBOacoQwCtmuukjnIgoA37uI3QstHxrgXRlxRv5edN5TNMrplrcrCp1KvKVEes6L+D45d3V8/d/NxqmA8u1M60H4kzcQbg+pdH/p8buojnOflkdOHVkjNgrs8VlaAIMYAEu51YmJ394+c8bhXNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894904; c=relaxed/simple;
	bh=ZdQ/IO0ReljNxXX68kgqbH31SUrEdfwHn+DsXpwI6kI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f9RsMEGFrBre4GXDZcxOGqO3ieMYyvq3uWDiyx+oWGhvvwBQXQXuTSm9BABBiyPlE18eYDeXKY526PUUDXOKHChWMyFm14LJ40hQnIKpoRJlHgcANZPq8CtqEIqW+i0O1BZyWZZ35bnHft7eaflQXeIn0DYTqn1qugLgNg6w/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELI7GUjE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JCxHGpTZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdcGOXTZqUAGvG4HuLuddwUdUaL9bJg7D/bLbSLmyhk=;
	b=ELI7GUjEUIVWs7IVpT8nnl/Aa2kX9RqpTdEv1Ri9VDR0T2RDtJd93gAG3hDm33gqYJJngy
	6ccWWGNovapBZf8HE7x62yo4dFYrpnXpPLDlbYLNFA/+n5l5XKoAL7G2XLmiyVpsD91SjS
	uzCBok6gB2OXqfs3TlsPdJC5Izmkw2577fgLh4aaOqwv3zXpwiF/51VgHwXWEGK143if5B
	gdVvmNeqQnIte9GKWQJTzJScxUHKoPtLWfh9EZeOqBQzb/U49jvFWY/OZTSXi0oiVdwGGq
	9R4PrOr7pGfCM7PEXNULxwiL7u4wNtiN2kHKDk7tFpfepr+2tyhn8YniBqR5iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdcGOXTZqUAGvG4HuLuddwUdUaL9bJg7D/bLbSLmyhk=;
	b=JCxHGpTZzpTl3X2nyCBc3bnWrknDyDNuEvkRdsSz6rXME2DH2WWEk4yXPHa2Kogphoct6L
	OrPnzEFbLwGipQAA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Don't clear perf metrics overflow
 bit unconditionally
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
References: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489952.31282.2734011160340897182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a5f5e1238f4ff919816f69e77d2537a48911767b
Gitweb:        https://git.kernel.org/tip/a5f5e1238f4ff919816f69e77d2537a48911767b
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 10:41:34 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:19:07 +02:00

perf/x86/intel: Don't clear perf metrics overflow bit unconditionally

The below code would always unconditionally clear other status bits like
perf metrics overflow bit once PEBS buffer overflows:

        status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;

This is incorrect. Perf metrics overflow bit should be cleared only when
fixed counter 3 in PEBS counter group. Otherwise perf metrics overflow
could be missed to handle.

Closes: https://lore.kernel.org/all/20250225110012.GK31462@noisy.programming.kicks-ass.net/
Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250415104135.318169-1-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66..2b70a3a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3049,7 +3049,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
-	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	inc_irq_stat(apic_perf_irqs);
 
@@ -3093,7 +3092,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
 		static_call(x86_pmu_drain_pebs)(regs, &data);
-		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3104,6 +3102,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 */
 		if (pebs_enabled != cpuc->pebs_enabled)
 			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+
+		/*
+		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
+		 * counter 3 and perf metrics counts if they are in counter group,
+		 * unnecessary to update again.
+		 */
+		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
+		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
+			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
 	}
 
 	/*
@@ -3123,6 +3130,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
+	status &= hybrid(cpuc->pmu, intel_ctrl);
+
 	/*
 	 * Checkpointed counters can lead to 'spurious' PMIs because the
 	 * rollback caused by the PMI will have cleared the overflow status

