Return-Path: <stable+bounces-52234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A69091FF
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4352C1F240FB
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91C19EED1;
	Fri, 14 Jun 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVfKxho2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813FD26ACC
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387325; cv=none; b=Xju++R5yGJbXIgi94LVchbD/PQO70oIW9otJ5CqTxboeiEJcPLruc97SZtNqGTR0wtGlqCGyOY1cWdj3CnjJPLFGQ3oiEc/vEkcEsaYbC0IbT2DXKhJe1oVlf4nZhJStt6gBqTfJbMYC1iFv654lVMjbZCr2QRrsSyA18CwI2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387325; c=relaxed/simple;
	bh=92J8SyqxIdf2oE6L5pTOUXazVSTyJnFiR/byTfNtl/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPXHGWr1+L1XabWsUJiI9eWs4PaOrllM2ogCrz2Ez2r+588mI9WcksI1VcmHECsSNlziBP2eD/P2tw7miGkBJWTsDySh03CK+tknQJlt9KmDs+Xb4R08MBDXRaPDZwTNdIVBMuKqaJyj9/2o6rxoAhiKhrVjViViVdrSr3BWBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVfKxho2; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so2616104276.1
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718387321; x=1718992121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/1LOPv92dlO9DKKyPTS9cPz+tBToHnqWBwgmZh3nDw=;
        b=AVfKxho2HOkrGPN0M2Zq1/bMxgOLQz3fhN/A+DC8VLDeHkJ4h8xH8y5VYOEJSaXA0x
         6CTgNtmppB0wrfbKpiKzclvhGgrAZ6ZnXYoM4Gt+fjHT6u0OVSYj1Yyqlae9QBafSq+U
         cZXTQegp5zEF1XrMocEEg2J6sZzjW03LsyE8wycbf//X5vfOV9aT3eer4N2caGvdgYkg
         M7Fc9nzEpVJQbpxWxvLPsq49PYoBEu8WI6VYEgr0FGPgDsUVIVo/TR/o9EDkBTB9iieu
         6jbUfUX7eLKCiIwe+2hFVmAAKJGfXExDpYg2ICmVrmP9siuqKI0qfkawhgEBe99mOhrG
         0pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718387321; x=1718992121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/1LOPv92dlO9DKKyPTS9cPz+tBToHnqWBwgmZh3nDw=;
        b=vjIh77UHj6g0kRQlQsu6/zfU99iLkrzyP5aW/CdSDx3ayk66+sSCchNFFI2FXqSXFR
         MP5YnMEc/ZqQIxCXLCF4+AUP5xMKGUHLZFe4nJUG2z4QlYDh/TIHMLDg0F2zXURRaC/3
         QA4SBIpaZP9YNVU+U/MLxeksWXeBiBuRFurA7Dyf/5VmQ9d076Q5iHHTi4BgG0g7tjIl
         axn7IBiafHLvkU/BzjBQqZou2Mf779bXO8ANdW7xt35jDLSIauYv/WmPJefc9s/wJX4t
         KKbbde2ohE7nlzksg9zQiJhKebstGmvlQfB8ogvCcbStRrG0zYiOSh5XFpUedd3xMPz6
         Dmsg==
X-Forwarded-Encrypted: i=1; AJvYcCUL/klB++UJcyJzslkkWpQ/OORNX0CqwuDs0c826jbBy6/ehcLN4ut32akAxJX25r6pmFT6bU8f8tKC3dV9qLfZ+S8fekBr
X-Gm-Message-State: AOJu0Yx4jMc6f4x2JDRsQA4qfT/TMwLMH/IGT4zf0H/NGPZQEHxQhLti
	uFBkzwwzG4QA7/Abk2kjzv7THKQ2ns04LgJO779fTI4odZ04xXLOe81/shswX4tDVi0KzojhMSA
	7RCnhNWRAO5bksSMIYR0y5I4meexWsR/UvVhIBg==
X-Google-Smtp-Source: AGHT+IGUxEdaon415iN8h281a2LuqoE9nZyftt9g8HQiehPuXE3/tb0mRmefYubCxnRYFAQS7EzlNNoC73f3DBYcL/8=
X-Received: by 2002:a25:c785:0:b0:de6:1057:c85f with SMTP id
 3f1490d57ef6-dff1537c45dmr3081777276.22.1718387321539; Fri, 14 Jun 2024
 10:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
 <20240613095901.508753-1-jtornosm@redhat.com> <CAMSo37UzU9WrQOQVo=Bb-LfOwS=GJrsSLMgGAwLY7JoGQ9ap7g@mail.gmail.com>
