Return-Path: <stable+bounces-177713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF4B4378E
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 11:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A1F3A4B2D
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BB2F9980;
	Thu,  4 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2ZuVh1I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFD2F8BD3;
	Thu,  4 Sep 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979387; cv=none; b=dfsfg/bcn0wBQbZ0K2dxQZymAI+ezpHSxWz7vG3wqb7fPLPLpTHlQViVM2Mh24tk8Yd+FKVN/sY1+ETNxwxW4a/yl5TvxbeqeFDypW1vKpnHf5suqO7Shbpq5+d2fStDiEfc710ZVESLdSmRSFoadkEHUB3wGZ38w3Qq0bcRNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979387; c=relaxed/simple;
	bh=tlQQ4A8SaD2iscfk1wzIkweYD5icMB5K/XilKna4f7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZDbuICGRCMtGTjeSfbE0nnEXSrqY8GSAcly/b4q2CtwG3KgASUugW85lepfq+QMdvMcFcRmzlBwk2wlwY2HOsbx/+0z5R1Xuju5kzYjCm8mQga/UfOp1xc/Ca2E2MVoadSmx23C078rZjS4BJZyzF1fePy8FHNwRcxIBukI5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2ZuVh1I; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61e3b74672cso1807886a12.0;
        Thu, 04 Sep 2025 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756979384; x=1757584184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJbNOvdwkGYJ/Frmp0x806yVuX/X2QwoxXLiar6zoiw=;
        b=c2ZuVh1IOKdeLiDCIry4bCGIjotN0bkASA8vpHTXTLsEzCkTC3dIGhEYjkTrJgyN7M
         T6tJ8PCBvHcPSs62P+HBoKYg1kt9RyD6f0TVpHD91L0nTfQKT43R1KfEwa+3XQK+F4hm
         6he5H8woHlUIvcKr0D1orelL6CwAJoKAvgLHJUDShP0i53OnJ10YB9lHxgpy+4O0RCYQ
         90nZ84esi+pljgcrr8FByREtuteb/AbiGMV1ZdFBZmBq1BYWQcUcyL8bpUP3X89dv8MW
         Qjns595bg+vDGPXHWJWfrkVA6eynr+Ymbe/jdX9tNnkYmETddGJpasKLfpUIQEsHzqWY
         9GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979384; x=1757584184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJbNOvdwkGYJ/Frmp0x806yVuX/X2QwoxXLiar6zoiw=;
        b=KIgHH6mcSR45zn10KLbHxCwEqwlZqg6RLhSJjpGVrmwIPjLubZRoeVivqm7A+kPJQK
         VXxuGx8Jy3wC21XOTIBOPtKVPBXuUmL4We4PpNnhhRq3DATCHtfZI1JY3V7Dl9LhNsSA
         KeFdwkPnkqyn9bMFaxK+WxBjuN17jjfl/kNaMf/hgIjks9kGLPwv3v73GnRIP2yGv+3l
         jHh2e0iFATBeulfSppoDtAKp9HAJ8qW5BgCpOlScQe3JDNpJVW+uEHncolvZ3gjfshpP
         tnNzg/JfpV28HLUEsJOSqWuH4noalzjdjczxa468f79FI6JkFw+x8FkAeMiyn9SPY13i
         OLaA==
X-Forwarded-Encrypted: i=1; AJvYcCUwS65O4PuLiCdZTxiSV4BF/EgoNAL89n1HhoIcGbjFUXWFqi03YZ8qVXaauziQGp75xj6BmEnR1iA9@vger.kernel.org, AJvYcCXOo6CcuN7QamoGdRZXPKqqA+p4ipVmHUnC5SkTionyVrNnLBFeMXL1S8m2juOe8N6T+3xtpSyS@vger.kernel.org, AJvYcCXSEn3g3BvfGvK+LWqVZZAlEiY7nFyFITYUsyZ840kJP21JT36ZSkL1z6uooQbSSyV+6Otnb5ILMZIYYj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EtSMnLfu//oVwEvAyn2oYRmOAqVhE6poXpSNovPvbf5VhWCG
	aSbdsDEG5B7Jq933w4X7sVH0JKx2iWOmDqrLyiNQAO0iqd49hPBDBCGYufv8sdw6Pg048UeaPkt
	cEGB9G/I8vKeI+/HGVKHa+kLYRKmQ1Ag=
