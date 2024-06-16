Return-Path: <stable+bounces-52300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22483909B9F
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 07:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B571C282D6F
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 05:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711A163A97;
	Sun, 16 Jun 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WATgfDnj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3923A48;
	Sun, 16 Jun 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718514031; cv=none; b=tB+b8ZB3CsmOZZg8dbacaBrSRaFXISclJYdjtpVoO765HGN5gQTJa3dSMnE+BwsXYUVZTF1GHBpKgOZ65i/7ToDIfAWICNQxWmRaJfAzYXPORWNHIuf7lXRp5d+qYHOgKoo2zl3/j2pN+GhkeF3OKGoS1nVw2gNiVhyLnlXSpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718514031; c=relaxed/simple;
	bh=dFvpCqY5+2CFNbC8zPegnePsXfdNUaa2ytim/4/5cto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+bemQSZFV4bva8WRI0znoVnxcRIcPIXh3prBTRNyiAyx1QjLtumzsO0vRNLraHTPQDO+YAA/LUkFubrd4N7ncgMy5aLBeYkhVlttjM9H3QoOK1jgBcodmCGliwAylqZ61jP1BA4wdRhcVr+1FrXVfbXk7BFU51XJwr3XtEMFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WATgfDnj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6e4f97c1eso2848025ad.0;
        Sat, 15 Jun 2024 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718514029; x=1719118829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=113P9Hj54jdtOkzxrNklcEm6xaBaWSPktCNILIwVJS0=;
        b=WATgfDnjNIFbnU5tX/wxy+rYwWUTqKz4cD06y5oWREiTM0E296BBwZbMM36llIM3uX
         Ckvu80t0m0H7A6b4a2P+RB1akryR2U+2CnNtBa1xz3Cp8aECRWsAF/KDJcUX1tMrioQ1
         FJRp0LDm6ooBdLtNcQee3+sdIRUtygjZdjPKeu85g5RgjfNjU0/7HJ2HyXBYOJyMYp5a
         FyVJVZLkd1Dzz/P0b8XlVjI6oWPlxfRz74pD+SvNYnrytsjn7tUw26ugPrSF2QQlyMjI
         oFm7jRlDJbugvdKdEjEL6EOP1Pp+M+0WGCm5JZxxClS8wixxQgjKt7/YAfmJ/mZL41pY
         HX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718514029; x=1719118829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=113P9Hj54jdtOkzxrNklcEm6xaBaWSPktCNILIwVJS0=;
        b=bNE6kYOgJ6l1Ysm9FMwThStqfvHh4/nn4EkU7nYZdrQ4r1kgdyXKX6ciGnWlDCUyxA
         r5XI4L4wu0OVs5Wzyq8ghWwT57SyYI0pagUOUQzj6O1RjO2wGHw/h+Y3FV3lQ5rYMyK9
         4kWDSCuZdyGva8zZ1paxOB9eg/ctfSnOzYrnOzBPLEe+RgYXFl2QFCoWgDe39xLB+ByO
         v3Ulv5Lq3eSAhomEvnQkH3ILkLn+9/4lRxZE4r9yvYOqFTj/IJfWWEH2xkOZ5Wz0NM7t
         LWaeUnvF2/SLJ587Oxes/yodAI0IwuBlCT1skB8yRzepCrnHdu6ZkZCe5Fof4Ltj5ttI
         lE3A==
X-Forwarded-Encrypted: i=1; AJvYcCVONjWZqaqAXo7IllDdoO6A7KLDP52YeUOUI4RLBsF+LulzJLP2R0GvUsLi7+xaMe5NIljK53jQHYsiFiYVuXNCu56hbYLsGF4akV5o/ZPgylro2Prcd6cowrP0a8RUyPeiuKDzLzbDrESPbuae6rIVjBRneO6cRSKt+Q/VOPMI
X-Gm-Message-State: AOJu0Ywmlwa7BZfnMxS2wj0e00zfRf8VymbwNjGQp9ZK9ifrWXW/DPAi
	BFD9ZJtE/UtoP/8onoLvv+3ZGMBptveP3AF95GRPsBlaV9uFJpgBvj26EPiM7pCQvLswXGsepyo
	z3XEF9quhIRQ0ZsO9nA583L4QVbE=
X-Google-Smtp-Source: AGHT+IHspohlVfmzYBUO5l9J2tinMfXgfa5zFkBLq4QhznzM1N9UhS2DZbiCB912P60XIt7ruGyiYi9YGKtdQmO8zhk=
X-Received: by 2002:a05:6a20:da98:b0:1ba:f7a6:ed61 with SMTP id
 adf61e73a8af0-1baf7a6f430mr4874116637.6.1718514028800; Sat, 15 Jun 2024
 22:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612022256.7365-1-ki.chiang65@gmail.com> <2024061227-cruelness-unwind-13a4@gregkh>
In-Reply-To: <2024061227-cruelness-unwind-13a4@gregkh>
From: =?UTF-8?B?6JSj5YWJ55uK?= <ki.chiang65@gmail.com>
Date: Sun, 16 Jun 2024 13:00:16 +0800
Message-ID: <CAHN5xi169fOtgkAOd3Kc=DO2oUjZipZ-PMY7EQ60JJO699pQWg@mail.gmail.com>
Subject: Re: [PATCH] xhci: Don't issue Reset Device command to Etron xHCI host
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jun 12, 2024 at 10:22:56AM +0800, Kuangyi Chiang wrote:
> > Sometimes hub driver does not recognize USB device that is connected
> > to external USB2.0 Hub when system resumes from S4.
> >
> > This happens when xHCI driver issue Reset Device command to inform
> > Etron xHCI host that USB device has been reset.
> >
> > Seems that Etron xHCI host can not perform this command correctly,
> > affecting that USB device.
> >
> > Instead, to aviod this, xHCI driver should reassign device slot ID
> > by calling xhci_free_dev() and then xhci_alloc_dev(), the effect is
> > the same.
>
> How is freeing and then allocating the device doing anything?

