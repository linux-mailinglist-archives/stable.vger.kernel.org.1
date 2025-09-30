Return-Path: <stable+bounces-182060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60452BAC73D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 12:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4047C3B1089
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E92F9C38;
	Tue, 30 Sep 2025 10:21:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD782F99A4
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227673; cv=none; b=WlrYaJu0LKIb+l3Tzg4dwpiUpcN1BbBPkY77TBOPn8FRhq9RNWVVEqUXnl7UOUhAn6HtG9vaG8qqG/bliE+p6jGycEXUuNvWJ6Wrao9XMTyo6QGMiBZfGkYWhaz9ysBWO7zMIl36+9iynsL9LrxCEtrEJ8rVG3G0GWA5SpGWjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227673; c=relaxed/simple;
	bh=WQLYqqeVFTfkVzqoUMVRfNAxbGpfZXqrGeHdXR29J2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0wPaDfiruoOpaMJB5WAj9SvR9zv8KCuiCyHCG+y0vMqE3WO48bFfC4elO4NtbXg9W/G6xBqMEbwFNIDPg/YYMSAZQE4McA/cJ9PcTeTacWYyYeiyBRiP3FXrYWtPVwz0IcltsTRjHVkZuzU0wtih4Hm4uf2xBFEspcNBv87DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-92cbfab6c0dso760362241.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 03:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227670; x=1759832470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auZnMEhGQ1qbaDugOLJ3H3dc2TwXmOwQEh+fyQy4fvU=;
        b=bM+NQXcdT/Avb7bDXujjzdd3BIl+iczAG2EqTeSCdGpfFb6HeHTsm+VWlowYRvk9az
         IknhcRfLuVIILBLu50hwLSREJYz9qG6XAsGl5bAfxmkIR2QgBYGekNdZPx95WRf1m3qu
         ONZqz6CMMvu7VqqZXO9k9KEFduzEX46THQYqpDj321mYcD0pNClVCXsYED9ame4CXpZS
         ur2Y3uDkSMgB+YL1UCVZUEHpmGOW7HgA1h+GnME+NJDulc+nycXgmjRmd/THJynQBMrF
         81mGlF7JhdBx5h3bUP51d1I4mmPe7v/L+UzdwX1SkOAZaSjKfSvwRxKd7mhsodNBwl+m
         gJiw==
X-Forwarded-Encrypted: i=1; AJvYcCW162xI/PGSrG2N90u0ENtZE/r6iznD/uO63/Eft/JAUiBt3ctBBt2tNl9jhAN0NJPLLa6D4wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzeu1+OuncZTOn2RreBlnSESFXuQwEMYWR4b1jjGDFixm6EnFL
	p2L4MQ0yXlM1Npj36KF7dm919YJXVicCQWKrrIAvoMS3x4DyOsHWqyDglEG9GySK
X-Gm-Gg: ASbGncvNihUK3qjevzy+p2M5zazrpdWCte8DHRhy9i2xc5ghKEvtq9KgY+laLZ2zi4S
	MxsylRLKehayr4QMtarLudDI6zKAfhvE5+CgJm5g809YrTFEjrF7FnA0rnj/UUDCwwfNqlcTslw
	T/oXxfKUPsiVErzVs9Poyp6xiNqVy0XZlpLPUZ/XjFa8Kwg4pUFLd7CMbRN5gsACsf6JoOZUmS/
	mqTvIJs17LlqC0iOC3ModI8MJyeLQFjtiRokRk+ZazaL5BbOM2kCOyGfr5y5dm3UI3iBK4+2pmV
	k53EIAiDTLTi0vAmcxux4UwfdrEvN2deYAzg3arjDVh15DzM4Iy6xXwXgMxeavbIo9DvreTbmbc
	YlbevGnjx65i3Cw+f1PPHVYwD4fGV4wpLHkk86s/bAj8tV9Lc94k5TGuFiP7x7pwz4FNGwM82Vs
	2zPtfeSuSl5Zi9a30xjBY=
X-Google-Smtp-Source: AGHT+IGpL7KeOHh9iDVOCKOfBYGqnag6ogHiI4F9VakTPOoVMPKWhMWc9SzSclTaWrA3ZmbNRQ+Rgw==
X-Received: by 2002:a05:6102:b03:b0:5a8:4256:1f14 with SMTP id ada2fe7eead31-5acd94bd965mr7973434137.35.1759227669649;
        Tue, 30 Sep 2025 03:21:09 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae3182b293sm4476580137.6.2025.09.30.03.21.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:21:09 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5a218470faaso4395348137.2
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 03:21:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq8CZBXDxp3ZPJU4GsvdoyH2rV+ACnyRegNdoL+AZ/ryXMx6CZUHIZnBersyVgqRt4SVJ/mdU=@vger.kernel.org
X-Received: by 2002:a05:6102:a4e:b0:520:ec03:32e9 with SMTP id
 ada2fe7eead31-5accb9fe470mr8731133137.3.1759227669064; Tue, 30 Sep 2025
 03:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXv1-w0SE7FZy5k3jg2FO-a-RB2w1WB=VM_UFEA9zjWDw@mail.gmail.com>
 <ef82c610-0571-4665-a5d1-07a9ed9fb8d3@tuxon.dev> <2bd09757-cd66-4a2a-8801-0f62dc99b9c8@tuxon.dev>
In-Reply-To: <2bd09757-cd66-4a2a-8801-0f62dc99b9c8@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 12:20:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6TQFZJ_r+XZOuh7yTUKwZxQRCr4Ps-xZ8U702xMd1=w@mail.gmail.com>
X-Gm-Features: AS18NWCkJPBMZWKc2yUGwPw-vQOHjjVBBvrCu5QO61We_9-kmpWet2XbZ5yLDKI
Message-ID: <CAMuHMdW6TQFZJ_r+XZOuh7yTUKwZxQRCr4Ps-xZ8U702xMd1=w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Tue, 30 Sept 2025 at 07:33, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 9/29/25 15:10, Claudiu Beznea wrote:
> >> This conflicts with commit d57183d06851bae4 ("pinctrl: renesas: rzg2l:
> >> Drop unnecessary pin configurations"), which I have already queued
> >> in renesas-drivers/renesas-pinctrl-for-v6.19.  Hence I am replacing
> >> the above hunk by:
> >>
> >>             /* Switching to GPIO is not required if reset value is
> >> same as func */
> >>             reg = readb(pctrl->base + PMC(off));
> >>     -       spin_lock_irqsave(&pctrl->lock, flags);
> >>     +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> >>             pfc = readl(pctrl->base + PFC(off));
> >>             if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
> >>     -               spin_unlock_irqrestore(&pctrl->lock, flags);
> >>     +               raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> >>                     return;
> >>             }
> >>
> >> while applying.
> > This is right. Thank you! I'm going to give it also a try (on actual HW) a
> > bit later. I'll let you know.
>
> Sorry for the delay, all looks good to me (checked on RZ/G3S).

Given this is a fix which will be backported, I will reshuffle both
commits, so your fix is first, and the above no longer applies (here).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

