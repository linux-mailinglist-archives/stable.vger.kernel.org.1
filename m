Return-Path: <stable+bounces-195110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E415CC6A4FE
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C23493862D4
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A38364EB9;
	Tue, 18 Nov 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mp+qZB6I"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E592264C0
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479805; cv=none; b=nJT3CiLb82FbOFdvMWPKB0fy9pj40KQhYXFeYfOZLprBaVrUh+vZk2sepkms9j/wmPs7xOWuZ8Bmn8/aMuivojhVJMglrxLgddH54dC3969Uzh53up2h463zic8Mj3evjii5+Cy2kC1VUt7IzSoBXzHWfnXqfIFXTNBlagtSU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479805; c=relaxed/simple;
	bh=+24wzuM2d6/z3za5a1bgC0s4AxWk02vt3UgqBsXcTlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AazgpVz79FmAHR4QQdB5aTbiPWUI2+iMrSbf0/Ia0cDx4i8RqAVZUWNbnCb4n+80QrpfBa8GpnDLLivJwr86rTYZehFSXW/pKekSXpVhglIQhySACRZHnPoohjZI/Zj9znSKsLe28+viSQpH7mwV8qFKm81AFDWweXijJgXSbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mp+qZB6I; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so6176111e87.1
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763479801; x=1764084601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn2Mbn8QjQbEvF6k9evaAStTuEpXTz+uPHt8wyM8qmw=;
        b=mp+qZB6IFxuGs/ZIOUbbwH2hkW+io5rL8djVbyeGARDShJHloy4ScEwrsHfC3tz06W
         28WQ+JKl3Qb60xmphyAYWpp/jjaFfmBzOS9A59IYgAE8YFPF/QC8cpJh26mWwvuYZxjI
         ciKepYk7HMBSynJjnqJI5jac1AoJSoi8faOZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479801; x=1764084601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rn2Mbn8QjQbEvF6k9evaAStTuEpXTz+uPHt8wyM8qmw=;
        b=hexkRaz0lPC1j7cptS2T+sa1sIIXQdFBlFqCipzR964Al4/61FXCU9aROGCLYN6Mil
         WzDBD6EVAYh6GiKEV7+8P45p78Myni3M1tSU1+0Fy17WqtHGs16iUXmfz1bOVhPk/f5D
         lUFl2MdSx1NyngOOvEzOPxP4+kLii8uJIrZlDnkSKxUx+lsfUzy8I0n3Wt2R9NRH2Tm1
         uSC5W69gWK/4L2kbQ/Nfu5bHmNM2m7Kyo3QG99jGnRRd/cmcpJ+ByucsmwpRnJwXXV1h
         bXTVaSlntGQBioQMYIIDOTXFOVd9lMkMw1W+kp3sp/6SZ/IP30P/eiznkJp9IrqlJaNn
         CZQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ASfFyO4NstSUESwLaaF0TECcqzLGksi56iqU8CqmL8FnLdQAfVNASy19oCsZDAIL2h2HUQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnW3n5Q6uIof+qKeRnk0v+xEn8PtkhNeWIRLkkrqSTT4CsdKG0
	2Qq3+3TiyijNNwHctKSz8advzUPsECExz0Azv/Yq6gTSQWrwzi3T8QfVmzh/+2vpJXhbd6VSGch
	86lCjQ4sKL46WNIChIbMHjTk/XsWFnKuQqqsPylNFc6Ex0jo+MFJ7lkA=
X-Gm-Gg: ASbGncsiSe6jwBDRXLaVvd7BwIDaTqgJwp6+YxdMpQ0Od1tZe60//SH74Rbo0sTk6i7
	3tb9eFbR7xFAvr5athtPd8LlWpzHJFm/DjWyoJEe5DNB8+bITbspwkUCaMFgbZWU0KdBmzwszjq
	xUfFas+wUT2Gucvy8gO4sbj11DIK6AL8u8H4N/th5i8PLS2/fBBUZrb8jrTKx+EjwNQWlOi2EKw
	FckVUKDHuGxJqo2GD47uY9RrqPDPT44Po06qL6iCQfGAOUCfSqha0+dXBwHz2LGieig+y10dVAK
	VdQDhSdlPbfClZuTfVlOqNQ=
X-Google-Smtp-Source: AGHT+IFFn0iZrBboNmpo+GWX933TjZSX5IzQqp3ykGo3xqUxB4suwykCgvLFrDK8JHzKa6iA2K0HWWhX6jwphVg8q2U=
X-Received: by 2002:a05:6512:acf:b0:594:5d87:af7f with SMTP id
 2adb3069b0e04-59598742395mr1159221e87.4.1763479801549; Tue, 18 Nov 2025
 07:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114150147.584150-1-ukaszb@google.com> <d25feb0d-2ede-4722-a499-095139870c96@linux.intel.com>
In-Reply-To: <d25feb0d-2ede-4722-a499-095139870c96@linux.intel.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 18 Nov 2025 16:29:49 +0100
X-Gm-Features: AWmQ_bmz55YLXjTAhJXuGphxL9YPobTssZXYQUGDPJV1iIgwZl4moU_XRjcmm0g
Message-ID: <CALwA+NZRXEGMsmjmEa1NUEO78yfw1CDz8tbc=zL=bhV6gRs5fA@mail.gmail.com>
Subject: Re: [PATCH v1] xhci: dbgtty: fix device unregister
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:23=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> Hi =C5=81ukasz
>
> On 11/14/25 17:01, =C5=81ukasz Bartosik wrote:
> > From: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> >
> > When DbC is disconnected then xhci_dbc_tty_unregister_device()
> > is called. However if there is any user space process blocked
> > on write to DbC terminal device then it will never be signalled
> > and thus stay blocked indifinitely.
> >
> > This fix adds a tty_hangup() call in xhci_dbc_tty_unregister_device().
> > The tty_hangup() wakes up any blocked writers and causes subsequent
> > write attempts to DbC terminal device to fail.
>
> Nice catch
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
> > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > ---
> >   drivers/usb/host/xhci-dbgtty.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbg=
tty.c
> > index d894081d8d15..6ea31af576c7 100644
> > --- a/drivers/usb/host/xhci-dbgtty.c
> > +++ b/drivers/usb/host/xhci-dbgtty.c
> > @@ -535,6 +535,13 @@ static void xhci_dbc_tty_unregister_device(struct =
xhci_dbc *dbc)
> >
> >       if (!port->registered)
> >               return;
> > +     /*
> > +      * Hang up the TTY. This wakes up any blocked
> > +      * writers and causes subsequent writes to fail.
> > +      */
> > +     if (port->port.tty)
> > +             tty_hangup(port->port.tty);
>
> I'm not a tty expert but would the tty_port_tty_vhangup(&port->port) make
> sense here?
>
> No need to check for port->port.tty, and it does all the needed locking a=
nd
> tty reference counting.
>
> It is also synchronous which should probably be ok as this is either call=
ed
> from a delayed workqueue, during suspend, or remove()
>

Hi Mathias,

Thanks. Good point to call tty_vhangup instead of tty_hangup.

Let me test it and if it looks good I will send an updated patch.

Thanks,
=C5=81ukasz

> Thanks
> Mathias