X-Gm-Gg: ASbGncvD7f3ohR0eeNAE0WiaJCWH8VBdYbKotsYQ3RdPpb84DWhHssNFIqTRjys2fNj
	5yk2fNmDNSreKY7gCnryKHKU71+zZ0m+5xdD6tWyekNa/I6Y543nE86dg+lfs7Yl6PZabtUhj+c
	R22MMrXBxDM3eEGH/Qm/LP5gYLfKSPicBOaMOuW2zVN1gGBQPsz2zrSv6USSz+8Wj6RMY3d/MNL
	MQAzll3KVQyGOxxeQ==
X-Google-Smtp-Source: AGHT+IEym0TH2z8qEFt9WsYQjUjil/LV/1cr0gI187BMwtPUNK+/X4B9HHmhicxhhHBU3epGxzmnQxouyxtZCL40q+M=
X-Received: by 2002:a05:6402:5252:b0:61c:899d:90cc with SMTP id
 4fb4d7f45d1cf-61d26d5bc94mr15686461a12.11.1756979383629; Thu, 04 Sep 2025
 02:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901094046.3903-1-benchuanggli@gmail.com> <86721a4f-1dbd-4ef5-a149-746111170352@intel.com>
 <1aaeb332-255e-4689-ad82-db6b05a6e32c@intel.com> <CACT4zj8LxG_UeL22ERaP4XVwopdSjXz7mH95TyxXJ==WKZWHLw@mail.gmail.com>
 <416be416-014c-4efb-9f85-8f7023dcdc3f@intel.com>
In-Reply-To: <416be416-014c-4efb-9f85-8f7023dcdc3f@intel.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Thu, 4 Sep 2025 17:49:31 +0800
X-Gm-Features: Ac12FXzUZFrC1mTCqdAH4oDlb8uBabI8RAGNPVWv2KxPMYvodNfo0WIwG8me464
Message-ID: <CACT4zj9ttNfa4FkeBQS+CRsTRuq1apqYqGUmr9xyzU2RgTsV8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	SeanHY.Chen@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:15=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 02/09/2025 09:32, Ben Chuang wrote:
> > On Tue, Sep 2, 2025 at 12:50=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 01/09/2025 15:07, Adrian Hunter wrote:
> >>> On 01/09/2025 12:40, Ben Chuang wrote:
> >>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>
> >>>> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() wh=
en the
> >>>> vendor defines its own sdhci_set_clock().
> >>>>
> >>>> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> >>>> Cc: stable@vger.kernel.org # v6.13+
> >>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci-uhs2.c | 5 ++++-
> >>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-=
uhs2.c
> >>>> index 0efeb9d0c376..704fdc946ac3 100644
> >>>> --- a/drivers/mmc/host/sdhci-uhs2.c
> >>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >>>> @@ -295,7 +295,10 @@ static void __sdhci_uhs2_set_ios(struct mmc_hos=
t *mmc, struct mmc_ios *ios)
> >>>>      else
> >>>>              sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> >>>>
> >>>> -    sdhci_set_clock(host, host->clock);
> >>>> +    if (host->ops->set_clock)
> >>>> +            host->ops->set_clock(host, host->clock);
> >>>> +    else
> >>>> +            sdhci_set_clock(host, host->clock);
> >>>
> >>> host->ops->set_clock is not optional.  So this should just be:
> >>>
> >>>       host->ops->set_clock(host, host->clock);
> >>>
> >
> > I will update it. Thank you.
> >
> >>
> >> Although it seems we are setting the clock in 2 places:
> >>
> >>         sdhci_uhs2_set_ios()
> >>                 sdhci_set_ios_common()
> >>                         host->ops->set_clock(host, ios->clock)
> >>               __sdhci_uhs2_set_ios
> >>                         sdhci_set_clock(host, host->clock)
> >>
> >> Do we really need both?
> >>
> >
> > We only need one sdhci_set_clock() in __sdhci_uhs2_set_ios() for the
> > UHS-II card interface detection sequence.
> > Refer to Section 3.13.2, "Card Interface Detection Sequence" of the SD
> > Host Controller Standard Spec. Ver. 7.00,
> > First set the VDD1 power on and VDD2 power on, then enable the SD clock=
 supply.
