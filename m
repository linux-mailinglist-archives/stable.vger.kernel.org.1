Return-Path: <stable+bounces-126815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC7A727FF
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FEB3B9A3C
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A635224F0;
	Thu, 27 Mar 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBs2wdAV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F391119A;
	Thu, 27 Mar 2025 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743037626; cv=none; b=jNvUC3X9lPy/5FQ0NkcPGFtWtSXwawYNBJvJ4JrOyRJmVAzv7JGi5r40j1kf4QvSJYZheSLkGkXBkO2TisorAteVFJgI8TTXJckDOD75IGfC0cO1TYcqlgAoY6CiaprfYZGyxkxeEOlEkcW//joeTho5D3vL/ObpROIk89VOne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743037626; c=relaxed/simple;
	bh=0GQI5+ZmVpRyrSFOevHMXw860aRwr/2Ssj18xrBLxLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rmj7BwJZrjMgJv6nchesG3X5s2ct7LqEV2uj6LU3VR/vHQ6igrZXfvCkfP9uwqp7JFFGrgBTin3hBh6CXEK9Pxf/Pot+3An/7Rb5HmBazfxAKtQk3zQdQ3/nmx/pWLGWh2bK+FCoR0zCNYp3UhinWGCuNb950vqsyuLQV2MzpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBs2wdAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A140C4CEEB;
	Thu, 27 Mar 2025 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743037624;
	bh=0GQI5+ZmVpRyrSFOevHMXw860aRwr/2Ssj18xrBLxLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cBs2wdAVfgBjSDppTkOuqrQhVuE+OyMn2IAdvFUxNgCbW3t/Gf3577qkm+XBLicoi
	 PnPvhPhHTsXzuytHuSJfxY8NSsol9GyCKB3abAxfPzN/QPUC8h7SZ06xbtCgVXWIjV
	 e27m58RScDQ9y2i9dLV91bs9ky5sh71QycaqtZ3r4c19/VJBfSc2U+GL8dsnGHKNhR
	 wXSt7UAvyj0W2k+jaeEGxi2/57HsX0hiEjfxulMsJ3YN0ftCw8y/j3G0KBPmIj/qmQ
	 gSAI42ZEFHMpMeSZQaOGvONVdq25s1iA6f/RHTil+zBClXtsB6Xn7F4YuAFWQtbvme
	 x/BStjnU2JMZg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so653186a12.0;
        Wed, 26 Mar 2025 18:07:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvmgpJIZ8S/9bOPO21w/gS69JsaWEjvdcpSZ3KvyrkeLG+kEGT3ob1Ed1CsRK1MaaNbVecN34stXTsVnA=@vger.kernel.org, AJvYcCWZop2KL3oYIq9TqhOuuDC1ntBxDKzPPC49sBF2HHxeuNyE6YIakHp5aR2LImugPcCPICun1ddt@vger.kernel.org, AJvYcCXHCqG1EFd8st/Pe47KodHyzP6sqB/Xl/BwGNEzV3nHFRreRlqcaiJH/bvUFJTbNnm4MB6439hZ22ew@vger.kernel.org
X-Gm-Message-State: AOJu0YwsX5CS2mX96igmu3o3xnVTifWR81xx7lFcwM+2eB1kbA+xB6F9
	QCarTykJFL5HkTzDoEAgTS5+cSU3mSNZXyTZfGoFvpiNiXoffEEAJnC8nOXIMVCff+24Zc/yTcO
	ABbuT1VldqEjIYSkhUyQIjcuxmX8=
X-Google-Smtp-Source: AGHT+IFCKQaskcJ0YEf27xIxO3tFk1nEkoDNaI4E6/YZWbOpxyt19zyaCXeYbfXwfaqMj6tRTAI2rr9AtP3LFJh7vB4=
X-Received: by 2002:a17:907:7fa6:b0:ac3:17d3:eba1 with SMTP id
 a640c23a62f3a-ac6fae42902mr138462966b.9.1743037622978; Wed, 26 Mar 2025
 18:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326102355.2320755-1-chenhuacai@loongson.cn> <ab64291d-2684-4558-8362-9195cce1de07@rowland.harvard.edu>
In-Reply-To: <ab64291d-2684-4558-8362-9195cce1de07@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 27 Mar 2025 09:06:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5L5HX3UBem4t+goyK2HiUb0HWM8OJZhGw4Y7RtODLh6Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jo8dYzymK3cDoUqamW6-Hi5Ql2pJeLvuSkwV7A59HxDmbBd0McV-uaVYqs
Message-ID: <CAAhV-H5L5HX3UBem4t+goyK2HiUb0HWM8OJZhGw4Y7RtODLh6Q@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Mingcong Bai <jeffbai@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:11=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Wed, Mar 26, 2025 at 06:23:55PM +0800, Huacai Chen wrote:
> > The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> > MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> > keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> > only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> > is wrapped around (the second 4KB BAR space is the same as the first 4K=
B
> > internally). So we can add an 4KB offset (0x1000) to the OHCI registers
> > (from the PCI BAR resource) as a quirk.
> >
> > Cc: stable@vger.kernel.org
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Mingcong Bai <jeffbai@aosc.io>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/usb/host/ohci-pci.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
> > index 900ea0d368e0..38e535aa09fe 100644
> > --- a/drivers/usb/host/ohci-pci.c
> > +++ b/drivers/usb/host/ohci-pci.c
> > @@ -165,6 +165,15 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
> >       return 0;
> >  }
> >
> > +static int ohci_quirk_loongson(struct usb_hcd *hcd)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(hcd->self.controller);
> > +
> > +     hcd->regs +=3D (pdev->revision =3D=3D 0x2) ? 0x1000 : 0x0;
>
> Please add a comment explaining why the quirk is needed and how it fixes
> the problem.
OK, I will do it in V2.

Huacai

>
> Alan Stern
>
> > +
> > +     return 0;
> > +}
> > +
> >  static int ohci_quirk_qemu(struct usb_hcd *hcd)
> >  {
> >       struct ohci_hcd *ohci =3D hcd_to_ohci(hcd);
> > @@ -224,6 +233,10 @@ static const struct pci_device_id ohci_pci_quirks[=
] =3D {
> >               PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4399),
> >               .driver_data =3D (unsigned long)ohci_quirk_amd700,
> >       },
> > +     {
> > +             PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a24),
> > +             .driver_data =3D (unsigned long)ohci_quirk_loongson,
> > +     },
> >       {
> >               .vendor         =3D PCI_VENDOR_ID_APPLE,
> >               .device         =3D 0x003f,
> > --
> > 2.47.1
> >

