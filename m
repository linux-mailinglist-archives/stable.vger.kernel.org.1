Return-Path: <stable+bounces-119846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC0A4811C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 15:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D107D7A687C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769522FF44;
	Thu, 27 Feb 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjaWN3nN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3122FACE
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666380; cv=none; b=FZe3BGY1pyRfO+cfzVkxipXIpg2qrxC1zf7vvilQo2EpKMYsucJMpyfvXa2XzvhTils4K/c//BVv6ycYj7ef/hX+Kpzyi4aqAk2gxNt68YCl5ytkdH5KCa+8yQHFACoYrYrV4/i9pEnPy2Il4fRdN4RyDOvguuGSds+plfLxzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666380; c=relaxed/simple;
	bh=vNASoWN4bLXkRimV+HPXtdcacrBTx6VB1OuhbBdPWVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nze/5lgNVDbP7IqUwtypNUO7Z0UEJofjpk/Jog3kUwqdxKPOo19GmDdxjGpdE0QDup76S8SVVLQ+M9RdGU2ykHZG/ToZ6kuGUSBUkQTwSyfHx2qSOcdRl9anLB/e8L/EFbFyq2Gj6Fp4gWOIqq8fbBrOJBHcb4Fj0LVvyn/ARkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LjaWN3nN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf06950db5so144958766b.1
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740666376; x=1741271176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6k0dzLt8wTithUz8xgT6rJeUcNWe78clQV/pCJMqU0g=;
        b=LjaWN3nNdLyHhQnDPc1RqFnkqos402r3umtidAK/0ww0dDy7jIQJfzIFTdobriUS86
         zSKTcIAEGjiuWviOg84Lm5bCJtjgv3FOAazt7EIlGXj8UOFAGSfVhjsm0/e0iEDHfOn3
         fEzBnqzkn5PMG9L3Y4U4M/NKwK5bS/BcY51TlyisXkEwjFi1JZua06FckIG0OFDMcRCK
         DMuD1gtTrdNMeqR6qZjvEvyzXn0wUymlsChl0B0/+LISC/ppuEVAa57u9+FCQzpvDqbo
         Qb3muE6TFGV12NxWPe4qqPQBgCyFVrlPqo9uebKQUkA3wFza7IBvhqN1jkrGHgeogvcs
         VXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666376; x=1741271176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6k0dzLt8wTithUz8xgT6rJeUcNWe78clQV/pCJMqU0g=;
        b=qY7ADCiG2h9l7r2OcxJ/Vj7Hjkitb+t9v1doZs1lGqVc7WSuRWQnlHrfxezZ3gGG8I
         ueeX8OcTTzi0XOfsVhwxSD0HGWg+oYcooqLie2HRqPyX3v8BWzJ7hOoGurPAGne4qcvJ
         iyZ+frIe0mIYNRBnMWadZRjRIllioSZrLAlCl/jJEzkNPEc96cQ+Vl8dBsJjwTxuPwDY
         J5PV6p1+65wNEAbhDY4FOEawfWUy+PxwCCD0ukA9bQ1XmwmmJ+VLBPpZaqD6y2tJdXL1
         RV+iVG3yC8fZ5RBha0nexVcotKn7SkRUw5z0qz35KVDg/qO6Jz1WSIJAniwjlbt4KNEC
         +dWg==
X-Forwarded-Encrypted: i=1; AJvYcCWRdIQwTL92EssT3qSnHjVN77soYU+ulioI/l/SvHOsDn4OOBs5DRWphaNqgkt0iHV85fP0uFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrY8HzAmizibg7cJ77r4T1lDfaAeg2ixUUd6SauZmMt86+BBgS
	MRVN6Ox6lI1wSiB2sxjhpTWn4EQgzj03YTuJ0skiMcLbz0/Qi8dQRVprMxDQ+dKKJgxmVZl72jH
	6
X-Gm-Gg: ASbGncvEt98A0c/ZoW53PmJRyt3p24/gQVo3pvgu7U9bnD7IJB+4URAZwyHVJY/27QF
	U9L+UjdzSRM00OwkGW1Tc+LYHt47/EWuUQBBEuZudTGfZcIZZ0xQsDWarrnGDh6oCPgShzw61Z3
	8uJ+iuQWqXUPGFd8dGO9mB4qXZPuHFdYpRFyiUAaRC59p90bVlUhyW8mhM1Q/srTN9tVHw15Jk0
	v63Rpx/u1Ei9zaW3F+yqjf/uzAESgb8X9E0fmtOl2OJOsPaXhfMn4VqyUPZ5nCFU/r+HS7p+aQe
	K7B82de2rolnzNyCtLH5pAQ=
