Return-Path: <stable+bounces-109242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAFA1384B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B175160C43
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A011DE2C1;
	Thu, 16 Jan 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NNkuYFJY"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100519539F;
	Thu, 16 Jan 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024683; cv=none; b=lvdSQR+6bXj+d619TOM8AlfOkJORDmc30rs9ajqfJwjsTq4QlVn1s/r4hgVCfFUPPoO2TUT51mt0Rd/uSoUB0H8fI+QzZ5/sSREwmBp33al53ETnGXYzBFgUrZXXXTd9qIs+Ez3Mn4t4YYQQYSFI9C2D/eCZduItELVGR8B4eGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024683; c=relaxed/simple;
	bh=udEk1jg766leWDtC3YL+cmAPvUjMMRcQGtk6yyA5p/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttlCzfDqBzN2sZh7ADk5rGQfQe5UssHumkeVeVnqhRofDQSvW02YJQzJSEc0hPLf7piKzairOiTTXYEnRB3VZ2pa/482ESOk5JGhd/gRnmYU9lAiWMEkhS+hf4C5UkzOTd0wdZGBDZpBKMpwsnARWXUCH+Jjf0zCOBVv+u5Wm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NNkuYFJY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wzbEg2Uym/RfTI4+/bX5iwFr7gHGdR2b38FGkzYxqPo=; b=NNkuYFJY5hIHc3o3AFXQamH8Mn
	up2ug9Y0lsKs7CzuWOAuWiwvgEdM3sJPUCI2bfbPiIGsYiasu+t1/EaW1QO0cMBb88m2nrLuKzyrP
	UBn189gHD21Fgp5xkuJVDCCE1oVdSG2/o1W4p+3tuwQr9ZtIBcgzLI6EtG+fyOlSrae8xutzW4hrw
	yT3wzVK3wvThtvr8mu+1l1GCM4e70BOtsLJzyxfOO0RgguTLfHR5SyQ8EQKsyKl6iUDkedUVGd6nt
	vuF4crzHKE03ffiI1wDMC35V19+46sWZj5h7H7FZIWBeYzT1wkwUUa7/a6MutWxCj6NbRyFpbG74R
	Qgr8NXIQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYNT1-0000000CKLa-04cl;
	Thu, 16 Jan 2025 10:51:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8EC9F300777; Thu, 16 Jan 2025 11:51:14 +0100 (CET)
Date: Thu, 16 Jan 2025 11:51:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V9 1/3] perf/x86/intel: Avoid pmu_disable/enable if
 !cpuc->enabled in sample read
Message-ID: <20250116105114.GH8385@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250116103256.GI8362@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116103256.GI8362@noisy.programming.kicks-ass.net>

On Thu, Jan 16, 2025 at 11:32:56AM +0100, Peter Zijlstra wrote:

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index ba74e1198328..050098c54ae7 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -953,7 +953,7 @@ int intel_pmu_drain_bts_buffer(void)
>  	return 1;
>  }
>  
> -static inline void intel_pmu_drain_pebs_buffer(void)
> +void intel_pmu_drain_pebs_buffer(void)
>  {
>  	struct perf_sample_data data;
>  

Also, while poking there, I noticed we never did the below :/


---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5b491a6815e6..20a2556de645 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3081,7 +3081,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
-		x86_pmu.drain_pebs(regs, &data);
+		static_call(x86_pmu_drain_pebs)(regs, &data);
 		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 050098c54ae7..75e5e6678282 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -956,8 +956,7 @@ int intel_pmu_drain_bts_buffer(void)
 void intel_pmu_drain_pebs_buffer(void)
 {
 	struct perf_sample_data data;
-
-	x86_pmu.drain_pebs(NULL, &data);
+	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 38b3e30f8988..fb635e2b9909 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1107,6 +1107,7 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+DECLARE_STATIC_CALL(x86_pmu_drain_pebs, *x86_pmu.drain_pebs);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {

