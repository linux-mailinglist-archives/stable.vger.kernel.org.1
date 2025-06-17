Return-Path: <stable+bounces-152745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C04ADBF68
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 05:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED363A6261
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5C20487E;
	Tue, 17 Jun 2025 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIcolLWy"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7B2AD11;
	Tue, 17 Jun 2025 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750129315; cv=none; b=pFkHuQP1nVgiINsfPS5VnVCadwhXrHoRUgt3/dsk1kLIRwMTTqHorv357wsu/EV4xUrFyS7TUtsm87GzvUkRMPv/Gyvs/bprnaLdczKN3kaz7SPYW4zv0JmMULPOnOyDa0Y8CkBGVdtNByxtR4OwZBlkFxVVszaxz64k4GNVRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750129315; c=relaxed/simple;
	bh=+nsuOjHKSn+wU7zKSuad9aE9Iy7woMm2OR7+pFpohD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbJSCVcskO2RKsI0DC4mY+RHlpcEZz6784QciqAA9k7MjpSZovNse/rz33GtUpNaahGYceKsCKCo1GrH/5L9zq9jga6x3u421CkxWfm94Ne5LtHyl7VXjSwJ5gKvYx3MPmPMHunFlV61qynh64HIEsXfXWeqCPCOgEtd5YT2X/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIcolLWy; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53145c74e15so902652e0c.0;
        Mon, 16 Jun 2025 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750129312; x=1750734112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u75Z/m51HLoqvQuvmxYYX48fqhq+BQTGNtp2KTyT5vE=;
        b=PIcolLWyN6Gz8ITUKtFW/+VlulORLLPoW78e8zVyz26FaapMKximWdiJigiXFcstxm
         RdddPeq/ognHf8maz7j+WGWFFqgfSZcwXIKTsJATPadB5E3f9eR6me3lFQL8xjVOEPh8
         F2GyX9hd3RiYCEsB3dSFuTLesbqCFlGh8veFeTULvyli0GnSb2RinsfcjjWQPfDM53c9
         UWrmNYPOwZ6HOjfcxGVKTHnEce4HqbqOAb8+uJUu9+1oNFcnE2kXwH7gEcZ4YresWSpL
         Cu7ivCGwR5vdlhgdE9J6OTa9F7Im+LTDGdhUL1N5PFiUwjRrgzwKWMOpe1t1WAwV0hgV
         9vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750129312; x=1750734112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u75Z/m51HLoqvQuvmxYYX48fqhq+BQTGNtp2KTyT5vE=;
        b=dUfujhTWZ2lKxSGTG0xKgQlaa8/8FY2eI/SmkPaVaLeDMG48ONyHBjrFhG5ZoxqiyU
         w8EjlFKXyCUQJEtIEJdcxdERnwVHs0MhPOWJTpBjgeLq1gVcPIsVmY/zJ7XUHqxiLT+c
         UF0WZA6UXunc9ER3IZ0+BOErTnzTB+geoRIB97k0duXazxJsu3ZJx0neXKUCoKYb7aJC
         HM2Hi8TUyHI6PvRX2HWNiCf8I3KzfnTnXF9Yb/287kuBCkVJR5OA81is1u90KvWfmxpk
         vv2Sc0qAUFKc4MD2gLS3R2aSPRahHasX1c5sDbJy+B0iTeUjezr/IM5Lgxpp5/1Jqk03
         OPdw==
X-Forwarded-Encrypted: i=1; AJvYcCWugO73FFW9yD5oTYjMzaz6TtmEDc8Ym2clC7kb8qAPOV/lTAdFdRemzk/HTh3dcLDa0GIWCUndAs+ll2M=@vger.kernel.org, AJvYcCX5xRzuzRKBNsRRZnaGa1gNUVmRKZpfcozXyHUMCTdStL3/TlwMt1eqvSIZWo8RuCZH2eFfkeVp@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWnce6bc49de5dvdlzrb8SHVJUr8ph/y0QDGzMBpKJ0px35qg
	2D0FYddXiiHgoxkkB6oW8USuGS0nqpspEJHceDYqeooRALdZJIu6rvZ2jHDo2eLsIRgkjnqn/g5
	rVLO3w8sR9NdLGRd3zel48os9gtxXkNo=
