Return-Path: <stable+bounces-98910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AAF9E646C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2BD169C10
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87018C34B;
	Fri,  6 Dec 2024 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTGX1qJR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E0188CC6;
	Fri,  6 Dec 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453399; cv=none; b=lYQdbFhwydvo1ob231RqQWMY+oIfGaGh7XOY3gDZEhuAPrxcl1r/ERwNjJlZdNDxQJbvRtubf/c96Q5n0DvYnKpLILfqbpidiyDJ0Vt2n0SM1z2sMTPR70FkUCDzzaVlt+hn4VKZ8Q38bggrnibfOm8BaKdnyRtEHYVslaUGtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453399; c=relaxed/simple;
	bh=d1mlV6zQCgCyxHwYY1PXH9w0PynEoomgfBQSdBZwFno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npBztaiQRh1jJY45w6sFt3ZoEci3yefqsX7kFq5sQm9uLsbPWIR5QaxoEee+Ky0aUArJmexmdueFJxSuw1b5DCpxKvHlwj2k8cXzFBIY62r4GZRJvDDps654XRMWeQIdFmM+8CuKvE/Gm5RBxoy1f8V3wZETL1mfz8PeNqKmzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTGX1qJR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so1387199a91.2;
        Thu, 05 Dec 2024 18:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733453398; x=1734058198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFcBusQAgop/cJ9zHlAC34d6C2cvFm40FRSAV1uCAPY=;
        b=VTGX1qJRPX47AXTqVOGDViuamU6neySro3ttK0RvwANwuBekx0sV9IJVZKhBujs1D2
         A02KifHA4ZTl9SAxms6bb7nOlkfGWMiZKIyIZ0oY0dhJKXBwvqnVrZwoIEz3G9Daq9Yo
         HS6XjgVAwwcvrzlZW0/wXWP/lsfo1TWAanHFaDevBbkauarkReLbcVUH6oTCH2sb1tlg
         xuZ5m8Ay/+ygVWM1UNaIsYNW3hJKKXMnoUD5ffjBH1UX5HVz7FbFTREk7zoOzC31rsmv
         FExfgaA+y2Bspq5GLWEKOr8qfia9j7Xq9q2FvisUwQgwnV7V2z2uSpXaXxqcysIJvdbV
         u1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733453398; x=1734058198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFcBusQAgop/cJ9zHlAC34d6C2cvFm40FRSAV1uCAPY=;
        b=t3DrjkhbOD7SsX8qKkMtRfGnB0GAWkTPb/eZEcWETW22LAIN51BoM5n9kL8mHtfjVZ
         rxd8FlnhrBmEUv0Dg3V7KsYQgcPxFnRAIrRnxTucOSwIOZlyxU3wuAxnsqRrLNsO2hOD
         exIsXpei/4Zpe883Mtp5+m8mI7R1S9Br8NVE7tFDQ+Gm5DGkjVK0oe1Pg1h/xsrryXx9
         v24SpOZ7MSFuXKv0eW14DR3zeP++ayLyXCE9wfD+EUNIqvCvbducSOiQIcwRi1t5J4ck
         GuPVwdvHm7tfEVcNJXYXxEx+DyvD4SgHrviI5RnJYFR1DDYu0wEFh3Tmja0+y8c276jL
         DEbw==
X-Forwarded-Encrypted: i=1; AJvYcCUaogRd3o0u9Sor3tkqBuoGphl+4+yIjBICD76HC3L5HMncnLSH0pdnkI8CuuVKWe0FbADUnEg6@vger.kernel.org, AJvYcCVUdMNA26MOVK9+nWnHSC31kl8bZQm+1FQAL0VEDmwtEadaDrlwVK41UikDm3F0vq09EjTmyxs6UqjjZ2s=@vger.kernel.org, AJvYcCWyegYLFTjEymg7XSM90ekuPk0APsH2QUqya8U1YjgQ4n9YgzWTqqJNCRWD6fijYPumub55RNZO@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSciM7823odQzr9D71VF88jiI7FqzV42N6MwobwLDhbknHj4A
	Ol/a6sUBP6r576h/bwACE9oBXoWNdSHmjXPYQhZT31Y99pW4Ek35dfbhFjbeW83875q9F/dzr/w
	W1uakrqzYHCJj2ddRzZI1l7ydzzs=
X-Gm-Gg: ASbGncsZTkwPIfDDbILlT85nI+T96OOq8hLTPxTWCd5oiYVCCRpEKgiBs+QU43teBTs
	GYnpVKYoKsFInpo79AHBuNcrG63vpGQ==
X-Google-Smtp-Source: AGHT+IEA11huRP+Trp19deRlrQWYZoOM5ceG9+1zVCv7r7Tsw6HHVVGPX/+z5mIMkkizPeSriAQ8V5bZRdiioL1KesA=
X-Received: by 2002:a17:90b:33c4:b0:2ee:863e:9fff with SMTP id
 98e67ed59e1d1-2ef69e15339mr2443280a91.10.1733453397711; Thu, 05 Dec 2024
 18:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
In-Reply-To: <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 6 Dec 2024 02:49:46 +0000
Message-ID: <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub, Eric,

On Thu, 5 Dec 2024 at 09:09, Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Dec 5, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > Hi Eric!
> >
> > This was posted while you were away -- any thoughts or recommendation o=
n
> > how to address the required nl message size changing? Or other problems
> > pointed out by Dmitry? My suggestion in the subthread is to re-dump
> > with a fixed, large buffer on EMSGSIZE, but that's not super clean..
>
> Hi Jakub
>
> inet_diag_dump_one_icsk() could retry, doubling the size until the
> ~32768 byte limit is reached ?
>
> Also, we could make sure inet_sk_attr_size() returns at least
> NLMSG_DEFAULT_SIZE, there is no
> point trying to save memory for a single skb in inet_diag_dump_one_icsk()=
.

Starting from NLMSG_DEFAULT_SIZE sounds like a really sane idea! :-)

[..]
> @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *ha=
shinfo,
>
>         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
>         if (err < 0) {
> -               WARN_ON(err =3D=3D -EMSGSIZE);
>                 nlmsg_free(rep);
> +               if (err =3D=3D -EMSGSIZE) {
> +                       attr_size <<=3D 1;
> +                       if (attr_size + NLMSG_HDRLEN <=3D
> SKB_WITH_OVERHEAD(32768)) {
> +                               cond_resched();
> +                               goto retry;
> +                       }
> +               }
>                 goto out;
>         }
>         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).por=
tid);

To my personal taste on larger than 327 md5 keys scale, I'd prefer to
see "dump may be inconsistent, retry if you need consistency" than
-EMSGSIZE fail, yet userspace potentially may use the errno as a
"retry" signal.

Do you plan to re-send it as a proper patch? Or I can send it with my
next patches for TCP-MD5-diag issues (1), (3), (4) and TCP-AO-diag.

Thanks,
             Dmitry

