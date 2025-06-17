Return-Path: <stable+bounces-152749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49632ADC099
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 06:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7F3B5F03
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 04:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C816AD4B;
	Tue, 17 Jun 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMn8fxJL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303711ACEDC;
	Tue, 17 Jun 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134612; cv=none; b=pBj86aqlO00CcVsxi19VoKI4ZUyDqg+62XPsLaBnmjhHxPR3VhnUcD3DwCriLUOULq1MzXpzJ21y7EmfXrUmTNaSOt5WRJ3Stf40ywuilKZoXq4spCqPJU0/fv9bglVFWknh5IXkh6krVBk0ZMx9t7BHNeVtYtqI0Wf3BBIxncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134612; c=relaxed/simple;
	bh=coN5M7UgkY2OpbkDobN63+woVFkfmnwHWQ9uWlTZHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp1TotFYhd0vAN+89c4gSnZnPqtx+xPFBiC0FRRVrOx01Bm2VgmalbcLINuNryLiittDivdtmF7f9UFmYBQmDmg4RvMEKH9EsUjGSdZ3wpg68LpbtJ016trtCzOygvrBrUbS++xNm97dUIUghAoAi0zhGbwJJZJMxzpM/QZEW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMn8fxJL; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52413efd0d3so1630617e0c.2;
        Mon, 16 Jun 2025 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134610; x=1750739410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdKsiLMagRvcTcqea0FT3P7to9kBSQlL+YJdIZTByqg=;
        b=LMn8fxJLorM1rfO/Y6HXn0nip8GMkEGOo7/8JzKmDI4/cwdzFLnMM79Poc/EUnJQWJ
         FL72tQKDUtOXHfz1AIg/AVuZzf3FiAg4yeSemOfBG4VtirfMAJrH2+yImFKTLZTZaUSt
         witQ/p/l367pSwJ9ygpxjKowEek80Gw9zwom0u+rgusHF3GqjUbb/+gFWFDq3MTXGUFg
         jIzrkzyF8k26FfSiZQFQZHQZHI7MYKn1yulBlaX+VLDJ+ogYLaDeIUa8KqHmjsHN3SRs
         98Ogr8rWx/FktQZrWYOqcdgmVtXZfk97RJLjoXvXOS8rcljLPVuXVMBswW2YLrDF1kR/
         nRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134610; x=1750739410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdKsiLMagRvcTcqea0FT3P7to9kBSQlL+YJdIZTByqg=;
        b=vZ3yfqwYrR5WUFwB+4fFaNJrs/3xss4rCIO90kQ6TwwfI9LEgPkRdb6BcsmaA/ryoa
         ftd8gVTHStNfe5QtlujIWZUbDd9pOy8x3qB9/wT696FBC05KFGa0DBV3FPVOi/vUVHJr
         lifS1Eb5O9JdjLQQP7LZB73LdZq4F+XcAZEis1AgqlSxXeGB6Fe2SnbFele6xBkDef9z
         wUtGsj5GOEt2RwToWe8y+15m/hcW7Pp8Wytw/otzHsnYzUjSxsZvkKk2kvC7nbo1ziGZ
         IQi60wn4QOP+hlNJ6trBjCKRS6Y7Xxws9OmJ5n5tvbYywq4CpHEAvNdrpNKrRX1fsQrS
         AdhA==
X-Forwarded-Encrypted: i=1; AJvYcCV2gOIR2Juk84EgA6FjAvD5D7Vl2i2i4Er97WmE0i27YhxXKhiT4pLdnqlJShZR/RYpoBi4pi8sRt9KV7Y=@vger.kernel.org, AJvYcCWrWoFyjfk7GtI7noRBMEoKS2pO2ZOb24pwOKRhsCpgBzXhMyJzOpmOGBKsYOYT7gtMqng6XWWA@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBj1PgITZjUjFEiuiQhKJIqAdkt1A3QRv55YgzhJmqRk+N6G6
	4xB17NewB8T8uXaHtkYaDw7JASaD1wfkdO/kAY0V8/vq3mzqII5X4sA29Xwylp/27cE6aJShbMw
	rcHxbH267Hng4SC0KvAFWQv14i84G4Pk=
