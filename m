Return-Path: <stable+bounces-119853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493BA48549
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 17:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BB2189671C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5E1B0421;
	Thu, 27 Feb 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rezkK4U7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800051ADFE4
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673967; cv=none; b=lF5GZ+YAWCbdM5pOyW/kI6KCW84Gs/KLtikhtDu8Y8NX4w5EMYRAbfKGNf3pT89qZaN4llBoe8YUJ8G5Wnp1ekfT7FMsUF/HUER/UbwtRB52y0lkr7zu09yxGbuT4+wy/5YVrWKF6D5j4lFOAOCDix4XQs47F9WenwlN2tBRNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673967; c=relaxed/simple;
	bh=wuQ99hXtmb6GTwGl7mePLWn1OF/2FQnmOhHQ/Yjazmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUKtNJEPwUeoLkJXfmjJ1n1HoLKh4JjtMwy/K9sN0zdnUDZ6WBf0aBnGHQ2BKcVzobd0TnFP13IWsEGcFPRFjl4mT2yraYghAk3LqeFApvNrYCP8mdsryIHwHCVB8ySeQCuQkMlqDgjX+GcZ8oynAulzrlUzPSNGo50id4ezCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rezkK4U7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abee50621ecso160891066b.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740673964; x=1741278764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uxBzUeb6aEpw2RFXXNhIl9qOIlWZxMjJ6EPTTtqpNP4=;
        b=rezkK4U7Tw3qR+vcpgzgc1rho+4OVxDcQVa1Q1NmO7qMF2eF3p14dqh0aLxVUhJfTV
         aOl70Xt1MCDzYD9wG0+f1WlfOB/I9BxErRdebcbbHWZz+qU4tM1kBkn+/qdZ6hpehNOf
         ZpVDyiqB7ncPjWGps2+2cwE7e6ROVVlZVcJlJrUQE268r2wVdY5HrnXUBCKAN+LxqHq0
         z2TWVt3rm/Q5jFR1LyInTjgNNLYwF88+gbTFIdivYt1S3yQ8cG8dxKLZQQ5nZcDW+RfS
         wH+HsqOY+zWDCCONM5WYQqCZygIDas/uDSg1CNLlUHd8lTYI3L/fNLxmbPEhCQZW/TZk
         H21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673964; x=1741278764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxBzUeb6aEpw2RFXXNhIl9qOIlWZxMjJ6EPTTtqpNP4=;
        b=tiu6mIeFywUmpc6uDABNjrwc88jqGvGHVl/5jWp2XiUyL9qUjK5FqAdgV9KrDWvTEy
         qWFuB+XifkrQnyAdpJhR1L5NG9V3vqVH7DCj1L8dJKwnrV07AzlYdLgs4RcHUIUsU/iD
         22G3BsZSPt9SCS/2cMLLPAvlXZ+ynx8JeluBmZqy0K7VWKSpGOfj1qkJuJqpQPOe4JkO
         OI1bBvGove8Uvl+5gO23UgwhlPOe+6I/WyM43UqQAfBItnWjyXPetzs44RL2qOXyURfW
         IOik00a4o3/VUNP23irELeYjMc44ZEghf7kSn3Y9i/dWOzhQEWz4KecJgx29mU61DutG
         jKFg==
X-Forwarded-Encrypted: i=1; AJvYcCUrGk0/U0qkWuKG1TUAIyEmGaWu63FpqK95QzAw/pm/kAe3+FTvsO/IDfitWg+oIqTr5/8yd20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9p1JugueTMSImofVtYFxJnfF5tVj7cqXWpe/i5ug1inxLs9s
	C99OjC+cuvkm4WWKeowTUMpkMjvnB/QgXrZnLqLE0BxsXL8pAosjOvhb83ZzPQ4=
X-Gm-Gg: ASbGnctJeR6iz8KWL2ZivOyHWF74/SHPttdZtUTbadJs56BIhddE+TXr9U7vwwCLfmD
	68JR388qUQiY/eS8p9Au3ViwLr+WFB9/5jjybknNk7hObMsQT5MxLS42ZuWliZsS96PLwUwpIVk
	LgVYlHGXSzbs5h+8+DBTp9w9LtXyJ2PyyI1Nrxicw5CWFX7L0CFs/aVuCMKi5Uq31HoFwWfn2Yv
	wovTpd+Rguu/bZgGFsglJy8rLUujKIE5kxeYD+1ZizeT63JRYVny665ogHtWdIWs1jS8apeNTwS
	hjF0vIiYr8XvgpT0kN6lsag=
