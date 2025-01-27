Return-Path: <stable+bounces-110879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7256A1DA92
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38153163294
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2F157493;
	Mon, 27 Jan 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kpiDTN9y"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F07DA62;
	Mon, 27 Jan 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995365; cv=none; b=eV2qNjVB0TPHRZ+YZqv9tn/ZCc3okqUyzuPJ/9y4cpIYtv4D4yahsiLmruQJhgaNlKAcGxwPZJbgWipqdDHSDxNyFlJKrpUi0QF+ZfyQT9AuC+x+Dt26Ji4aIC3AKs7GLONu1lazqucBFZCkcV1l3BI4azw5q8bewh9YCwC1NOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995365; c=relaxed/simple;
	bh=hO92UuukEkI9ocNsg8SWXd7ID/vdfc1Y4HYcED9rMcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzfY5e2uPnkRrdlfzFD52nQ9StsX9ZSrGJ4nQtO262wlC1A01u5lsvFMMe/llKwfCGAQxgVuVy1xJWLVny3/vrFSu5Po5VfeXrnu6tHSonNx35dxfhz2oLce0I1zo4z8Shdm83m5ob5wU+MAebpaFWDw/bfv8cxUqS31XbCZX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kpiDTN9y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bDaTPO2x/aTAjvVSlVsh/e9yfd+KvqjQi+MHjLjJpW4=; b=kpiDTN9yjxBkuGeDrslVUNX2zA
	CxKRnKB7FUrkMI7jmGc6luUmMvVyV6ekajEhMBXJhTTCFKoKjoz3EZVisp8gyYC6pllOaQs1muUvK
	m2JnlZiPDO/xpN37jrXlI51Pbs1wzCPNaUwqhzefc0Xc2s9x5zCgBtr1AIkV0qecMejKznSGj1PrY
	IqeuC/5Q2Lrqt0oW58tbcTCoI5qQ0HvNbTTolmFvz9FUra0gNVaBSaVORKngCD4CKTV9JsTO+GNUn
	VwOMd+6Txf7uYV3nH0nv75UURVuTeXMH1tGdDVXv4uCMgTcTnEY3Htrnm12CepHEc7g2UhXLDlOZT
	geueG6iw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRzB-0000000Ej7o-3EBZ;
	Mon, 27 Jan 2025 16:29:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53A3F3004DE; Mon, 27 Jan 2025 17:29:17 +0100 (CET)
Date: Mon, 27 Jan 2025 17:29:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/20] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Message-ID: <20250127162917.GM16742@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123140721.2496639-3-dapeng1.mi@linux.intel.com>

On Thu, Jan 23, 2025 at 02:07:03PM +0000, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The EAX of the CPUID Leaf 023H enumerates the mask of valid sub-leaves.
> To tell the availability of the sub-leaf 1 (enumerate the counter mask),
> perf should check the bit 1 (0x2) of EAS, rather than bit 0 (0x1).
> 
> The error is not user-visible on bare metal. Because the sub-leaf 0 and
> the sub-leaf 1 are always available. However, it may bring issues in a
> virtualization environment when a VMM only enumerates the sub-leaf 0.
> 
> Fixes: eb467aaac21e ("perf/x86/intel: Support Architectural PerfMon Extension leaf")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/core.c      | 4 ++--
>  arch/x86/include/asm/perf_event.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5e8521a54474..12eb96219740 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4966,8 +4966,8 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
>  	if (ebx & ARCH_PERFMON_EXT_EQ)
>  		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
>  
> -	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
> -		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
> +	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF) {
> +		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF_BIT,
>  			    &eax, &ebx, &ecx, &edx);
>  		pmu->cntr_mask64 = eax;
>  		pmu->fixed_cntr_mask64 = ebx;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index adaeb8ca3a8a..71e2ae021374 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -197,7 +197,7 @@ union cpuid10_edx {
>  #define ARCH_PERFMON_EXT_UMASK2			0x1
>  #define ARCH_PERFMON_EXT_EQ			0x2
>  #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
> -#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
> +#define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)

if you'll look around, you'll note this file uses BIT_ULL(), please stay
consistent.