> >
> > Do I need to add a separate patch or add it in the same patch like this=
?
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 3a17821efa5c..bd498b1bebce 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2369,7 +2369,8 @@ void sdhci_set_ios_common(struct mmc_host *mmc,
> > struct mmc_ios *ios)
> >                 sdhci_enable_preset_value(host, false);
> >
> >         if (!ios->clock || ios->clock !=3D host->clock) {
> > -               host->ops->set_clock(host, ios->clock);
> > +               if (!mmc_card_uhs2(host->mmc))
> > +                       host->ops->set_clock(host, ios->clock);
> >                 host->clock =3D ios->clock;
> >
> >                 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK =
&&
>
> It can be a separate patch, but the whole of
>
>         if (!ios->clock || ios->clock !=3D host->clock) {
>                 etc
>         }
>
> needs to move from sdhci_set_ios_common() into
> sdhci_set_ios() like further below.  Note, once that is done, you need
> to add "host->clock =3D ios->clock;" to __sdhci_uhs2_set_ios()
> like:
>         host->ops->set_clock(host, ios->clock);
>         host->clock =3D ios->clock;
>
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3a17821efa5c..ac7e11f37af7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2367,23 +2367,6 @@ void sdhci_set_ios_common(struct mmc_host *mmc, st=
ruct mmc_ios *ios)
>                 (ios->power_mode =3D=3D MMC_POWER_UP) &&
>                 !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
>                 sdhci_enable_preset_value(host, false);
> -
> -       if (!ios->clock || ios->clock !=3D host->clock) {
> -               host->ops->set_clock(host, ios->clock);
> -               host->clock =3D ios->clock;
> -
> -               if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
> -                   host->clock) {
> -                       host->timeout_clk =3D mmc->actual_clock ?
> -                                               mmc->actual_clock / 1000 =
:
> -                                               host->clock / 1000;
> -                       mmc->max_busy_timeout =3D
> -                               host->ops->get_max_timeout_count ?
> -                               host->ops->get_max_timeout_count(host) :
> -                               1 << 27;
> -                       mmc->max_busy_timeout /=3D host->timeout_clk;
> -               }
> -       }
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
>
> @@ -2410,6 +2393,23 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mm=
c_ios *ios)
>
>         sdhci_set_ios_common(mmc, ios);
>
> +       if (!ios->clock || ios->clock !=3D host->clock) {
> +               host->ops->set_clock(host, ios->clock);
> +               host->clock =3D ios->clock;
> +
> +               if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
> +                   host->clock) {
> +                       host->timeout_clk =3D mmc->actual_clock ?
> +                                               mmc->actual_clock / 1000 =
:
> +                                               host->clock / 1000;
> +                       mmc->max_busy_timeout =3D
> +                               host->ops->get_max_timeout_count ?
> +                               host->ops->get_max_timeout_count(host) :
> +                               1 << 27;
> +                       mmc->max_busy_timeout /=3D host->timeout_clk;
> +               }
> +       }
> +
>         if (host->ops->set_power)
>                 host->ops->set_power(host, ios->power_mode, ios->vdd);
>         else
>

I will add this as a separate patch and modify  __sdhci_uhs2_set_ios().

Best regards,
Ben Chuang

