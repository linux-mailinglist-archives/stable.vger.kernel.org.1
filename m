Return-Path: <stable+bounces-179342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C7B54A18
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F2D7A6228
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DA2EBB87;
	Fri, 12 Sep 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpQmoETS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47319992C
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673686; cv=none; b=hZBsMJQrHE4qh6VkGZGhKujkI15JfYqU5SvPrOVTe4fPWJi2dUBrQ4h3bgwYXAEcqLvepGrx2FMuF6wrMvt7FuFPzvDdGF/dLvm4rWH02AIuBwIxkO+9/g9urygaTWMrb7ZSdS037fyRBsfYFL3Eu1RTjZVgFJOqT+uh00bTm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673686; c=relaxed/simple;
	bh=m6J7mEhtfDTGpCjwarUqcA6tU1DTF8naID7IQXNMe30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7Qa7UXTeInAiK1e/O+7OQe1BQdDsUWZyK0sgLmvqGk4SgSU9Ls/OTkXkMxNjIdToVfoX7VnydAD7YszN9RXmZ/ulcCA4OMsmI5EuuU7r+QrQ2T9mF8SssnkxESVhM8TK0F4h/oTs2dd047FR7sf7WJ91efxC+oNZdlK4azJaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpQmoETS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F7DC4CEF1
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757673685;
	bh=m6J7mEhtfDTGpCjwarUqcA6tU1DTF8naID7IQXNMe30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LpQmoETS98inPqZi5AqB+OzmN6Ty9u+y/krvwO9yUzyPar1DbcYpzmEKBG3dXpBII
	 ILf+FlbLCDnbqux8TejoOodVrjhtSKeQ4sq5L3+F4Y+8hOpYiasGl7sEVieMqRKiaE
	 b2t275oZCt4vBlgLolqBO+ChlIFpXUWRV8iD9b9E2tvXFPff4lsPuPLYZ4/xY+IEAJ
	 BXoeBbgskmDg++FtknScvqFQ795RRY15rQa4Pu+c9QhUB0YlblrnIuhXZYhiy8zVwz
	 sdYhisCjRHPPs23FQpV4q92S2DmetextUHd2v29Fke6JY8fsEnXrW0VfO6wofmJ9x7
	 k0Bn3igMqX1pg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74572fb94b3so1645379a34.2
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 03:41:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL2vLaKpkKWeCQH2mWWZ2/5bOXj5J2svvMtHE3hHySZ3qZmj+i6bonY9fvhrwFdtOOMy7gOdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZd1X298vLq93fFzZhQ05eSefhwcmRG9vICnhVzJE25qXbKkcm
	wpHoXCy6Fxi7x5OK9k1FF/wPnBXdNITuACvmZhs4Mj0JvsAq57AQWbP0yXXekxZsipQImC0VQYI
	QwCmmrgu+Tq72b4M+vFADus9+i5njfNQ=
X-Google-Smtp-Source: AGHT+IF7Vsvj3OHVHQY95P31PtDdF7eOAdWDxBkVTMeI633/kFE/8IkNdzRob4dhJraZ8L94Uxc/6xzM9z5CAZFrGUg=
X-Received: by 2002:a05:6808:1829:b0:438:3680:d66a with SMTP id
 5614622812f47-43b8da0c463mr1054285b6e.32.1757673685238; Fri, 12 Sep 2025
 03:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910065312.176934-1-shawnguo2@yeah.net>
In-Reply-To: <20250910065312.176934-1-shawnguo2@yeah.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Sep 2025 12:41:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
X-Gm-Features: Ac12FXylO9FnJH84vML_P-k8emVeRvhY6bUpdzdnRuNdH4Ws6rNLuFthHF4Fq4g
Message-ID: <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
To: Shawn Guo <shawnguo2@yeah.net>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Qais Yousef <qyousef@layalina.io>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:53=E2=80=AFAM Shawn Guo <shawnguo2@yeah.net> wrot=
e:
>
> From: Shawn Guo <shawnguo@kernel.org>
>
> A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1)=
,
> due to that platform's DT doesn't provide the optional property
> 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> platforms, because that the 10 ms cap for transition_delay_us was
> accidentally dropped by the commits below.

IIRC, this was not accidental.

Why do you want to address the issue in the cpufreq core instead of
doing that in the cpufreq-dt driver?

CPUFREQ_ETERNAL doesn't appear to be a reasonable default for
cpuinfo.transition_latency.  Maybe just change the default there to 10
ms?

>   commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
>   commit a755d0e2d41b ("cpufreq: Honour transition_latency over transitio=
n_delay_us")
>   commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")
>
> It slows down dbs governor's reacting to CPU loading change
> dramatically.  Also, as transition_delay_us is used by schedutil governor
> as rate_limit_us, it shows a negative impact on device idle power
> consumption, because the device gets slightly less time in the lowest OPP=
.
>
> Fix the regressions by adding the 10 ms cap on transition delay back.
>
> Cc: stable@vger.kernel.org
> Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..36e0c85cb4e0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -551,8 +551,13 @@ unsigned int cpufreq_policy_transition_delay_us(stru=
ct cpufreq_policy *policy)
>
>         latency =3D policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>         if (latency)
> -               /* Give a 50% breathing room between updates */
> -               return latency + (latency >> 1);
> +               /*
> +                * Give a 50% breathing room between updates.
> +                * And cap the transition delay to 10 ms for platforms
> +                * where the latency is too high to be reasonable for
> +                * reevaluating frequency.
> +                */
> +               return min(latency + (latency >> 1), 10 * MSEC_PER_SEC);
>
>         return USEC_PER_MSEC;
>  }
> --
> 2.43.0
>

