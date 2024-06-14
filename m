Return-Path: <stable+bounces-52207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D008908D73
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ED2288BFC
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C8171B0;
	Fri, 14 Jun 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eh5r25wg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82366D51C
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375578; cv=none; b=boqC+enMJUWSHDoTUVxMgXrAGF89lHaAzqj7QTiLQLC6y8cUrt0si210l1XPSPfmlXueRxFik9f3bPIClImuN2beakBVZ35DISkWlIGbweL7S++8Qw058vhjx/2h3XOiZX+3ACutB6lm2wi80mafRKbGbr0Lvqfud2WTRvjpw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375578; c=relaxed/simple;
	bh=RKc6T39/lDmb0PfrWOKSfypECfYy+KzXmzWz6xd1B3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paxiQLBq/UjTFkVBbTSTjl65ygeWGqAireKtZHJJtugfS3/SZMyUSL7agWD22h21ZKwg8HuCGkZrguRpGFrGy7boPk2NeVBHYrBnWPLxCF567fTpZeEQrs3IVUrn7t2vGls3t+SfmZ0dKWFfDunJ5B+GtSJ4WUb5R/Tk40gNIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eh5r25wg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso1852562a91.1
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718375576; x=1718980376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmTKXhIPP/E6AeMNlSr6idjALZflTqy4gRU9SHdel9M=;
        b=eh5r25wgHjpU8EnKrCAlj5lO1bJ82v194Tq98vRZvknWMKYJe4ctul/jprhud4V9I1
         MCLf2PvS6BG3sbZ+SZAz4EKf9b2CYQaQbM/XNgKJfTvtJe2Mn0/2WBqWdVq3uriCbMZE
         v3aXuAPRVpf1W+J64THiMsWcPZdvj1fZaRmSy1QvRpN87sbAn64NxQh8Sdheefb4bOZ+
         3Nv+sjv8/L3SKWHie9P1kBzBhwFf3cifuV7xhndyaFNrPbUTS/E9eL95dCPTlogRn1Kv
         iZ9PyCkiht2ArK2WB8gx1SHO/0jChvbbT03PY/eaIS6qPfehAHOIP5HzBTkPgSCsMHv9
         yE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375576; x=1718980376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmTKXhIPP/E6AeMNlSr6idjALZflTqy4gRU9SHdel9M=;
        b=LobUuwzJA1M0n+WCP00oXSnmFt3Lhr2pCwZOZAQyuz+flTyvb4YyXBBcz2MmJVaVaj
         Uq68XXHH5fDRAKUnKPfPnovcddbkcK8scy+zKASPlRE657ig9nJkEUASt1zsM5AN4cUI
         AZY+YzmC/RBX2lVa+KBYCrnAbBuX+OV5F6CcQXbWTCUVQcZJvCP/mXkb7449NnDCZDtP
         6CI43moqW1TYZ5Bx6Azxw3vO7zSuSH0cVls34MdIIPAM6gz3hoeJcPOfMJJPNqV10SFw
         4WaxPti1/br1Et2YtNNmdttz3Np83svtFWI6ILALxjKM2vswncNk3x9tBTdiIAciAK/q
         to7w==
X-Forwarded-Encrypted: i=1; AJvYcCVnEUEbNqweiGw1ldXf8nmdSFZuNIlIuSv37mXPiRJ9Z8w0wKMWYCFecRaJdAFKZm3vrS4i85SM7wMCK+nHHexjRhjFmhty
X-Gm-Message-State: AOJu0YykTnDg8V9r+hmpCeNZizIJDcaXu31SNyC/E0zOjq53IG7JQpsf
	2qL0gpBuIsnq8iCFqmxjW9Rqforp/swC1g7F+gY/0eyTlSXinHc1NxX8ZPSoYJeKB0DZh3xkNVx
	xt9683Ke/UBb290wjfk0vNpByNuzxqf+4F6wnB90lXXAz68OqRok=
