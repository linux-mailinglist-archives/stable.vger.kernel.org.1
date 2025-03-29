Return-Path: <stable+bounces-126993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50792A75529
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 09:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00733AFFE1
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F719B3CB;
	Sat, 29 Mar 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx/mZjrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3F5D477;
	Sat, 29 Mar 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237669; cv=none; b=tFbGZIPpAjrcPZF6aMeERjsLBKjsjK/vGXbacNK3SBYlOTJjQqVVZLBfD2z1q/9Ly/V3uce2ivP8P5CmUcNPLNIBx1BObJ5N2a6ulCZ/0HNmV0cOkSmsY7yzDdCGd8IYr7G5Dx573KZ2rcscf5ZY0Ag0pTcaxqG364h8GQ8w2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237669; c=relaxed/simple;
	bh=Zxi4fz242TKRMcLWwMnqMDyq07mgpNk9ykRalU4MaA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOJ1N0sklWAm52i1FTxDAWsTt6XK7HIaYECGcdGWflBRf5dGAq/t7OCkUOU8fBqKldXr9s0rFk5LO12PbHZD8DjUlsRwPUWAKegEauPMJK2g9RRJTDTKVuTfCYI5JkV7zhTikaTTGA/vUnrUFbaWH5VOaRRuXRnuxoE/c/ytjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx/mZjrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDFAC4CEE2;
	Sat, 29 Mar 2025 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237669;
	bh=Zxi4fz242TKRMcLWwMnqMDyq07mgpNk9ykRalU4MaA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zx/mZjrM6XqTziTy4RNGn0HVSEcxkhfXOeQCNfYvlSZZiEnuOKpvNsTq82xlA8hRn
	 LbRs532AIIcDZ/RkQJriwX+XNIeEfJ2Ip4JCw0HGkujPwcRC+4Ys5+oeo3REgNpuTG
	 le8ktQt7eDzaqcHFiO7r2yiqk/gp3mm2q1X62kPgySJEAlrVfxV71BNxeFGatrAhRQ
	 6UdcVXJaq87kmDu/aArGCIKEVSH1bDf+5jRZFhusGYSAJ/0fkb4NBGDb4hB2yOAkCQ
	 6HQ1pGAJxfOxAQXNl+x+FoqE8WIav2byeSAAYWDXZkPJ1dUobUuNHm852mot0D+Tv4
	 s1oL/yqaxhVUQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so4722786a12.0;
        Sat, 29 Mar 2025 01:41:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe2ow4tLo9fFV0iXyIFsnSzP2khsk7L9TCHX2eMyIscKr8HO7JwtWO7zH+d3rIMXC5HGIuVfms@vger.kernel.org, AJvYcCWPLhSBvx1SSEp62udXDcfOWfGH71gsapekK0aYDcKToBHUObTkyi04dH8UWLgbb+bDnKzRA4KtKtnDww4=@vger.kernel.org, AJvYcCXGZcnMrlf7wwudloKf0xDOEOY9xmwOFcToxLWB/HoBb2+ydA5WM4Jwi3JDWfdMbm4nqK6PhehabTQP@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeRCs2llyRmLEn7t20nxFnVhZ4tQN9ICG6a5LHEe5J6LfyvJk
	0ZIHZxnBV9BXwH57Z3fmpjLxO7LG6vhaxII0X+FZ+Ooseu5T6bAT7aMSQ8AlGpUDQMBjrgqdVih
	j+HWi2J/LuF0mJ13e5sYkOY0Xk20=
X-Google-Smtp-Source: AGHT+IGv/udn16XAHP7Zs4N/IrBN03X4HvrPUNd9Z/faAOhZLawsyjO76H/1B0YEPwmuaU5XcM20zJcmJKmgAZJmeY0=
X-Received: by 2002:a17:907:9693:b0:ac6:ff34:d046 with SMTP id
 a640c23a62f3a-ac7389ea430mr192916366b.2.1743237668046; Sat, 29 Mar 2025
 01:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327044840.3179796-1-chenhuacai@loongson.cn> <208f5310-5932-402b-9980-0225e67f2d66@rowland.harvard.edu>
In-Reply-To: <208f5310-5932-402b-9980-0225e67f2d66@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 29 Mar 2025 16:40:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4aitynD20EEWQhF_uv79+1nw7sKxzd7c_+009oY63tEg@mail.gmail.com>
X-Gm-Features: AQ5f1JpMjO_6Um_SuZ1zMErU5UTbjicHozY5ADRdcNCOEzMWygBf3AVFsRaYCIg
Message-ID: <CAAhV-H4aitynD20EEWQhF_uv79+1nw7sKxzd7c_+009oY63tEg@mail.gmail.com>
Subject: Re: [PATCH V2] USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Mingcong Bai <baimingcong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:13=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, Mar 27, 2025 at 12:48:40PM +0800, Huacai Chen wrote:
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
> > Tested-by: Mingcong Bai <baimingcong@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: add a comment explaining why the quirk is needed and how it fixes.
> >
> >  drivers/usb/host/ohci-pci.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
> > index 900ea0d368e0..bd90b2fed51b 100644
> > --- a/drivers/usb/host/ohci-pci.c
> > +++ b/drivers/usb/host/ohci-pci.c
> > @@ -165,6 +165,24 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
> >       return 0;
> >  }
> >
> > +static int ohci_quirk_loongson(struct usb_hcd *hcd)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(hcd->self.controller);
> > +
> > +     /*
> > +      * Loongson's LS7A OHCI controller (rev 0x02) has a
> > +      * flaw. MMIO register with offset 0x60/64 is treated
> > +      * as legacy PS2-compatible keyboard/mouse interface.
> > +      * Since OHCI only use 4KB BAR resource, LS7A OHCI's
> > +      * 32KB BAR is wrapped around (the 2nd 4KB BAR space
> > +      * is the same as the 1st 4KB internally). So add 4KB
> > +      * offset (0x1000) to the OHCI registers as a quirk.
> > +      */
> > +     hcd->regs +=3D (pdev->revision =3D=3D 0x2) ? 0x1000 : 0x0;
>
> I'm sorry, I should have mentioned this previously but I only noticed it
> now.  This would be a lot easier for people to read if you wrote it as a
> simple "if" statement:
>
>         if (pdev->revision =3D=3D 0x02)
>                 hcd->regs +=3D 0x1000;
>
> Otherwise the patch looks fine.  If you make this change, you can
> resubmit it with:
>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Thanks, V3 is sent:
https://lore.kernel.org/linux-usb/20250328040059.3672979-1-chenhuacai@loong=
son.cn/T/#u

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
> > @@ -224,6 +242,10 @@ static const struct pci_device_id ohci_pci_quirks[=
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

