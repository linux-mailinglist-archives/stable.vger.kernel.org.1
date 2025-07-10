Return-Path: <stable+bounces-161546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EFAAFFCF5
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACBF6429C1
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E014E28D8FF;
	Thu, 10 Jul 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjhPiN7o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153F28C5CE
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137736; cv=none; b=V1Gn7rKL4s8DpZGT9x9NcuA1KE+b5HHu2EhlNkUNbQTSbXacJZxW9hdU2tCGOJHLwMaT9Uz3xGA5MZ8028zBokKhB32OpHRlnWffADzOu/O/f+wHfORKIhbEbk80aRvlXTo+01gDX7/tEPTP3mEtZr83sQ3XBWTnZ0lG0N/D5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137736; c=relaxed/simple;
	bh=YaLtdwlFm8Pp8FrAVenfUscodpXbZafUSMlYqOfSb20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhdJAUjWUKo2K6sIMxSZjHIEL4c/VXsdbTzPTjU5cpN+blCgmHoJdcAKN3+gxYE5lP/4czex09prrllDxz7s0TfssxzJtrmOe96mVtv9kR8Mvsr5620Z/yjlNUWbamDYnNIQcg7R+wIIu+vAezGunkunZt/IVeYctdy23+D/Iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjhPiN7o; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso554048276.2
        for <stable@vger.kernel.org>; Thu, 10 Jul 2025 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752137733; x=1752742533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TuZ56aBu1u+xu2PP1rjAbadZECnB88F+tV1akFcj7s=;
        b=bjhPiN7o5rLB1qQAS+mq0oHRXTIg8H/301ZaatZvNrF10q152PgpJhBQSeshnJpYY3
         h6KT6WYZfOyFdzr7Vlqke0WrdYzsCiaFl2c46FvytjM2quHDAj5lDnnM1NnmHL7W4ujP
         JFKHEmC/lVYKHzND6h2qp16IVGoHuMUby0h1wlY3Jh8TI/p9Ik4A2TwJ+G9Vy2FItSjY
         diLliq8UF93XHbm6Yl3uUKRa/2mq6XOVNG+r/0FRTGg1eTlTZkRwX2xdyi6J9QOiL+Kv
         BUiVGIaBGzydd/SZqwHU62IJ7qkEgi6xNZ6I9D7HbWplzh1ogb21RrriUcvs4XnSsrGI
         PTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137733; x=1752742533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TuZ56aBu1u+xu2PP1rjAbadZECnB88F+tV1akFcj7s=;
        b=dPxJAXEYnjnXawn66yNfXQvL7yPufbTEwqp6+FGHEpzYyWKoSn434Y9abcVbHhgaE5
         Frp8zlkqI5AHEuY+QlNm/8Uf4xGIZ1hD2ElYXQ2C1o0cF1IamoebBtlMZFcwuktVT5JN
         mLr0MDVfaONTswywBZSjo6VNrcR1i5riqI850Hg3Tmgx4Z3XLo3YLFWdKIpzPp6Bqzzt
         HcRWXJToRme3HcU8UO0W5mCI9ylN/Epc1WzyTlEkLXqnfQMzLjXajzazcdZJ6dqblcU/
         +7cD+08VwEUqtfG8RaYgrAq2QEqCLiEjJLaWL+pGGKTzhzp54Dr0KVqFoiqpxdvzygfN
         6U4g==
X-Forwarded-Encrypted: i=1; AJvYcCVIOgBCeRIwOVUAxIuf08NfxmkSx88l4qu8Tdufo8JBR/JlSrDrYqmPiksx0qD7mpRTwrvHYwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUa2efNw8jC0ZdRbVIlnSO1DrZi1eN4rPGXkI9LNWALVKuX66
	ZSNuAgTi6w6KRl+XQQ5YIp2UkiEluLJKobs8QoRGSQ7B1b2E1fCSjmukq9teh+Trxq0xpITiFK6
	mBHp8eml+WlQfPnKP1o2U00MU2auyrHa/woZTFhxYPg==
X-Gm-Gg: ASbGncsytIcKZy+lQ38PuP6GfD5O48WpxIGEB6f3kVgiL64W+4c5hux2J9Nq3xzOubP
	V0BJbsMto+6GHFh5y84BWmhgvHQHzRtMeZEW2N+fgwqnJfc4Jpq7DUiTUOjzAl2xertvvlyUUWj
	D5UuHSFdlJEzI1qKbEmO3kNLFaVUgykFNXH4f4XhI/4CV8+Zss7MQNHg==
