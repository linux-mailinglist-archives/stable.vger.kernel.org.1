Return-Path: <stable+bounces-112287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E074A286BC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9101661C6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCC22A80B;
	Wed,  5 Feb 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHK7rtZN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8qol6aXZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6421A452;
	Wed,  5 Feb 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748333; cv=none; b=JIkI+nKdZ6wfYNYgb2c7jq6Z3k/Z35SqWEaV9QBZjrsux2p5gjidtmUg3pAG1ZSYhvHX6rFfzrxc7W2UagYfIXGiKpcsTwxb9txdpvONU511yLNA4vajgPgq0k81Zl1rI9HeV3r53d3KSoU1KnQXHq6tobtnJiYwwFLt+il0gnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748333; c=relaxed/simple;
	bh=ejBGybWl/2X7RDzx8HyJW9Tu44YXvc3CcenPSChZzT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oXngvXX486y8NhxU9u5T7lbGBMn6Wbr30u/k2vYhRjLdlLvAWykjMCua8VREsKae7ytd177vM3dTxNOUJiOCBORoU/jloNTPMl/kINyG2k55yzl9rDEldmWvybOm44s7VffuXW1yOBqJB+KHuAUlnVI/y0qwS/VnmK9peD8uYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHK7rtZN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8qol6aXZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 09:38:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738748329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkwJ1eZFowoE0UqaNvPP1RgTdHMWV6s/fbvUXBztQFs=;
	b=oHK7rtZNRqtKFvhBUQlDGUWy4SQcYm6FTOd48mls4Di9GG96AJ/NJ77v5nLY9gkm9q/w7Q
	0PnfS7RtAA7PaxXEAds1iLsvfJ5caj7QARzYuYIpyhJbiSwrQFhbouAI0Xh92HHa/t+lQp
	0ClMVBftTXrrtboQPmDA/zicYs5vC1wX1SjrFbbSJ/bFJ9Wm18C7rzrsgmHElq3wtqFHU1
	d4ALLx9dn5qDeEaS3nUp+483djpELeYtsaB25eycWk+HaEBsc5QbbaNtZ6GDwxGFXXzvdm
	Q9TriGg2MQDUQVl+Cl8e4aJGZEtPI7rTHC0jrpn0tkghw0viGzpFZZdtjP+f3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738748329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkwJ1eZFowoE0UqaNvPP1RgTdHMWV6s/fbvUXBztQFs=;
	b=8qol6aXZxGHcZV2QJBb4wdQmsQsHiqKYWFgvR7zl+xINmahZXZwu7c6D+Uev7EOmBxB40S
	2lfmYHCXG8ABoODQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Avoid disable PMU if !cpuc->enabled
 in sample read
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250121152303.3128733-2-kan.liang@linux.intel.com>
References: <20250121152303.3128733-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173874832925.10177.13373416999968689534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f9bdf1f953392c9edd69a7f884f78c0390127029
Gitweb:        https://git.kernel.org/tip/f9bdf1f953392c9edd69a7f884f78c0390127029
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 21 Jan 2025 07:23:01 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Feb 2025 10:29:45 +01:00

perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read

The WARN_ON(this_cpu_read(cpu_hw_events.enabled)) in the
intel_pmu_save_and_restart_reload() is triggered, when sampling read
topdown events.

In a NMI handler, the cpu_hw_events.enabled is set and used to indicate
the status of core PMU. The generic pmu->pmu_disable_count, updated in
the perf_pmu_disable/enable pair, is not touched.
However, the perf_pmu_disable/enable pair is invoked when sampling read
in a NMI handler. The cpuc->enabled is mistakenly set by the
perf_pmu_enable().

Avoid disabling PMU if the core PMU is already disabled.
Merge the logic together.

Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250121152303.3128733-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 41 +++++++++++++++++++----------------
 arch/x86/events/intel/ds.c   | 11 +---------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2acea83..1ccc961 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2785,28 +2785,33 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 
 DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
-static void intel_pmu_read_topdown_event(struct perf_event *event)
+static void intel_pmu_read_event(struct perf_event *event)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		bool pmu_enabled = cpuc->enabled;
 
-	/* Only need to call update_topdown_event() once for group read. */
-	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
-	    !is_slots_event(event))
-		return;
+		/* Only need to call update_topdown_event() once for group read. */
+		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
+			return;
 
-	perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
-	perf_pmu_enable(event->pmu);
-}
+		cpuc->enabled = 0;
+		if (pmu_enabled)
+			intel_pmu_disable_all();
 
-static void intel_pmu_read_event(struct perf_event *event)
-{
-	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-		intel_pmu_auto_reload_read(event);
-	else if (is_topdown_count(event))
-		intel_pmu_read_topdown_event(event);
-	else
-		x86_perf_event_update(event);
+		if (is_topdown_event(event))
+			static_call(intel_pmu_update_topdown_event)(event);
+		else
+			intel_pmu_drain_pebs_buffer();
+
+		cpuc->enabled = pmu_enabled;
+		if (pmu_enabled)
+			intel_pmu_enable_all(0);
+
+		return;
+	}
+
+	x86_perf_event_update(event);
 }
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 322963b..eb14b46 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -953,7 +953,7 @@ unlock:
 	return 1;
 }
 
-static inline void intel_pmu_drain_pebs_buffer(void)
+void intel_pmu_drain_pebs_buffer(void)
 {
 	struct perf_sample_data data;
 
@@ -2094,15 +2094,6 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	return NULL;
 }
 
-void intel_pmu_auto_reload_read(struct perf_event *event)
-{
-	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
-
-	perf_pmu_disable(event->pmu);
-	intel_pmu_drain_pebs_buffer();
-	perf_pmu_enable(event->pmu);
-}
-
 /*
  * Special variant of intel_pmu_save_and_restart() for auto-reload.
  */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 084e919..536a112 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1644,7 +1644,7 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 