X-Google-Smtp-Source: AGHT+IFPiAh0aeBq6xYUjN8mX4IW/PAsfUQs8jb283aqV3dQ8WT2sDgO3JG1TYGiMkc7aIHTJxWeuXKKUMN+LnZejZE=
X-Received: by 2002:a17:90a:b30f:b0:2b3:9ce8:1239 with SMTP id
 98e67ed59e1d1-2c4db132d2cmr2981189a91.6.1718375575765; Fri, 14 Jun 2024
 07:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALrw=nEVktSeq4HcLqM0VfTrdHCLHeqi71-fKD8+UcBjtoVaBA@mail.gmail.com>
 <20240613194047.36478-1-kuniyu@amazon.com>
In-Reply-To: <20240613194047.36478-1-kuniyu@amazon.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Fri, 14 Jun 2024 10:32:44 -0400
Message-ID: <CALrw=nHaNZfkkEiYot=aSTZ0_9QzhxRkumnaCv=DOz8pJtZOiQ@mail.gmail.com>
Subject: Re: [PATCH] net: do not leave dangling sk pointer in inet_create()/inet6_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsa@cumulusnetworks.com, dsahern@kernel.org, 
	edumazet@google.com, kernel-team@cloudflare.com, kraig@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:41=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Wed, 12 Jun 2024 14:22:36 -0400
> > > And curious if bpf_get_socket_cookie() can be called any socket
> > > family to trigger the splat.  e.g. ieee802154_create() seems to
> > > have the same bug.
> >
> > Just judging from the code - yes, indeed.
> >
> > > If so, how about clearing sock->sk in sk_common_release() ?
> >
> > This was my first thought, but I was a bit put off by the fact that
> > sk_common_release() is called from many places and the sk object
> > itself is reference counted. So not every call to sk_common_release()
> > seems to actually free the sk object.
>
> sk_common_release() is called
>
>   1. when we fail to create a socket (socket() or accept() syscall)
>   2. when we release the last refcount of the socket's file descriptor
>      (basically close() syscall)
>
> The issue only happens at 1. because we clear sock->sk at 2. in
> __sock_release() after calling sock->ops->release().
>
> So, we need not take care of these callers of sk_common_release().
>
>   - inet_release
>     - ->close()
>       - udp_lib_close
>       - ping_close
>       - raw_close
>       - rawv6_close
>       - l2tp_ip_close
>       - l2tp_ip6_close
>       - sctp_close
>   - ieee802154_sock_release
>     - ->close()
>       - raw_close
>       - dgram_close
>   - mctp_release
>     - ->close()
>       - mctp_sk_close
>   - pn_socket_release
>     - ->close()
>       - pn_sock_close
>       - pep_sock_close
>
> Then, the rest of the callers are:
>
>   - __sock_create
>     - pf->create()
>       - inet_create
>       - inet6_create
>       - ieee802154_create
>       - smc_create
>         - __smc_create
>
>   - setsockopt(TCP_ULP)
>     - smc_ulp_init
>       - __smc_create
>
>   - sctp_accept
>     - sctp_v4_create_accept_sk
>     - sctp_v6_create_accept_sk
>
> we need not care about sctp_v[46]_create_accept_sk() because they don't s=
et
> sock->sk for the socket; we don't pass sock to sock_init_data(NULL, newsk=
)
> before calling sk_common_release().
>
> __sock_create() path and SMC's ULP path have the same issue, and
> sk_common_release() releases the last refcount of struct sock there.
>
> So, I think we can set NULL to sock->sk in sk_common_release().

Thanks for the explanation. Makes sense. I'll spin up a v2 with this
(and try to test it as well).

>
> > Secondly, I was put off by this
> > comment (which I don't fully understand TBH) [1]
> >
> > On the other hand - in inet/inet6_create() we definitely know that the
> > object would be freed, because we just created that.
> >
> > But if someone more familiar with the code confirms it is
> > better/possible to do in sk_common_release(), I'm happy to adjust and
> > it would be cleaner indeed.
> >
> > > ---8<---
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 8629f9aecf91..bbc94954d9bf 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -3754,6 +3754,9 @@ void sk_common_release(struct sock *sk)
> > >          * until the last reference will be released.
> > >          */
> > >
> > > +       if (sk->sk_socket)
> > > +               sk->sk_socket->sk =3D NULL;
> > > +
> > >         sock_orphan(sk);
> > >
> > >         xfrm_sk_free_policy(sk);
> > > ---8<---
> >
> > [1]: https://elixir.bootlin.com/linux/v6.10-rc3/source/include/net/sock=
.h#L1985
>

