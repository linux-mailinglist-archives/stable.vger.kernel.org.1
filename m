Return-Path: <stable+bounces-60697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69900938F89
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB13B20511
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2216CD30;
	Mon, 22 Jul 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTs5rHgo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74503A8F7;
	Mon, 22 Jul 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653223; cv=none; b=UuOhTp9fh6YjDl1AL/ix5gNzIeQNxzaobowVhPv7Gp8StiGidpS1lwKmOFu4j5fetI/Ef8ilJC0INy6RzEI6cwk1QgwRhQ0FwY1CU/kH6PI20zMqImCybAFRecFORIYkJZ3uqYhXLZvtHiSZn2PPiaF93xNHQv7NO1BwP1jSW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653223; c=relaxed/simple;
	bh=1NWo5kuTSf6HFPQlaVFMwtg1JYv9jr1rp7z+2ZDzVbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdK0R+tox1xFsFQX5Ipx1/UbVKqB71plV3P2hutQn3b2rNTvM8Frr+WyAPfQWOxe4sNK66dbiwSZujKDdhba+DdU6KmHnTv/WpxJNnElwNHOKED6tUfR+OdC+IURX19xEKNUqdQt06RgW34F/CXg+LyTjStF1pAREq9h+3aXxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTs5rHgo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4267345e746so32038425e9.0;
        Mon, 22 Jul 2024 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721653220; x=1722258020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LsFpJZAJXkg/UmbQ07wX0fYqBIpr0upLgmexGhUi+U=;
        b=bTs5rHgo4HIFjLF4wMD3GOu1qbAE4mmYA342uieJuSUB9sBN8fLdAPFoq3Bw42FTOu
         TEs7W5vwBM3mjTNckBqgiiXilVCCLJOqTCI1E5Esb3lvkFi/pTh+2HtBnIXhE/e//BmH
         H7v9/lguITT6LU9WFIi/hlPe977LnOBG9ML8XSaBMtpVcSaHQrU1m895ibA3MXDWMbV/
         hbaQ6WQMzarGV6BlFu7liBjnjJldr5v+mdm62vsnHGD3crWdbHslcQuQ4P7dveQdqbj5
         5pq1ysljnKPGiRvAddIZ1Bk0XHZcwBy5iMxcyiqEiGklgsAe5xLOf28hDunDfHQ7DEEW
         R6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721653220; x=1722258020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LsFpJZAJXkg/UmbQ07wX0fYqBIpr0upLgmexGhUi+U=;
        b=bHVGkV85J9VOm6NGMgFtxBc5XDhcqNOWBfLG+vTc76ease3nsoh+RiGsB3eMuUDxA+
         USoUnmiJp+VMvE3WL9lJs3jDq0zP0JSsxmqA849Mt8q2ddFRED+2/W+zW0WfoZlVwToc
         2EeRGeJXzL1YUiBidETHnk9jrrRuRrjjK+7KU35AiURjMSU9HFLe9rkBt3+bkv6UDACZ
         5cKmb2jF7PhN7FJGMXITESyw1uQx4h9V1fm8FUoelA0GGaRlwuguEPiowlZh3dYMobkq
         rhA/wTG5uPLCe2aXHUliFQ2DNQGEzJuyrGjfePEeOZCeSBpidPEe6bZE6CW2BGHGUw/L
         2GeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwa5U9G1N2xbnKINYKAzgJnwojQPpKLoWdye7AqHgaLqPJFYg8D7r6lC02YODGyBC5I3Ph9IdG9M/H/2fF1xmBX3d+rii1AI6jSL8SDZnVgvp8DKknRq2G/bwbMNVQWbcGge5
X-Gm-Message-State: AOJu0Yw24ggETtxyH5KOCLj9Bz/6mS+D4l+/lrgq2EorytgrbBtJv3Bt
	45H8qDuNsEnN/NypskwBFQmbITQK4DSPxICsd0zS2c1py+ivlqsHZWgCisU056WCPjWzHDv5xE/
	CP055vAVPPFv1j9Rh+cWr12vviUU=
X-Google-Smtp-Source: AGHT+IHJqGppC1eemmJ5+BXpllc/ByXWAl0qMQ0EYCCaLCek+P5QHrtMibe37ZRcvzY45gK98tGBplzEFREywWglzkA=
X-Received: by 2002:a05:600c:4f0d:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-427dc512eb2mr40546405e9.3.1721653218905; Mon, 22 Jul 2024
 06:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721192048.3530097-2-crwulff@gmail.com> <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
In-Reply-To: <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
From: Chris Wulff <crwulff@gmail.com>
Date: Mon, 22 Jul 2024 09:00:07 -0400
Message-ID: <CAB0kiBJYm9F4w5H8+9=dcmoCecgCwe6rTDM+=Ch1x-4mXEqB5A@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Roy Luo <royluo@google.com>, Krishna Kurapati <quic_kriskura@quicinc.com>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, yuan linyu <yuanlinyu@hihonor.com>, 
	Paul Cercueil <paul@crapouillou.net>, Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 9:07=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> > From: Chris Wulff <crwulff@gmail.com>
> >
> > Make sure the descriptor has been set before looking at maxpacket.
> > This fixes a null pointer panic in this case.
> >
> > This may happen if the gadget doesn't properly set up the endpoint
> > for the current speed, or the gadget descriptors are malformed and
> > the descriptor for the speed/endpoint are not found.
>
> If that happens, doesn't it mean there's a bug in the gadget driver?
> And if there's a bug, don't we want to be told about it by a big
> impossible-to-miss error message, so the bug can be fixed?

Yes, this is an indicator of a problem in a gadget driver as was the
previous check for a zero max packet size. In this case, the panic
is in an interrupt context and it doesn't make it out to the console.
This just results in a system freeze without this fix.

>
> > Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket va=
lue")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index 2dfae7a17b3f..36a5d5935889 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -118,7 +118,7 @@ int usb_ep_enable(struct usb_ep *ep)
> >               goto out;
> >
> >       /* UDC drivers can't handle endpoints with maxpacket size 0 */
> > -     if (usb_endpoint_maxp(ep->desc) =3D=3D 0) {
> > +     if (!ep->desc || usb_endpoint_maxp(ep->desc) =3D=3D 0) {
> >               /*
> >                * We should log an error message here, but we can't call
> >                * dev_err() because there's no way to find the gadget
>
> This will just hide the error.  That's not good.

The previous check was also hiding the error, and introduced a panic.
I could add a printk to that error case, though it would be unassociated
with the gadget that caused the problem. This function does also return
an error code when it fails, so the calling function can check that and
print an error.

>
> Alan Stern

