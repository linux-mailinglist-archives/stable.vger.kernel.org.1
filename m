Return-Path: <stable+bounces-144812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5EAABBE45
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F8F17CF2A
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ABA278E63;
	Mon, 19 May 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cv7y9k4F"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657F2777E4
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659022; cv=none; b=VJ0hFMfXshuFFos1VlXNoYqBEBrYkBlnSTOvgRWf1our9RHyJoIr6d2UwgEnS7QnGkqEaf7BnDzForUz1/346YRonHa2yElcCbFFT4w3ZwJsQV45gpqAp++U8rszuAgzs8cxx3AiVa9HqoY59fdCrQDS22M1YsCgkNKMT0gbK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659022; c=relaxed/simple;
	bh=QmE21RMOPD+vBYqDMh8BaNMIgCWhOsjsbr6wb7VOWD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmgMSn+AWSd0TtzTpx61JokFpzTuiRLHLDc91A//fPO4aPh+HeHZZcfo97GJeqvWB4A4J9Y33Uj2POZ5Zu0pQ9guLosJ/mO2PPHOvjHlkpzeOuBktuKoTC9LEN/SYMTSkMIqpDQB7GEFBEg2p6SBLrehC5mSO0fWpbwn8lfKneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cv7y9k4F; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-328114b262aso25596751fa.3
        for <stable@vger.kernel.org>; Mon, 19 May 2025 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1747659018; x=1748263818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmE21RMOPD+vBYqDMh8BaNMIgCWhOsjsbr6wb7VOWD0=;
        b=cv7y9k4FehwcRiFTC51AKZIJQzFcCmdgQB8zc2WOU7AnJ2ZKeLGA56ohf4zHodC43C
         eA3ARGBG1v3205QJEzLbOgQHxy+UrS5kpQU/ogTAy9XfQ2ae5kH/bM/QRWjvkXcwD9sN
         1sG9u6OqUeLtZeLIC+HvFybRxdj+DLQlPtBC/X0YfqnUV4pvP8QuFBgP7uhivRJS67nk
         2Pr81/qOpKABZdRNszGaSRmmblnt90Ay0YqnXHgrCqxhm5E2XK5u4RHKuyYQpM59T0++
         qxvpuingnHPaW1N7tXRX4RpXrQLmj7LmktxGv1Ult+qIAuyLg849SF3dn6R1a2e+Eaa3
         4Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747659018; x=1748263818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmE21RMOPD+vBYqDMh8BaNMIgCWhOsjsbr6wb7VOWD0=;
        b=YFe9vPSfCaW9wd6gfySY42sRdjBAh/Zf96C3rPUItS9pu1bHhQdMTSgSGgrnP6zHgf
         YjyclTGKjs7NXGFNpd58WHpT5q8ye1MNnbybjEnWlmIxNTvek9neRFbPQ6+5cl8lndXb
         Nb/Gem9sej85S1dBABWWxt6AW9F0FUxLummbXlwJRxl0AdppEhcGuoQ0LobvEIIx+Kpx
         POVwvGJynNRfg+YRcvvj7RxLKDBDNJ+vvx9d6id+IIq6/i97xZyghGvGAZarKBDk6eSq
         z+JSPJnWJwiCs7wg2HAwPTG4wG5xoEXX3NxRScFAfgPXkzceBExQuheSPOIhyGAvEvYe
         ajmg==
X-Forwarded-Encrypted: i=1; AJvYcCXTc8Q/Wx3wFmkkR8fKMwbbjhgkunz/0OrPstN2CLGyWP7rckVs2KjB6sK1q/Sy6+bNmsb53MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn32adZ+aV4R3at+hs04/ZU3tgb/t4DcWfhOQz96TmkPzdfg2W
	r1lDJeZUhWyYxxrc47m3qLM6+d/BOR1TAOyKrXUpJGxBPt9AtS9yGXntAzgJZkbnyDh+Qrndiw3
	vxaYMVKcbcG/apfabPnQy9MafA1YUzNPA+uWm1YoBnQ==
X-Gm-Gg: ASbGnctFh6JjIs56LsMw1rSN9OnMVw1gt+YSkF6vtYxUKsad1lWOrADpJghf8ytY5QY
	3a7Y5TRgEHInvB2tiWTKRKLzu07/HK5E7upln8JSSvNfjpKEywAbFKPbtcQ+XRR/0lgYWiIaB+a
	6AoAx7jVwmRXPb0jE/T/nyfurz7XSrF8TnVAirAJ4ElM2m6d6hvGWPjglG04sBaXc=