X-Google-Smtp-Source: AGHT+IENWfYyNPrvqdJkkInr0wph6rUkn8UzeZpWdw7KVY+SQfhvXNCVt/aAXye31RRnjNVIrHnJ5w==
X-Received: by 2002:a17:906:d542:b0:ab7:e3cb:ca81 with SMTP id a640c23a62f3a-abf2657c56dmr9884666b.30.1740673963757;
        Thu, 27 Feb 2025 08:32:43 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1f1d5b4csm56471066b.85.2025.02.27.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:32:43 -0800 (PST)
Date: Thu, 27 Feb 2025 18:32:41 +0200
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
Message-ID: <Z8CTqdFafLY17C25@linaro.org>
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
 <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>
 <Z7zVgeM+7P7SLWIu@linaro.org>
 <vc7irlp7nuy5yvkxwb5m7wy7j7jzgpg73zmajbmq2zjcd67pd2@cz2dcracta6w>
 <Z7161SzdxhLITsW3@linaro.org>
 <5euqboshlfwweie7tlaffajzg3siiy6bm3j4evr572ko54gtbv@7lan3vizskt3>
 <Z8B2Bl/9uD3jPvQi@linaro.org>
 <j55de6bbipoavqx25w2s6qr7n6fv6w7bj3lrgyag4dlvvddbqv@shn22aqcqeci>
 <Z8CIY2OJUMqIOHGU@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8CIY2OJUMqIOHGU@linaro.org>

On 25-02-27 17:44:35, Abel Vesa wrote:
> On 25-02-27 16:25:06, Uwe Kleine-König wrote:
> > Hello Abel,
> > 
> > On Thu, Feb 27, 2025 at 04:26:14PM +0200, Abel Vesa wrote:
> > > On 25-02-27 10:58:47, Uwe Kleine-König wrote:
> > > > Can you please enable CONFIG_PWM_DEBUG, enable pwm tracing (
> > > > 
> > > > 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> > > > 
> > > > ) then reproduce the problem and provide the output of
> > > > 
> > > > 	cat /sys/kernel/debug/tracing/trace
> > > > 
> > > > .
> > > 
> > > $ cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 13/13   #P:12
> > > #
> > > #                                _-----=> irqs-off/BH-disabled
> > > #                               / _----=> need-resched
> > > #                              | / _---=> hardirq/softirq
> > > #                              || / _--=> preempt-depth
> > > #                              ||| / _-=> migrate-disable
> > > #                              |||| /     delay
> > > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > #              | |         |   |||||     |         |
> > >         modprobe-203     [000] .....     0.938668: pwm_get: pwmchip0.0: period=1066407 duty_cycle=533334 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938775: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938821: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938936: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938982: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939274: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=921458 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939320: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939434: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939480: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=5000000 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079585: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079698: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079750: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > > $
> > > 
> > > > 
> > > > I didn't take a deeper dive in this driver combination, but here is a
> > > > description about what *should* happen:
> > > > 
> > > > You're talking about period in MHz, the PWM abstraction uses
> > > > nanoseconds. So your summary translated to the PWM wording is (to the
> > > > best of my understanding):
> > > > 
> > > >   1. PWM backlight driver requests PWM with .period = 200 ns and
> > > >      .duty_cycle = 200 ns.
> > > > 
> > > >   2. leds-qcom-lpg cannot pick 200 ns exactly and then chooses .period =
> > > >      1000000000 / 4.26666 MHz = 234.375 ns
> > > >      
> > > >   3. leds-qcom-lpg then determines setting for requested .duty_cycle
> > > >      based on .period = 200 ns which then ends up with something bogus.
> > 
> > The trace looks better than what I expected. 2. is fine here because it
> > seems when Sebastian wrote "driver requests PWM with 5 MHz period" that
> > meant period = 5000000 ns. That was then rounded down to 4266537 ns. And
> > the request for period = 5000000 ns + duty_cycle = 5000000 ns was
> > serviced by configuring period = 4266537 ns + duty_cycle = 4266537 ns.
> > So that's a 100 % relative duty configuration as intended.
> > 
> > So just from the traces I don't spot a problem. Do these logs not match
> > what actually happens on the signal?
> 
> What I do not get is why do we expect 2 pwm_get() and 2 pwm_apply()
> calls each time ?

OK, so the second pwm_apply() is due to CONFIG_PWM_DEBUG.

But still, the first pwm_apply() requests duty cycle of 5MHz:

systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=5000000 polarity=0 enabled=1 err=0

So since the period is 4.26MHz, due to the knobs selected by the
provider, this duty cycle will result in a PWM value that is above the
selected resolution, as I already mentioned.

> 
> Need to dig a bit further.
> 
> But meanwhile, if the first pwm_apply() call goes all the way to the
> provider, then the duty cycle value, when translated to the actual PWM
> value that gets written to reg, will overflow. So this is what is wrong.
> And this is what actually happens.
> 
> > 
> > Best regards
> > Uwe
> 
> 
> 

