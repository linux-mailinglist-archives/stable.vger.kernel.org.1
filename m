Return-Path: <stable+bounces-169787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289FB284CF
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF20AC6135
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC822F9C32;
	Fri, 15 Aug 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAA0VfWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C92F9C24
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278168; cv=none; b=ru+UC1SVq/LT+dVL72VJCJM1/2nMfRgyq3uYfMba5CQh1vKTA1Vqc5njEG4iCQ0Bnlxz80ujV34hW+SsD8CORJGXrMxKsdMkWOdpEjB/bESq1gTpUnWqEC1gdUak2yBrSxfAQCyOF2lCwi3Sc6TTL31RH938O9H8WxV6YByUmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278168; c=relaxed/simple;
	bh=stDA3/Ml1btuAa8vYK/yVVVr/nLkfldaTV2hr8BIxg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efrWQDTMCpxz/xZuLWp0DxifRyU/9RRLChMV+Ur95IaVgzFAzdpz6L4JPW2nHWDCX6JtkOGaTks7fubHLPzcjWTk4fm2PEr3WhK4JT1Baema0XSpeUbC3U2uDZNkFN9SzkZ1L+JLye1f4radbuwj7aOZxAlgh4VD9TsDWLBCNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAA0VfWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CF9C4CEEB;
	Fri, 15 Aug 2025 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755278168;
	bh=stDA3/Ml1btuAa8vYK/yVVVr/nLkfldaTV2hr8BIxg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAA0VfWDz+Tn4rqtOLQUTKE/0F1K9nKcAlhMi+H8mB82/g8/xIrY8J3Q7R4U59Fin
	 3+g3B1PF2/hvfIL7n0o8oWhf3bY849u09sMbqNJOxUQUIhmBerjFHQWJZOobA3UUmz
	 K4EKQRAvJ9WVCiLm2rFFaCUPMBmlj5b+BT3Od0Rw=
Date: Fri, 15 Aug 2025 19:15:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6] sched/fair: Fix frequency selection for
 non-invariant case
Message-ID: <2025081531-spectacle-cubicle-8a01@gregkh>
References: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>
 <2025081504-overplay-unaired-854e@gregkh>
 <tencent_7A3AC9F50BB7F1803289E2C9@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7A3AC9F50BB7F1803289E2C9@qq.com>

On Sat, Aug 16, 2025 at 01:01:44AM +0800, Wentao Guan wrote:
> From ddd3f1ed6e88d88502d2b42e159ac976b4194b78 Mon Sep 17 00:00:00 2001
> From: Vincent Guittot <vincent.guittot@linaro.org>
> Date: Sun, 14 Jan 2024 19:36:00 +0100
> Subject: [PATCH] sched/fair: Fix frequency selection for non-invariant case
> 
> Linus reported a ~50% performance regression on single-threaded
> workloads on his AMD Ryzen system, and bisected it to:
> 
>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> 
> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> is supposed to return the current frequency and the performance margin
> applied by map_util_perf(), enabling the utilization to go above the
> maximum compute capacity and to select a higher frequency than the current one.
> 
> After the changes in 9c0b4bb7f630, the performance margin was applied
> earlier in the path to take into account utilization clampings and
> we couldn't get a utilization higher than the maximum compute capacity,
> and the CPU remained 'stuck' at lower frequencies.
> 
> To fix this, we must use a frequency above the current frequency to
> get a chance to select a higher OPP when the current one becomes fully used.
> Apply the same margin and return a frequency 25% higher than the current
> one in order to switch to the next OPP before we fully use the CPU
> at the current one.
> 
> [ mingo: Clarified the changelog. ]
> 
> Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Wyes Karny <wkarny@gmail.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Wyes Karny <wkarny@gmail.com>
> Link: https://lore.kernel.org/r/20240114183600.135316-1-vincent.guittot@linaro.org
> (cherry picked from commit e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27)
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> I tested the patch two days ago, and the upstream commit can be directly apply.
> ---
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index cfe7c625d2ad6..819ec1ccc08cf 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -156,7 +156,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
>  	if (arch_scale_freq_invariant())
>  		return policy->cpuinfo.max_freq;
>  
> -	return policy->cur;
> +	/*
> +	 * Apply a 25% margin so that we select a higher frequency than
> +	 * the current one before the CPU is fully busy:
> +	 */
> +	return policy->cur + (policy->cur >> 2);
>  }
>  
>  /**

Does not apply against the latest 6.6.y kernel release :(

thanks,

greg k-h