X-Google-Smtp-Source: AGHT+IHZq2d3S+OFJEJgyHeEacU64SWD23Xe1c+OR6kFdAltX/pushK47A2AKniHUMV1lo/oKwDrjJc4yhzuESlE9Mg=
X-Received: by 2002:a2e:b8d4:0:b0:30d:e104:b67c with SMTP id
 38308e7fff4ca-328077c924amr42532911fa.39.1747659018349; Mon, 19 May 2025
 05:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516104023.20561-1-brgl@bgdev.pl> <aCckl9cC8fCBhHQT@hovoldconsulting.com>
 <CAMRc=Mf=xW6HFVYOOVS2W6GOGHS2tCRtDYAco0rz4wmEpMZhmA@mail.gmail.com>
 <aCdutI4J6r5kjCNs@hovoldconsulting.com> <CAMRc=MdS0QG_ThYUhwTRaKidyGcj3h6x0=jmaW7UK8EBPhrYrw@mail.gmail.com>
 <aCsnOthU3z1jwWdb@hovoldconsulting.com>
In-Reply-To: <aCsnOthU3z1jwWdb@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 May 2025 14:50:07 +0200
X-Gm-Features: AX0GCFuIqXotxUTxO7wCippzeAa5UBQlB2tz_hDqZnuqIAXKKSVVzo9gCE8BMg0
Message-ID: <CAMRc=MeWM+2_FW9fxFvQeYqOSw+-5M-CQnTHrFf+jZs9Z4fneA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sysfs: add missing mutex_destroy()
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 2:42=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, May 19, 2025 at 02:18:15PM +0200, Bartosz Golaszewski wrote:
> > On Fri, May 16, 2025 at 6:58=E2=80=AFPM Johan Hovold <johan@kernel.org>=
 wrote:
> > > On Fri, May 16, 2025 at 02:32:54PM +0200, Bartosz Golaszewski wrote:
> > > > On Fri, May 16, 2025 at 1:42=E2=80=AFPM Johan Hovold <johan@kernel.=
org> wrote:
> > > > > On Fri, May 16, 2025 at 12:40:23PM +0200, Bartosz Golaszewski wro=
te:
> > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > >
> > > > > > We initialize the data->mutex in gpiod_export() but lack the
> > > > > > corresponding mutex_destroy() in gpiod_unexport() causing a res=
ource
> > > > > > leak with mutex debugging enabled. Add the call right before kf=
reeing
> > > > > > the GPIO data.
> > > > >
> > > > > No, there's no resource leak and it's perfectly fine not to call
> > > > > mutex_destroy().
> > > >
> > > > No, there's no leak but with lock debugging it still warns if the
> > > > mutex is locked when it's being destroyed so the change still makes
> > > > sense with a modified commit message.
> > > >
> > > > > You can't just make shit up and then pretend to fix it...
> > > >
> > > > There's no need for this kind of comment. You made your point clear=
 in
> > > > the first sentence.
> > >
> > > Your claim that there's "a resource leak with mutex debugging enabled=
"
> > > is is quite specific. Now I had to go check that no one had changed
> > > something in ways they shouldn't have recently. But mutex_destroy()
> > > still works as it always has, which you should have verified yourself
> > > before sending a "fix" tagged for stable backport based on a hunch.
> >
> > Yes, I admitted that the commit message was wrong. And yes, it
> > sometimes happens that we get copied on crappy patches. However,
> > unlike what your comment suggests, I don't go around the kernel,
> > "making sh*t up" just to add a "Fixes: Johan's commit". I had this as
> > part of a bigger rework I have in progress[1] (discussed previously
> > here[2]) and figured that with the series growing in size, I'll at
> > least get the fix upstream before v6.16-rc1.
>
> But it is not a fix. It is based on a misunderstanding that you should
> have caught yourself by just looking at the code before posting.
>

Noted, I'll drop the Fixes: tag and submit it as part of the rest of the re=
work.

> Sure, mutex_destroy() is an odd bird, but you still need to verify your
> guesses before posting patches based on them. It's that lazy attitude
> (and violation of the stable kernel policy) that I'm criticising.
>

IMO what you just wrote here is a way better way of expressing your
criticism than what you led with.

Bartosz

