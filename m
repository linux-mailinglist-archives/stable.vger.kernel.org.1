Return-Path: <stable+bounces-165621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33937B16C3A
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 08:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718AC7B5D8C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182D23BCF2;
	Thu, 31 Jul 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRx+kNx9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216B1C32;
	Thu, 31 Jul 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944794; cv=none; b=huSFROGv/e0h0Pmgu+6V6ypX8S2Gs44aaJ7doiiLU3eafb6IxlOnIxBnlKkFd7CdLWTNtkuhz4h/hA5VSNvqxscz40xK+DLzrGGyM/oVqYi2RUuGjigMRed8EcttzGXDaIGVARk495TxuqN6YDpwAGOYUd43W/I20FDVL/9omTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944794; c=relaxed/simple;
	bh=NuRNpPmfQpQpPNl9LAnFKhEpqDrLAxr6pfFbsTDayzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4kAFpBfhTs5+3Af/exjjoHVnPQMlnMXDKlUeNMGrS3hS0StL5ubRLM+O4wzX1tTA8s9KvxpH6K2dc5b9/BtM8LUUtLOuR9gzCUhokEPt/Vxr8TkomyDsAvMk4qg3x6z1Gso3ZTc+x67aPcn7YrBYpzlaKa48rjU0qA5mE8byBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRx+kNx9; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4fc070be397so20517137.0;
        Wed, 30 Jul 2025 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753944791; x=1754549591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDsiKJgU+PjPr0QN+TFdnYrJqJNkl3C/gJbgpR3qRFw=;
        b=CRx+kNx91APXmNpvRpG/yhFtbcBAa4sD2CAK+vwvqP3jBu+ZM8YJKeU24+W+ATbdFF
         ycWRiUh1DNea7vy3TNpKKTMM/p9QnQBYMaixvsAxZWnQB6PHRzcNIh6AdnfvnYZP1I1s
         dG2DBCz5oLx8/BP67GMX7cN7LMiYGmA1qfEo4+g7BB6yY8svz9GYb04B1/M4EbH5rtN5
         ZWhaJk7vLQLuaGdE7kIMUtyQRC5HJTVfHq7CJ99odiFP25RfVGkDUn96Iyl7JOt25T5l
         XhbmWtyvEQcm4FHIVERPdF4E71onNwJ38t2DlodlofE9j9stPiLTRINt4mannsxrcphJ
         zB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753944791; x=1754549591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDsiKJgU+PjPr0QN+TFdnYrJqJNkl3C/gJbgpR3qRFw=;
        b=MFGk8cdoYDdXssN0NltWDtvFUO7W9KLx4irLS+cwUJE+duqxjVXnXlBMQzRev+5mRa
         lhKZIpnBonfq8LNRtqmX1Om2lyDpakRvcRFb18Mil2soHRgPaRvwD6o77xrlOzXsUVc5
         MV9klQke2rRl42WQf9cQiJRiEgHUiWsh1kIaeB6/t9o9dQEZKwNryXYMDbLGYmjg/IDN
         nXYmiBBZMn6nOIqu1tTzEZ14BI/oY9qAzm6ALC9P8viYYkpQ5LjDyIEwprEcH1HI3kCd
         22+qQ4UuQAilyO4lFVwhHHnFVZe7rc25OMlav7ofvYuTXXCRB548F3tLP08fauZAe0Pj
         lyMg==
X-Forwarded-Encrypted: i=1; AJvYcCWFgR5mUz8LIZBZnVeTCgrZTV1a6R20DcR4awQT/L1ZsrenOqpCYSi+zR3u8ntn7lEFSUfGJ1HO@vger.kernel.org, AJvYcCWci96uDLwRqq/L440zRzOKBbCAD0Mr2/ZOpnITJuWRtVuMe+tEGmIK++StQxpWPbAXFcVZGx1T4BhVYjw=@vger.kernel.org, AJvYcCWlTwZ7cwQgYijqkf8Th24uehMzVrSD9xTgcI4bvRi1EVkcCorZXnD7eyULZWy0+EgVn3c3KFPsZhYY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9c8Ldr6mV8izymunLne2VOokf13M9uhCIX36UI/75c4kBCeys
	TCWKIoBKHJU8Z9T5hOYxCzqLSo9XGbrP7jHNa1X7DcuugRmfi5kpiInG26SUWuPBvwKRkURsKd8
	dNWfTW5LUtOFeLdHRGsd/bGHRTRtfWT0=
X-Gm-Gg: ASbGncvtJILb4CS3OfAocgiVTeh47aJp5oAhYMzpPG4bXaXjZHx6O6g6eEYyjuwzOS3
	JMkEJ9NPqmnbHLSeRCoAi6rRmVKXxdmEW4ghnMYof1saDoAHdaMC7iZrnxLFVJ5vW/Po9APlLLS
	T3PUSPkBcX9ueUqpqbCXdkAKam4Cz9OiLiQk3BNjdPoDyVGGY63Q6Jzslnh34QECzevQvima4R2
	OMIEeKZWcXx5YzGEpAvfLlS/PM/XzXPEDV2Q+M=
X-Google-Smtp-Source: AGHT+IGz8a3XvuOvN9SXPbHwDUVUyd/dEBzCYfI2ukTelfP0n0A+LLEA2Z7QdS8s4/fOgyg1o06D+MnHDG6W9NviHL4=
X-Received: by 2002:a05:6102:d8d:b0:4fb:372d:6d70 with SMTP id
 ada2fe7eead31-4fbe88f0fdbmr4324654137.26.1753944791138; Wed, 30 Jul 2025
 23:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729065806.423902-1-victorshihgli@gmail.com>
 <20250729065806.423902-3-victorshihgli@gmail.com> <a7ba16c8-e6ab-4ca2-bf7e-8719c469f59a@intel.com>
In-Reply-To: <a7ba16c8-e6ab-4ca2-bf7e-8719c469f59a@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 31 Jul 2025 14:52:59 +0800
X-Gm-Features: Ac12FXxeFzCbGeue7_tIbOif4MqPVo8LgGr3Blt_qFm7bwpp3quMP3Z07E0Jr6k
Message-ID: <CAK00qKAVAy3ZM-NwQ-y07LDsXsg91D2DRXrySGu=ufTE=Syztg@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] mmc: sdhci-pci-gli: GL9763e: Rename the
 gli_set_gl9763e() for consistency
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:54=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 29/07/2025 09:58, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
>
> Also needs to explain in the commit message, why it has a stable tag, say=
:
>
>         In preparation to fix replay timer timeout, rename the gli_set_gl=
9763e() to
>         gl9763e_hw_setting() for consistency.
>
> With that:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Hi, Adrian

I will update the commit message in the next version and also keep
your acked-by tag.

Thanks, Victor Shih

> > Rename the gli_set_gl9763e() to gl9763e_hw_setting() for consistency.
> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E sup=
port")
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index f678c91f8d3e..436f0460222f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -1753,7 +1753,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot=
 *slot)
> >       return ret;
> >  }
> >
> > -static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> > +static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
> >  {
> >       struct pci_dev *pdev =3D slot->chip->pdev;
> >       u32 value;
> > @@ -1925,7 +1925,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pc=
i_slot *slot)
> >       gli_pcie_enable_msi(slot);
> >       host->mmc_host_ops.hs400_enhanced_strobe =3D
> >                                       gl9763e_hs400_enhanced_strobe;
> > -     gli_set_gl9763e(slot);
> > +     gl9763e_hw_setting(slot);
> >       sdhci_enable_v4_mode(host);
> >
> >       return 0;
>

