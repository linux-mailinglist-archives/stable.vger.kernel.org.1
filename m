Return-Path: <stable+bounces-200177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A42FCA860A
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 17:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0DC30FB134
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0752D876B;
	Fri,  5 Dec 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="fmy1flCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F752C2365
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764951587; cv=none; b=MUF4MUpjJ0kmlK5ReaQgOiITNa+g77CNx8TcRqCqPIVLxvlCFqqTYgvM/duPAis/kPSICVLjLzM4Xi+MfYjLhbB60K4bjYh9PDZI0DRAyd5+llCgvfx5SPELzZjNFVoGW78ilQi2Iur/CeT1YlOXZ2Nu8E6dWHvtX9HD3XbPG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764951587; c=relaxed/simple;
	bh=hDMbzfmENdHfWL79AM2kPjpbwBhLSdqhPtR6U4xOajM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDFVhlMHScj8adtEbKraCQegFuJp310jSnMjZZ6YBhoeqQwcdAKDbmo0AZa0o79T8NPyOcUNauiINBZCgZgmxABunv6lAnX9AhTsRyEQVFzFWpA6dZzq1TzCX+eZYlleFLt2Fw9SuKM9949VoJxL1Pu2IBo5CHZnVVp2I9dYLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=fmy1flCl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7370698a8eso306932066b.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 08:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1764951581; x=1765556381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAbqYtjoS1Tqer4NnfEvoEpU3/4o6IX/rjsldncYrIg=;
        b=fmy1flClzORIE7huAj8bUjb79ZNvEjlnqQVeoIflBBMipSOahkp5tFWogwb+h0tIKy
         e4DtxcqgJrvgTm4kGsULj8/6iv4G23tK/C3AVNWETCUOjmJuiuzWT4xIgKnWSVSUe9ne
         nVPbTPIVG/MTE20wOS9pp/LLQ7CuAmaJOcZEd9M8UXhdNsktif/OU5SlbpM4Y6GLA48E
         /kpIY7Z5fHcvXOhfB2yqoVJwe0c+pI8Xupm1XUln9uzJrjyDLxMzvZSoyCzM7IG4Q9je
         hbI+PMfcbXr3pnAQuZmpXu17wIfhqiVQUjXpW7PWSUR0GlXT+DJAnBWF4q4QT3IUbezx
         hBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764951581; x=1765556381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAbqYtjoS1Tqer4NnfEvoEpU3/4o6IX/rjsldncYrIg=;
        b=qjaajr7Ge8i9UiXVyYN+EA1eehSv6QwAzzsHOqbVKA7wTNUiLdbF4r5pKWubD9Qn0P
         C1k9Ln8rKF+x07cZ2ZWSEiB7Q3aVMaFXEpsPime1WbjWLjABPOoJ28X9rLXVds2FDZyd
         QYfTrkfLuq8OwIUsHrLy9Qsh5o621cJUcl8Nhf8msVHJsngxDo/3IVFDhQWLvW3d1myi
         8fhPFU4DUaWJ7uqW4hYAgTZ4P/BXb+582eAZvaSphirUxpYtkF5Go3NyVgK6ThcCCuhD
         NA5CyxRDYQVeNGNFYcEqfss12f+bl/2cm1uMKaE8kt3mtlkEBXvYmQL8zkCCrGyN2fHC
         3TWA==
X-Forwarded-Encrypted: i=1; AJvYcCUQsExR0cByqIN+DmToAj4WHjJN0KSGXwj+WOZOjeDPLjOTewuP9iyj31oG45P6hQ/aSMNpO1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8D3HfipDkFiQIm39YcQGALyMv4BMO61Gut3e2u3st/DwHQBcc
	7E96S46V2Sfx/ExzAx6ZQEaAmbdlZF9IeEdoMqJ/tsJ0sZqcQ56/p1Nbkx2Ce2hVhhSF8c1Tn1A
	ur7NtlQLgTs/j7IEjmfedGkgPK8x5GOjEh1zK/FI06Q==
X-Gm-Gg: ASbGncsexBVPsy9pEtRUSLNzNPclPJDaHR2ni4NX0sEJTocHS4Q0i+lDos6r7OslDzR
	wo8LTDU9/sxuYRKZB2f4mHVc2QAlcQT+oAFiF8eEqxamj3Bjh1l2g5b3VOOtkcY2giHWkS8GaD5
	K8VhveVm2EdVSVyN9hlHksGu3QeSQPVX3ydu1aFbSWfTpQYHNqBojCzeRZ/LYRVZSWGD6Z6w1dQ
	+mvgSdz2z2D0mN4WqG8+FkhsFmI33XAhFbS0Vk9+W4FEyFQbnPgeUIZ8YZXGD0zUyybTf4=
