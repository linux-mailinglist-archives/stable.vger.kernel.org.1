Return-Path: <stable+bounces-99987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481AC9E7A10
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 21:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C750C283E91
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625451D222B;
	Fri,  6 Dec 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFRwQ4yo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081B1C5496;
	Fri,  6 Dec 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517336; cv=none; b=pP8VLPom83IqBWCdyFuiAa1+ycu0E8mXSpzY96CePcD3Esvkpa9RvCh8Lya6yjitUjWBykyP1pZk5oEpKbBy/ULy/LwFi1e1Z5f5+vJek7UHPkMnVX/n3R0rPSxI2YjdZwFRN6b6UfeQaHPovaJKTFJ6JrUq8slL46urTqV7Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517336; c=relaxed/simple;
	bh=KfHWQu6liIdf7TzsYbc9sbR4p1miYi4VnYm5haG6c2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpEon6TM6Sm8/hPwUxNx6ydppQl3uocH5sG4DNS1EUqcrOh0Itw27kQE29hMKg38ccmEbuUQjccsw18AMrv0zkPXHLeRowIx1spi9Ay/zkJ3uek35FyfCkiRS/wHkz+6JFY2NkcdUr4+vuZWMqqiASvez5qJYXOVGinMaFqEI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFRwQ4yo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so2098374a91.1;
        Fri, 06 Dec 2024 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517334; x=1734122134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WSYKgnoISSMoL6c1SM0OSo8i8y8ZqVOfOOSDtnT9Wo=;
        b=iFRwQ4yooYMBi6Y4uNDj0IMEZTD75GD7BD8AN+tZ8YBpIcue9FKfanxHigdDiLZaNT
         EU99mKWX+Myd2DOVrj0/8y3v2fBjybcUPYbbQTp0BPfEhkxuS/W639TEbqoT2IfJSs/I
         jQlzvgllBEq72u2kZG0cx2Lwmj6BDAB75rTfaZ9p6hePLY89dm0uUO75CE197fPt8Z+z
         N8TTcuG4tf/6IQMrHpab/mrPfaa33LzX77yk5EV9CW9H20V9W9nqMXFCM7xTBflsLz7f
         8BLI07q+AHh110zqnrQdLeQ2Vl99TMbuVJ8Lu3RiMt71LRHavzENvjvwY2SRd/Nkz6U+
         svpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517334; x=1734122134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WSYKgnoISSMoL6c1SM0OSo8i8y8ZqVOfOOSDtnT9Wo=;
        b=UCKQMSOtXOIY8ALrIyGPxCu77iCEMbu81fEsYJdXpbd8DxpDrRDYnkR6oVw3kPhno/
         QDSTyYrihxeK/P+Hmn6OLXqrqqmfDM7jiWovqG9N85TLCfXl3YLbeSkRSQGv1UCaZKnD
         uL1KClIi1pcoLrDeNmk6yYuVvFRfEEum00jnRaYHD8dL0yJw791+7lS/COqJbx2zj7t4
         YhmSi23c9Nx0ewcOQe5U96F/1ej831DB85Ecv+0ImAXiuRO0Rjqn/xRvcacx3fdTSfPc
         3cw7ATKdnDS1XiemOzvynRsVkuzDSyAkhZlevk+jwNfXwmepx7guHsPy7gLt3BrQ+zTz
         FnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEZHthPvcMxqY44n7wofi5e3vsdButEnfY6BKUTL857QGNezxr8c8pab29vr4kEkCzRgXuLadH@vger.kernel.org, AJvYcCVr0udokKEg3wsQIeYtPK0zIc1RxihL3aEItMEyyI0yMagE2hH2NGckzhuZrvH3hanX0rOrtUHQ63yvOes=@vger.kernel.org, AJvYcCWa3j9Rsp5aZdLW0ggnkOHpcDIuEQjixSlhQSq5oKKJMXkd47DL9nLbaZabvY25eABBGGktJOCU@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUn2EX+lGSZq7Igdk5mWy8j/9XOCjrbOb44NdiOYnYF6DsPLE
	bOhvUNcwuMlpiSDywG45IfyB54xdGvdRLjtQq1bdA9r8fkk7LCrUonWUbR3P9QRLGjIsqgLppnL
	0aj0KXOf99OHyh/zFlgtvzsEnBDOAgJsVRGM=
