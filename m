Return-Path: <stable+bounces-161462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1AAFED0F
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B4547700
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8932E54DE;
	Wed,  9 Jul 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LejgoGzb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59182E54B8
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073574; cv=none; b=bUNPvVNU1GQV0oGantOaeeDbu/1a5bCMboF3BSlZapPHFUFMK+351VuR5KyXMbHrOa2VO806LUjwgAsusOREyxMsaiI4BkM/lkPFA7QOstNwr/4Y0QTlVtNfMuyFIRPMX3/pLU2xqjFe91/jw4xXBIO0TPwTARbxEWuZMHfqnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073574; c=relaxed/simple;
	bh=o3VYnZZ+tgbvdHkK92dLWkBeuvHVxESaeyOIu1N/g/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOlUConGlOwqyS/ND9yEVVG3izADvX58wyMMX5CYNuy/ksPaONUJCn4l5OyQd/vGr977fSzrp5W73g18F7GLqzt+DFtQviZVaXa6KNmePl8sJcKfcU2k1xDw9rKEcZnLwoK9FEiF+707zyiRA7ibPuiQaJayPK2vhGj8LSbJjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LejgoGzb; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so3879949fac.1
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752073572; x=1752678372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsnFkpfHpSLgnhHehYxT0SXfvXjOpGn3uyHH/tWMnN4=;
        b=LejgoGzbRoD2/w5y0m+OWWyebygHSyOCnAu+w5C+iomnqqeHG7tdymtKVurHt91lNI
         eXMG+liJd5ytd8pCNx3TXKY2SJDjeFYQq1vA1uYEIoCHvqvLy23e9+EFCnrHO2pyqgmd
         TIz+h6YVXzQrXsR9pMjTYsBdkr8Dt6SR520++qBMRnsELXf5faLvuSL/iNu1OhtzLZfi
         Bs4Of0mrhO5MziM5ntn9DT4A7E9HTbakXbYwibuMyCvKFf4hl72kH8+4bxCw/0gOFWCK
         mKTVSuS+pniN2BXglroTrgwgW+BfavN4vmvllcFnPd8TZHVwaIvq0G0ZogW1VV4MQoN7
         Iwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073572; x=1752678372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsnFkpfHpSLgnhHehYxT0SXfvXjOpGn3uyHH/tWMnN4=;
        b=e1a7FHebr/NiDeoRuE6wjv3z8VkmjGcSyYkGyhVN2PF/fynopftvo53EsJmIQ1Uhpw
         3RdF6eOam7QxjAZ1hIjFGn84mL3GhYi2U8mR9mB9zUbPIMZkt9ahsBQnn0n47HZDS1Vy
         gaKTM26o3rzvZbrExRQ7LGUIvAENYAwLfp/Ughj+b4za7pFXylKEOkwpsrlsfqkAyeAk
         UPby08V1AJ6/x5jLAhSKc6HxvPPWg9f0FanVT4w6jKvssvuAsbnyNZYuBCVom8G5vkJY
         pPMpaFfq5SHvszY4uS1zH5SwNm4vwNE/hty+V6oyB9zobmFRwlS8yPVGSIClAkfb7WVA
         bepQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfmAh0Kl90pvcmAAyVlq6q01BGN1Yn6iMPXDjr2aaC62MhmiwdrKcXHH/DV6Ay+XqlNnZ4jhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6fbL974P+B8bFzu/zkIZ2Y4rdHHPEOGFxUCEpoF9BpGAMAtt
	K+aTJJjVXIWOZ5tUCWNBWG35bEkgTHkoqNHRLTTibWYcIqthLcL+SrhY3cv/scZOYneuVSbESRJ
	KY1amZ8NdjV5zZXoZdUfdRLSbrpIUSz7ofjfmxJa9Vw==
X-Gm-Gg: ASbGncuc95deiQo8JBR5c4JQPi5X9us0/HH13IqmhtdPCZRd/SwzTgfdfjz10zUJfFm
	+2n+GLy4baAzJBBp81o36mySMvBYfj0mh2+7F9zR6dF51MFYPRp6h/wTv3wxKp9J9Oi2B6bJe2g
	zbFSNAXXxXG/1PJjKvKV8MAc6xzdZSZkLu890LVDLs389OSPfm+B0T/Sc=
X-Google-Smtp-Source: AGHT+IEoIWgN9FHK8lgM2gGwznFgQbiF3DbfPGXKatkisn2IE+PTbhiG0+Lt8kkPL/tOOIf7zyi6ttIW9vTDxhV9tVs=
X-Received: by 2002:a05:6870:3329:b0:2eb:a8fb:863c with SMTP id
 586e51a60fabf-2fef871c3b9mr2055828fac.19.1752073571432; Wed, 09 Jul 2025
 08:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-3-avri.altman@sandisk.com> <CAPDyKFrbjCi4VdEdeUoVG7wbgwXS2BcOZV4yzh8PiTc_V+rxug@mail.gmail.com>
 <PH7PR16MB6196923468505A9E81C72A69E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB6196923468505A9E81C72A69E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 17:05:35 +0200
X-Gm-Features: Ac12FXw4izV7yEntC-xOPd2IbjfL_R5Ol4qvcliu4FarntwAyL3EWBV0D1Bead8
Message-ID: <CAPDyKFooHB5b9YXhifr8XLbw5OB-Nk=eik0smtRbKLYkEOBRog@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit handling
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, 
	Sagiv Aharonoff <saharonoff@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[...]