In-Reply-To: <CAMSo37UzU9WrQOQVo=Bb-LfOwS=GJrsSLMgGAwLY7JoGQ9ap7g@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Sat, 15 Jun 2024 01:48:30 +0800
Message-ID: <CAMSo37XjHhBz1hc_se0Fj8=gnju-iOT52Nf60jwLJ1hPN_kUaQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jstultz@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Jose

On Thu, 13 Jun 2024 at 19:46, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi, Jose
>
> On Thu, 13 Jun 2024 at 17:59, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello again,
> >
> > There was a problem copying the patch, sorry, here the good one:
>
> Thanks very much for the work!
>
> I will test it tomorrow, and let you know the result then.
>

I tested with the ACK android15-6.6 and the android-mainline branches,
which have the issue reported,
after applying this patch, the network works again now.

Here is the console output from the mainline branch, in case you want to ch=
eck:
https://gist.github.com/liuyq/bd3fdada41411bc89a0cd4acf9ec11cf

Thanks again for all the help!

Best regards,
Yongqin Liu



> >
> > $ git diff drivers/net/usb/ax88179_178a.c
> > diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_1=
78a.c
> > index 51c295e1e823..60357796be99 100644
> > --- a/drivers/net/usb/ax88179_178a.c
> > +++ b/drivers/net/usb/ax88179_178a.c
> > @@ -174,7 +174,6 @@ struct ax88179_data {
> >         u32 wol_supported;
> >         u32 wolopts;
> >         u8 disconnecting;
> > -       u8 initialized;
> >  };
> >
> >  struct ax88179_int_data {
> > @@ -327,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, stru=
ct urb *urb)
> >
> >         if (netif_carrier_ok(dev->net) !=3D link) {
> >                 usbnet_link_change(dev, link, 1);
> > -               netdev_info(dev->net, "ax88179 - Link status is: %d\n",=
 link);
> > +               if (!link)
> > +                       netdev_info(dev->net, "ax88179 - Link status is=
: %d\n", link);
> >         }
> >  }
> >
> > @@ -1543,6 +1543,7 @@ static int ax88179_link_reset(struct usbnet *dev)
> >                          GMII_PHY_PHYSR, 2, &tmp16);
> >
> >         if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
> > +               netdev_info(dev->net, "ax88179 - Link status is: 0\n");
> >                 return 0;
> >         } else if (GMII_PHY_PHYSR_GIGA =3D=3D (tmp16 & GMII_PHY_PHYSR_S=
MASK)) {
> >                 mode |=3D AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
> > @@ -1580,6 +1581,8 @@ static int ax88179_link_reset(struct usbnet *dev)
> >
> >         netif_carrier_on(dev->net);
> >
> > +       netdev_info(dev->net, "ax88179 - Link status is: 1\n");
> > +
> >         return 0;
> >  }
> >
> > @@ -1678,12 +1681,21 @@ static int ax88179_reset(struct usbnet *dev)
> >
> >  static int ax88179_net_reset(struct usbnet *dev)
> >  {
> > -       struct ax88179_data *ax179_data =3D dev->driver_priv;
> > +       u16 tmp16;
> >
> > -       if (ax179_data->initialized)
> > +       ax88179_read_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID, GMII_PHY_P=
HYSR,
> > +                        2, &tmp16);
> > +       if (tmp16) {
> > +               ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_M=
ODE,
> > +                                2, 2, &tmp16);
> > +               if (!(tmp16 & AX_MEDIUM_RECEIVE_EN)) {
> > +                       tmp16 |=3D AX_MEDIUM_RECEIVE_EN;
> > +                       ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM=
_STATUS_MODE,
> > +                                         2, 2, &tmp16);
> > +               }
> > +       } else {
> >                 ax88179_reset(dev);
> > -       else
> > -               ax179_data->initialized =3D 1;
> > +       }
> >
> >         return 0;
> >  }
> >
> > Best regards
> > Jos=C3=A9 Ignacio
> >
>
>
> --
> Best Regards,
> Yongqin Liu
> ---------------------------------------------------------------
> #mailing list
> linaro-android@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-android



--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

