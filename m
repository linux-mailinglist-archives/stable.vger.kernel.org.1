Return-Path: <stable+bounces-132240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F957A85ECC
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4711C189C027
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A513957E;
	Fri, 11 Apr 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm4NZKel"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E5200CB;
	Fri, 11 Apr 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377742; cv=none; b=RRvm06w4BXMiLnVoFc/c4GueQC1g1zxxBZq2K0T/NPTu5Cyh16S/oxjxu8oL63ieYu6n7KoJe9MJsJYpMvda4OFkineh6x60qHtVwyzgeSXxelgC2W7EJe00nlj15rGw6CCl0kZD/KLm3c3LwOLdQ/9vajGazBlvRni5Jfjm/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377742; c=relaxed/simple;
	bh=EpULsdwEbrZTkpHDw292seYcbb+7NxXrhCvlVf1h1q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRXXecby8/d9bt/clx7e3eeDR4zdBbeeyNbNgsZjszLEDw/WojIrbyKoK8YyVtHBLNPvz7oD4WVMyOA6K/KmxMl8FTM/HCKTB7xGLSo0bfuq1ecCMGnHleZ2pkDbIyEkKKu8DLZkDfMCBWLXEUWHI5q9w/XDTmTGaBv2k/D/dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xm4NZKel; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-30bee278c2aso31693961fa.0;
        Fri, 11 Apr 2025 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377739; x=1744982539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sah0SVBmFLpz4h/jlec344lM1AesPXbeFTOSULVxmM4=;
        b=Xm4NZKelzaKQ2jGSXd0wUARc6D6PB15xJp+bf9+/SM2bJo0bSy7fqDuFCTgYfz4VV+
         /909CEzlH7UrgLLgtPBQRXqXAVcywpCguY/auaKhwdUdwSF/uES+/ZT8eX/KK23S3+C4
         rbP7pbMmV+bTJQDDeRV9PzzC+JpXYcVowPO672dKVmZOV3bK25/oH0el2gl5YMxAISYQ
         5KWIrTMJfOKYffY1exyaGw6KdeMgx2EUCLRh08T8Cyi1dGAI6lPhBRLLm+j1jxR0qH/p
         ad38/OzIi9SZsfknEKHLMmEpdL1GWbIC6NtVeYFA/QivU9ogJvwIhvAsvjq39tlp6RZ7
         wSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377739; x=1744982539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sah0SVBmFLpz4h/jlec344lM1AesPXbeFTOSULVxmM4=;
        b=mhZhEi8UMwBAz8j5MQ5wnheSYMMZteNY6CHXnckz/gmBQ/K0uIFQhLLkQ8pfeYZZRG
         lF33bXK+9TT8CL27PrMcUqvns8I3WCtarDGFmrJ4/0kU/7hu5TDeQh7SvCTPYYY8l+7R
         2x9swrtpkFw0411iRccpTafpJDXyBFsIk5atNIwi2LxXGp74mLH1V5yjhObgojKeEVdk
         7e3psxRb2+fAy/u+pzGmrAt994VhJ8Rd9oyQ3JC248ORlLT7v0peRef9zYAl7k4txHvz
         32btfQs7BshWy2SscBSIFugk4WsKfyLM+CvEB9dSFhyqU2pNJq0wJH0ndTX4ANnvvEVF
         R6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU1nO6UE1rMNlbcBZwXrjhsOTH1UJVOPwLygRapRNlwZ6gUjdPWB6VPbMEiu5U+Xg0kuXffHJRY@vger.kernel.org, AJvYcCWYlGwqAgMebu+hSpPAVKtJV70bSxsqeKfFHqAfcd5jkEV3afO4LKnzG58Qys8Knt0LwOdmqM++lgsYDls=@vger.kernel.org, AJvYcCXMQwFjWKhbjNcuIiE/n0FBRsnKPglkvxRHB62Vp0GRfKXuBEjWvSg8tkFtuEREksr/l5kNtcGF/9qw@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJwLpxz0Uzf7axtrTJ3CeXeT4gtmAn9CwLT7NRA+fEPAAq/xX
	PB7/n3+oG/FlvNOYJuLDCRaSXjNwvMXu+GskrlOn9/Wm8BMpnkP4PSxXiuMf4adg04Ds9VE5hKr
	I7sEoI7n4/nfwXadgDwnbM1AJ6kUIQoPvOSSIB/Of
X-Gm-Gg: ASbGncs3+5q/Xic73BfIEMNhevW/xJ2j7ZJD5Nd9rHsfWIHsU1Cl9SfPtOo0RP4NdHe
	4flIQ84qJiRYzScv7vE6XSvSMBa7cw41JuWa+Qe4nEdoNKv0h7H5h2/d5Rp9M1b7I+NiaHMIlfk
	1ukn7roAitusCyu5MsuwAdSw==
X-Google-Smtp-Source: AGHT+IHw+lifGU70y9Vd72DyBga7i8AjGwQnPrs/Ioo3jLXofjG+CAq6Y1GhP4WwWrG6KrV6FXm0JU1muYB3vRAji0U=
X-Received: by 2002:a05:651c:312a:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-31048972d82mr10675451fa.7.1744377738559; Fri, 11 Apr 2025
 06:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405113020.80387-1-bsdhenrymartin@gmail.com> <2025041119-debit-cosmic-f41c@gregkh>
In-Reply-To: <2025041119-debit-cosmic-f41c@gregkh>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Fri, 11 Apr 2025 21:22:07 +0800
X-Gm-Features: ATxdqUGEZYsaCXX5XdyoJ9leRiLY8Ans_fSIobpjEITgHPNCVrlUjQY0Xk24xqI
Message-ID: <CAEnQdOoikipXfvBUcfmFUp8As4+K58Bb=oeFKmEH8x_nqkTX_g@mail.gmail.com>
Subject: Re: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the review.

This patch was made against v6.14. I=E2=80=99ll rebase it onto v6.15-rc1 an=
d send a v3
shortly.

Best regards,
Henry

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=94 21:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Apr 05, 2025 at 07:30:20PM +0800, Henry Martin wrote:
> > devm_kasprintf() returns NULL when memory allocation fails. Currently,
> > ast_vhub_init_dev() does not check for this case, which results in a
> > NULL pointer dereference.
> >
> > Add NULL check after devm_kasprintf() to prevent this issue.
> >
> > Cc: stable@vger.kernel.org    # v4.18
> > Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub=
")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> > V1 -> V2: Add Cc: stable label and correct commit message.
> >
> >  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gad=
get/udc/aspeed-vhub/dev.c
> > index 573109ca5b79..5b7d41a990d7 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > @@ -548,6 +548,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsign=
ed int idx)
> >       d->vhub =3D vhub;
> >       d->index =3D idx;
> >       d->name =3D devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
> > +     if (!d->name)
> > +             return -ENOMEM;
> >       d->regs =3D vhub->regs + 0x100 + 0x10 * idx;
> >
> >       ast_vhub_init_ep0(vhub, &d->ep0, d);
> > --
> > 2.34.1
> >
>
> What kernel version did you make this against?  It does not apply to
> 6.15-rc1 for me :(
>
> thanks,
>
> greg k-h

