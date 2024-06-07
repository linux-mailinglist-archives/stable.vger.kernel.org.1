Return-Path: <stable+bounces-49999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67240900BE2
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 20:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881EB1C21BFC
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454ED13D8BF;
	Fri,  7 Jun 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ+P6kAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00825A20;
	Fri,  7 Jun 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784833; cv=none; b=kvTmHPYa2BI7qBPSSYiusoPb/PyXlPK1i2r0SNqsk1T4DYWOMoEkoHGxhSI40KYhoKQjacqJB+rz6lbfNY8fcrnBt0rAAovXvca6PtlG16xwIWSwalwz+kYSdEtTt643MPW+ja0s/cvLv5qqWDOvd12WOdKvQhvA/RrlZRhcZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784833; c=relaxed/simple;
	bh=+d6eJOSptWCzzm26y7U5MbNGJfLQUzNJXPv4dUZf8Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmMFJ4xoiYvCpm8eimGrVcLK75m29IjDzu/goOUy+dExUbXfUnl+AkIaoVNZ6wSFJRrKWKwch85eB87Z/4ITokrqGwU0F82KIICDGFuHvtR57ZMwP78naaivo51pwOj1XSk1drnIF//TFm1YtzrGyHJda8uN078QyTm0lpyHGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ+P6kAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD17C32786;
	Fri,  7 Jun 2024 18:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717784832;
	bh=+d6eJOSptWCzzm26y7U5MbNGJfLQUzNJXPv4dUZf8Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJ+P6kAhbtDhS7jZsR+y53cAyqJidkC3Tdaqg1EQi2Tgk6LdJeXefpIJBnBL+QfGu
	 aiaASN7aB8foNZJ4zRSR9dhcJmC5T7+bCaBCk+JIkr0RmAz+jD9RntfhZHi3C6Cv4K
	 UwZPIWdR137BYrgyQwegkfFQ/r2m1iNoz7Q/snadEWPbtPTvIWgGuJNpwopHG+8MPX
	 z8YmXR0xcFfVHqAAC+QM0wBOLIzJX25nR2yPM4oFCPX3oQimF3iwvUoXHiBMvk/lfZ
	 tTatCZ5mVKq3EZe9nNYQAdzzv67IYhdsL1QKHNeEoaiwrTGjXX3r4oBcfgRPqqHq6G
	 QgTYFcE3wadhQ==
Date: Fri, 7 Jun 2024 11:27:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Khalil, Amiri" <amiri.khalil@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] perf stat: Fix the hard-coded metrics calculation on
 the hybrid
Message-ID: <ZmNQ_rxnz-lAKKPp@google.com>
References: <20240606180316.4122904-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606180316.4122904-1-kan.liang@linux.intel.com>

On Thu, Jun 06, 2024 at 11:03:16AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The hard-coded metrics is wrongly calculated on the hybrid machine.
> 
> $ perf stat -e cycles,instructions -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         18,205,487      cpu_atom/cycles/
>          9,733,603      cpu_core/cycles/
>          9,423,111      cpu_atom/instructions/     #  0.52  insn per cycle
>          4,268,965      cpu_core/instructions/     #  0.23  insn per cycle
> 
> The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 = 0.44.
> 
> When finding the metric events, the find_stat() doesn't take the PMU
> type into account. The cpu_atom/cycles/ is wrongly used to calculate
> the IPC of the cpu_core.
> 
> In the hard-coded metrics, the events from a different PMU are only
> SW_CPU_CLOCK and SW_TASK_CLOCK. They both have the stat type,
> STAT_NSECS. Except the SW CLOCK events, check the PMU type as well.
> 
> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> 
> Changes since V1:
> - Don't check the PMU of the SW CLOCK events 
> 
>  tools/perf/util/stat-shadow.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 3466aa952442..6bb975e46de3 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -176,6 +176,13 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
>  		if (type != evsel__stat_type(cur))
>  			continue;
>  
> +		/*
> +		 * Except the SW CLOCK events,
> +		 * ignore if not the PMU we're looking for.
> +		 */
> +		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
> +			continue;
> +
>  		aggr = &cur->stats->aggr[aggr_idx];
>  		if (type == STAT_NSECS)
>  			return aggr->counts.val;
> -- 
> 2.35.1
> 