X-Gm-Gg: ASbGncvYzihkad8iYqdeEDl7YlL0smFuw1xPDVF70qJY6012OVQpRo4qLFIbw28uyCB
	7MZsinmcRwDVUHj4MNe7vUz8kbpER2uLLZSIKhK2PgGKznDgXk5J8iG452/BiqDO7xg9oiYTR0m
	wfj1sWyVyBoUcgFAJjx94u6X9Gh8LTbg1NvjvO5fkpOOo=
X-Google-Smtp-Source: AGHT+IH3O0bo9lTKoYDcGH9D7lVDop32g1C5r70VHXuxW/nd9qbrLusDr29m441OZsEZGw0CB3nvZH1Gj9WsqLJ29zk=
X-Received: by 2002:a05:6122:3bd0:b0:531:3900:8551 with SMTP id
 71dfb90a1353d-5314989a8eamr6802796e0c.8.1750129312186; Mon, 16 Jun 2025
 20:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616132539.63434-1-danisjiang@gmail.com> <aFCh-JXnifNXTgSt@codewreck.org>
In-Reply-To: <aFCh-JXnifNXTgSt@codewreck.org>
From: Danis Jiang <danisjiang@gmail.com>
Date: Tue, 17 Jun 2025 11:01:40 +0800
X-Gm-Features: AX0GCFtKyrfm9TIjR5SftUPZL2VQwc6OnrGk3iuj5hx40J4WFoWm2EVEyMO3TCo
Message-ID: <CAHYQsXR43MGM826eHtEkmH4X2bM-amM29A38XUj+hMbNF2vDJQ@mail.gmail.com>
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 7:00=E2=80=AFAM <asmadeus@codewreck.org> wrote:
>
> Yuhao Jiang wrote on Mon, Jun 16, 2025 at 09:25:39PM +0800:
> > A buffer overflow vulnerability exists in the USB 9pfs transport layer
> > where inconsistent size validation between packet header parsing and
> > actual data copying allows a malicious USB host to overflow heap buffer=
s.
> >
> > The issue occurs because:
> > - usb9pfs_rx_header() validates only the declared size in packet header
> > - usb9pfs_rx_complete() uses req->actual (actual received bytes) for me=
mcpy
> >
> > This allows an attacker to craft packets with small declared size (bypa=
ssing
> > validation) but large actual payload (triggering overflow in memcpy).
> >
> > Add validation in usb9pfs_rx_complete() to ensure req->actual does not
> > exceed the buffer capacity before copying data.
>
> Thanks for this check!
>
> Did you reproduce this or was this static analysis found?
> (to knowi if you tested wrt question below)

I found this by static analysis.

>
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transpor=
t")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> > ---
> >  net/9p/trans_usbg.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> > index 6b694f117aef..047a2862fc84 100644
> > --- a/net/9p/trans_usbg.c
> > +++ b/net/9p/trans_usbg.c
> > @@ -242,6 +242,15 @@ static void usb9pfs_rx_complete(struct usb_ep *ep,=
 struct usb_request *req)
> >       if (!p9_rx_req)
> >               return;
> >
> > +     /* Validate actual received size against buffer capacity */
> > +     if (req->actual > p9_rx_req->rc.capacity) {
> > +             dev_err(&cdev->gadget->dev,
> > +                     "received data size %u exceeds buffer capacity %z=
u\n",
> > +                     req->actual, p9_rx_req->rc.capacity);
> > +             p9_req_put(usb9pfs->client, p9_rx_req);
>
> I still haven't gotten around to setting up something to test this, and
> even less the error case, but I'm not sure a single put is enough --
> p9_client_cb does another put.
> Conceptually I think it's better to mark the error and move on
> e.g. (not even compile tested)
> ```
>         int status =3D REQ_STATUS_RCVD;
>
>         [...]
>
>         if (req->actual > p9_rx_req->rc.capacity) {
>                 dev_err(...)
>                 req->actual =3D 0;
>                 status =3D REQ_STATUS_ERROR;
>         }
>
>         memcpy(..)
>
>         p9_rx_req->rc.size =3D req->actual;
>
>         p9_client_cb(usb9pfs->client, p9_rx_req, status);
>         p9_req_put(usb9pfs->client, p9_rx_req);
>
>         complete(&usb9pfs->received);
> ```
> (I'm not sure overriding req->actual is allowed, might be safer to use
> an intermediate variable like status instead)
>
> What do you think?
>
> Thanks,
> --
> Dominique Martinet | Asmadeus

Yes, I think your patch is better, my initial patch forgot p9_client_cb.

Thanks,
Yuhao Jiang

