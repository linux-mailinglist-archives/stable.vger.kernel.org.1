Return-Path: <stable+bounces-111821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5DA23F21
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313ED168E91
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E51CF284;
	Fri, 31 Jan 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9+wSyXw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F81C5D4C;
	Fri, 31 Jan 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333733; cv=none; b=Is5Nf4EkoL8Koojrv+E9vi7/Zea4AbIUMcP2NHSGtJrCh5eeb4yrv0xDqOc1dSNMDF+3hgsz1cAvr5+JVGqn0pjVRo6byOuf67GC85bpwFTFDYYq7klvZzyVc1iCHjAVIgHwHAlMQHbWfaEDMmeJIOaD8UZyKIsTGo3W2Igh/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333733; c=relaxed/simple;
	bh=A9muo+en6T68s7TNl988exsaw5hAsdSDQpNNPFl10qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9DDau0ndgDDJDp6qHMCQFYrsWTJb6B6JHw0wwGGJlhMUNUiFWIrNfTkl9d7eqsjMX9I6JepP7rBMdZtZwArVziW2uB1rdWM5pj0B7LWUxIycccbW99mGbO6lUe3VaEywERYusdtCtktYPdq6KmA9iMWS0ywaPpFR7UoPwMPdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9+wSyXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD556C4CEE3;
	Fri, 31 Jan 2025 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738333732;
	bh=A9muo+en6T68s7TNl988exsaw5hAsdSDQpNNPFl10qM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n9+wSyXwDlsjNIEC6UIthBDz//Yl85KzqQ+bK9GGL7jqcEyqcINSskkdysBO0XQbl
	 MnbxPdP43bx2hXYWiSrqRtSXpXfhdPNV9Yk4US6S4VbIiPcoC48kePGem8maeeft9s
	 xm1vNBpZ3/RbIfEfmFgCZszqcH6eLZw1SZe4y8Rm/lzzUC/MLwn/lQ3yamD2Pi9YgG
	 XZ6Te8qAigWJBuHMOsMZhZU35TLPPYFvIgmaq+uue48kxYq1LEfPb+DGvOia4Hd0jA
	 uzlencmoC5xlPqFnYQiNH0mWY1/DiQlcsxiubuhvSubtSiJ3MfkN9l9etdx4tuL5W/
	 ga23B2BHTxT7A==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so3884862a12.1;
        Fri, 31 Jan 2025 06:28:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcclQAJwtotPmZ1iNbIuAT3wQwWaMP6Wiwu/7KS6KDLOzWa4yIdq9d7uR67UQ3uJwK461M5Vnd@vger.kernel.org, AJvYcCWzDvkqBeKx3dm+VUQOr1lIXjPD/Z0J6G7CZBjZaIQI+NOURK69NXip08SUgKN+ThzNOM05ETxNYIQy@vger.kernel.org, AJvYcCX3UXLEvghD4UnclzPiKMYTuuWPdMgxi+ByZgqG8VGetO1EiyXY8ZGURyOMq5ewqYmn4h9pUko8PbHw0Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6IV2u3zpYjWBYlbHX4vJhMVNVAA0oLYS8EYT4YhahgznOwbl
	VSRUCPaTyLHXCEvkMcEPPB3FrtXxJ/nCUykVzk1+wnktHA6fwHQs5VJ4Ej2V6hNXZkSnbwmoFgI
	WN2goLdlxSVtfG3VILS3U5pnrWd0=
X-Google-Smtp-Source: AGHT+IEUQQntaQTqJSLkFPH0tGJX/gR+KgBuOx+Lx2taIdYSwdqfNiv9Yak3PI3h35yIGKbORAZ2/iVlRL1+6RkGiuo=
X-Received: by 2002:a05:6402:84d:b0:5d0:bdc1:75df with SMTP id
 4fb4d7f45d1cf-5dc5efebbb2mr10651841a12.24.1738333731438; Fri, 31 Jan 2025
 06:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131100651.343015-1-chenhuacai@loongson.cn> <2025013107-droplet-reset-127e@gregkh>
In-Reply-To: <2025013107-droplet-reset-127e@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 31 Jan 2025 22:28:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6DS=Vne9O-pLdfUki7tfJPdwB3CWbCDH5ejypWCnsM5A@mail.gmail.com>
X-Gm-Features: AWEUYZmfIXd5UQSR65fYRELf4Z4SYd6T1UR_-wZsgCtcjWU2irrd7qCjQcPLu1Y
Message-ID: <CAAhV-H6DS=Vne9O-pLdfUki7tfJPdwB3CWbCDH5ejypWCnsM5A@mail.gmail.com>
Subject: Re: [PATCH] USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Baoqi Zhang <zhangbaoqi@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg,

On Fri, Jan 31, 2025 at 6:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
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
>
> If you read the top of this file, does this patch meet the requirement
> to add this entry here to this file?
Emmm, the device id is also used in
drivers/pci/controller/pci-loongson.c, but uses another code style so
it is not suitable to share the definition. Maybe the best solution is
use 0x7a14 directly.

Huacai
>
> thanks,
>
> greg k-h

