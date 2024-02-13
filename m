Return-Path: <stable+bounces-19767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B98535CB
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0219D1F25366
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FC5F57E;
	Tue, 13 Feb 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="suIEP2Yw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F715D91C
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841067; cv=none; b=r0ykwAR20LYUJt3ZyUkgcCX8BoW0UYxjG+1FnBM2QkcKNZJ6Sep9z4B/B22ewdYcXExce+bny5ygy51DT35bGrb7I22+HmdIBj36vLsRMUEjwsSGn7zQTZNqHF8s/oDUQ7wHwMii3hyjvSM+5oSBlVUYw1MweMfL7sv82nDX2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841067; c=relaxed/simple;
	bh=/YevbOA0JPuaAtfPxeJ1bpHUa+cX9ThV5+AYyflrceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqAY3UlButr5I5uuki9F8UoenXeN/5Sd6BaKEV9iToLy7Ma8BnPLcUX6CxrI95eXFDV7luwOMVaAFxp7KyBb2J7/Krudz0W/fjxnKCQQzY7f3hAPvRvcu9zmUV5ju8NIpnVsbO7G59xKkqmZ3WtoHlNWOINzIj11CvOzLgnENsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=suIEP2Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799E7C433C7;
	Tue, 13 Feb 2024 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707841067;
	bh=/YevbOA0JPuaAtfPxeJ1bpHUa+cX9ThV5+AYyflrceo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suIEP2Yw3yNWCHUzfy4g84Ftx1fg8wt1NNBxRWlJclm8UHU09tvMIThoSCb08EZ4z
	 QZ7p6SOmA9ml05WyWab9ACAdtUso3kydAJiwhPOsDJpNifxmjfuWwGRp+cIEyHUtSr
	 olWXNx6+Lno+qAFx24gTxDspX3BzV8XIvT1G/rvg=
Date: Tue, 13 Feb 2024 17:17:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jwiesner@suse.de, feng.tang@intel.com, paulmck@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1, 5.15, 5.10] clocksource: Skip watchdog check for
 large watchdog intervals
Message-ID: <2024021330-glitch-scraggly-81a6@gregkh>
References: <2024012905-carry-revolt-b8d5@gregkh>
 <87jzn8gzgi.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzn8gzgi.ffs@tglx>

On Tue, Feb 13, 2024 at 04:23:41PM +0100, Thomas Gleixner wrote:
> From: Jiri Wiesner <jwiesner@suse.de>
> 
> commit 644649553508b9bacf0fc7a5bdc4f9e0165576a5 upstream.
> 
> There have been reports of the watchdog marking clocksources unstable on
> machines with 8 NUMA nodes:
> 
>   clocksource: timekeeping watchdog on CPU373:
>   Marking clocksource 'tsc' as unstable because the skew is too large:
>   clocksource:   'hpet' wd_nsec: 14523447520
>   clocksource:   'tsc'  cs_nsec: 14524115132
> 
> The measured clocksource skew - the absolute difference between cs_nsec
> and wd_nsec - was 668 microseconds:
> 
>   cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
> 
> The kernel used 200 microseconds for the uncertainty_margin of both the
> clocksource and watchdog, resulting in a threshold of 400 microseconds (the
> md variable). Both the cs_nsec and the wd_nsec value indicate that the
> readout interval was circa 14.5 seconds.  The observed behaviour is that
> watchdog checks failed for large readout intervals on 8 NUMA node
> machines. This indicates that the size of the skew was directly proportinal
> to the length of the readout interval on those machines. The measured
> clocksource skew, 668 microseconds, was evaluated against a threshold (the
> md variable) that is suited for readout intervals of roughly
> WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5 second.
> 
> The intention of 2e27e793e280 ("clocksource: Reduce clocksource-skew
> threshold") was to tighten the threshold for evaluating skew and set the
> lower bound for the uncertainty_margin of clocksources to twice
> WATCHDOG_MAX_SKEW. Later in c37e85c135ce ("clocksource: Loosen clocksource
> watchdog constraints"), the WATCHDOG_MAX_SKEW constant was increased to
> 125 microseconds to fit the limit of NTP, which is able to use a
> clocksource that suffers from up to 500 microseconds of skew per second.
> Both the TSC and the HPET use default uncertainty_margin. When the
> readout interval gets stretched the default uncertainty_margin is no
> longer a suitable lower bound for evaluating skew - it imposes a limit
> that is far stricter than the skew with which NTP can deal.
> 
> The root causes of the skew being directly proportinal to the length of
> the readout interval are:
> 
>   * the inaccuracy of the shift/mult pairs of clocksources and the watchdog
>   * the conversion to nanoseconds is imprecise for large readout intervals
> 
> Prevent this by skipping the current watchdog check if the readout
> interval exceeds 2 * WATCHDOG_INTERVAL. Considering the maximum readout
> interval of 2 * WATCHDOG_INTERVAL, the current default uncertainty margin
> (of the TSC and HPET) corresponds to a limit on clocksource skew of 250
> ppm (microseconds of skew per second).  To keep the limit imposed by NTP
> (500 microseconds of skew per second) for all possible readout intervals,
> the margins would have to be scaled so that the threshold value is
> proportional to the length of the actual readout interval.
> 
> As for why the readout interval may get stretched: Since the watchdog is
> executed in softirq context the expiration of the watchdog timer can get
> severely delayed on account of a ksoftirqd thread not getting to run in a
> timely manner. Surely, a system with such belated softirq execution is not
> working well and the scheduling issue should be looked into but the
> clocksource watchdog should be able to deal with it accordingly.
> 
> Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> Suggested-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240122172350.GA740@incl
> ---
> 
> Backport to 6.1, 5.15, 5.10 because tglx has too much spare time

Hey, I'll take it, thanks!  Now queued up.

greg k-h

