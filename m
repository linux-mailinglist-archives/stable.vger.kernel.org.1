Return-Path: <stable+bounces-109237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB6A137F9
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBA9188AB45
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310761DDC2B;
	Thu, 16 Jan 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z9XbPZXX"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DF19539F;
	Thu, 16 Jan 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023586; cv=none; b=FdPULHkbPyUBTTRwL8UrhgN7ZjDUk20Tvipw0MdpkCxJanqkVgfgFOSFtyB2Ipq7tDYbYh7+V2zFJw6EIlmt+J3rvCFRS6zMf6QG5IIMduK5fOKPhjOWxwGw5TSTYCaGWRkp2JCuCSgG5NJTV5Lo9IHjBF4/xt2+lZWC6yBeR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023586; c=relaxed/simple;
	bh=QU5d+Tyq+Qb2PApXjG+Zo+3QY/YuLIJeuJDQkS5Wwrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv7Tm1SDJNKhN1id0HPl4d81Mdxjhkqd16AeoW/D2+HSKE1VOR9E0H3Zu4g3FXnMWTh9UTom+pIvOKgYOvkvBG6MUBuHCJlahMM/Pmd7ov0vMEulLs3Icpom+ymDbLhTuVadbmEuGB/7flMwBszQ4WVOopIDf+XvxY2Cg+TqQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z9XbPZXX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YQozZ0qAw76KyENUe8cP271dJjMXAoDFnL7V32VXPSM=; b=Z9XbPZXXGMBLk78qmBqAmyE/8n
	MjspFRXmpAYMjU9mdXnUIrC4bOAPTh3qoW9gERMtQFaUrSIhBZGAULSu06rAU/usgdpwZCyUW5nac
	Oqz4NxrsKi89mLRzPjaY8syLOGYjv7DIhVjPHLuZeUxys7azJdoCPaTcBLbn694ucdRBnSl7zyJIw
	Cvnby9sxf/O+JL8EJs7OwmKA1DnunlM1S9TRI5KCuf+h/LeN+Klkk7KS+VawFW1csgGIef2YQD4OT
	CZj3ejz8J9EAQcMNujxY2eZlijCgn9GwDkKpI49BOUa3Qkmu8VodAyOErBynaSrcyg3uaOmj/9T8J
	e3XL8obQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYNBJ-0000000C52v-2zEW;
	Thu, 16 Jan 2025 10:32:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8471300777; Thu, 16 Jan 2025 11:32:56 +0100 (CET)
Date: Thu, 16 Jan 2025 11:32:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V9 1/3] perf/x86/intel: Avoid pmu_disable/enable if
 !cpuc->enabled in sample read
Message-ID: <20250116103256.GI8362@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115184318.2854459-1-kan.liang@linux.intel.com>

On Wed, Jan 15, 2025 at 10:43:16AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The WARN_ON(this_cpu_read(cpu_hw_events.enabled)) in the
> intel_pmu_save_and_restart_reload() is triggered, when sampling read
> topdown events.
> 
> In a NMI handler, the cpu_hw_events.enabled is set and used to indicate
> the status of core PMU. The generic pmu->pmu_disable_count, updated in
> the perf_pmu_disable/enable pair, is not touched.
> However, the perf_pmu_disable/enable pair is invoked when sampling read
> in a NMI handler. The cpuc->enabled is mistakenly set by the
> perf_pmu_enable().
> 
> Avoid perf_pmu_disable/enable() if the core PMU is already disabled.
> 
> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/core.c | 7 +++++--
>  arch/x86/events/intel/ds.c   | 9 ++++++---
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2a2824e9c50d..bce423ad3fad 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2778,15 +2778,18 @@ DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
>  static void intel_pmu_read_topdown_event(struct perf_event *event)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int pmu_enabled = cpuc->enabled;
>  
>  	/* Only need to call update_topdown_event() once for group read. */
>  	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
>  	    !is_slots_event(event))
>  		return;
>  
> -	perf_pmu_disable(event->pmu);
> +	if (pmu_enabled)
> +		perf_pmu_disable(event->pmu);
>  	static_call(intel_pmu_update_topdown_event)(event);
> -	perf_pmu_enable(event->pmu);
> +	if (pmu_enabled)
> +		perf_pmu_enable(event->pmu);
>  }
>  
>  static void intel_pmu_read_event(struct perf_event *event)
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index ba74e1198328..81b6ec8e824e 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2096,11 +2096,14 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
>  
>  void intel_pmu_auto_reload_read(struct perf_event *event)
>  {
> -	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
> +	int pmu_enabled = this_cpu_read(cpu_hw_events.enabled);
>  
> -	perf_pmu_disable(event->pmu);
> +	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
> +	if (pmu_enabled)
> +		perf_pmu_disable(event->pmu);
>  	intel_pmu_drain_pebs_buffer();
> -	perf_pmu_enable(event->pmu);
> +	if (pmu_enabled)
> +		perf_pmu_enable(event->pmu);
>  }

Hurmp.. would it not be nicer to merge that logic. Perhaps something
like so?

---
 arch/x86/events/intel/core.c | 41 +++++++++++++++++++++++------------------
 arch/x86/events/intel/ds.c   | 11 +----------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196d1d18..5b491a6815e6 100644
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
+		if (is_topdown_event(event) && !is_slots_event(event) &&
+		    (cpuc->txn_flags & PERF_PMU_TXN_READ))
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
+		return;
+	}
+
+	x86_perf_event_update(event);
 }
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e1198328..050098c54ae7 100644
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
index 31c2771545a6..38b3e30f8988 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1643,7 +1643,7 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 

