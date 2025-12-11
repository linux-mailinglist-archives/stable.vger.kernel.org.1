Return-Path: <stable+bounces-200816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780ECB6C8B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E63B13026B29
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266B327786;
	Thu, 11 Dec 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="bRknftTT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA43271F4
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474649; cv=none; b=MmZRcfgGBKEZQXHuyoamVgdmdDTQi3WUNG++NqPSaaA3Ty1y/pva9mDoI+FUV4WaIbpYdt6jfjm/dXZWHruYA6t7c3/C/Z3dC5Onc2jScrnhwFueO9UJnx2E5KCZli9aM+ggWanfWLNaJ/JIjsqOLK2z67R8DHbFTYOD903ejX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474649; c=relaxed/simple;
	bh=o17sRyxm7UIDmprl4aZGfoSnq3QhFyWV1enFXSD4gps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xn2os7OF45m/sUNEj25STi8YbUpM6kIjJUnEhx9dwVh0OOVR63+ZLWYnGdsf7B7Sld+Ym5os8xPqJq8K6qVXaDN522zPQV4hFfdVNwumcuasdrpt0rlC3HN0K90JeYofxWEuAtek9TZDgddBHw/W5N4vADJ8CZMELYRswo9KSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=bRknftTT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so699464a12.0
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765474646; x=1766079446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1yff4bc0T45kril10BQxgoSw39c1NrtcFM6PjLf2Ls=;
        b=bRknftTTHZELLVKWr4F+u5MqlBS/LKbDTqunAbxxahVW2hVZwUCx7UJ6xgiABdeCJW
         jWxKtCMy30AsYx/FDYuaHsntmGw2vMjxhP1D6LPqu1xglijYCdlRfSf3KPLh8I2Ylfza
         2uQp2d+NDgFxPrstD4UjoIgKsTE3rRkppc6i9Ty6Ig4Q++RzdPpWirS/T48pSZQ8SZda
         GQdPYtXUnEQNLSolURsgbZu6468be4Zj0iL9EWWHSnGHT/r0/N2N+545IF1S3fEGgYvN
         Ay09+TKW3aoY5qvjEHncJ/HBIpgtpD0VlVO1LjkTDZrrTg+YE2B1cijgK59Pu5L1VZnP
         qD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765474646; x=1766079446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1yff4bc0T45kril10BQxgoSw39c1NrtcFM6PjLf2Ls=;
        b=KKtjjU5Gi90olEZjiuZU9ikBEYTHuoflOekOJ8bEiIRWWpxX7jpX0XgQK6laBtTohL
         BILz8oimzVMkPX0xgd8yh8vY53nJxm0mtFZpJumcp2Q0fq1qiWReInHEcYbRQW9RFFrY
         1IZ/ADYTK4fsPafo3rI/a5XKhnBwntpALBLpXs+HqdqjbZWT7dqZjNCCgWKGhx/1fKAI
         BQIUL37kkhMDPintR60Ev1hesCWA388GUfpoTcqp8uQ7tqJlPEWwJoIAUhklVOMuEcTl
         XvPjKVoq0kzrOMGm5jXegCAVu2DHoIWmly4uhjn2hHo+5uEyYtPxA6fiDgkfTsHRvFrp
         hQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWHwHS3/G382+njS/CzyDa0SKOgPUHbmCudK/bunsUWbGHa2aC5jIHiKuWE2Prl6QuTYsPYEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6ABWje89j9+kPk2+EdbGqKNpx2bt/0ikumPrfzRF4H70uARV
	Lj2oAOxQm04P/BWKYrdufYhkYTsfAphKeVe492G4NllMDlz4tOuHO5c84S4nXv4HVRGXaB4OEBK
	e0RpzSttKpXxNar3rcjATXxzkE9VNfG/FiMUk1sloDg==
X-Gm-Gg: AY/fxX4Xo6eX+MVpVbVQkBwBsAwkbqbx3qSmpjXuBVz5hfhP+cz/N4G80YOU6PVMWcs
	f48J9tuViJd30CzTMOQzT1IyamhY8K+t+NQA2Zp15Hx0lyoaFLuDWLSTodL920DT5fi78NoXPC7
	j3cSLz8M6Kkt8aEJ4HYvK+uB6TtaPPbOGw0cY5leMMzf4vrUYHjXyIW7XMJI5BokMx16ZzLCk2z
	NnLJidV6qY83RtOq1ujVG0Aphbe5thCw65AuIjZ+VFXISaq8odAfF3lm+pmLvMggWv4yVgb