X-Google-Smtp-Source: AGHT+IFY8g17YE8yWo3qq9wpjlIeW2NB44AYZq4zWQm8vlXxbhYi8ED78332w7Z5H66WCxQgHaCySw==
X-Received: by 2002:a17:907:724f:b0:ab7:bf87:d9de with SMTP id a640c23a62f3a-abc0de146b4mr2739502966b.37.1740666376508;
        Thu, 27 Feb 2025 06:26:16 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee486sm131152666b.90.2025.02.27.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:26:16 -0800 (PST)
Date: Thu, 27 Feb 2025 16:26:14 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Kamal Wadhwa <quic_kamalw@quicinc.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
Message-ID: <Z8B2Bl/9uD3jPvQi@linaro.org>
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
 <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>
 <Z7zVgeM+7P7SLWIu@linaro.org>
 <vc7irlp7nuy5yvkxwb5m7wy7j7jzgpg73zmajbmq2zjcd67pd2@cz2dcracta6w>
 <Z7161SzdxhLITsW3@linaro.org>
 <5euqboshlfwweie7tlaffajzg3siiy6bm3j4evr572ko54gtbv@7lan3vizskt3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5euqboshlfwweie7tlaffajzg3siiy6bm3j4evr572ko54gtbv@7lan3vizskt3>

On 25-02-27 10:58:47, Uwe Kleine-König wrote:
> Hello,
> 
> I was dragged into the discussion by the patch that Abel Vesa created in
> reply to this mail, i.e.
> https://lore.kernel.org/linux-pwm/20250226-pwm-bl-read-back-period-from-hw-v1-1-ccd1df656b23@linaro.org/
> 
> On Tue, Feb 25, 2025 at 10:09:57AM +0200, Abel Vesa wrote:
> > On 25-02-25 01:09:00, Sebastian Reichel wrote:
> > > On Mon, Feb 24, 2025 at 10:24:33PM +0200, Abel Vesa wrote:
> > > > On 25-02-21 00:35:08, Sebastian Reichel wrote:
> > > > > On Thu, Feb 20, 2025 at 12:31:00PM +0200, Abel Vesa wrote:
> > > > > > Currently, for the high resolution PWMs, the resolution, clock,
> > > > > > pre-divider and exponent are being selected based on period. Basically,
> > > > > > the implementation loops over each one of these and tries to find the
> > > > > > closest (higher) period based on the following formula:
> > > > > > 
> > > > > >                           period * refclk
> > > > > > prediv_exp = log2 -------------------------------------
> > > > > >                     NSEC_PER_SEC * pre_div * resolution
> > > > > > 
> > > > > > Since the resolution is power of 2, the actual period resulting is
> > > > > > usually higher than what the resolution allows. That's why the duty
> > > > > > cycle requested needs to be capped to the maximum value allowed by the
> > > > > > resolution (known as PWM size).
> > > > > > 
> > > > > > Here is an example of how this can happen:
> > > > > > 
> > > > > > For a requested period of 5000000, the best clock is 19.2MHz, the best
> > > > > > prediv is 5, the best exponent is 6 and the best resolution is 256.
> > > > > > 
> > > > > > Then, the pwm value is determined based on requested period and duty
> > > > > > cycle, best prediv, best exponent and best clock, using the following
> > > > > > formula:
> > > > > > 
> > > > > >                             duty * refclk
> > > > > > pwm_value = ----------------------------------------------
> > > > > >                 NSEC_PER_SEC * prediv * (1 << prediv_exp)
> > > > > > 
> > > > > > So in this specific scenario:
> > > > > > 
> > > > > > (5000000 * 19200000) / (1000000000 * 5 * (1 << 64)) = 300
> > > > > > 
> > > > > > With a resolution of 8 bits, this pwm value obviously goes over.
> > > > > > 
> > > > > > Therefore, the max pwm value allowed needs to be 255.
> > > > > > 
> > > > > > If not, the PMIC internal logic will only value that is under the set PWM
> > > > > > size, resulting in a wrapped around PWM value.
> > > > > > 
> > > > > > This has been observed on Lenovo Thinkpad T14s Gen6 (LCD panel version)
> > > > > > which uses one of the PMK8550 to control the LCD backlight.
> > > > > > 
> > > > > > Fix the value of the PWM by capping to a max based on the chosen
> > > > > > resolution (PWM size).
> > > > > > 
> > > > > > Cc: stable@vger.kernel.org    # 6.4
> > > > > > Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> > > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > > ---
> > > > > > Note: This fix is blocking backlight support on Lenovo Thinkpad T14s
> > > > > > Gen6 (LCD version), for which I have patches ready to send once this
> > > > > > patch is agreed on (review) and merged.
> > > > > > ---
> > > > > 
> > > > > Do you know if the pwm duty cycle to pwm value calculation is
> > > > > correct otherwise?
> > > > 
> > > > Sorry for the late reply.
> > > 
> > > No worries, I understand this takes time.
> > > 
> > > > Here is my understanding of the calculation of the pwm value currently
> > > > implemented.
> > > > 
> > > > First, find the best pre_div, refclk, resolution and prediv_exp by looping
> > > > through all refclk, resolution and prediv possible values, for the
> > > > following formula:
> > > > 
> > > >                          period * refclk
> > > > prediv_exp = log2 -------------------------------------
> > > >                     NSEC_PER_SEC * pre_div * (1 << resolution)
> > > > 
> > > > 
> > > > So in DT we set the period to 50000000. For this, as I mentioned in the
> > > > commit message the best refclk is 19.2MHz, the best prediv is 5, the best
> > > > exponent is 6 and the best resolution is 255.
> > > > 
> > > > So if you use these to compute the period following this formula:
> > > > 
> > > > 
> > > >                 NSEC_PER_SEC * prediv * (1 << resolution)
> > > > best_period = -------------------------------------------
> > > >                              refclk
> > > > 
> > > > So in our case:
> > > > 
> > > > (1000000000 * 5 * (1 << 8) * (1 << 6)) / 19200000 = 4266666.6666...
> > > > 
> > > > So here is where the things go wrong. Bjorn helped me figure this out today
> > > > (off-list). Basically, the pwm framework will allow values up to 5000000,
> > > > as specified in the DT, but for then pwm value will go over 255
> > > > when computing the actual pwm value by the following formula:
> > > > 
> > > >                             duty * refclk
> > > > pwm_value = ----------------------------------------------
> > > >                 NSEC_PER_SEC * prediv * (1 << prediv_exp)
> > > > 
> > > > 
> > > > So here is how the value 300 is reached (I messed up this next formula in
> > > > the commit message):
> > > > 
> > > > (5000000 * 19200000) / (1000000000 * 5 * (1 << 8)) = 300
> > > > 
> > > > But if we were to use the best_period determined:
> > > > 
> > > > (4266666 * 19200000) / (1000000000 * 5 * (1 << 8)) = 255
> > > > 
> > > > So I guess the process of determining the best parameters is correct.
> > > > What I think is missing is we need to divide the requested period (5000000)
> > > > to the resolution (255) and make sure the duty cycle is a multiple of the
> > > > result.
> > > 
> > > Let me try to summarize that:
> > > 
> > > 1. PWM backlight driver requests PWM with 5 MHz period
> > > 2. leds-qcom-lpg uses 4.2666 MHz period instead due to HW limits
> > > 3. PWM backlight driver is unaware and requests a duty cycle
> > >    expecting the period to be 5 MHz, so the duty cycle can
> > >    exceed 100%
> 
> Can you please enable CONFIG_PWM_DEBUG, enable pwm tracing (
> 
> 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> 
> ) then reproduce the problem and provide the output of
> 
> 	cat /sys/kernel/debug/tracing/trace
> 
> .

$ cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 13/13   #P:12
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
        modprobe-203     [000] .....     0.938668: pwm_get: pwmchip0.0: period=1066407 duty_cycle=533334 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.938775: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=0 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.938821: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.938936: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.938982: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.939274: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=921458 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.939320: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.939434: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
        modprobe-203     [000] .....     0.939480: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
 systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=5000000 polarity=0 enabled=1 err=0
 systemd-backlig-724     [006] .....     9.079585: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
 systemd-backlig-724     [006] .....     9.079698: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
 systemd-backlig-724     [006] .....     9.079750: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
$

> 
> I didn't take a deeper dive in this driver combination, but here is a
> description about what *should* happen:
> 
> You're talking about period in MHz, the PWM abstraction uses
> nanoseconds. So your summary translated to the PWM wording is (to the
> best of my understanding):
> 
>   1. PWM backlight driver requests PWM with .period = 200 ns and
>      .duty_cycle = 200 ns.
> 
>   2. leds-qcom-lpg cannot pick 200 ns exactly and then chooses .period =
>      1000000000 / 4.26666 MHz = 234.375 ns
>      
>   3. leds-qcom-lpg then determines setting for requested .duty_cycle
>      based on .period = 200 ns which then ends up with something bogus.
> 
> Right?
> 
> There is a problem in 2. already: The PWM hardware driver is supposed to
> pick the highest period (in ns) not bigger than the requested value. So
> it must not pick 234.375 ns. (Enabling CONFIG_PWM_DEBUG on that is
> supposed to wail about that.) It should instead pick (say) 187 ns. In
> the next step the hw driver should pick the highest duty_cycle (again in
> ns) not exceeding the requested value (and physics). That will be (I
> guess) also 187 ns in the constructed example. So you should get your
> requested 100 % relative duty cycle at least.
> 
> So the problem about now knowing the resulting PWM waveform is somewhat
> real. I think if leds-qcom-lpg behaved as expected from a PWM driver, it
> would be a tad better than your report suggests. I might miss something
> though.
> 
> Best regards
> Uwe



