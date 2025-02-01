Return-Path: <stable+bounces-111861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F239A2474F
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 07:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488A23A8688
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21D7081F;
	Sat,  1 Feb 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcO44HCz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAE191;
	Sat,  1 Feb 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738390717; cv=none; b=hljmhLAuY7uRHldIlA74QGl8pUsrV3tAA7348xSVy/RHsXMXR+wLErFppizP87xjtAYLi4WRwTTsHJAyml4wmeJxHs4F+AX6rYkOLV2dvM/NO+tPr3l2eM7YaOna4rKNA8R/9nfo9vb28zTI6jyrEJg8+PzfTNlWyKCRjPsfLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738390717; c=relaxed/simple;
	bh=yjtAijXbmoLFe0I5SwZNxph0SsQj7Ue/lV58vZxk7UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfi8bJn89y/hMrR2SxlxjO3u5pj3SluWFt/yn5kTLRvWc9rz4veZmvFDJ2M6MFacvVWpiykM93b5z/c9Hc6UUJsr6BpQ+QggzsZ4mwwi+tXlZIEs4aY6UlbNbDKqp4QGEWkDU5wQ0FM3wSml8JWUJofI1+DNXuJw6h2qo3tSy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcO44HCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2362C4CED3;
	Sat,  1 Feb 2025 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738390717;
	bh=yjtAijXbmoLFe0I5SwZNxph0SsQj7Ue/lV58vZxk7UI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VcO44HCzOKhCLqdkBpx4uLyusvwKtBe+3zbBzdaeQo1CET1g87HI99ty2YaqEsqOu
	 Qq5sdrTJO2boe85rMU3J7o9Xm1mvtRxTLPagb9mNR8xfUgZxOB8E1WlQy1yOLCHR6T
	 SBAUYEt8hyaQ1YsLP6GJFOH8SqFHT1lSRqMsPxI7Zr5Y+7ba2O/O+fnd7mcluEnZsz
	 n1jrX/yiJtM3cxToF9QxQYffpvn7h2E+XlZGMzwVcBGSGwrCsAoQcx0bSDfd+Fp+Mi
	 69kty+kdx2da8TJI3Q/nqePRH5QL43+/b75mi/m/ST/6viYI9b4CFv2IQ3CaLhFi0h
	 3DmjhZDSDsXIQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so3200317a12.1;
        Fri, 31 Jan 2025 22:18:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwPavv7AYWm5BNJFbt8DZTtMEtLCx7hIyR6ZoPlyCAfxWnpzxzvm/AOcM6sOJ79T7gwn/Prj95iAnx@vger.kernel.org, AJvYcCVr4jzzXG5nxUXsxU32gW4s9FEAqu+fZqhk1CuvXoF8J3ma5BwGO32VIIUsd+xf+CtfRFeh+WWF8tCBdG4=@vger.kernel.org, AJvYcCWDLaatCmXKSnp/ETmS0D7WskWB67FuqrJv70qsbojDI4YXBWy2X2SLcZFZj1Pzcr48GNHUB+2s@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlqosvvL0aDaQw2OUrJlOgRIxuvXtikP698+C8jT7oAWBivzS
	SZGpRA7Xbugcr8f7QOYChxI3Q71lQz6W9AqLCaiaNwF0j/4nRkZKVpgBnmyZrC3kgIk3FHVxRhV
	Bseo7DEPgacvBAnCmeuX8TSDSBRM=
X-Google-Smtp-Source: AGHT+IH/+Isujf7AoFj4Pd4Nf+NNmjAsI2oXk9D4/G5oGPGn6NUxSU1mxzzJfdburMy0CXZrzHhO3R5pFapg1hk1wMc=
X-Received: by 2002:a05:6402:3217:b0:5db:da94:6e7e with SMTP id
 4fb4d7f45d1cf-5dc5efebfa2mr16143644a12.24.1738390715476; Fri, 31 Jan 2025
 22:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131100651.343015-1-chenhuacai@loongson.cn> <b6a18bab-b412-443a-b39a-2194596ec79d@rowland.harvard.edu>
In-Reply-To: <b6a18bab-b412-443a-b39a-2194596ec79d@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 1 Feb 2025 14:18:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5F5zujP+=c9k7=Ce7-8+5fMS4NKuE2UqCx2SFk=g3nRA@mail.gmail.com>
X-Gm-Features: AWEUYZlp9uFXy8wQZ66kjksDaLvyIFFcyTFb-teq1-nkUk4v_0-f_38tjVg8XlE
Message-ID: <CAAhV-H5F5zujP+=c9k7=Ce7-8+5fMS4NKuE2UqCx2SFk=g3nRA@mail.gmail.com>
Subject: Re: [PATCH] USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Baoqi Zhang <zhangbaoqi@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alan,

On Fri, Jan 31, 2025 at 11:18=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Jan 31, 2025 at 06:06:51PM +0800, Huacai Chen wrote:
> > LS7A EHCI controller doesn't have extended capabilities, so the EECP
> > (EHCI Extended Capabilities Pointer) field of HCCPARAMS register should
> > be 0x0, but it reads as 0xa0 now. This is a hardware flaw and will be
> > fixed in future, now just clear the EECP field to avoid error messages
> > on boot:
> >
> > ......
> > [    0.581675] pci 0000:00:04.1: EHCI: unrecognized capability ff
> > [    0.581699] pci 0000:00:04.1: EHCI: unrecognized capability ff
> > [    0.581716] pci 0000:00:04.1: EHCI: unrecognized capability ff
> > [    0.581851] pci 0000:00:04.1: EHCI: unrecognized capability ff
> > ......
> > [    0.581916] pci 0000:00:05.1: EHCI: unrecognized capability ff
> > [    0.581951] pci 0000:00:05.1: EHCI: unrecognized capability ff
> > [    0.582704] pci 0000:00:05.1: EHCI: unrecognized capability ff
> > [    0.582799] pci 0000:00:05.1: EHCI: unrecognized capability ff
> > ......
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/usb/host/pci-quirks.c | 4 ++++
> >  include/linux/pci_ids.h       | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirk=
s.c
> > index 1f9c1b1435d8..7e3151400a5e 100644
> > --- a/drivers/usb/host/pci-quirks.c
> > +++ b/drivers/usb/host/pci-quirks.c
> > @@ -958,6 +958,10 @@ static void quirk_usb_disable_ehci(struct pci_dev =
*pdev)
> >        * booting from USB disk or using a usb keyboard
> >        */
> >       hcc_params =3D readl(base + EHCI_HCC_PARAMS);
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_LOONGSON &&
> > +         pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_EHCI)
> > +             hcc_params &=3D ~(0xffL << 8);
>
> Can you please add a comment before this "if" statement explaining why
> it is necessary?
OK, will do in next version.

Huacai
>
> Alan Stern
>
> > +
> >       offset =3D (hcc_params >> 8) & 0xff;
> >       while (offset && --count) {
> >               pci_read_config_dword(pdev, offset, &cap);
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index de5deb1a0118..74a84834d9eb 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -162,6 +162,7 @@
> >
> >  #define PCI_VENDOR_ID_LOONGSON               0x0014
> >
> > +#define PCI_DEVICE_ID_LOONGSON_EHCI     0x7a14
> >  #define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
> >  #define PCI_DEVICE_ID_LOONGSON_HDMI     0x7a37
> >
> > --
> > 2.47.1
> >

