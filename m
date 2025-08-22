Return-Path: <stable+bounces-172337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C1B3127A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0E7AC539C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE0272E7F;
	Fri, 22 Aug 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgYcrVfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F4221FCA
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853451; cv=none; b=bxd7oi7IayEZZGBeQZ/i+TQGkT2l4MWSU/KH2m0+rZcznp9g6o9MhHBYPkKPwQjei7YfAYzjYNgYd7lGpeiCtYXMjCfBs+xwV+R21UoJ8hElmb35y8UrG+iFC5itd782bXsirGiTT9Sq3oJMmrH9ncKvDtuWyfBKtbDRwjp4sKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853451; c=relaxed/simple;
	bh=QpXW7bPXW/KgttxYZIBAe/jHuI5P/u5IboOeIHqiCQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecUaNfZEmpZWtBHnQsPGJarTkKaVK3uozlUVVZJchOyaFa6UpnXMdtZ3SKAkXFlctis2vutoWY85KJoACdbr6Zs/XsfO0Rc0uoaG1eHSANwLxEO9dvqNX+HaGKGAGHUbwtIL5/TDYFOPdGX7WM+5HYI0jGZJ03pIiH029Lro7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgYcrVfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078DBC4CEF1;
	Fri, 22 Aug 2025 09:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755853450;
	bh=QpXW7bPXW/KgttxYZIBAe/jHuI5P/u5IboOeIHqiCQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgYcrVfN3iiKrF5YImEbZd+XJoLcIZv/U87kI8zLhBX5hSQSLvSJA5C1QshhSBIjJ
	 nSUfbETWVVmU2C3q62Jv1FEsKyr3+pL9Ho2g+qAUm+9BA7Og00o/VqFlXIRVN9g0T0
	 oIFAQfCyRDro/yPvtx8KWSWt6EdAKUOJQKjXaRSE=
Date: Fri, 22 Aug 2025 11:04:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wyes Karny <wkarny@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 6.6 8/8] sched/fair: Fix frequency selection for
 non-invariant case
Message-ID: <2025082258-starfish-crunching-77ba@gregkh>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
 <20250815181618.3199442-9-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815181618.3199442-9-guanwentao@uniontech.com>

On Sat, Aug 16, 2025 at 02:16:18AM +0800, Wentao Guan wrote:
> From: Vincent Guittot <vincent.guittot@linaro.org>
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
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

You forgot to sign off on this one :(