X-Google-Smtp-Source: AGHT+IHwYlHgHLDk6t0DAeyZR6wuIa1pzzye0g91Dzw8CXF4QIhSiYZYQhtr31uSprLcgsbZQVlfF/dGe1kN6wqxzeY=
X-Received: by 2002:a17:907:8694:b0:b76:8077:4eaa with SMTP id
 a640c23a62f3a-b79dbe49c0bmr1122346866b.6.1764951581403; Fri, 05 Dec 2025
 08:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org> <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com>
 <2025120413-impotence-cornfield-16aa@gregkh> <CAG=yYwkbpW8KG8ks9QGfOroV44sishtjFwvhnxBpD9O2en+7Ng@mail.gmail.com>
 <F776C81D-B1E8-403D-848D-1C6A189E6740@sladewatkins.com>
In-Reply-To: <F776C81D-B1E8-403D-848D-1C6A189E6740@sladewatkins.com>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 5 Dec 2025 21:49:03 +0530
X-Gm-Features: AWmQ_bkXtUvbLDIW8AM_8JgOiORNeZ5xJPz9MSTKCVysh3B10mLS_p-LNes_9y0
Message-ID: <CAG=yYwkuemRE+66q9+5g8=yPZHWrfEFDk3Aa1sWnMwkuHe0Vhw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
To: Slade Watkins <sr@sladewatkins.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 5:41=E2=80=AFPM Slade Watkins <sr@sladewatkins.com> =
wrote:
>
>
>
> On December 5, 2025 6:51:36 AM EST, Jeffrin Thalakkottoor <jeffrin@rajagi=
ritech.edu.in> wrote:
> >On Thu, Dec 4, 2025 at 9:46=E2=80=AFPM Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Dec 04, 2025 at 02:38:10PM +0530, Jeffrin Thalakkottoor wrote:
> >> >  hello
> >> >
> >> > Compiled and booted  6.17.11-rc1+
> >> >
> >> > dmesg shows err and warn
> >>
> >> Are these new from 6.17.10?  if so, can you bisect to find the offendi=
ng
> >> commit?
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> >hello
> >
> >6.17.10 has the same dmesg err  and  warn .
> >
>
> Hey Jeffrin,
>
> Can you please bisect and find the offending commit? We'd love to figure =
this out, but can't do much of anything with no information from you.
>
> Reading your previous emails on this, it seems like you're using a differ=
ent machine. Have you run this on your usual machine to see if it builds?

compiled and booted 6.17.11-rc1 on my laptop (typical usual machine)
no typical errors and  typical warnings .
so the error has something to do with my Desktop
one thing i want to say is that  my onboard graphics is connected to a vga =
port
which is converted to hdmi using a converter. video=3DVGA-1:1366x768@144.

--------my desktop ------------------
jeffrin@debian:~/kernel/linux-stable-rc$ sudo dmesg -l debug
[sudo] password for jeffrin:
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.001421] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001425] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001653] e820: update [mem 0x9f800000-0xffffffff] usable =3D=3D> rese=
rved
[    0.025796] pcpu-alloc: s212992 r8192 d28672 u1048576 alloc=3D1*2097152
[    0.025799] pcpu-alloc: [0] 0 1
[    0.361824] PCI: pci_cache_line_size set to 64 bytes
[    0.361824] e820: reserve RAM buffer [mem 0x9e5e4000-0x9fffffff]
[    0.361824] e820: reserve RAM buffer [mem 0x9eeb7000-0x9fffffff]
[    0.361824] e820: reserve RAM buffer [mem 0x9f4d3000-0x9fffffff]
[    0.361824] e820: reserve RAM buffer [mem 0x9f800000-0x9fffffff]
[    0.361824] e820: reserve RAM buffer [mem 0x23f000000-0x23fffffff]
[    0.364954] pnp 00:06: [dma 0 disabled]
[    1.132492]   with arguments:
[    1.132494]     /init
[    1.132496]   with environment:
[    1.132498]     HOME=3D/
[    1.132500]     TERM=3Dlinux
[    2.382115] QUIRK: Enable AMD PLL fix
[    2.560086] libata version 3.00 loaded.
[    3.420789] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.648703] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   34.329828] PM: Image not found (code -22)
[   49.778876] rfkill: input handler disabled
[   61.785074] rfkill: input handler enabled
jeffrin@debian:~/kernel/linux-stable-rc$
-------------------my desktop---------------------

i have to find a kernel that  works without  the given err and warn related

please explain to me how to do git bisect with two sources( kernel x
and kernel y)






--
software engineer
rajagiri school of engineering and technology

