Return-Path: <stable+bounces-111823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C99A23F3F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EF93AA511
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825591DDC3A;
	Fri, 31 Jan 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwpm/ieK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357541B6CE0;
	Fri, 31 Jan 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334807; cv=none; b=HckLbITvDAHX6Y76tiIE2a8QNWhkdG0OMNny7AK1lnAjPJTFfe3e6ChopHPAuUSVkLzOw3w4n7XKbYmIr5qy24Foqj+FGE4xQAmt7Hf8wDDs4dYFGiUcd0pICCU0F/WXuJgKcqezT+1gk7VFjGHg37dNCFAywPNk74moRVbRjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334807; c=relaxed/simple;
	bh=+C8b+XWdcnnMzbneWIM03ZUgjtV2rOh+jarlxZxFwJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN2LSsAH7EJswHB5fr3uyZPv495Z9VE0hIzwrwoFU4cQIF3ODcazUsOmRQ7SWyKBT5i/EWRV5qXpK1N92DP3qomZjSKym/npKcaEqO2CeTnjPoWImRZWRg/T6fzIFkfDLD/VkJ98758QhFD6Wuswt9zOZkytlRU1QedP0Bt8FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwpm/ieK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07FBC4CEE4;
	Fri, 31 Jan 2025 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738334805;
	bh=+C8b+XWdcnnMzbneWIM03ZUgjtV2rOh+jarlxZxFwJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bwpm/ieKS65IVF2RVvG4tQmoDiv2lfHUuo/5ZFWCOginQInWjyirEjIlLJKUxyvWk
	 3fn6xkFYcQ77KbxNU3W19F6xB3H0l3WRwlNLDJdoRREHQ9hAqT6vGl08btDTrkugyo
	 TFDK5lr0BpwkMyE5I1ogJm9FWwHn3nMDsOtdLg7dWOxxKdr3mEBxv8CKOIQJH0yD2z
	 T84/uCYLaBofhpG9GsdpFaVGjcwD2H2fgGhiQOKhaa6ukmF6p8aBUNJw7kQ0JDYPR7
	 oGg1lU8BXFgYep/7/VRb+cBT2MOr/7j4TAkxOZix8+oIp0YKJL/8RZ393o0QQuETpQ
	 68GGGJR68KxXQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso2568007a12.3;
        Fri, 31 Jan 2025 06:46:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUNwRdh2uBvSpAGeFPRPD0fwnQVOgSnc3qRYCMspAhBkQz9ysGHWp+9wwM5xuP4mCrTv1dJCPm1uNc@vger.kernel.org, AJvYcCUmLkOaDGb7wxJMW6Os2o25cFJ6l38YwY0ieUNley8BwLstBxLh6/BfJHoqS7nFsheZ50JS3r3f@vger.kernel.org, AJvYcCWz//NV8thVd+OgR9WXB4DKWczhqqJy1X5yhEzOZdPXYdfkH/5fM0rOkj49zgKlIdFcPQIElgkYwK41Og0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipCdMQ1sfQP99QfpdhP+QEAR+NUQV0IuJJBDG82m8peVW3Nzl
	1ZrgyczIea8EzCHVoTeoNxiVSv1VTndEdE5lP9xU1sNHGGAmGO/Eye2u8L/hWQb47WhrCu+oU1n
	Vv1MdQOuq881YSYJr+uRRMgRJoZQ=
X-Google-Smtp-Source: AGHT+IHeD+XZIEIcDS6hEieGNSfg8VINqJhcEkeIkEJOgCdQFBtKYL/Ih4R5Ovr6H/BOoh6QqbcHfYYXJ9clDUv7sPk=
X-Received: by 2002:a05:6402:51c9:b0:5db:e91a:6ba4 with SMTP id
 4fb4d7f45d1cf-5dc5efc67fdmr11961819a12.19.1738334804211; Fri, 31 Jan 2025
 06:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131100630.342995-1-chenhuacai@loongson.cn> <2025013133-saddled-reptilian-63c3@gregkh>
In-Reply-To: <2025013133-saddled-reptilian-63c3@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 31 Jan 2025 22:46:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7PXUd6BaoKqgJ-3g=+m9wLnXqEzya8++c5RM3c6Kafhg@mail.gmail.com>
X-Gm-Features: AWEUYZnpeBAkX4DkxJerhYwHbZ4fZdPhlfQ5DbZbzFuHGz2k9uj3j3JRqL9a8xQ
Message-ID: <CAAhV-H7PXUd6BaoKqgJ-3g=+m9wLnXqEzya8++c5RM3c6Kafhg@mail.gmail.com>
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg,

On Fri, Jan 31, 2025 at 6:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 31, 2025 at 06:06:30PM +0800, Huacai Chen wrote:
> > Now we only enable the remote wakeup function for the USB wakeup source
> > itself at usb_port_suspend(). But on pre-XHCI controllers this is not
> > enough to enable the S3 wakeup function for USB keyboards, so we also
> > enable the root_hub's remote wakeup (and disable it on error). Frankly
> > this is unnecessary for XHCI, but enable it unconditionally make code
> > simple and seems harmless.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> What commit id does this fix?
It seems this problem exist from the first place (at least >=3D4.19).

>
> > ---
> >  drivers/usb/core/hub.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index c3f839637cb5..efd6374ccd1d 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3480,6 +3480,7 @@ int usb_port_suspend(struct usb_device *udev, pm_=
message_t msg)
> >                       if (PMSG_IS_AUTO(msg))
> >                               goto err_wakeup;
> >               }
> > +             usb_enable_remote_wakeup(udev->bus->root_hub);
> >       }
> >
> >       /* disable USB2 hardware LPM */
> > @@ -3543,8 +3544,10 @@ int usb_port_suspend(struct usb_device *udev, pm=
_message_t msg)
> >               /* Try to enable USB2 hardware LPM again */
> >               usb_enable_usb2_hardware_lpm(udev);
> >
> > -             if (udev->do_remote_wakeup)
> > +             if (udev->do_remote_wakeup) {
> >                       (void) usb_disable_remote_wakeup(udev);
> > +                     (void) usb_disable_remote_wakeup(udev->bus->root_=
hub);
>
> This feels wrong, what about all of the devices inbetween this device
> and the root hub?
Yes, if there are other hubs between the root hub and keyboard, this
patch still cannot fix the wakeup problem. I have tried to enable
every hub in the link, but failed. Because I found many hubs lost
power during suspend. So this patch can only fixes the most usual
cases.

Huacai

>
> thanks,
>
> greg k-h