X-Gm-Gg: ASbGncsK7tZzqp/Byf6a477FOYsYW4o6XprD1bVeZrBLvCN0ngmJ+hjU4bnqYQtFrz7
	S5oV2DiJbsqQWGQOppTX1WwaJ8Gy1gw==
X-Google-Smtp-Source: AGHT+IEpzaK/NG2+IvtIdZyl1H8wLBBipy2MsvnS1vHIIgei1Y3hj+929YdX4hnkWtIF7aUOoa4AmVt8HXwZErvXBiE=
X-Received: by 2002:a17:90b:524e:b0:2ea:853b:2761 with SMTP id
 98e67ed59e1d1-2ef6aaddd08mr5902936a91.37.1733517333959; Fri, 06 Dec 2024
 12:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
 <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com> <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
In-Reply-To: <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 6 Dec 2024 20:35:22 +0000
Message-ID: <CAJwJo6aeza8omfs+GbVz-KoGV-4vgZzBU1oa+PBTxe+W-YxtJw@mail.gmail.com>
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

On Fri, 6 Dec 2024 at 15:15, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Dec 6, 2024 at 3:49=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
> >
 [..]
> > > @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo=
 *hashinfo,
> > >
> > >         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
> > >         if (err < 0) {
> > > -               WARN_ON(err =3D=3D -EMSGSIZE);
> > >                 nlmsg_free(rep);
> > > +               if (err =3D=3D -EMSGSIZE) {
> > > +                       attr_size <<=3D 1;
> > > +                       if (attr_size + NLMSG_HDRLEN <=3D
> > > SKB_WITH_OVERHEAD(32768)) {
> > > +                               cond_resched();
> > > +                               goto retry;
> > > +                       }
> > > +               }
> > >                 goto out;
> > >         }
> > >         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb)=
.portid);
> >
> > To my personal taste on larger than 327 md5 keys scale, I'd prefer to
> > see "dump may be inconsistent, retry if you need consistency" than
> > -EMSGSIZE fail, yet userspace potentially may use the errno as a
> > "retry" signal.
> >
>
> I do not yet understand this point. I will let you send a patch for
> further discussion.

Let me explain my view. It's based on two points:
(a) TCP-MD5/AO-diag interfaces are mostly used for
debugging/investigating/monitoring by tools alike ss. Without a
side-synchronisation, they can't be used by BGP or other tools/tests
to make decisions as the socket is controlled by another process and
the resulting dump may be incomplete, inconsistent or outdated.
(b) The current default of optmem_max limit (128Kb) allows to allocate
on a socket 655 TCP-AO keys and even more TCP-MD5 keys. Some of
Arista's customers (I'd guess the same for other BGP users) have 1000
peers (for MD5 it's one key per peer on a listen socket, for AO might
be higher).

I think the situation that's being addressed here is a race and
potentially it's rare to hit (I have to run a reproducer in a loop to
hit it). That's why in my view a re-try jump is too big of a hammer.
And failing with -EMSGSIZE on 327+ keys scale sounds slighly worse
than just marking the resulting dump as inconsistent and letting the
user decide if he wants to re-run the dump or if the dump is "good
enough" to get a sense of the situation. I would even say "the dump is
inconsistent" has its value as a signal that the keys on a socket
change right now, which may be useful.

Regarding the patch, my attempt was in this thread:
https://lore.kernel.org/all/20241113-tcp-md5-diag-prep-v2-1-00a2a7feb1fa@gm=
ail.com/

However, I should note that I'm fine with either of the approaches
(userspace to retry on EMSGSIZE or to get an inconsistent dump and
decide what to do with that). I'm somewhat looking forward to
switching to problems (1)/(3)/(4) from the cover-letter and adding
TCP-AO-diag, rather than being stuck arguing about what's the best
solution for quite a rare race :-)

Thanks,
             Dmitry

