Return-Path: <stable+bounces-80727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E099007E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA991C22FAD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE7149C7B;
	Fri,  4 Oct 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QfHXi2Cz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403373CF74
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036324; cv=none; b=bYlLA7euKagrFJKxJbufql/7eMJM5x59Gb9Q2jVQFveFUU9KfHxgj0rH+Ru9t4E4Hg2dNjufnhnkYZRrI1+5ueLZCNbOpFVxg3NJbG/GCDkt5XUgdeQn9V3QvXHcESgI7/A0JnSdRL5wBach3vQyzVAC81OLq/lZHO36LNntiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036324; c=relaxed/simple;
	bh=MGIV2Zrds0Tr+Iag7pnNW8b4OboPtXpobSSn+Pg2GnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL755DvYrFJMZlbul/K33BQc0U26cMQLpX0VD6it47JlUyFlriOoKrYltkSy0b0QvcNZ+RLC9TFX2OvVU6vOBI6edskaEct1hv6MC4jYQxiuWk82G6vlXtYvC9Mo1tyTvzlyDKd/S+V1UBqL09fml/zIwBm74HXvDo93ZpT/AUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QfHXi2Cz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d6ad6050so1688675b3a.0
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728036322; x=1728641122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btQA1+hJcdMMNHgojMSUVQunR//xOuKAqvLVtMqwMTQ=;
        b=QfHXi2Cz+Q295WPZ+NVZZAIPvM2rdDfpV1j0ynClsK6Uh6HgpZVxDo+pnKNqoZANGt
         rxQZa5z74Ckqrk9EAEQdtFJ/OZkGEfbyXvqa4nRGbzvpd0/U2dnYuiVQd5C0ue3g2bsq
         ZrycXcrktVoVyn9fKYb5NwuwcbYc7teMm/06s0E2s30aVSo0brwQMnC+jJ9kGk9aXgVs
         nxTdyggv6LSvIsbo7e8ytrOfMpDV86ca7BfAa2+KMKdKhFmK7BvkLCQjo1lu8ZNd6tzT
         7LPVx+9AhvWiTdYf2IUqD5Jtz6P6stO+ODEkjotGdQ6XRDjfjHDg+7pD3YlUhXs8Yydv
         RIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036322; x=1728641122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btQA1+hJcdMMNHgojMSUVQunR//xOuKAqvLVtMqwMTQ=;
        b=vMjSJhkVdxbLPdmoXH/Cw6MY8vM0WA+Jpjy8dIwsaPGOaxbOQ+/NI1rvU8szk/x14g
         H9h83Bqp56rP3TCjxhdhKiofy9Ur19II8XuGRKx27ipC6D+CxycztAE2eloHq8D3mAbD
         4+ZmoQ5tu2JI5OCfk/M1FHDNqZjUOlkjSM1MdcVi6n8jY6j3eTf3yvcy/S74kACXpA4o
         KEyEPTaSSAIftCYNIHkro8N3vyD7Xtq1vmfPCwNZ3ERnV9LpPh4D+06vqJZ1YeO8Skxu
         /VxJPCtDdwZ2NMRSxJZJgbsqXm93E1F0j1BcPw6JRM6IZMrWhJQg7NdEM7a4X5KYroQg
         Za9w==
X-Forwarded-Encrypted: i=1; AJvYcCWE5tVkKQTM1J3Cxplt5pBk1tO//0kui2i6aQcjNxBAkKj+hHb7BWzfaPam9pD3yUA5RgmsUeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoWchClsvDLtzCzShwIH8M+p31HWMeWJ+VSAjkPDYPeYoAYOx
	qoshBRddnMT6eQSGevrlxqjc4rwEtrNGT2j/GmQEX5hugnrT0niLRm5XMIB/FxYbv/PhpOIzPuf
	b+nwCHw05jets9VI//8Go3/9k5+txq22/baRY9g==
X-Google-Smtp-Source: AGHT+IFkM7wK9W/MGjMxwILmKCuQzg/h44yqETKY/oTXPOtp+cPz5UrnMAjNkbW7FLSZEX1IsDwVg+1L3IRWtVfpYjM=
X-Received: by 2002:a05:6a00:c94:b0:71d:d1b4:b454 with SMTP id
 d2e1a72fcca58-71de23a95bemr3106191b3a.2.1728036322517; Fri, 04 Oct 2024
 03:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003170151.69445-1-ignat@cloudflare.com> <20241003215038.11611-1-kuniyu@amazon.com>
 <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com>
In-Reply-To: <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Fri, 4 Oct 2024 11:05:10 +0100
Message-ID: <CALrw=nEV5KXwU6yyPgHBouF1pDxXBVZA0hMEGY3S6bOE_5U_dg@mail.gmail.com>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com, davem@davemloft.net, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Oct 3, 2024 at 11:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> > From: Ignat Korchagin <ignat@cloudflare.com>
> > Date: Thu,  3 Oct 2024 18:01:51 +0100
> > > We have recently noticed the exact same KASAN splat as in commit
> > > 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> > > creation fails"). The problem is that commit did not fully address th=
e
> > > problem, as some pf->create implementations do not use sk_common_rele=
ase
> > > in their error paths.
> > >
> > > For example, we can use the same reproducer as in the above commit, b=
ut
> > > changing ping to arping. arping uses AF_PACKET socket and if packet_c=
reate
> > > fails, it will just sk_free the allocated sk object.
> > >
> > > While we could chase all the pf->create implementations and make sure=
 they
> > > NULL the freed sk object on error from the socket, we can't guarantee
> > > future protocols will not make the same mistake.
> > >
> > > So it is easier to just explicitly NULL the sk pointer upon return fr=
om
> > > pf->create in __sock_create. We do know that pf->create always releas=
es the
> > > allocated sk object on error, so if the pointer is not NULL, it is
> > > definitely dangling.
> >
> > Sounds good to me.
> >
> > Let's remove the change by 6cd4a78d962b that should be unnecessary
> > with this patch.
> >
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Even if not strictly needed we also could fix af_packet to avoid a
> dangling pointer.

af_packet was just one example - I reviewed every pf->create function
and there are others. It would not be fair to fix this, but not the
others, right?

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a705ec21425409dc708cf61d619545ed342b1f01..db7d3482e732f236ec461b1ff=
52a264d1b93bf90
> 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3421,16 +3421,18 @@ static int packet_create(struct net *net,
> struct socket *sock, int protocol,
>         if (sock->type =3D=3D SOCK_PACKET)
>                 sock->ops =3D &packet_ops_spkt;
>
> +       po =3D pkt_sk(sk);
> +       err =3D packet_alloc_pending(po);
> +       if (err)
> +               goto out2;
> +
> +       /* No more error after this point. */
>         sock_init_data(sock, sk);
>
> -       po =3D pkt_sk(sk);
>         init_completion(&po->skb_completion);
>         sk->sk_family =3D PF_PACKET;
>         po->num =3D proto;
>
> -       err =3D packet_alloc_pending(po);
> -       if (err)
> -               goto out2;
>
>         packet_cached_dev_reset(po);

