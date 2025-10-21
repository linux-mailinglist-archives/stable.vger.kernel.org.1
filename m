Return-Path: <stable+bounces-188355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D6BF7057
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83566545FF4
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65033375D;
	Tue, 21 Oct 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE91G58O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40D238C1F
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056368; cv=none; b=h4CBCZPDGnENIAEOzigWrzXjJeDUYnhOnUtNm/txIeyrM0lk08e6Ii+43Bm9uKrekbWakCap0tDZDBCaI13a9EyNP5Yig2wAV/BBNEqdlnI+EjUCkK8o2M74s8xasbMm+Rk/WI8hVXrO8eCxHXV21dUwInWErydIdgm4mp1tnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056368; c=relaxed/simple;
	bh=L2kPsqPKw1JgCCFXpbyfRvm/7VjWm7EVFxxOo1tNXMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU1zoZXowiMJZDxxWOTskHGrqpf9x+yN9UvsEk1vGc3U9BJ2xONy/dzEsV0G3fHYQOTX22mi0vYocyJqQ+PdgFtClh3LUMeEKQYCmNZQNYp2Y6r7ifEaGdOM7vmr2aWiicmdD+SyyX6rw/BcA6Vmf7wW05bNGLxlOE/bl2T4l1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE91G58O; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4285169c005so314739f8f.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761056364; x=1761661164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJsoERq+lbtNyBXS9BXRJIRxk8+1s/ACK0Sp04sYLmo=;
        b=UE91G58O3po8+pUM55mgcQ7DjQ2f/C/x5sb3gffPcGZzdf808apvNVF/ztXs235D46
         wR+U//YtOgMR9uJKr6C28XbuM0RRFdZKOiuax9o9cTE7eo6PXTSAnMLfcG45fbtf7hNK
         udDSvo9byi0AGSM59iCQZ8/jnpUe7qWHqEnu87yqbP403Esagx00r8vSBg74bgSP5ZBs
         osH9F4gRfjd736JqCo6KzO5kw3Yj92FG+16fZ+YdW8oTbLY4EJ8iZB/Ft35Pcxd8qoJA
         lRdBbAauW2eV/1gHYcRSOR36/wzOeXyUYpVD02C7Oo2TSi+/JDxTfNw1xkubUPue3oNp
         Wpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056364; x=1761661164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJsoERq+lbtNyBXS9BXRJIRxk8+1s/ACK0Sp04sYLmo=;
        b=FxbyDU70OT+O6YGq9hOnLirOpUuVw+S/8iG2DkGMqxlB4Cy4yBf0AeUh3xtKAhjdDq
         2EgSYUSV94dBJh/DCbn9nvvBqkvmjoia+4kxGSbSTKZf6Pn897vr1cJfiWdxiOButxdE
         59iJCbJru5VAbqaQ4eLf4GB4wHbwDUQEu8/BQI856aN6/kfs0zuHlN5rgrstlNmeepTK
         3+3r7sEXIMBYYRDi5sVfjBKVftJEXzbaZQ/V8zqs2nqlwrjUSrc7EQ4scbx6DJ0QrRsK
         PnmrTFmW2wzrmj8zHZ2Z/uvPtAYS550KFtZATqo09YMCKwQfpqRGA2vy1MVelCjMv9Zk
         BDcg==
X-Forwarded-Encrypted: i=1; AJvYcCXsbOd5ChWhc1zzQ0InI34OyTyU+Pe7JkP3y+VtF0BtiVV5IodhYssYREUpF3hyySXIwtBji6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/43uEzNbraRckURr4SX2S/VnIWDpxaXOsEVK+yRIAtUeWNKdg
	LWYAn2c3aL6mghy9TRLDS26oZRoRP3nxdPOYgwfYlJICl/B67OwsiN7vchqaxxUr+9l3N3OST5/
	kCQxFt3APFl/StuKPulpDIQHrq/qQ0o4=
X-Gm-Gg: ASbGncti8GTVQ3DtqQnn2H8Vq1kVbo5LSlfYFmMRvi3UJHCkOhKxKskOnwS6skN8ZsT
	ecM080voPuHTq4J+YsSMWLrk+0M3nltxqTxBX5DVvcM9keyS9vsQgnCN7Sm31VgjX9EB5t1c1mE
	bo76MeH6jwhLiBwBwjira06ZjEjgx/MUvuKLd07hha9p2teM86Bt/UaX2POA9ReQlUiAEx5MmS6
	RU8qOdtQD/pJbae3H66I3K5hetBeCWVtbKaFUxlUEZjTq71StKL5Rr77LXAx7InYaXX8Pkwc2sA
	Z2RAQfvDvJ/GNS5F6Ko=
X-Google-Smtp-Source: AGHT+IF90bxjz8ix40Ll9PxzTcZHjhnAQi9gB+R9Z+uHtbgPIaVOQudoZ+vcDoGIlUSSnwqhVwARNc6fqY+obGVADgc=
X-Received: by 2002:a5d:5c89:0:b0:3e8:ee5d:f31e with SMTP id
 ffacd0b85a97d-42704d7eb32mr13379995f8f.25.1761056364261; Tue, 21 Oct 2025
 07:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
 <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
In-Reply-To: <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 21 Oct 2025 16:19:13 +0200
X-Gm-Features: AS18NWCPMHLTced0Dmr8zTG585fd-t61s0ttRFUl_G7jBr-X0tGHFlvGwKtayRE
Message-ID: <CA+fCnZdHJtHgZuD9tiDGD8svXTEdP=GK8HSo71y_UfKgZcaUxg@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: do not limit transfer length
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:18=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Thu, Sep 4, 2025 at 10:08=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Drop the check on the maximum transfer length in Raw Gadget for both
> > control and non-control transfers.
> >
> > Limiting the transfer length causes a problem with emulating USB device=
s
> > whose full configuration descriptor exceeds PAGE_SIZE in length.
> >
> > Overall, there does not appear to be any reason to enforce any kind of
> > transfer length limit on the Raw Gadget side for either control or
> > non-control transfers, so let's just drop the related check.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadge=
t/legacy/raw_gadget.c
> > index 20165e1582d9..b71680c58de6 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io=
 *io, void __user *ptr,
> >                 return ERR_PTR(-EINVAL);
> >         if (!usb_raw_io_flags_valid(io->flags))
> >                 return ERR_PTR(-EINVAL);
> > -       if (io->length > PAGE_SIZE)
> > -               return ERR_PTR(-EINVAL);
> >         if (get_from_user)
> >                 data =3D memdup_user(ptr + sizeof(*io), io->length);
> >         else {
> > --
> > 2.43.0
> >
>
> Hi Greg,
>
> Could you pick up this patch?
>
> Thank you!

(Greg to To:)