> >
> > >
> > >         /*
> > >          * Current limit switch is only defined for SDR50, SDR104, an=
d
> > > DDR50 @@ -575,33 +574,24 @@ static int sd_set_current_limit(struct
> > mmc_card *card, u8 *status)
> > >         max_current =3D sd_get_host_max_current(card->host);
> >
> > Looking at the implementation of sd_get_host_max_current(), it's very l=
imiting.
> >
> > For example, if we are using MMC_VDD_34_35 or MMC_VDD_35_36, the
> > function returns 0. Maybe this is good enough based upon those host dri=
vers that
> > actually sets host->max_current_180|300|330, but it kind of looks wrong=
 to me.
> >
> > I think we should re-work this interface to let us retrieve the maximum=
 current
> > from the host in a more flexible way. What we are really looking for is=
 a value in
> > Watt instead, I think. Don't get me wrong, this deserved it's own stand=
alone patch
> > on top of $subject patch.
> I still need to consult internally, but Yes - I agree.
> Ultimately however, CMD6 expects us to fill the current limit value, so m=
ultiplying by voltage and dividing it back seems superfluous.
> How about adding to missing vdd and treat them as max_current_330, like i=
n sdhci_get_vdd_value?
> Maybe something like:
>
> +/*
> + * Get host's max current setting at its current voltage normalized to 3=
.6
> + * volt which is the voltage in which the card defines its limits
> + */
> +static u32 sd_host_normalized_max_current(struct mmc_host *host)
> +{
> +       u32 voltage, max_current;
> +
> +       voltage =3D 1 << host->ios.vdd;
> +       switch (voltage) {
> +       case MMC_VDD_165_195:
> +               max_current =3D host->max_current_180 * 180 / 360;
> +               break;
> +       case MMC_VDD_29_30:
> +       case MMC_VDD_30_31:
> +               max_current =3D host->max_current_300 * 300 / 360;
> +               break;
> +       case MMC_VDD_32_33:
> +       case MMC_VDD_33_34:
> +       case MMC_VDD_34_35:
> +       case MMC_VDD_35_36:
> +               max_current =3D host->max_current_330 * 330 / 360;
> +               break;
> +       default:
> +               max_current =3D 0;
> +       }
> +
> +       return max_current;
> +}

I think it's way better than the current implementation in
sd_get_host_max_current().

Still, I still think it's weird to have three different variables in
the host, max_current_180, max_current_300 and max_current_330. That
seems like an SDHCI specific thing to me, unless I am mistaken.

I would rather see a more flexible interface where we move away from
using host->max_current_180|300|330 entirely and have a function that
returns the supported limit (whatever unit we decide). Maybe it also
makes sense to provide some additional helpers from the core that host
drivers can call, to fetch/translate the values it should provide for
this.

> +
>  /* Get host's max current setting at its current voltage */
>  static u32 sd_get_host_max_current(struct mmc_host *host)
>  {
> @@ -572,7 +602,7 @@ static int sd_set_current_limit(struct mmc_card *card=
, u8 *status)
>          * Host has different current capabilities when operating at
>          * different voltages, so find out its max current first.
>          */
> -       max_current =3D sd_get_host_max_current(card->host);
> +       max_current =3D sd_host_normalized_max_current(card->host);
>
>
> >
> > >
> > >         /*
> > > -        * We only check host's capability here, if we set a limit th=
at is
> > > -        * higher than the card's maximum current, the card will be u=
sing its
> > > -        * maximum current, e.g. if the card's maximum current is 300=
ma, and
> > > -        * when we set current limit to 200ma, the card will draw 200=
ma, and
> > > -        * when we set current limit to 400/600/800ma, the card will =
draw its
> > > -        * maximum 300ma from the host.
> > > -        *
> > > -        * The above is incorrect: if we try to set a current limit t=
hat is
> > > -        * not supported by the card, the card can rightfully error o=
ut the
> > > -        * attempt, and remain at the default current limit.  This re=
sults
> > > -        * in a 300mA card being limited to 200mA even though the hos=
t
> > > -        * supports 800mA. Failures seen with SanDisk 8GB UHS cards w=
ith
> > > -        * an iMX6 host. --rmk
> >
> > I think it's important to keep some of the information from above, as i=
t still stands,
> > if I understand correctly.
> I believe this highlights a common misunderstanding: it conflates the car=
d=E2=80=99s capabilities (i.e., the maximum current it can support)
> with its actual power consumption, which depends on the required bus spee=
d and operating conditions.
> The card will never specify or attempt to draw more current than it is ca=
pable of handling.
> If a current limit is set that exceeds the card=E2=80=99s capability, the=
 card will not draw beyond its maximum;
> instead, it will operate within its own limits or may reject unsupported =
current limit settings as per the specification.
> Therefore, the logic should distinguish between the card=E2=80=99s advert=
ised capabilities and its real-time power requirements,
> ensuring we do not confuse the two concepts.

I understand what you are saying and it makes perfect sense to me.

My point is, I think we need some more information in the comment
rather than the two lines below that you propose. It doesn't matter to
me if you drop the comments above, just make sure we understand what
goes on here by giving more details, then I will be happy. :-)

>
> >
> > > +        * query the card of its maximun current/power consumption gi=
ven the
> > > +        * bus speed mode
> > >          */
> > > -       if (max_current >=3D 800 &&
> > > -           card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_800)
> > > +       err =3D mmc_sd_switch(card, 0, 0, card->sd_bus_speed, status)=
;
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       card_needs =3D status[1] | status[0] << 8;
> >

[...]

Kind regards
Uffe

