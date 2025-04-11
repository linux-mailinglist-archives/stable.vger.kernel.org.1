Return-Path: <stable+bounces-132241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C2A85F0C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5364B441C8E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896181ACED1;
	Fri, 11 Apr 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OED7EW9o"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BB2EB1D;
	Fri, 11 Apr 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378242; cv=none; b=bIKtDfrCtP3/wZ700HYJPPAdSRiP+5cD3DLU0vANe7d8pPf+KGKSCc6tM2D0nS2iW6+iOw0SW0k9HtjDymgRNompWVH9emM70WJ5uq9ifc4MqPsiL84NZDJD2Si2f9TAkTO9LG7oBM8uKUTw70QRoqOyypChNlT/RW9JJ6pO5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378242; c=relaxed/simple;
	bh=jueZpG4oTv3+EEGxq89YYgWm1ZpK/jmc9aD28F2zK0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lrc7hjIk+9T4baglrJdIrK6xcU8GBw16ZVdV431gYQR4G9zoxlBd8AFl0h+sudHSZA8njitaYvbPGbm0r7Czo75qv2LvRLxw+V827CHeFVAdnzxEJRmNbp6182Ft1Zjs8LDCs/SZEM/chgKEwRH5Clo+VxH129qJCbuOqH/9QJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OED7EW9o; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so16308631fa.2;
        Fri, 11 Apr 2025 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744378239; x=1744983039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2R/IkUgsNUQZyYj/hsSGzxvJ2UNWF/IZAubjoxHQl0=;
        b=OED7EW9oxb0n1TJOyAt2IWEcpfTsqfsAPRfvJIjYM3OkF8H23GzElV7o20jDOnYGod
         knfquLm8ZDzFW0AbjQWK+AX/ln/a7tQ+a9m30aMHzCiiQk2N7VmvOWSqqJ2Cvc84sK6Z
         LG35SRljqlFngR97aP0plXUi5r9/1hWh/Gh85rLC9ytOmlTm+Mw36boo/GKDlUf4p8P4
         kODQag4R+74W0TUR+U35r/7ZYDr158OQMnBcijRHQTtCqs9gnuydId19MhxCNrprKBbo
         IjfNSY16GM8px7OTQNsW6jGC0Quur7TLQV81C+PU5gdvqFB6ev5JfcuKoIZQmwV5qj5f
         n+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378239; x=1744983039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2R/IkUgsNUQZyYj/hsSGzxvJ2UNWF/IZAubjoxHQl0=;
        b=J5Ezn56mqyYWnSQnNw34k1Ym/c3eCrUvLcUxUUSpwG4knlWurAUx7u0Qvv4aHtzh19
         3jxJNFiIxb6eW33TDtcRC24ZW962HH4cuAZO+wx7M2KI5Pnogi9evDSiPRKgHApxSBZI
         VkNImIG84/M+A470hFa5D+fb0VtCqX8K+f30StosGBePvS0Owsx7Z3JFOzkrryBNtgX5
         q3urxJdfxv2r6bs0f8MQa64gJxlR45k8CbdWbRfERGGxvy5Kan8J7GBWau6fL6kq3dUS
         clnQrKKQN9//+F4JdPC18GPBcEKOAeCIGID5rO/e1GbcqAc2GuoIMOrc+gKeaeqoiosp
         LeUw==
X-Forwarded-Encrypted: i=1; AJvYcCU0M02NylB7BNELlSeB4NILq9HX2ujQYPX0D8lcbrHNAqMXHUWzxgYsZEJU5xSTgdirYSjoN2XgCl59@vger.kernel.org, AJvYcCUfASsqMZ85tqmYqlN0XhN+xD3QxF/NcoSMx2F4MDlOZKQpFYlU0O6+cq1jbfZ2J6NzEv90mnXc@vger.kernel.org, AJvYcCXA8OaL+LwRCtA/4JXpDN3OEBdoZjvxh2ST9CSYPxkTOz1K4fF5FgiCVVCrv8lP9JX6K+ahx0EUUE2ZNTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeM6dS1lsb1a4u22lEHjDHWM4Zm3FIXfHBy9rAfHL1HeSGENR
	7BeoL6AaRgw7I7djSKk7LCixW+cGYYxiXbCFcQc2X99Y30U9tlfkaz3Fth7zOd6PzDdKUNNaAR7
	+ddb+0wcfpCHWKWc3dkz98sPKR6E=
X-Gm-Gg: ASbGncudll7R0S8KjJ/aX/DLbG2D4P6GmlgxNikq5tvTvYDeVmTaF0jzCVMPHb5inSE
	tZQvJ4o2wuv8vAWK2lOxPTYnl18DZE1iHJ5dgEVYAUGYCAJTpmSEdq+qn2T8HDCNCxig7ex3vKU
	PMeU1SVLd9k4V9iraSHdCG
X-Google-Smtp-Source: AGHT+IG1lqVlN04eQ+Cdjd0vIhu0KNn3WIjR2MqivG0AARDZu5eY1L6Hi/Vnc2KqgBWl1QD8jRqYqg+Y0ThYnZbHxqc=
X-Received: by 2002:a2e:a545:0:b0:30b:a92e:8b42 with SMTP id
 38308e7fff4ca-31049a930d6mr9258461fa.26.1744378237355; Fri, 11 Apr 2025
 06:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405113020.80387-1-bsdhenrymartin@gmail.com> <2025041119-debit-cosmic-f41c@gregkh>
In-Reply-To: <2025041119-debit-cosmic-f41c@gregkh>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Fri, 11 Apr 2025 21:30:26 +0800
X-Gm-Features: ATxdqUFFH3sTnc2x3CM9EZtpM34AzSWHqdFLolBE3C_g_Sf3mnv8aMarh0qkivM
Message-ID: <CAEnQdOqmq3wwn3FLNq2wiq6MuM9ZMgcs6vcmwpVVgwzY=zeceg@mail.gmail.com>
Subject: Re: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> What kernel version did you make this against?  It does not apply to
> 6.15-rc1 for me :(

Apologies for the noise.

I just rebased onto v6.15-rc1 and noticed that this issue has already been
fixed upstream.
Thanks again for taking the time to review =E2=80=94 I'll drop this patch.

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

