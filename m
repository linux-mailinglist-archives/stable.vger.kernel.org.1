Return-Path: <stable+bounces-78166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FF988CA9
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE947B21944
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B61B6522;
	Fri, 27 Sep 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Qx81rf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A91B374C
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477965; cv=none; b=VAdPbWbYksUZMlduij92D8lyJ/uDqf7/yniNaoXGb+WftEg7jER0c+9COSmRPUOz/ih9ubwQblWwt6roitgzulARoC+jM274RW/LRJV+CltCJwByNw2BJWJYqzCuBpDuDIuuyvxWFm31llv7sWCkuvv2AtnLQ8AtTZt+lsjLLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477965; c=relaxed/simple;
	bh=RETDblGo7fJm9ykfdR5QC0amdMsWUTecNy67KvQxBgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXbCulvXHBe0g/LljG57elAE6v3VJCXjR/CO3zq5fZKAqXBw3NWl9vjnWGl/XgnE6n7/BR6pZo8VvpsqIKPJbZ6EBNYug3yKOTbhpXTDOHNA/HUUeikRS49lV6ymi+leJ6e0T+y6bmWdLH4n7rB5gpZPljsTHLnxW1B60wJNErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Qx81rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB49C4CEC4
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 22:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727477965;
	bh=RETDblGo7fJm9ykfdR5QC0amdMsWUTecNy67KvQxBgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O4Qx81rfrfy7QCHveW2a1LP7n8JIzgcxH4F4PqF8SwFe/FUcZdbgMlRF4rjU95Yr4
	 uNlT8qIuA3+xKei5eJ2jOk1lCjKPZa60yjWimVEPsNBnpKITRyDzoWIiP/EL9CAGES
	 wW4u+7UkcfuzXqEIAVwHEFQ6IUwDHssjRL+RWXEAg3npRaBudmYpXeIvs7A/BmqISo
	 b7VoGDi8JSOiBzlGFderzWZ/RMSb1TjRfirIgoXezEd6N/YAzTi+oy44AtMOtWVmCd
	 lOSDpWAJeQUIhrspOBM/cOAuv0WX6c4wEYtRChPOj2N+f25oerwXA8q5cPXfdjRVuD
	 v4A0jGs4tjQ7Q==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so32795ab.1
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 15:59:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwiXiRG4fieXGEMp1tOWFXKhhAhiV+uK74SPA2KkeWOEyNi8xC1YfHooJA/zCLhbfsSF/IrF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHYwBegF5Op2Bk3KDNlyN5gWDEpaYoJIUCgG90hvl+00vy30b
	mrmBiGsmIk+XFixeenjMe1lujAUaTNgMLVekGQnqb151FFfrfKo53KJAH6pI6zWgLoN/DCXhj0f
	ZrGdHIOBqgxm4cZc85fD1+Sw7kFQ1FpisIrOI
X-Google-Smtp-Source: AGHT+IFsEwYg450S3NeKQn6xBQFs4856zgRTrSXHV+euzXNZKECEPNG2NCRcHPEkRwrNy63oW9OieWa6BqbUgzGKprw=
X-Received: by 2002:a05:6e02:218c:b0:3a0:9b7c:7885 with SMTP id
 e9e14a558f8ab-3a34bd82af0mr1249545ab.22.1727477964236; Fri, 27 Sep 2024
 15:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com> <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
 <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
 <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>
 <20240925003718.GA11458@google.com> <CAF8kJuNDzk21jZR1+TkGdMOrXdQcfa+=bxLF6FhyuXzRwT4Y9Q@mail.gmail.com>
In-Reply-To: <CAF8kJuNDzk21jZR1+TkGdMOrXdQcfa+=bxLF6FhyuXzRwT4Y9Q@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 27 Sep 2024 15:59:11 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMoOZYySOFev46uMxdwvVjFbfCTSKeHywrazN-VUxJyoA@mail.gmail.com>
Message-ID: <CAF8kJuMoOZYySOFev46uMxdwvVjFbfCTSKeHywrazN-VUxJyoA@mail.gmail.com>
Subject: Re: [PATCH v3] zram: don't free statically defined names
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:04=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 24, 2024 at 5:37=E2=80=AFPM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (24/09/24 11:29), Chris Li wrote:
> > > On Tue, Sep 24, 2024 at 8:56=E2=80=AFAM Chris Li <chrisl@kernel.org> =
wrote:
> > [..]
> > > Given the merge window is closing. I suggest just reverting this
> > > change. As it is the fix also causing regression in the swap stress
> > > test for me. It is possible that is my test setup issue, but revertin=
g
> > > sounds the safe bet.
> >
> > The patch in question is just a kfree() call that is only executed
> > during zram reset and that fixes tiny memory leaks when zram is
> > configured with alternative (re-compression) streams.  I cannot
> > imagine how that can have any impact on runtime, that makes no
> > sense to me, I'm not sure that revert is justified here.
> >
> After some discussion with Sergey, we have more progress on
> understanding the swap stress test regression.
> One of the triggering conditions is I don't have zram lz4 config
> enabled, (the config option name has changed) and the test script
> tries to set lz4 on zram and fails. It will fall back to the lzo.
> Anyway, if I have zram lz4 configured, my stress test can pass with
> the fix. Still I don't understand why disabling lz4 config can trigger
> it. Need to dig more.
>
> Agree that we don't need to revert this.

Turns out that my oom kill is a false alarm. After some debug
discussion with Sergey, I confirm the fix works. The cause of the oom
kill is because my bisect script did not apply one of the known fix
patches after applying Andrey Skvortsov's fix in this thread. Sorry
about the confusion I created.

Feel free to add:

Tested-by: Chris Li <chrisl@kernel.org>

Hi Andrew,

FYI, the tip of current mm-stable
abf2050f51fdca0fd146388f83cddd95a57a008d is failing my swap stress
test, missing the fix in this email thread.
Adding  this fix 486fd58af7ac1098b68370b1d4d9f94a2a1c7124 to mm-stable
will make mm-stable pass the stress test.

Current tip of mm-unstable 66af62407e82647ec5b44462dc29d50ba03fdb22 is
passing my swap stress test fine.

Chris

