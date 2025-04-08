Return-Path: <stable+bounces-128839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB803A7F585
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B08317CABA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2E261361;
	Tue,  8 Apr 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bBG8scTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972025FA2F
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095852; cv=none; b=SXcAc6g4NMGERaej3vuH3q1eGfcXyYDJGRMrgT+b5koMXRlDmenu11pAuO+yCTTX5+Uh6C03Ng456OukW66wpm73VV18ZRads5BrSu29azb73xdCBIt6462jvgF7/UYZRs/eYv60UmwoHLzvd4L3QnTZLDSS3XpPurECJFvgI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095852; c=relaxed/simple;
	bh=AZOpj+5wprMU0r564NxjdgGnc1d7rbh95EMk8UeXqTE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e2GquOl9w5E9b7aW3Nchi+VrlhlMcAPsdIW2ONZtFawsSvwebAfB8ghjVdjJlRg9Vhbutkz3xZHr3TKLJ6YMpeMF7mTb3bSuQ63qgFKbT8vDZuEIGhVKh3moko3BibNzIx/uwtQR2cyupZ2A0MnL8bVDVAYxl0V8IUOeAQIxgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bBG8scTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDA6C4CEE5;
	Tue,  8 Apr 2025 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095852;
	bh=AZOpj+5wprMU0r564NxjdgGnc1d7rbh95EMk8UeXqTE=;
	h=Subject:To:Cc:From:Date:From;
	b=bBG8scTcGq3ZjQUvf8CEY7Xbv53vj/Va9oX0D7j755kQf5p1D/IvS9HEG8wkxST1r
	 KBTWHq39VFuuM9HEt6pU/CS9yEv/d0KLX8hdD4jpEg/+RkNb6f2WYow4PmzqT1l4aP
	 X43dhyUZ7bJ5t6BqIjr0J9RZG3P/XjXN9DSGwE/U=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample" failed to apply to 5.15-stable tree
To: kan.liang@linux.intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 09:02:39 +0200
Message-ID: <2025040839-deputize-undertook-8a56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f9bdf1f953392c9edd69a7f884f78c0390127029
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040839-deputize-undertook-8a56@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9bdf1f953392c9edd69a7f884f78c0390127029 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Tue, 21 Jan 2025 07:23:01 -0800
Subject: [PATCH] perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample
 read

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

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2acea83526c6..1ccc961f8182 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2785,28 +2785,33 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 
 DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
-static void intel_pmu_read_topdown_event(struct perf_event *event)
-{
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-
-	/* Only need to call update_topdown_event() once for group read. */
-	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
-	    !is_slots_event(event))
-		return;
-
-	perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
-	perf_pmu_enable(event->pmu);
-}
-
 static void intel_pmu_read_event(struct perf_event *event)
 {
-	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-		intel_pmu_auto_reload_read(event);
-	else if (is_topdown_count(event))
-		intel_pmu_read_topdown_event(event);
-	else
-		x86_perf_event_update(event);
+	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		bool pmu_enabled = cpuc->enabled;
+
+		/* Only need to call update_topdown_event() once for group read. */
+		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
+			return;
+
+		cpuc->enabled = 0;
+		if (pmu_enabled)
+			intel_pmu_disable_all();
+
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
index 322963b02a91..eb14b46423e5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -953,7 +953,7 @@ int intel_pmu_drain_bts_buffer(void)
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
index 084e9196b458..536a112f6353 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1644,7 +1644,7 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 


