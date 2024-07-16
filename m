Return-Path: <stable+bounces-60351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A059331AF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 21:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96681F282CE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502CC1A0AEB;
	Tue, 16 Jul 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBwjXqNt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A91A08DE;
	Tue, 16 Jul 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156778; cv=none; b=OiLrnPxP0zTpuO/f3FM1gdNq1hFQ+ojNIhNLSWb95I9VOHIsRGkL9qeh/3PFybfipkkSfLxl2MS+Fpr/AhmovbloShs4HY44AjiX3qo6APRIhmMNJL72MlzRzL7JOCp7jyzYYv6gxQUM5sPvXgB5l33/34Dml1jcOHRAa6QytPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156778; c=relaxed/simple;
	bh=hCthXUdD01KBNitk5fycxmdatgmaILEAggf7B4hbIko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ8ql7RBuJFd+bAobfK8/Ib4b1g1JK/AR/Bkk4Uc9WoBS1A+RMtIGG7xkdHHsI2G6hfetakDuNKAPfB3cd6/ePigSL48nbgxmoUQvia9DmckpqA3DvTes3RKz0TIqLVC4V9Dhml44JJYdy10zFRFPcJBAqSJLi4ihfyNm/R7rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBwjXqNt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso40378051fa.1;
        Tue, 16 Jul 2024 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156774; x=1721761574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyKoBohd+J4BAo+0pkskFiWS3AipkamgrhZnkqwfyM4=;
        b=QBwjXqNtNEebpCPFDmulRdXuu7UrusfEeZ3r+p0YcAd8zJeDODK/lZ+aHx0JUBJ4fa
         NqtjcAF+jLZ6BETCjkohJzV2p6pnN1T3KcJO7Cl3kBY7/RZlYRGQiLDcpDbOgybOa2d5
         XXurw2uoHZhArXBK+BWOCS6S1HceSozlDQpu+XVDfnZ7WqC/s+3W4DppGuWmYLo1q74R
         AaL6PkUukN4JaGl/xl76uuwVuP15SP3ZbIOVDe5EJMv4A1rcQdeGsOaPvm39PD8kRwdU
         hKe0/df2Gzmfg+G8Nm1JSLbar1k5OhuiWvWXLIM/gbbifyH4Fc0XcdpiWTSf+N9PL7En
         BrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156774; x=1721761574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyKoBohd+J4BAo+0pkskFiWS3AipkamgrhZnkqwfyM4=;
        b=lYQQuWLxCTenqiiI3hooOxsEaN4k8s7o9utWzUKJg2hv83XNQUmSkk8Fg1urxlwbf5
         VCGMfKnbahkGZiPqcI+Y5q2O4+j6k0lQNJc7eUa1Akstv1W57i0z2gwWL3bxImovy2yl
         wHcSBQCvAXwQumj439RgFKIK8pjJAq1zM9lCZHsAF7GVgZtU5MzfwA3V91TVq5FfywPn
         dwonydjVOdWtt4g2bG0wiYPvIDQr8Hv6gHcKKVGo4mm93R3/v0+P6RfFrZAKW038/+s7
         Bdv7XZPLEjz7pfFJXczKUd/ROVkFVlDjR4mgRcv8kcn2pqmk39QHqBKPHACElSI+j5+U
         wXeg==
X-Forwarded-Encrypted: i=1; AJvYcCXgZHdS0tQaBNqGePFO+Uxbf9xXL6CGXkr0jRIKVDOFYKiIRCSzNlMg9crsPYkmD5elKZxMbMFO+bA+cPlH2A04mjZpPQK2ekqrqjZTiAyqdvY5zHnJaQZnRg19SVVzykIbiLDpLNRT/jplfp9MqG3s0INcLa4yQ05Xu+7aRHUa1voIgV4J
X-Gm-Message-State: AOJu0Yz2zxct1L7B5qOk2tN0Glggb6fLNzJmjcDimZe1oEpf9AXgWNlM
	BmkG4zsm7s7cZXCggui5KAxocs0hhYDf6k8YQuTfPJyMVSC6G7wCTajNOyawzHhwwkvt4QlIHO/
	qz+kIqyuaZidCc3eK5bjiA2+ynO4=
