Return-Path: <stable+bounces-161423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39743AFE695
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD92D6412F4
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7F28DB7E;
	Wed,  9 Jul 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGTpBrgr"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090F28DB7A;
	Wed,  9 Jul 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058267; cv=none; b=sOx4YPGtgudYb0ZSOK0QR9LQPcBT5/Jf44yece8eJycUagx7Cr/yVKfXTfbWCBB/gaqWq8fEMZL0TbPnapp85GFPpVGivGNTc9Ys8Yp4DcOOei54PML7hXhbd54Q1h5agN2LMqdccq3w4LV2MEe+dQxk/6YJgC9QaeUEa2AFPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058267; c=relaxed/simple;
	bh=H0pKKG3Vj13XMckfV9eMIOet3WbHEybTrrvm/nwzOJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ2brkflA+m8xti4lHLgRzvOVJR/jOJEpWKjaqq6e6jJvX12eG0qh15TPafP0Op9PW7butAipiVAqb6nnAf1XV/M8zH5Ac6Ht+F+rpDeaeFc0mR2pG9EFO2/wG2V+qXO65xig1sWeo/KMj5x94NpyXCtN4ZP27lmgtmeVxtumxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGTpBrgr; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso33286515ab.1;
        Wed, 09 Jul 2025 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752058264; x=1752663064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xbUpQ2Nx3t/Kf3f8fBQv7LXqgIs9cNM7iYZVp0gjKA=;
        b=IGTpBrgrUJrgIVSo9+NsSJy5FOlJc+oGUvDQpfR4VNE54O1SQUMun/e3KqTMPsyBP9
         4zCXlOSlv2+Z4r9Ho5YaZ/dbOiH5JUBWN9zrsUm4+UrApGYvfPuq5T+hpHIe5TQXChOR
         68XgrBQfhtmUbm/FsH0CkOUdrOzaTcKHbn2XrB6CWG3y6bfGd7trXLa0N1/YFd/JzMkM
         Mp77eMQasLXYfYvDOM6UKtNce3asNbkA57BZJgF8VwuV+3z+ITvXlVM9iPPCehLXpif3
         k0aalE/0f+B1M/1m9rnQK+q8UHepaFTWM1NearcyScaLMaGXDL5Mtx/l+WSfrSqypCBH
         VpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058264; x=1752663064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xbUpQ2Nx3t/Kf3f8fBQv7LXqgIs9cNM7iYZVp0gjKA=;
        b=jK6FhGoJiBdYxUpqhefEumeuv3b5NMAHILtG/yH00im46p3ulWbeZRK+LZTRcsVHso
         OatRHaF/VKJ3FRJjJvZwl1ndZad4+QpmI3ouqzYFbVsipxgEGdCeD2quJC0wGyV6Zp8/
         3HPyAjZ/a+hZtVfs8yVMg80303TGnjeigsxQxBroZH0UDpQoYnXr4iKBZdckN0Bjc/Iq
         ftgWUQUDVXyVc+7lVzjdH6g8idUkcR+7+T9eKYd/Z9HB3b8hshfEGakcZqd+h+5Ed8Ri
         h4GeqcN71JxAQuTMAiiuMXiSjRtkZWQJkK0zMy0kNwSfT8Hw8TE26EhWkRstEDkYb40l
         brdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhuib+9iNVzML+fIjjv1/zitSTjGg2tWKxhE9cIbL+LXfYSQtmqgPc1wGYTS1Dg4SANxF+f6Wk@vger.kernel.org, AJvYcCVgO6tzdru9eKNZGiE9Zzh45y1O4bjT+bWiERfXQku2i42JeFMmIQBWb9xLRf8B9kyThg+x370jcmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPUV31bP7AvzNb7mnQIcFnA9CJcisksPt/txSRa36dlXTItc2
	4rK6XD62HQ6/EanZsoMwhIRVXZSCY4VS0rsrBjdkLQ+8Noib3rP/opN3VKMCHuYDuwCH8EKKk1x
	HoWpB2asONMmQuSBptRmza/KCiCkOBGU=