To replace the Reset Device command, I found another way to inform
Etron xHCI host that the USB device has been reset, which is to issue
the Disable Slot command and then the Enable Slot command to Etron xHCI hos=
t.

The easy way to issue these commands in sequence is by calling xhci_free_de=
v()
and then xhci_alloc_dev(). Apply this patch then the issue is gone.

>
> >
> > Add XHCI_ETRON_HOST quirk flag to invoke workaround in
> > xhci_discover_or_reset_device().
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> > ---
> >  drivers/usb/host/xhci-pci.c |  2 ++
> >  drivers/usb/host/xhci.c     | 11 ++++++++++-
> >  drivers/usb/host/xhci.h     |  2 ++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index 05881153883e..c7a88340a6f8 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -395,11 +395,13 @@ static void xhci_pci_quirks(struct device *dev, s=
truct xhci_hcd *xhci)
> >                       pdev->device =3D=3D PCI_DEVICE_ID_EJ168) {
> >               xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> >               xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> > +             xhci->quirks |=3D XHCI_ETRON_HOST;
> >       }
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ETRON &&
> >                       pdev->device =3D=3D PCI_DEVICE_ID_EJ188) {
> >               xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> >               xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> > +             xhci->quirks |=3D XHCI_ETRON_HOST;
> >       }
> >
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_RENESAS &&
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 37eb37b0affa..aba4164b0873 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -3752,6 +3752,15 @@ static int xhci_discover_or_reset_device(struct =
usb_hcd *hcd,
> >                                               SLOT_STATE_DISABLED)
> >               return 0;
> >
> > +     if (xhci->quirks & XHCI_ETRON_HOST) {
> > +             xhci_free_dev(hcd, udev);
> > +             ret =3D xhci_alloc_dev(hcd, udev);
>
> Wait, why are you freeing and then allocating the same device?  That
> needs a lot of documentation here.

OK, I will add a comment here.

>
> > +             if (ret =3D=3D 1)
> > +                     return 0;
>
> And why does the function return 1?

xhci_alloc_dev() function returns 1 on success.

>
> > +             else
> > +                     return -EINVAL;
> > +     }
> > +
> >       trace_xhci_discover_or_reset_device(slot_ctx);
> >
> >       xhci_dbg(xhci, "Resetting device with slot ID %u\n", slot_id);
> > @@ -3862,7 +3871,7 @@ static int xhci_discover_or_reset_device(struct u=
sb_hcd *hcd,
> >   * disconnected, and all traffic has been stopped and the endpoints ha=
ve been
> >   * disabled.  Free any HC data structures associated with that device.
> >   */
> > -static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev=
)
> > +void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
>
> Why is this now global if you are only calling it in the same file?

Try to fix compile error like this:
drivers/usb/host/xhci.c: In function =E2=80=98xhci_discover_or_reset_device=
=E2=80=99:
drivers/usb/host/xhci.c:3756:3: error: implicit declaration of
function =E2=80=98xhci_free_dev=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]

OK, I will revert it and put xhci_free_dev() function declaration
near xhci_discover_or_reset_device() in the same file.

>
>
> >  {
> >       struct xhci_hcd *xhci =3D hcd_to_xhci(hcd);
> >       struct xhci_virt_device *virt_dev;
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 30415158ed3c..f46b4dcb0613 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1627,6 +1627,7 @@ struct xhci_hcd {
> >  #define XHCI_RESET_TO_DEFAULT        BIT_ULL(44)
> >  #define XHCI_ZHAOXIN_TRB_FETCH       BIT_ULL(45)
> >  #define XHCI_ZHAOXIN_HOST    BIT_ULL(46)
> > +#define XHCI_ETRON_HOST      BIT_ULL(47)
>
> Defining bit quirks just based on the vendor seems wrong to me, as that
> information can be determined when needed at any time just by the pci
> id, right?  So why is a quirk bit needed?
>
> Shouldn't the quirk bit say what the broken functionality is?  Same
> probably for the XHCI_ZHAOXIN_HOST, but that's not your issue to
> solve...

The XHCI_ETRON_HOST quirk bit is used to solve more issues
encountered only by Etron xHCI host.

Would you like me to check the PCI ID like this?

if (dev_is_pci(hcd->self.controller) &&
    to_pci_dev(hcd->self.controller)->vendor =3D=3D 0x1b6f) {
    ...
}

If so, I will modify it and resend this patch.

>
> >
> >       unsigned int            num_active_eps;
> >       unsigned int            limit_active_eps;
> > @@ -1863,6 +1864,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message=
_t msg);
> >  irqreturn_t xhci_irq(struct usb_hcd *hcd);
> >  irqreturn_t xhci_msi_irq(int irq, void *hcd);
> >  int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev);
> > +void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
>
> Should not be needed.

OK, I will remove it and resend this patch.

>
> thanks,
>
> greg k-h

Thanks,
Kuangyi Chiang

