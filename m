Return-Path: <stable+bounces-54879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076449137A4
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 06:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D60B227D2
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 04:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319D168CC;
	Sun, 23 Jun 2024 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6lODbS3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A7D518;
	Sun, 23 Jun 2024 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719117564; cv=none; b=q9Nt1LAB0dEOTrmb5mrLaHZU7jLrHXsEURw6Nu19vfxaWz4gclLkzVPBLl7lUsAvCaMw/D7xNpfj/bFKAJnXy/7e3o5tbDRSeQMj5FbltHrmHqrCPzs+WAuyJjGwTpS8TDr5R1G5mzgGUlc8fLgON/bNtauLK33mkqP2fK1t3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719117564; c=relaxed/simple;
	bh=EKy19ZjGn/aS+LlJEXMy4mVOfboYhqedqM97sjJR2xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcgQdHAt2Hc7XLYzBgj+EBsQpa8+qUeKD71y6mzFSJotl932rRsimkjFWZ/Ap5xxHGgKxUBlJsG228OQwVwLqk14joQ6uD1pW6KanjmCtAlacucrfRq+qPEzAG+p8XvLxLu1FnHrNZ8Q/WzfVi9h9S9nUjD6m+4NGRyqlYr9zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6lODbS3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9cc1d7379so662835ad.1;
        Sat, 22 Jun 2024 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719117562; x=1719722362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PnQ01roy4700N+vwuQEr8zP1UPIft7myTscZi49+x8=;
        b=R6lODbS3T39Ws+beurS7EirmOTPa4LSeR45JNrCxqiwlNuOiOM/AEpJuxZMJV+PBNy
         QtqLf0IIjU5cny3qYmTBxhbHZh57VCwN/uETp9BqQGxyQwXm9vxEBAcjuxxnkLFWjZLX
         vovliMhS8oWtSvKgkSbc5NZobYwhyAZjdvh7DIynLWLHQ1iemV7KHaqyNVceEwgCfxS+
         BM3wQ0e24v0QJJbzhAl0NkQt1yvHu1pZLuQewWcI+vYk3mNFnO26qMEupl66HM8UpJuJ
         mYT/oCy3z9G2tWiH907OVpkNhcDtXciUAyZ7jIquoLPJEYZO2qjoVC+vVG3RtukRDNY4
         rApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719117562; x=1719722362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PnQ01roy4700N+vwuQEr8zP1UPIft7myTscZi49+x8=;
        b=Lmki24jdqvQcjIuVTua3nC6wileuAX5hh7mvM8OuC+rCe5rYBjyjuyFCj1a4poGKUK
         keGKPKbo6LhGdZArTMFYfe4H7PIC9D3bcYgHQVURJ2KDQykn0/30Uy1lTaEpWPofzUQs
         jmO6EBlOhAUNb3LMR4pOIDaDMPeWL7yBDDNuY0/bUpVF2VtuKPvRrgA2LoyuiOSnnrYd
         RoHLnYYb0tcUfL0pHOnpbRwOwmC34wtpyyq0B4vhXHSR/yOTA6yrbcZ+V+v2DGytVu3D
         E6VqWg/CQ2bfePMf+YHDcip3zPnwISQikdif1RtujABbjjpRtPGAQzmWC7JkHm/DiZtq
         awWg==
X-Forwarded-Encrypted: i=1; AJvYcCXm7QVWZ8ieD/lLGc+nGVez6M01ZJMXVS++0nQM0qrYCZ8WFZFGlbxe5l2JzuOuYMtU6km0b1/MaLFy7zOoB8HooURvRjq9E2JTEDSyUhEsYFV1Q+0bcl9TrkVyCPtnCPf3UP8HPLnYbX9rEYVKAYCcGJ+AQ2S486A3zuLCViqo
X-Gm-Message-State: AOJu0YwxyZh88QfYu1c91LnmYPyWvtrOor9Jro39Bl8wQBOZGr1AAwcQ
	uCaV4Y/3rXz8QAJg7vjfi/2NIgeqP9y5f1Y52p7nZdZaVTK6HXiLgX6cLhzrPraeICLQZ1Oqu2Z
	aqW5U4gdPeF50azeUHWwH0ONQNew=
X-Google-Smtp-Source: AGHT+IEuu0QwsdejhKfPShJWJoz+ec41/6FyOZ32R9rp5sOVmGlXuGGSg68xJZLuEm99D/3jKPARtKqtkdMXQmY2yuY=
X-Received: by 2002:a17:903:234a:b0:1f9:b35f:65dc with SMTP id
 d9443c01a7336-1fa0d832226mr33410285ad.6.1719117561784; Sat, 22 Jun 2024
 21:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619054808.12861-1-ki.chiang65@gmail.com> <2024061903-shadow-pesky-1205@gregkh>
In-Reply-To: <2024061903-shadow-pesky-1205@gregkh>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Sun, 23 Jun 2024 12:39:10 +0800
Message-ID: <CAHN5xi2qy666O_SBkGb2SadRyPFPaxsk5HFH01bgSZTy05R6Sw@mail.gmail.com>
Subject: Re: [PATCH v2] xhci: Don't issue Reset Device command to Etron xHCI host
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jun 19, 2024 at 01:48:08PM +0800, Kuangyi Chiang wrote:
> > Sometimes the hub driver does not recognize the USB device connected
> > to the external USB2.0 hub when the system resumes from S4.
> >
> > This happens when the xHCI driver issue the Reset Device command to
> > inform the Etron xHCI host that the USB device has been reset.
> >
> > Seems that the Etron xHCI host can not perform this command correctly,
> > affecting the USB device.
> >
> > Instead, to avoid this, disabling slot ID and then enabling slot ID
> > is a workable solution to replace the Reset Device command.
> >
> > An easy way to issue these commands in sequence is to call
> > xhci_free_dev() and then xhci_alloc_dev().
> >
> > Applying this patch then the issue is gone.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
>
> What commit id does this fix?

Fixes: 2a8f82c4ceaf ("USB: xhci: Notify the xHC when a device is reset.")

However, this patch is a workaround for Etron xHCI hosts, should I add this
in the commit message?

>
> > ---
> > Changes in v2:
> > - Change commit log
> > - Add a comment for the workaround
> > - Revert "global xhci_free_dev()"
> > - Remove XHCI_ETRON_HOST quirk bit
> >
> >  drivers/usb/host/xhci.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 37eb37b0affa..c892750a89c5 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -3682,6 +3682,8 @@ void xhci_free_device_endpoint_resources(struct x=
hci_hcd *xhci,
> >                               xhci->num_active_eps);
> >  }
> >
> > +static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev=
);
> > +
> >  /*
> >   * This submits a Reset Device Command, which will set the device stat=
e to 0,
> >   * set the device address to 0, and disable all the endpoints except t=
he default
> > @@ -3752,6 +3754,20 @@ static int xhci_discover_or_reset_device(struct =
usb_hcd *hcd,
> >                                               SLOT_STATE_DISABLED)
> >               return 0;
> >
> > +     if (dev_is_pci(hcd->self.controller) &&
> > +             to_pci_dev(hcd->self.controller)->vendor =3D=3D 0x1b6f) {
>
> Odd indentation :(

Oops, one tab is missing, right? I will modify it.

>
> Also, that's a specific value, shouldn't it be in a #define somewhere?

OK, I will add a #define near xhci_discover_or_reset_device() in the same f=
ile.

>
> > +             /*
> > +              * Disabling and then enabling device slot ID to inform x=
HCI
> > +              * host that the USB device has been reset.
> > +              */
> > +             xhci_free_dev(hcd, udev);
> > +             ret =3D xhci_alloc_dev(hcd, udev);
>
> You are relying on the behavior of free/alloc here to disable/enable the
> slot id, why not just do that instead?  What happens if the free/alloc
> call stops doing that?  This feels very fragile to me.
>

These functions are helpers that can be used to enable/disable the slot id
and allocate/free associated data structures, I think they should be
called, right?

Or you would like to call xhci_disable_slot() + xhci_alloc_dev(), as in com=
mit
651aaf36a7d7 ("usb: xhci: Handle USB transaction error on address command")=
.

If so, I will modify it and resend this patch.

> > +             if (ret =3D=3D 1)
> > +                     return 0;
> > +             else
> > +                     return -EINVAL;
>
> Why -EINVAL?  What value was wrong?

I followed commit f0615c45ce5f ("USB: xHCI: change xhci_reset_device()
to allocate new device") to return -EINVAL, I think it means running out of
device slots.

>
> thanks,
>
> greg k-h

Thanks,
Kuangyi Chiang