X-Google-Smtp-Source: AGHT+IFyRrVrJt3yrUGmJztDaw4wnI3YQfLSOfI/fkbC52XE5Ibyn/jR5xr78gOHTeeuXfbLpf5aHP98ATBaARlmmLk=
X-Received: by 2002:a2e:9254:0:b0:2ee:8736:6c19 with SMTP id
 38308e7fff4ca-2eef41dab68mr22139501fa.30.1721156773968; Tue, 16 Jul 2024
 12:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716142519.2712487-1-sashal@kernel.org> <20240716142519.2712487-9-sashal@kernel.org>
 <0d437a3825d2f714b24c032066b43d7b9e73b0e9.camel@iki.fi>
In-Reply-To: <0d437a3825d2f714b24c032066b43d7b9e73b0e9.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Jul 2024 15:06:01 -0400
Message-ID: <CABBYNZLzf2x6cScmjGv2Rxk-i3F9=QKVWosrSEBgmHBdHqOWtg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.9 09/22] bluetooth/l2cap: sync sock recv cb and release
To: Pauli Virtanen <pav@iki.fi>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Edward Adam Davis <eadavis@qq.com>, syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Jul 16, 2024 at 3:00=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2024-07-16 kello 10:24 -0400, Sasha Levin kirjoitti:
> > From: Edward Adam Davis <eadavis@qq.com>
> >
> > [ Upstream commit 89e856e124f9ae548572c56b1b70c2255705f8fe ]
>
> This one needed an additional fixup that I don't see AUTOSEL picked up,
> otherwise it results to a worse regression:
>
> https://lore.kernel.org/linux-bluetooth/20240624134637.3790278-1-luiz.den=
tz@gmail.com/
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Df1a8f402f13f94263cf349216c257b2985100927
>
>
> Looks like f1a8f402f13f94263cf349216c257b2985100927 also contains other
> changes not related to this patch, seems like
> https://lore.kernel.org/linux-bluetooth/20240624144911.3817479-1-luiz.den=
tz@gmail.com/
> was squashed.

Yep, it seems I messed them up while doing the pull-request and 2
commits were merged together, not sure if we can rebase them now that
are in Linus tree, anyway for stable it would be better to unmerge
them if possible.

> > The problem occurs between the system call to close the sock and hci_rx=
_work,
> > where the former releases the sock and the latter accesses it without l=
ock protection.
> >
> >            CPU0                       CPU1
> >            ----                       ----
> >            sock_close                 hci_rx_work
> >          l2cap_sock_release         hci_acldata_packet
> >          l2cap_sock_kill            l2cap_recv_frame
> >          sk_free                    l2cap_conless_channel
> >                                     l2cap_sock_recv_cb
> >
> > If hci_rx_work processes the data that needs to be received before the =
sock is
> > closed, then everything is normal; Otherwise, the work thread may acces=
s the
> > released sock when receiving data.
> >
> > Add a chan mutex in the rx callback of the sock to achieve synchronizat=
ion between
> > the sock release and recv cb.
> >
> > Sock is dead, so set chan data to NULL, avoid others use invalid sock p=
ointer.
> >
> > Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotma=
il.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 8645461d45e81..64827e553d638 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
> >
> >       BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
> >
> > +     /* Sock is dead, so set chan data to NULL, avoid other task use i=
nvalid
> > +      * sock pointer.
> > +      */
> > +     l2cap_pi(sk)->chan->data =3D NULL;
> >       /* Kill poor orphan */
> >
> >       l2cap_chan_put(l2cap_pi(sk)->chan);
> > @@ -1481,12 +1485,25 @@ static struct l2cap_chan *l2cap_sock_new_connec=
tion_cb(struct l2cap_chan *chan)
> >
> >  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff =
*skb)
> >  {
> > -     struct sock *sk =3D chan->data;
> > -     struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> > +     struct sock *sk;
> > +     struct l2cap_pinfo *pi;
> >       int err;
> >
> > -     lock_sock(sk);
> > +     /* To avoid race with sock_release, a chan lock needs to be added=
 here
> > +      * to synchronize the sock.
> > +      */
> > +     l2cap_chan_hold(chan);
> > +     l2cap_chan_lock(chan);
> > +     sk =3D chan->data;
> >
> > +     if (!sk) {
> > +             l2cap_chan_unlock(chan);
> > +             l2cap_chan_put(chan);
> > +             return -ENXIO;
> > +     }
> > +
> > +     pi =3D l2cap_pi(sk);
> > +     lock_sock(sk);
> >       if (chan->mode =3D=3D L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy=
)) {
> >               err =3D -ENOMEM;
> >               goto done;
> > @@ -1535,6 +1552,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *=
chan, struct sk_buff *skb)
> >
> >  done:
> >       release_sock(sk);
> > +     l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >
> >       return err;
> >  }
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

