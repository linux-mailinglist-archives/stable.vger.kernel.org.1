Return-Path: <stable+bounces-99717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277109E730F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C3018879C6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F220ADFC;
	Fri,  6 Dec 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp90cuLD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DF17B427
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498113; cv=none; b=na2DbSAJbzXtFC3vbC0Bh/Tmn27AUETps18fBzIDAEf5rduoXnfwU3A6UdHoxxyd+7+cGTlKK84cDTbGfmmJXoiA2rPG4c/0tuCZl+8zVgJU/yFkjZ0NUP5kKweVD5qo09f0nAIT+5/u0F6TdCePpTuyqJkncQ5RQDvA+q03zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498113; c=relaxed/simple;
	bh=Rf6UKchEYwEj7kWnfy7/GJwdbAaaF5fK63RIngHucuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5sVsSNvDO6Gign4yhg1aqUVmNis9I25Gm52ZBrHvmW95vsvLAnc453i7qYGxS6/8IeEkO/mNl2SpVchb37qAzMRDW1svbGiJEfJTtAzfq+Cf+4AshIojwioGLp+tD+UgjQbpwEQxjC3+7hNKMoZnqgcxA3s4tvhbq5WIZG0Z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp90cuLD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de7321675so2788074e87.2
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498110; x=1734102910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bi85J4Anbz4KnoI5R1OFbqEq2YSaUnMErItaEKHBxE=;
        b=Zp90cuLDUTSPxz7keYnv/UeeqioLl+78w+JBT+Bv9+0t4bo5JqhK0LTFg8fKtlqBy1
         EveSAd6Zr+dfHoAr2Tpe1QJdYmowoeAzass77DTvCfXtCX/xRGapz3i1B/XJHKA3q8cW
         uUML5i/cQjn99TO7HQgc6nHzdcuhLni0KomsOSQ2amd94OWBT5OSjFvBfaeE24xzTf9p
         2t8CtIef/ChTaAPRviqUwJZb0FYW/d5feeoJDOcAzYYY+zt2ImYJ+VlTETbB/6RXhrey
         GokUQqc10TKm7bOhFL2aEwwW/T1/OIby3ZStNixr86Mg5J4Dks2oD7w6knLJUPnSxlzk
         zeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498110; x=1734102910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi85J4Anbz4KnoI5R1OFbqEq2YSaUnMErItaEKHBxE=;
        b=Q0D1nXOzqbo6q+uuGPlVCICpA+GkaXD8UaEgdmlQ3JcF3jA7ri0VziGFdlMPvVnrGt
         /vrpb/5qs6/JXifG9ginDOoDOg/cfyVNmvlxNXRnOYxCBYrUfudv1D+ChvSF/1eWTTLC
         LVBU+0Ok2F2dMn9oDPzDVw5EN7kcmxwJQw7U65jCyPux9aWJKERAVJygEM13tAR5mbht
         ZBBxh5ExwhLsYywsd6IKn6zhqw6RqaK1BKJIt13zI99QbfS1DhR+nFqd70dGy9X91Qmt
         fe6UlcGxZsp0TXyyAswq5fGt6oZsRH1nmr5iRGRdeuUpfwJ9jxWGK9e66Rhd6fmEdYY8
         bDZg==
X-Forwarded-Encrypted: i=1; AJvYcCWtSPFrjXJ0OY2OY+ijWv1QvItvitOaN25GysHsikDFQT+MLQRF0rxAAxPXMVeRiNT4a1YqcsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywynrm/zHU8pyhAcoNEGaZ/MSs+/dPGI4SOKKI+QKGMnPJOEQh8
	roobgt09gPG128PlPj75I35K40i8u86r8AABKT3wjhPY/m1P9oamNhxPyh8ACZe4biFicQotFy6
	EtCIgagob8VT9iNhB/VHdQdR8tJwJHAABwpW2
X-Gm-Gg: ASbGncsmyVT677GOXEXZIIwZ3pJrmzQhiIZGNaMH5VFqx/zDDrpBjtMjS6qm2lpysJR
	zXzd7YZAqTa7jWk68yL9XW6akdKGnC8w=
X-Google-Smtp-Source: AGHT+IE1cwLWlIj1GpiqN0fNBxkpgemnySZUfP6KDIPqY4kGmA+U/DT/8PsZJRBrjehxVuks6Jtd7XQt1GDre3GD9fE=
X-Received: by 2002:a05:6512:3b0b:b0:53d:e669:e7d4 with SMTP id
 2adb3069b0e04-53e2c2b8efemr2131796e87.16.1733498109407; Fri, 06 Dec 2024
 07:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
 <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
In-Reply-To: <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 16:14:58 +0100
Message-ID: <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Dmitry Safonov <0x7f454c46@gmail.com>
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

On Fri, Dec 6, 2024 at 3:49=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Jakub, Eric,
>
> On Thu, 5 Dec 2024 at 09:09, Eric Dumazet <edumazet@google.com> wrote:
> > On Thu, Dec 5, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > Hi Eric!
> > >
> > > This was posted while you were away -- any thoughts or recommendation=
 on
> > > how to address the required nl message size changing? Or other proble=
ms
> > > pointed out by Dmitry? My suggestion in the subthread is to re-dump
> > > with a fixed, large buffer on EMSGSIZE, but that's not super clean..
> >
> > Hi Jakub
> >
> > inet_diag_dump_one_icsk() could retry, doubling the size until the
> > ~32768 byte limit is reached ?
> >
> > Also, we could make sure inet_sk_attr_size() returns at least
> > NLMSG_DEFAULT_SIZE, there is no
> > point trying to save memory for a single skb in inet_diag_dump_one_icsk=
().
>
> Starting from NLMSG_DEFAULT_SIZE sounds like a really sane idea! :-)

There is a consensus for this one, I will cook a patch with this part only.

>
> [..]
> > @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *=
hashinfo,
> >
> >         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
> >         if (err < 0) {
> > -               WARN_ON(err =3D=3D -EMSGSIZE);
> >                 nlmsg_free(rep);
> > +               if (err =3D=3D -EMSGSIZE) {
> > +                       attr_size <<=3D 1;
> > +                       if (attr_size + NLMSG_HDRLEN <=3D
> > SKB_WITH_OVERHEAD(32768)) {
> > +                               cond_resched();
> > +                               goto retry;
> > +                       }
> > +               }
> >                 goto out;
> >         }
> >         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).p=
ortid);
>
> To my personal taste on larger than 327 md5 keys scale, I'd prefer to
> see "dump may be inconsistent, retry if you need consistency" than
> -EMSGSIZE fail, yet userspace potentially may use the errno as a
> "retry" signal.
>

I do not yet understand this point. I will let you send a patch for
further discussion.

Thanks.

