Return-Path: <stable+bounces-103935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE3E9EFCB7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD104188E65A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8E191F85;
	Thu, 12 Dec 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIhlBHXQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F57189F2F
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032901; cv=none; b=YZNktYqEEoagtwkCnzhn7QgmszcmH+o78xbF3Rp54aPP5LwAd7MOsmhW0JLbyawVa3PA/fhVcE5tM9unb+aBJM0W2Tne5dWaUU8LvVUW6E/OBmLUEAh+NHCSGAcHoSOyBNkd+njvxdSkfnbdvsPkvCbwbFTGaVUmFNbNSqBdito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032901; c=relaxed/simple;
	bh=IczXGAF+eM1R/n6n4f5k72EKL4WE9hhqzfJUbDYrWKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzHbCZND0uprC/zPcyuCyEuweK11lDm4iTOJCZRqjk3gzhKTyx55NmYUFNBPB8aSawEyU9sHe5h/4x/HLe3BZjMYcSC8+YkLMZrpHH7JV6DT2I7l8FXTXfDyUg/4W+rsqJ38+hSkRSehDx+vxNVmaDDHGJtIcreXpTy0Lz82/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIhlBHXQ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51882c83065so464881e0c.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734032899; x=1734637699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BlbbI/g+hRuUgF8qGy3bJAgo11Dj0VWxvIagMZzWOus=;
        b=PIhlBHXQbq98ZmFqAlZAd3bNKAIJkTKuq2mQi0uJq4NoN7A1KEo5sVGgMBc1olSjrE
         aHhsplFimZy6b2Y9jMS4GlMQ5jjOUO5OhAzCZHTS5h0HBi7oBJDsb/6Xh+B8Wg9F4ZGb
         YdIY4XMeNYsYCM5KSpd2UlNyZ+xOoEQ4Cl8riDY6n0O82MriucH1bv2wfm4mtlYgyq0P
         UQ9sZfF/60PvIWHE4vSPBEIIRLSQd/isV32CjrHtVXbGCoHsJ+/RP5JlYVcKbX/CrStC
         ur5lID5czfRheXfHmCt424sJAslxX5Gfc4TXFoNB0LTq2CLuhHz0A5J0UCFzhVyDbbDm
         ejFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032899; x=1734637699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlbbI/g+hRuUgF8qGy3bJAgo11Dj0VWxvIagMZzWOus=;
        b=R9U/3ce5xNog7So2CjPgR1JK1bB3qFXW7ncqyIOCqCSgnnRvIe5OXYDSp/WCaXDv9A
         RWOiFR1GCXW+i9IMW6eeSTasDnGzQi2gRrzFakSfGp/Hz+A6RivlsvE4IBebAHqmH19v
         sYOxojhWWL9E5fDuQsTOdjzAe0RngdXp4MOT6c+uICxegUdEQ+V7yOqPJ7I6g5fO+Lk9
         MWIkpcniB66QkyJq7zXsrW2pUWl9Bnxn3vHlYcyk4XDMXsIVvUsPM/H66Mse1Ty2W/Oa
         NlhEJHWLkNW0guTRhBPgw68qxXUoRud47CmxwAgw7JxsBx/IevZ6E4qUqlXShqi+KdvQ
         Vyvw==
X-Gm-Message-State: AOJu0YxNwg2mjBJKfSkwhHyTVZ7Th5alq8rgA0b6ALe0+EdjWLwdnGdS
	6rUa8rGePgfezZXpyRaX9Z0GQjs02/6tp1NjrVc8RAbd4DEYYN8XLEUWnl9pJkDkKuoMSr1t8A/
	RoBj9DYxYxyoR1K/M5lwHWGSZJLBT1mCp66Kjzr8kuT9s2OL1NtE=
X-Gm-Gg: ASbGnctstuXs8zujaFencEkEzZ7rJKynY8C8MI4n4qgIf3B9kRjtk+20xK7at6v0TrI
	dcrYs9wXYDyP5ovq9YNQXLK2MOpwY9gNsoeDJ
X-Google-Smtp-Source: AGHT+IFBe0k1ufkZG205NB2FpxYW8UXDiGTPL48pwGMQjlmQbagnb8MkD4Y4QDURyIAwIg3y5dWgFpLofgO5GFaugWY=
X-Received: by 2002:a05:6122:8c17:b0:515:d032:796b with SMTP id
 71dfb90a1353d-518ca48a3d8mr68111e0c.11.1734032899050; Thu, 12 Dec 2024
 11:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144306.641051666@linuxfoundation.org> <CA+G9fYuX2BsEOCZPC+2aJZ6mEh10kGY69pEQU3oo1rmK-8kTRg@mail.gmail.com>
 <CA+G9fYu3SmdFKRkSDU0UV=bMs69UHx8UOeuniqTSD9haQ2yBvQ@mail.gmail.com>
In-Reply-To: <CA+G9fYu3SmdFKRkSDU0UV=bMs69UHx8UOeuniqTSD9haQ2yBvQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 01:18:07 +0530
Message-ID: <CA+G9fYvV21_-3QYWh_gmKMRZ89AYn-KM99DbmghsLQJEL2+4Nw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 01:04, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 23:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 20:30, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.12.5 release.
> > > There are 466 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The riscv builds failed on Linux stable-rc linux-6.12.y due to following build
> > warnings / errors.
> >
> > riscv:
> >   * build/gcc-13-defconfig
> >   * build/clang-19-defconfig
> >   * build/clang-nightly-defconfig
> >   * build/gcc-8-defconfig
> >
> > First seen on Linux stable-rc linux-6.12.y v6.12.4-467-g3f47dc0fd5b1,
> >   Good: v6.12.4
> >   Bad:  6.12.5-rc1
> >
> >
> > Build log:
> > -----------
> > kernel/time/timekeeping.c: In function 'timekeeping_debug_get_ns':
> > kernel/time/timekeeping.c:263:17: error: too few arguments to function
> > 'clocksource_delta'
> >   263 |         delta = clocksource_delta(now, last, mask);
> >       |                 ^~~~~~~~~~~~~~~~~
> > In file included from kernel/time/timekeeping.c:30:
> > kernel/time/timekeeping_internal.h:18:19: note: declared here
> >    18 | static inline u64 clocksource_delta(u64 now, u64 last, u64
> > mask, u64 max_delta)
> >       |                   ^~~~~~~~~~~~~~~~~
> > make[5]: *** [scripts/Makefile.build:229: kernel/time/timekeeping.o] Error 1
>
> The bisect log pointing to first bad commit,
>
>     clocksource: Make negative motion detection more robust
>     commit 76031d9536a076bf023bedbdb1b4317fc801dd67 upstream.

This issue was fixed in the upstream by adding the following patch,
  timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
  commit d44d26987bb3df6d76556827097fc9ce17565cb8 upstream

- Naresh