X-Gm-Gg: ASbGncuz3cKG+oUVYwBrtcGBFhj2vwUUexTz9lfEQzgRhcH6px1eQM/EB5E6/zD0K3+
	eZuxItDNbsjFZPez5Hk88BP58gY5AmaCkBdTLHCz0PzoL3U1no3LX9zOoqxjdh2d5mXNKbobuaF
	T5PFtFMRPxqy8XkyRhT41hVei7GpAH/3Yj8ZkoKLv/+2eBvVYg3hCTvO89m/Xe+39omiN3v1x01
	XMRWzCHm2s=
X-Google-Smtp-Source: AGHT+IEFSoW+B1+7oB3wJZhreQgkrHubweHBF+iObDZ4Y1ree4yt7pSHem/NTEDeGXSQbgCwa9gQsXw0aBIJJpHxcYQ=
X-Received: by 2002:a05:6602:2b0e:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-8795b0e02e1mr226180539f.7.1752058264482; Wed, 09 Jul 2025
 03:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708120004.100254-1-fabio.porcedda@gmail.com> <aG4_jEQmeD9a_oWo@hovoldconsulting.com>
In-Reply-To: <aG4_jEQmeD9a_oWo@hovoldconsulting.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 9 Jul 2025 12:50:27 +0200
X-Gm-Features: Ac12FXwTIfThVpPgYkfJKHKhbXqf4iMpd0eNto6BDxwxRmFcFF5JzO8kdaV48_c
Message-ID: <CAHkwnC9tb=SZXsP7t8oeNPJ24pij4Y1ayFVRk6tqLhzc5zbsqQ@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 9 lug 2025 alle ore 12:08 Johan Hovold
<johan@kernel.org> ha scritto:
>
> On Tue, Jul 08, 2025 at 02:00:04PM +0200, Fabio Porcedda wrote:
> > Add Telit Cinterion FE910C04 (ECM) composition:
> > 0x10c7: ECM + tty (AT) + tty (AT) + tty (diag)
> >
> > usb-devices output:
> > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
> > D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > P:  Vendor=1bc7 ProdID=10c7 Rev=05.15
> > S:  Manufacturer=Telit Cinterion
> > S:  Product=FE910
> > S:  SerialNumber=f71b8b32
> > C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> > E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> >  /* Interface does not support modem-control requests */
> >  #define NCTRL(ifnum) ((BIT(ifnum) & 0xff) << 8)
> > +#define NCTRL_ALL    (0xff << 8)
> >
> >  /* Interface is reserved */
> >  #define RSVD(ifnum)  ((BIT(ifnum) & 0xff) << 0)
> > @@ -1415,6 +1416,9 @@ static const struct usb_device_id option_ids[] = {
> >         .driver_info = NCTRL(5) },
> >       { USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
> >       { USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
> > +     { USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),     /* Telit FE910C04 (ECM) */
> > +       .driver_info = NCTRL_ALL },
>
> Please just use NCTRL(4) here. (And remember to mention additions like
> this in the commit message in the future.)

Ok, I will send a v2.

> Or do you have reasons to believe the interface numbering may change? Or
> is it just to avoid matching on both number and protocol?

The interface number should not change, it's just to have a more
generic definition that matches also other pids for the same soc. I
think it's easier to write and less error prone because the interface
number changes based on the PID.

> Perhaps we should try to generalise these rules at some point in case
> there is some logic to it these days (e.g. 0x30 => diag and NCTRL)...

At least for this SoC it's just like that (0x30 => diag and NCTRL) and
all interfaces with 0x40 and 0x60.
My modification was an attempt to go in that direction.
But It's not a rule so Qualcomm may change that for a new PID or new SoC.

>
> > +     { USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
>
> Johan

Best regards

--
Fabio Porcedda