X-Gm-Gg: ASbGncv+LTLH7dRZHmWv0iWxnLM+irl2DZ5hItGYBUIEWymHEFojt+4DrQoMvG0nh2Q
	rhifxolQNc+4RQI0OzxHo+8ruZFtBlQZeVkoGTMRdvp6+lwMviWWa+XKDQwZNVBcyaTsoSBlXJo
	rLJtBlnIsa3fB6aLcgz+pa9PdmVRY155B7uioTqBzm1VA=
X-Google-Smtp-Source: AGHT+IHTmBxbg43YFIE3hUpcQPBuc9uhECGzAwz81EpCiNKZAp9dAkImEX4ozSqVERNQsnuQ2oWLSFxJZYEP55GTnqU=
X-Received: by 2002:a05:6122:547:b0:531:236f:1295 with SMTP id
 71dfb90a1353d-53149b13c25mr7399510e0c.5.1750134609942; Mon, 16 Jun 2025
 21:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616132539.63434-1-danisjiang@gmail.com> <aFCh-JXnifNXTgSt@codewreck.org>
 <CAHYQsXR43MGM826eHtEkmH4X2bM-amM29A38XUj+hMbNF2vDJQ@mail.gmail.com> <aFDrBwql20jYrvp1@codewreck.org>
In-Reply-To: <aFDrBwql20jYrvp1@codewreck.org>
From: Danis Jiang <danisjiang@gmail.com>
Date: Tue, 17 Jun 2025 12:29:58 +0800
X-Gm-Features: AX0GCFvdy8vwc6GGsH1z6dEO-kWs183kySUYlgW7khdw1zEVOhnXzoycfuBIxxU
Message-ID: <CAHYQsXRhFMEhgPvY_6PVjD=oiWf3DWgLCr78xy-fWvxZwAMT3w@mail.gmail.com>
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Mirsad Todorovac <mtodorovac69@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 12:12=E2=80=AFPM <asmadeus@codewreck.org> wrote:
>
> Danis Jiang wrote on Tue, Jun 17, 2025 at 11:01:40AM +0800:
> >>> Add validation in usb9pfs_rx_complete() to ensure req->actual does no=
t
> >>> exceed the buffer capacity before copying data.
> >>
> >> Thanks for this check!
> >>
> >> Did you reproduce this or was this static analysis found?
> >> (to knowi if you tested wrt question below)
> >
> > I found this by static analysis.
>
> Ok.
>
> >> I still haven't gotten around to setting up something to test this, an=
d
> >> even less the error case, but I'm not sure a single put is enough --
> >> p9_client_cb does another put.
> >> Conceptually I think it's better to mark the error and move on
> >> e.g. (not even compile tested)
> >> ```
> >>         int status =3D REQ_STATUS_RCVD;
> >>
> >>         [...]
> >>
> >>         if (req->actual > p9_rx_req->rc.capacity) {
> >>                 dev_err(...)
> >>                 req->actual =3D 0;
> >>                 status =3D REQ_STATUS_ERROR;
> >>         }
> >>
> >>         memcpy(..)
> >>
> >>         p9_rx_req->rc.size =3D req->actual;
> >>
> >>         p9_client_cb(usb9pfs->client, p9_rx_req, status);
> >>         p9_req_put(usb9pfs->client, p9_rx_req);
> >>
> >>         complete(&usb9pfs->received);
> >> ```
> >> (I'm not sure overriding req->actual is allowed, might be safer to use
> >> an intermediate variable like status instead)
> >>
> >> What do you think?
> >
> > Yes, I think your patch is better, my initial patch forgot p9_client_cb=
.
>
> Ok, let's go with that then.
>
> Would you like to resend "my" version, or should I do it (and
> refer to your patch as Reported-by)?
>
> Also if you resend let's add Mirsad Todorovac <mtodorovac69@gmail.com> to=
o Ccs,
> I've added him now.
> (Mirsad, please check lore for full context if quote wasn't enough:
>  https://lkml.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
> )
>
>
> Thanks,
> --
> Dominique Martinet | Asmadeus

Sure, you can do it and add me as Reported-by, thanks!

