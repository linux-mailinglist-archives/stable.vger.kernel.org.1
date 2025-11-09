Return-Path: <stable+bounces-192842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C808EC43F41
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 14:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E43AC53C
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80E2F7445;
	Sun,  9 Nov 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgyML849"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767D2D595A
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696388; cv=none; b=Js05ascvnKSnq4p7eIWhhrmzIyjAp7DoEL/qsZzAMiqgLVBmNU07gmWCilfqIrh6CWCvXyCrosMUg8DHDWQJUp6GePOFn9DdiW1EECiTdziiHK2skt7gokIC/r1qTVkkUEeHKm1TYvOjdy+0umFXP/2zqNMQrabPUxsMfEVrSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696388; c=relaxed/simple;
	bh=rMm0qiXXjLedj9z0Uq3OgUq86FOvads5oH2nVGLSmtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARfnuQXvdIYqDIMn/0ZXt2G54z89B+h5r3DieqCzzGNzpZ9v9dl4ZjrXZfOEigwAAySY+OBddsKk2OhHlLeA2KekVmvd9bbGevToIbTwtIX2SLlmLcrpUTnuKm09AUtsLz+IapFWnLKvaYHlEXZFgtSbM++xQHMXA6H3UaV45hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgyML849; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064BC4CEF8;
	Sun,  9 Nov 2025 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762696387;
	bh=rMm0qiXXjLedj9z0Uq3OgUq86FOvads5oH2nVGLSmtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgyML849SrHaM9xKxbmi0UIULKpYD752gtUMNKGnb+T6hFeEzlIP1uKwP6TVuSeRE
	 JklNFDZ6UpiXHoHLkP6x7hlY4pKnhlYQAReuMJOwwswnvB1/p68N6tTvUb+KrzPR+C
	 XX0S2cLQUU5PiDn0XTXAUbC3inI2OLHt9S/uyz9ncH8B5+Mcyq0YGOmt2gIzMZeysx
	 4lYYYA/FZ4z/PdSdRrIroVQs8+tODHPBMyTsf2PjiGpGO6sXprRNcBWFYZqygQDLDS
	 o8f+QPbFsUkq8lyTSLOAnvX13Bjk+KCoTZoQxR/ek2vUuOyRRqZ8egg77TwR4bQptB
	 4rNRJEbGzuB7Q==
Date: Sun, 9 Nov 2025 08:53:05 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: stable@vger.kernel.org, Markus Stockhausen <markus.stockhausen@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "clocksource/drivers/timer-rtl-otto: Work around dying
 timers" has been added to the 6.17-stab
Message-ID: <aRCcwYm9hs6mkbDI@laps>
References: <20251104131736.99355-1-sashalkernel!org>
 <475307d0-75ac-422e-b268-a88b827986f2@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <475307d0-75ac-422e-b268-a88b827986f2@hardfalcon.net>