X-Google-Smtp-Source: AGHT+IHmdQwa8POPlNPzaUDlA7ppJ6M8JtOU+WZGPZOtTvMBOBTTwYlrmIuWhcAfLkYTxf70odorGU+gj0Q9+QZGFl4=
X-Received: by 2002:a17:906:6a09:b0:b7a:1be3:a582 with SMTP id
 a640c23a62f3a-b7ce84d135bmr722249266b.63.1765474645609; Thu, 11 Dec 2025
 09:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072947.850479903@linuxfoundation.org> <CAG=yYwm==BjqjJWtgc0+WzbiGTsKsHV3e4Lvk60fcartrrABDw@mail.gmail.com>
 <2025121046-satchel-concise-1077@gregkh> <CAG=yYwm0bVzYoccKKcdheGOc-exuxVCPeXSftDixS68qZZ7W7w@mail.gmail.com>
 <aTnET5C2PGiKsW_2@auntie> <CAG=yYwnYgw-MYea3yEfwSRiLL+PsKPdQdejotyFTpme0LXc-Pg@mail.gmail.com>
 <aTr0NpEHWSCrGNTS@auntie>
In-Reply-To: <aTr0NpEHWSCrGNTS@auntie>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Thu, 11 Dec 2025 23:06:48 +0530
X-Gm-Features: AQt7F2req17RppecxU0d8GIiJFE8Wcg_BugBfal6e-qcSTyFvfx5VN8m8i6sM7w
Message-ID: <CAG=yYwmqMSV7xQrL_Nrx06QO_f_61MigB-2eL1kiDO4Mt=4uew@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 10:11=E2=80=AFPM Brett A C Sheffield <bacs@librecas=
t.net> wrote:
>
> On 2025-12-11 21:09, Jeffrin Thalakkottoor wrote:
> > On Thu, Dec 11, 2025 at 12:35=E2=80=AFAM Brett A C Sheffield <bacs@libr=
ecast.net> wrote:
> > >
> > > On 2025-12-10 19:13, Jeffrin Thalakkottoor wrote:
> > > > On Wed, Dec 10, 2025 at 6:17=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Dec 10, 2025 at 04:22:21PM +0530, Jeffrin Thalakkottoor w=
rote:
> > > > > >  compiled and booted 6.17.12-rc1+
> > > > > > Version: AMD A4-4000 APU with Radeon(tm) HD Graphics
> > > > > >
> > > > > > sudo dmesg -l errr  shows  error
> > > > > >
> > > > > > j$sudo dmesg -l err
> > > > > > [   39.915487] Error: Driver 'pcspkr' is already registered, ab=
orting...
> > > > > > $
> > > > >
> > > > > Is ths new?  if so, can you bisect?
> > > >
> > > > this is new related. Previous stable release err and warn disappear=
ed
> > > > (i think i changed  .config)
> > > >
> > > > can you give me a  step by step tutorial  for git bisect
> > >
> > > 1) cd to wherever you have your kernel checked out
> > >
> > > 2) `git bisect start`
> > >
> > > 3) if you're already on a known-bad commit, then mark it as such:
> > >
> > >   `git bisect bad`
> > >
> > > 4) Mark the last known good commit as such:
> > >
> > >   `git bisect good <commit / tag>`
> > >
> > > git bisect will choose a commit to test.
> > >
> > > 5) Build, install and boot your kernel as you usually do
> > >
> > > 6) Run whatever test you need to determine if the booted kernel is go=
od or bad
> > > (check dmesg in this case)
> > >
> > > 7) Mark the commit as good or bad. Git will choose another commit for=
 you.
> > >
> > > 8) Goto 5.
> > >
> > > `git help bisect` will give you more information.
> > >
> > > At the end of the process git will tell you the first bad commit foun=
d.  You can
> > > dump the bisection log with:
> > >
> > > `git bisect log`
> > >
> > > which you can reply here with.
> > >
> > > HTH.
> > >
> > > Cheers,
> > >
> > >
> > > Brett
> > Thnaks for the tutorial  :)
> > 1. should i start with the bad commit first ?
>
> You start by marking one good (past) commit and one bad commit. It doesn'=
t
> matter what order.
>
> You have at least one "bad" commit you know of: 4112049d7836ad4233321c3d2=
b6853db1627c49c
>
> This is the 6.12.62-rc1 commit that you reported had the error.
>
> So, in your kernel worktree:
>
> `git bisect start`
> `git bisect bad 4112049d7836ad4233321c3d2b6853db1627c49c`
>
> Now we need to tell git bisect the most recent "good" commit we know of (=
where
> the error didn't occur).
>
> If you already know the commit or tag of a previous version where you did=
 not get the
> error, mark that as good. If not, pick a previous release, check it out, =
and go
> to step 5.
>
> > 2. how to move forward or backward in commits ?
>
> git bisect will do that for you as soon as you mark a good and bad commit=
. If
> you want to manually test a specific commit, just `git checkout <ref>` as=
 usual, and
> continue at step 5 in the instructions I gave you.
>
> > 3. what is the point in re-compiling the kernel  if it cannot narrow
> > down and  test news lines of code
>
> We're narrowing down the error to a specific kernel commit. Once we know =
which
> specific commit introduced the error, we can look at the lines changed an=
d try
> to understand why.  We need your help to find that commit, because it's
> happening on your system.
>
> Please do read `git help bisect` (man 1 git-bisect). It explains all this=
 better
> than I can.
>
> Thanks for testing and good luck!
>
>
> Brett
>

I do not see that error anymore. may be  i have made changes in configurati=
on.
THANKS



--
software engineer
rajagiri school of engineering and technology