X-Google-Smtp-Source: AGHT+IHpRL2f96J2shlr6yd/d20feDoo2GsONMoQSuHy/AWMYz2R16XYx1ueu1bLXtoc/tX9i+fwP4H2NzSFrMq0NXc=
X-Received: by 2002:a05:690c:3608:b0:714:13:357a with SMTP id
 00721157ae682-717c4797266mr24854187b3.20.1752137732579; Thu, 10 Jul 2025
 01:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-3-avri.altman@sandisk.com> <CAPDyKFrbjCi4VdEdeUoVG7wbgwXS2BcOZV4yzh8PiTc_V+rxug@mail.gmail.com>
 <PH7PR16MB6196923468505A9E81C72A69E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFooHB5b9YXhifr8XLbw5OB-Nk=eik0smtRbKLYkEOBRog@mail.gmail.com> <PH7PR16MB61968C1EEDFF40E26DF191CFE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB61968C1EEDFF40E26DF191CFE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Jul 2025 10:54:55 +0200
X-Gm-Features: Ac12FXwT52cMSLZxsnoKeWPoRMOLx6nSn-_e5ELZKtFgfGO5--wjl3MB67l7xQs
Message-ID: <CAPDyKFpiVFHhQwp8gyUMi+FHX6sWMqZdB6imOeGB255qpbK-KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit handling
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, 
	Sagiv Aharonoff <saharonoff@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 09:57, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> >
> > > >
> > > > >
> > > > >         /*
> > > > >          * Current limit switch is only defined for SDR50, SDR104,
> > > > > and
> > > > > DDR50 @@ -575,33 +574,24 @@ static int sd_set_current_limit(struct
> > > > mmc_card *card, u8 *status)
> > > > >         max_current = sd_get_host_max_current(card->host);
> > > >
> > > > Looking at the implementation of sd_get_host_max_current(), it's very
> > limiting.
> > > >
> > > > For example, if we are using MMC_VDD_34_35 or MMC_VDD_35_36, the
> > > > function returns 0. Maybe this is good enough based upon those host
> > > > drivers that actually sets host->max_current_180|300|330, but it kind of
> > looks wrong to me.
> > > >
> > > > I think we should re-work this interface to let us retrieve the
> > > > maximum current from the host in a more flexible way. What we are
> > > > really looking for is a value in Watt instead, I think. Don't get me
> > > > wrong, this deserved it's own standalone patch on top of $subject patch.
> > > I still need to consult internally, but Yes - I agree.
> > > Ultimately however, CMD6 expects us to fill the current limit value, so
> > multiplying by voltage and dividing it back seems superfluous.
> > > How about adding to missing vdd and treat them as max_current_330, like in
> > sdhci_get_vdd_value?
> > > Maybe something like:
> > >
> > > +/*
> > > + * Get host's max current setting at its current voltage normalized
> > > +to 3.6
> > > + * volt which is the voltage in which the card defines its limits  */
> > > +static u32 sd_host_normalized_max_current(struct mmc_host *host) {
> > > +       u32 voltage, max_current;
> > > +
> > > +       voltage = 1 << host->ios.vdd;
> > > +       switch (voltage) {
> > > +       case MMC_VDD_165_195:
> > > +               max_current = host->max_current_180 * 180 / 360;
> > > +               break;
> > > +       case MMC_VDD_29_30:
> > > +       case MMC_VDD_30_31:
> > > +               max_current = host->max_current_300 * 300 / 360;
> > > +               break;
> > > +       case MMC_VDD_32_33:
> > > +       case MMC_VDD_33_34:
> > > +       case MMC_VDD_34_35:
> > > +       case MMC_VDD_35_36:
> > > +               max_current = host->max_current_330 * 330 / 360;
> > > +               break;
> > > +       default:
> > > +               max_current = 0;
> > > +       }
> > > +
> > > +       return max_current;
> > > +}
> >
> > I think it's way better than the current implementation in
> > sd_get_host_max_current().
> >
> > Still, I still think it's weird to have three different variables in the host,
> > max_current_180, max_current_300 and max_current_330. That seems like an
> > SDHCI specific thing to me, unless I am mistaken.
> >
> > I would rather see a more flexible interface where we move away from using
> > host->max_current_180|300|330 entirely and have a function that returns the
> > supported limit (whatever unit we decide). Maybe it also makes sense to provide
> > some additional helpers from the core that host drivers can call, to fetch/translate
> > the values it should provide for this.
> +Adrian
>
> IIUC, you are looking for a host->max_power to replace the above.

No, the new function/callback should provide us the value immediately,
rather than having it stored in the host struct.

> However, giver that:
> a) there is no power class in SD like in mmc, and the card needs to be set to a power-limit
> b) the platform supported voltages can be either be given via DT as well as hard-coded and it's shared with mmc, and
> c) the platform supported max current is either read from the sdhci register as well as can be hard-coded
> I am not sure if and where we should set this max_power member, but I am open for suggestions.

I will certainly be host specific, so we need to have a host ops for
it. Depending on how the host is powering the card, it may need to do
different things to get the max-current/max-power for the currently
selected voltage-level for vcc/vdd.

I can take a stab and post a draft for it. I will keep you posted.

[...]

Kind regards
Uffe

