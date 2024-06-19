Return-Path: <stable+bounces-53681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB85790E26D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA171C22918
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 04:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6661E895;
	Wed, 19 Jun 2024 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4rZD798"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C280A55;
	Wed, 19 Jun 2024 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718772440; cv=none; b=N3R0aLs/yIm76GyCJR4sXV80m92sLVMIVBXD9gIDMZJ2+j+Mcx9MCn0H3N5VEchJ3rGhNBORPcxTELk+yBZEtMbCwxyeEoWsXQdsXxtw/nK7NFzzFBN4gbOMR1fzpwVpXmIajCodGgSU3m77rEq0Zkip/+JbjhWf+Bi0uOUhRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718772440; c=relaxed/simple;
	bh=d9d8wm0XILO22EEOKsoXRbHEs5o16Ci8DS8VkSBFRV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpXHNNw9Qs9+wPgvM7sbwupCpUYeqLIFtUW1hcF5WVzAWalqGAvSG0fz+4pV940IBf6leqgdQCjMbVlyfBCGBPeFvVk78Ebjgi58P+mWBrRDznUJ5ha4+niRO0BBLRgbjD/1ZySZRptIuLL7PzfICa7rM8GVxJVm+JqXsaZ0epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4rZD798; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6cb130027aso417251566b.2;
        Tue, 18 Jun 2024 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718772437; x=1719377237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFYZTOZ1i60wYpSJpHKXpp4LfhFXLu3o3ztKqSZFNrA=;
        b=Z4rZD798885RwSH3dZH37FwKV7Ir2J1U9WNdM5M1uJZA8Cmgeyy6s5hrKx5s5wmKxn
         HjA0KgcgNtoIBSNTINi0gvsUa9LR8U6lgWpRu1w4bcQ5Soy+GNTAuvjLJCjIeBS05V7U
         sc0CJsioejoju3IWZohkSWyhfN2IN+SozihcaNq7g9DzXP/FpEUJesSL1qZrm2v8ny7G
         NbuLbdjLDqyg3pFOdMRgbVHwNX2nwWWMPhIMXKJME1q1Jzq24pkmDg0NaYo3qCpiaS31
         in/WDvVsR0t7g7RXSY4TL7les8xd8S4EqoXVdiirudAdcxI97CF8XG4LbA3IwieAUHIt
         UzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718772437; x=1719377237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFYZTOZ1i60wYpSJpHKXpp4LfhFXLu3o3ztKqSZFNrA=;
        b=GrT98C0mNHiyXkkiVQ3RfZaGMsDCh+nvo50nqhreM9brJ6H+XKWy23+sphWi3tGqge
         Qc8p1toH9QTUD/P5NgrQM5gL317Bdm1RS8LwCjiff4mlpZrBGM+3H/WsUfF4zcnuuiJi
         umrBM8Sg/BqXcMKSxkRFsJvON8h5yDR4dXFRfSQW7Y65HCaPhZTOLE712c8TepgWQD88
         +cjMUDuLQUAg8WAZ3bnasuEQTSb+wsyslA/5pQipcAeQw4PAUyjR4B0+gilMZbryg+yn
         HPIwobzhtCEEHE6PQg9KNcWM9GpiECuIjdQcevCH4RGCFEMXKJ1KWfkSGWy0HZG4K5RZ
         1KFw==
X-Forwarded-Encrypted: i=1; AJvYcCXauzC1hJy/Wh1TzgoKi2oRaoLVP6K4Q8sNvYgKgBG9qUYAoyNTBRJZy3POwJ8M3XItK7js6zd3YUdRnUg2nynwsbDPaJpaELKs3QhqFRbYoSPiLOAig8dpjXfWzcI8uCoUIfcfFjsFbRYPHvfdpZeK8BaDJLQoCTHY5exTTZV5
X-Gm-Message-State: AOJu0YwwgMlwy4QwqS/3npaksQ6OAKSG8c4ndS3EF0Y1+CljwXjFlUug
	3a3EoUXGZex+UNHOTRHQqLeKslAXLFcbI7L8c7/vgBFO0etzNz60bKsLh67FZbnzaF+FeqED3I6
	tAyuQxL+8pvmqq0t4TcVha+bipVk=