On Sat, Nov 08, 2025 at 08:32:37PM +0100, Pascal Ernster wrote:
>Hi Sasha,
>
>
>[2025-11-04 14:17] Sasha Levin:
>> This is a note to let you know that I've just added the patch titled
>>
>>     clocksource/drivers/timer-rtl-otto: Work around dying timers
>>
>> to the 6.17-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      clocksource-drivers-timer-rtl-otto-work-around-dying.patch
>> and it can be found in the queue-6.17 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit fbc0494f847969d81c1f087117dca462c816bedb
>> Author: Markus Stockhausen <markus.stockhausen@gmx.de>
>> Date:   Mon Aug 4 04:03:25 2025 -0400
>>
>>     clocksource/drivers/timer-rtl-otto: Work around dying timers
>>
>>     [ Upstream commit e7a25106335041aeca4fdf50a84804c90142c886 ]
>>
>>     The OpenWrt distribution has switched from kernel longterm 6.6 to
>>     6.12. Reports show that devices with the Realtek Otto switch platform
>>     die during operation and are rebooted by the watchdog. Sorting out
>>     other possible reasons the Otto timer is to blame. The platform
>>     currently consists of 4 targets with different hardware revisions.
>>     It is not 100% clear which devices and revisions are affected.
>>
>>     Analysis shows:
>>
>>     A more aggressive sched/deadline handling leads to more timer starts
>>     with small intervals. This increases the bug chances. See
>>     https://marc.info/?l=linux-kernel&m=175276556023276&w=2
>>
>>     Focusing on the real issue a hardware limitation on some devices was
>>     found. There is a minimal chance that a timer ends without firing an
>>     interrupt if it is reprogrammed within the 5us before its expiration
>>     time. Work around this issue by introducing a bounce() function. It
>>     restarts the timer directly before the normal restart functions as
>>     follows:
>>
>>     - Stop timer
>>     - Restart timer with a slow frequency.
>>     - Target time will be >5us
>>     - The subsequent normal restart is outside the critical window
>>
>>     Downstream has already tested and confirmed a patch. See
>>     https://github.com/openwrt/openwrt/pull/19468
>>     https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/57875/3788
>>
>>     Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>>     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>     Tested-by: Stephen Howell <howels@allthatwemight.be>
>>     Tested-by: Bjørn Mork <bjorn@mork.no>
>>     Link: https://lore.kernel.org/r/20250804080328.2609287-2-markus.stockhausen@gmx.de
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer-rtl-otto.c
>> index 8a3068b36e752..8be45a11fb8b6 100644
>> --- a/drivers/clocksource/timer-rtl-otto.c
>> +++ b/drivers/clocksource/timer-rtl-otto.c
>> @@ -38,6 +38,7 @@
>>  #define RTTM_BIT_COUNT		28
>>  #define RTTM_MIN_DELTA		8
>>  #define RTTM_MAX_DELTA		CLOCKSOURCE_MASK(28)
>> +#define RTTM_MAX_DIVISOR	GENMASK(15, 0)
>>
>>  /*
>>   * Timers are derived from the LXB clock frequency. Usually this is a fixed
>> @@ -112,6 +113,22 @@ static irqreturn_t rttm_timer_interrupt(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>
>> +static void rttm_bounce_timer(void __iomem *base, u32 mode)
>> +{
>> +	/*
>> +	 * When a running timer has less than ~5us left, a stop/start sequence
>> +	 * might fail. While the details are unknown the most evident effect is
>> +	 * that the subsequent interrupt will not be fired.
>> +	 *
>> +	 * As a workaround issue an intermediate restart with a very slow
>> +	 * frequency of ~3kHz keeping the target counter (>=8). So the follow
>> +	 * up restart will always be issued outside the critical window.
>> +	 */
>> +
>> +	rttm_disable_timer(base);
>> +	rttm_enable_timer(base, mode, RTTM_MAX_DIVISOR);
>> +}
>> +
>>  static void rttm_stop_timer(void __iomem *base)
>>  {
>>  	rttm_disable_timer(base);
>> @@ -129,6 +146,7 @@ static int rttm_next_event(unsigned long delta, struct clock_event_device *clkev
>>  	struct timer_of *to = to_timer_of(clkevt);
>>
>>  	RTTM_DEBUG(to->of_base.base);
>> +	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
>>  	rttm_stop_timer(to->of_base.base);
>>  	rttm_set_period(to->of_base.base, delta);
>>  	rttm_start_timer(to, RTTM_CTRL_COUNTER);
>> @@ -141,6 +159,7 @@ static int rttm_state_oneshot(struct clock_event_device *clkevt)
>>  	struct timer_of *to = to_timer_of(clkevt);
>>
>>  	RTTM_DEBUG(to->of_base.base);
>> +	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
>>  	rttm_stop_timer(to->of_base.base);
>>  	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
>>  	rttm_start_timer(to, RTTM_CTRL_COUNTER);
>> @@ -153,6 +172,7 @@ static int rttm_state_periodic(struct clock_event_device *clkevt)
>>  	struct timer_of *to = to_timer_of(clkevt);
>>
>>  	RTTM_DEBUG(to->of_base.base);
>> +	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_TIMER);
>>  	rttm_stop_timer(to->of_base.base);
>>  	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
>>  	rttm_start_timer(to, RTTM_CTRL_TIMER);
>
>
>this patch is part of a series of 4 patches, but it seems you have only cherry-picked patches 1 and 3 from that series, although all 4 were merged into Linus' tree:
>
>https://lore.kernel.org/all/20250804080328.2609287-1-markus.stockhausen@gmx.de/
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/clocksource/timer-rtl-otto.c?h=v6.18-rc4
>
>
>I could only find the "linux-stable-commits" mails for queue-6.17, but you selected the same 2 patches for queue-6.12 as well. Is that selection of only 2 of the 4 patches intentional?

Do we actually need the other two patches? They don't look like fixes.

-- 
Thanks,
Sasha

