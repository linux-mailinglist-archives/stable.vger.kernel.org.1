Return-Path: <stable+bounces-80728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D39900BA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885C5285BF1
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 10:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203614AD2B;
	Fri,  4 Oct 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BGGZMmN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F671494DD
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037178; cv=none; b=fkkbP6R/lXVWfw2yFluqh34kY4T1s2YIoFKbVWXHPQer6Qhgcl5avk4EhvEv2PVNnzMJFhXiPrDDNfy5bE583UOFf86vhiXZoXZFR5Rh+5x5mbqcDNIicn5A5To+34OTp2746iF4uOc156p1P24m6DDGB6tYsZkL09yo/nS+2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037178; c=relaxed/simple;
	bh=ABL3wmDqqTNBkhLkQetuoOuvCA417zI/wRviczcrQXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7EYJzjQLKs3V+BkaVLnvQ84yIvYpgC94nLbZe62k0GItX/ipz3JO3ic5TkUcKcD03W5Katj+5qR4tH1vtNJi/saNlfv1iq63xTIa4YKAuBsdYDM5iRu7q1nm5aiRRKrZktoQm88gnz72czVknkPInsiohWY2m1l8nwBGC6zvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BGGZMmN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so5342004a12.0
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728037175; x=1728641975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/rcmFBYidoCiljefYKdEWXPO8lL88kIKj0tKbLJLyY=;
        b=2BGGZMmNtp0UofABcZ8f4t6myddTEFkcXdvPqKvJ5LbDJxZcTU7EzRYCdZ5sOE+4I+
         IMUEPioqReuLnOmSGKMQCaYaZ+DAXTzn5lEbglknhfgli4kh3mtfk2w8Ce/rSJ3nfiti
         AS6ganj6A+FpHBiKEmMkxMOktiEgzr4pfFKfxFcwezex8veIOMhxMamuE3UxZReaugtG
         QJGLOg8Z76B0b0r9fTRtzxnjwm+KKaQi/x6qXLaZ4RnfcdMROxJ5YeN6vPm9+w9fPdag
         ObRQJ163M0p0ZS83kgMm0aCKjcdZKP5IqBKqfb+UNXD2CLdFZP8qZaH0PFZXREJrE6aL
         YDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037175; x=1728641975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/rcmFBYidoCiljefYKdEWXPO8lL88kIKj0tKbLJLyY=;
        b=IxvHcNKW4ORODWTntjR037u9ganIYNO8xKQSGC1YV/E+iG0/tTvxxIazsgebvkW6ky
         PgW/8KJCN9JTKoZePdDtEFr+GAnZ7VyY5KS6PR47E6drJp+TE291dfnmKMIUiB989ZFv
         mK+CLR5nNga7pQYCYCATXFil1Mjy7IYBGb13Z+8NuYh74RXYiGqvNvniLu1D/Q1LcpMv
         wwMeYp/1AyoN0EwBHWrjroAghFPDcHfyncsymUE4MT1w11mgLFyYK1T/lgHFxnN/rYFi
         4QY+pT1BMbgU39r6xQkwe9ANySrfhE5DQNumVELBx4boep2ydVBXFSUY4SCfXxQZxpOB
         hZmg==
X-Forwarded-Encrypted: i=1; AJvYcCVqa15Gljzuz65ekaR4W0LFNeTXstYaAGiomwZs8/yzHOdJ/LkH+/oQHwEdJR7uCPyP0bn152Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTx1SNeuhRh0eYARzkLuinRoDUjGjQluuijKvEMNKDGR1D9KrY
	p+MGuhnnlCejKTlxvovHeBMmty2Xsni6GhdgoJG+7KvghDJKURdDifnH+PAWUYscLQuXEclWBnO
	T/HQIkIp9VYLrWPAxYAGZ1AXkc9w9LBkbeu06
X-Google-Smtp-Source: AGHT+IG2ylqDlHlpj6CludCqdF4jAiPwztB1MV/DHQjdD8kLzIL2saD55CdWhKN78Hfp28hLSalNMkp00XhcQDxqEsc=
X-Received: by 2002:a05:6402:5250:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c8d2e5523bmr2145135a12.0.1728037174770; Fri, 04 Oct 2024
 03:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003170151.69445-1-ignat@cloudflare.com> <20241003215038.11611-1-kuniyu@amazon.com>
 <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com> <CALrw=nEV5KXwU6yyPgHBouF1pDxXBVZA0hMEGY3S6bOE_5U_dg@mail.gmail.com>
In-Reply-To: <CALrw=nEV5KXwU6yyPgHBouF1pDxXBVZA0hMEGY3S6bOE_5U_dg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 12:19:20 +0200
Message-ID: <CANn89i+BNfpKY_qCRLFyGSgtzNeVGuPKudw2nWTF7=r0+P9jUg@mail.gmail.com>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com, davem@davemloft.net, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:05=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> On Fri, Oct 4, 2024 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Oct 3, 2024 at 11:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Ignat Korchagin <ignat@cloudflare.com>
> > > Date: Thu,  3 Oct 2024 18:01:51 +0100
> > > > We have recently noticed the exact same KASAN splat as in commit
> > > > 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> > > > creation fails"). The problem is that commit did not fully address =
the
> > > > problem, as some pf->create implementations do not use sk_common_re=
lease
> > > > in their error paths.
> > > >
> > > > For example, we can use the same reproducer as in the above commit,=
 but
> > > > changing ping to arping. arping uses AF_PACKET socket and if packet=
_create
> > > > fails, it will just sk_free the allocated sk object.
> > > >
> > > > While we could chase all the pf->create implementations and make su=
re they
> > > > NULL the freed sk object on error from the socket, we can't guarant=
ee
> > > > future protocols will not make the same mistake.
> > > >
> > > > So it is easier to just explicitly NULL the sk pointer upon return =
from
> > > > pf->create in __sock_create. We do know that pf->create always rele=
ases the
> > > > allocated sk object on error, so if the pointer is not NULL, it is
> > > > definitely dangling.
> > >
> > > Sounds good to me.
> > >
> > > Let's remove the change by 6cd4a78d962b that should be unnecessary
> > > with this patch.
> > >
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> >
> > Even if not strictly needed we also could fix af_packet to avoid a
> > dangling pointer.
>
> af_packet was just one example - I reviewed every pf->create function
> and there are others. It would not be fair to fix this, but not the
> others, right?

I have not said your patch was not correct, I gave a +2 on it.

In general, leaving pointers to a freed piece of memory (and possibly reuse=
d)
can confuse things like kmemleak.

I have not said _you_ had to review all pf->create() functions.