X-Google-Smtp-Source: AGHT+IGayy0M1sCNBfpVfISAbFW9VwDUdtz0F2xK7PjCYR0vbbF3DPWdhYycnwHgXp6Jm/A4OafhCs6RL6eCRJnqTTU=
X-Received: by 2002:a50:9f2b:0:b0:57c:a7dc:b0dc with SMTP id
 4fb4d7f45d1cf-57d07e0d41cmr778576a12.4.1718772436293; Tue, 18 Jun 2024
 21:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618124235.5093-1-joswang1221@gmail.com> <20240618213156.s5r7z7zg7q2dilre@synopsys.com>
In-Reply-To: <20240618213156.s5r7z7zg7q2dilre@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Wed, 19 Jun 2024 12:47:04 +0800
Message-ID: <CAMtoTm24GiEdqOx54TCh3DUXnOnWWAYOkohgXC9c2KenZxOjOw@mail.gmail.com>
Subject: Re: [PATCH v5] usb: dwc3: core: Workaround for CSR read timeout
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:40=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Tue, Jun 18, 2024, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v4 -> v5: no change
> > v3 -> v4: modify commit message, add Cc: stable@vger.kernel.org
> > v2 -> v3:
> > - code refactor
> > - modify comment, add STAR number, workaround applied in host mode
> > - modify commit message, add STAR number, workaround applied in host mo=
de
> > - modify Author Jos Wang
> > v1 -> v2: no change
> >
> >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 7ee61a89520b..2a3adc80fe0f 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -957,12 +957,16 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
> >
> >  static void dwc3_core_setup_global_control(struct dwc3 *dwc)
> >  {
> > +     unsigned int power_opt;
> > +     unsigned int hw_mode;
> >       u32 reg;
> >
> >       reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> >       reg &=3D ~DWC3_GCTL_SCALEDOWN_MASK;
> > +     hw_mode =3D DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > +     power_opt =3D DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
> >
> > -     switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> > +     switch (power_opt) {
> >       case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> >               /**
> >                * WORKAROUND: DWC3 revisions between 2.10a and 2.50a hav=
e an
> > @@ -995,6 +999,20 @@ static void dwc3_core_setup_global_control(struct =
dwc3 *dwc)
> >               break;
> >       }
> >
> > +     /*
> > +      * This is a workaround for STAR#4846132, which only affects
> > +      * DWC_usb31 version2.00a operating in host mode.
> > +      *
> > +      * There is a problem in DWC_usb31 version 2.00a operating
> > +      * in host mode that would cause a CSR read timeout When CSR
> > +      * read coincides with RAM Clock Gating Entry. By disable
> > +      * Clock Gating, sacrificing power consumption for normal
> > +      * operation.
> > +      */
> > +     if (power_opt !=3D DWC3_GHWPARAMS1_EN_PWROPT_NO &&
> > +         hw_mode !=3D DWC3_GHWPARAMS0_MODE_GADGET && DWC3_VER_IS(DWC31=
, 200A))
> > +             reg |=3D DWC3_GCTL_DSBLCLKGTNG;
> > +
> >       /* check if current dwc3 is on simulation board */
> >       if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
> >               dev_info(dwc->dev, "Running with FPGA optimizations\n");
> > --
> > 2.17.1
> >
>
> Why are there two v5 patches? This will confuse reviewers. Please create
> a new version on every new submission however small the change is.
> Please send v6.
>
> Thanks,
> Thinh

Sorry, I will submit v6

Thanks=EF=BC=8C
Jos Wang

