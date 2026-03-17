Return-Path: <stable+bounces-225765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jo+OL4QuWmFowEAu9opvQ
	(envelope-from <stable+bounces-225765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:28:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED5F2A5A9F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB30B3058E0D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A6396D2A;
	Tue, 17 Mar 2026 08:23:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD715395DB1
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735826; cv=none; b=YkkYpaBKiDBwtUYmQw5Pecl/FDp3uDUFETAFXkvR4BLTkEnuKHc88Up9iU0wWLEueaMVCoeWUaT9tyfh7A4o86/SNGaTrUybuPk4Gjvo5djNIfYX1a7fmCXaW0sMQL4CLynL6/hKT6GBFS+nR0QQ3K9j9iTAf9Rk/LustWtqHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735826; c=relaxed/simple;
	bh=aTR0ByVDp5twPVDF0We0yxjjtWE6HL5DaVZrXfqb4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrqwiXsHIgC/w+Oa2ajRI7BaGWwmcaH3tQSnHpJdhM7MogF5OCU146nShdevzx2MMs+NLDJvYUgI9wdpDIB5s469Z0K2NKdmDGdJdE1eESBTU7wpaDaCKlQJQ079T2Cr32v0Q7GgA4s6suv2QWkhHh1In1iGrqAK/2x20hwGKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56b672c68dbso231328e0c.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 01:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773735825; x=1774340625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BWsLLpeb8S2Ruk3mIA0NNiewV90E5kBU5fFfxw9bA0=;
        b=pi+kiJ0cG7AhdAmknU228Gqzx1tTHObtW00536/QO2bdOillEuH1wYEjQboA7l0ceW
         IWiMlUEGLG0frb90YzcwrS38QUuqlMoXZwd/J1MFYLYL1VXZV7buxbjkS4kcojUKXF8/
         JT07NdFOmk+qKH2smcZN/0/7Lkmu1Ps5kkeA8R4wsxEbfw5WZAGMF+IpYnrCVtdnloZQ
         3VO7DuAarL5bt+b/8YfhdsHPZqjv12gqxklexLl66JpCFjQEtms39/ibI0eCGc1BOr+A
         2PTjnbza+RYZlYSTk5lebkp+cbkoG3sqO3X77ifwn36EE36f9iOMOfZ+UlNc1/RnSMZk
         MwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnQujDRGdItooiPP4BMCLHrXuC8DJK1H88LR9FYbWdAEZrjWyREm5KankltS0EAi64RB6VMUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhzYHfqnbrIEbs4lQxk7zAQyCLPCRrOlhpR8FpXzpT/p7LDuY
	UKmwwhWhDEFoLZX73xA9E2jEcGqMvNp3I44HGXB42aoYrcTeAZo6r0tlK1C63Axh
X-Gm-Gg: ATEYQzyua1p3fMeKbvbV9hdcRpd2xN3S8J/JvAycTt6a+VOVgtAYWroqHpOME4NvMQx
	x7juiobq1hKOz5XH3TaCMOKrS/CXQ/DIdUaqEWJUGsJA3iUObDS5vTCr/jluqyVSjvbBCCcAwXz
	LHyRA8Osrm793q4Phl53/U4rA/PeAf/MMgm08j0qMyAv1T1wKAaqzWTjYT7nTl5rEI/m/q31wzd
	JULsA6inAPIPu6WcxB9lxBue3Rl5h+Y8IuFU23igZs5bXuZIBnWTYLIKAJgx1+CVVPEuQ3AVbFW
	wwXmb02SaEkt1DoB53J4MBCKfnSN9JzWPZTdqXBEwcu2qcftdMNTXofIo48RnDeXJgGxhroCBpF
	VMuiawsNsjkivHlZZvCoa8CFI0JUDMThYoPKhZwPv7e2P1Du+NxzfZHFE2Jwcrhjsxxh/PCsHSP
	oBZQfpoQBbI1GLhjrLIDpl3IYu2/hY2b2dQV+3kjXEeGvC4wwSS0pZNBo6W5I69xcJtVnn9g0=
X-Received: by 2002:a67:f252:0:b0:602:6ccd:7772 with SMTP id ada2fe7eead31-6026ccd7adamr348723137.2.1773735824644;
        Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601de6c9c9bsm8322749137.3.2026.03.17.01.23.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94ac3958788so335314241.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcWTUMnk0p5lt3Rxp3ObnKCFzLMrbWy/wg5K25OFNP+g/A2lqQy3SO+EdGX8kmEHnu6OKusDI=@vger.kernel.org
X-Received: by 2002:a05:6102:38d4:b0:5ff:de83:3e46 with SMTP id
 ada2fe7eead31-60263d8f933mr1167606137.7.1773735823847; Tue, 17 Mar 2026
 01:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros> <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com> <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 09:23:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6c1F8eVOi6bQssq3qsBcpGnQ-cT1AeXLqXXYEgK4xrg@mail.gmail.com>
X-Gm-Features: AaiRm50jZRADgQIXJgbrFUg4WeDPSzcNuPJxTTXR-hiMiTGwpkXr0IAMZW3mmeM
Message-ID: <CAMuHMdV6c1F8eVOi6bQssq3qsBcpGnQ-cT1AeXLqXXYEgK4xrg@mail.gmail.com>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd channel
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225765-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.688];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 5ED5F2A5A9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cosmin,

On Mon, 16 Mar 2026 at 20:13, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: Monday, March 16, 2026 8:26 PM
> >
> > Hi Cosmin,
> >
> > On Mon, 16 Mar 2026 at 16:52, Cosmin-Gabriel Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> >
> > Unused sibling_hwpwm?
> >
> > > {
> > >         if (!rz_mtu3_hwpwm_is_primary(hwpwm))
> > >                 return hwpwm - 1;
> > >
> > >         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
> > >                 return -EINVAL;
> > >
> > >         return hwpwm + 1;
> > > }

> It's funny how even after triple-checking the message I was about to
> send, I didn't notice it.
>
> This should have been what I sent.
>
> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> {
>         if (!rz_mtu3_hwpwm_is_primary(hwpwm)) {
>                 *sibling_hwpwm = hwpwm - 1;
>                 return 0;
>         }
>
>         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
>                 return -EINVAL;
>
>         *sibling_hwpwm = hwpwm + 1;
>
>         return 0;
> }

Thanks, now I can see what you intended ;-)
As the output parameter value is unsigned, and never very large,
returning that value or a negative error code as the return value may
be simpler (i.e. use the original "bad" version, and drop the unused
output parameter)?



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

