Return-Path: <stable+bounces-23514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641408617CC
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 17:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F65A285710
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9382C60;
	Fri, 23 Feb 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUZyt7eo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777184A43
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705526; cv=none; b=EP6YREARtbHeeeCjsyvnubM5ujBzzZ4uEjgv1+dxt/+xmEh3scmp7GqNpsaDrt/gRvV7g9/hQLuQuVfkWC+9cq35xrxhYg8knwdYl9a4dmzq73weKTBp2vbwJkXIXhXFyFLg4yXnPEDT6iqAfuajXxlJobGELG/G7+wipRogPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705526; c=relaxed/simple;
	bh=IyyFF0IS6sJIXTOl70nZ+3oIWRYJNBotTgtD2cQhipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5tHevGgH8QY1lAUxW1zkK4QjA/nDefkgb222g7ZdFMPoevtomV7/UciKSj1KMmrygi/bxyS7CJVFIA+sa/YvcUvUbUtAY4Alq8p+Bq3hpNzrkKCHqPoh7mnvF5eFIi0nslf1PBPFwfFZQnD2ULloYI0grW4zfCT+MO7bi38mFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUZyt7eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B29C433C7;
	Fri, 23 Feb 2024 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708705526;
	bh=IyyFF0IS6sJIXTOl70nZ+3oIWRYJNBotTgtD2cQhipQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUZyt7eoGmOv0//pG/lPfYfAEpdXklB0hV0HLG1zg5AiBfgsQc+L5oPR+Pz5EPziK
	 EvX8C2ZV7HZVuZvmEk11YarCa4R3zUw5GbaUK6vlKeXe7eMTKN0cHxzjtqYzR8DpkV
	 7CFqHdkArqXo9BJ2XVHrSpxyZfyW1hYByW4d2Wno=
Date: Fri, 23 Feb 2024 17:25:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: stable@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>,
	Sasha Levin <sashal@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4.19 v2 1/3] sched/rt: Fix sysctl_sched_rr_timeslice
 intial value
Message-ID: <2024022318-define-geometry-06c9@gregkh>
References: <20240222170540.1375962-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222170540.1375962-1-pvorel@suse.cz>

On Thu, Feb 22, 2024 at 06:05:38PM +0100, Petr Vorel wrote:
> From: Cyril Hrubis <chrubis@suse.cz>
> 
> [ Upstream commit c7fcb99877f9f542c918509b2801065adcaf46fa ]
> 
> There is a 10% rounding error in the intial value of the
> sysctl_sched_rr_timeslice with CONFIG_HZ_300=y.
> 
> This was found with LTP test sched_rr_get_interval01:
> 
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> 
> What this test does is to compare the return value from the
> sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
> fails if they do not match.
> 
> The problem it found is the intial sysctl file value which was computed as:
> 
> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> 
> which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
> introduces 10% rounding error for CONFIG_HZ_300:
> 
> (MSEC_PER_SEC / HZ) * (100 * HZ / 1000)
> 
> (1000 / 300) * (100 * 300 / 1000)
> 
> 3 * 30 = 90
> 
> This can be easily fixed by reversing the order of the multiplication
> and division. After this fix we get:
> 
> (MSEC_PER_SEC * (100 * HZ / 1000)) / HZ
> 
> (1000 * (100 * 300 / 1000)) / 300
> 
> (1000 * 30) / 300 = 100
> 
> Fixes: 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Mel Gorman <mgorman@suse.de>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> Link: https://lore.kernel.org/r/20230802151906.25258-2-chrubis@suse.cz
> [ pvorel: rebased for 4.19 ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 394c66442cff..ce4594215728 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -8,7 +8,7 @@
>  #include "pelt.h"
>  
>  int sched_rr_timeslice = RR_TIMESLICE;
> -int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> +int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
>  
>  static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
>  
> -- 
> 2.35.3
> 
> 

All now queued up, thanks!

greg k-h

