Return-Path: <stable+bounces-80721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010298FF1C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46451F21CE8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D848140E38;
	Fri,  4 Oct 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="humaQc4M"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F213C810
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032130; cv=none; b=cmcpgwuDnmbh9ub59FBTaqSv0NgFBd7UcoX7loGuQAOdR+EFhOiZZaHs5e9MwCfcjB0gX3gx5v8AL6DF0vH/g05riuc0HnxAbvPsbxOa4cNSwqVMPu/TLJOFmXb2OxL5eUro45LzO9Qyb9P9AEUBEMDCCo2d6kpX9eMcp6RXgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032130; c=relaxed/simple;
	bh=G4NOQYUd6lbAZrqBMu3K3LRuuLXb8ndFNWXjGjfThWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6DdbzaxakhRUID53/PbJ2/bZMK3jik48G52LmjbPy4UP9GEf0THReNa/cCmNkRxrpnanqtqQzqozZ90h3Vj5hkK8u7hQ3evHa4mXd88LFa1F9OIBQ58JvVpIRw1M09OTNx90nUP9dRsTkiVgqdgGSJJwbQvLAz+SvsjPQ+sNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=humaQc4M; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so23415491fa.0
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728032127; x=1728636927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHihkRJ426qI6C5wVNLcGdq46sW64PqDR1x8Iq4k5k=;
        b=humaQc4MtqhNrQg2IcqU4fsW6Uv1V40uVNxxwWDhibF0H9N18tGvWMXie7bWeWeumh
         MRFpK/k8OtUbx/8h39u+zrnMvfRCT5fHj83grBq5pycQdWuKztcGpUwb+FnJg6IQLXY7
         vEXVxxA8ViIFGmIMeh0f5Gf93JqP0rf77GaGd6PYbu1d8FSJkLKLWoNgxpaDerKSCyhX
         t7Qj+t0AS8xCy8AISCSusBvbSlpc2tjsxY9XufZxMWNAWizF3xpMQZ9tjX0Lm7bHhGQr
         HS79eVHRl0kWTnkgCpvHDuxCfa3FzFRp9hRtLb7xvdHueHvRdtbKM+/wd0ejCbPt2ozA
         +n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032127; x=1728636927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APHihkRJ426qI6C5wVNLcGdq46sW64PqDR1x8Iq4k5k=;
        b=lNce7x53auXDpqAOOaW6PFNkXcDNQ4EPoC4zkBnkYtIC2Ict8nwjLG02myQhA22FvA
         2tl5GN24fdVtxx5e8dDCdi7BfrFuKWSMz/IIU2wxAMc965mTi0ohwbWAcmzpbQouBPe9
         vDsj+pO2z81Asdnj4Ti8Y5qoM/I+vY0XTeT7WSrw/4aP0+DQu39SLVpu3+CVl6O6lVyS
         uaqanzQEw02A3Y4wv2VvAFyrvd+3RIWW7y6hE+vvLlDElBkiP3WARe4hH2uIMyD/1/+B
         nLc+tVhwVYpUgUETifQUXSzBF8b1GPH6zl3KHLtmGM/iGkxnYLBePk8vWCjBA9HCO/EN
         DPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcE2kq9sIZ0ob8dsYU6LC4Q2IPLXZ+yM3p2lY/YpZySQGSl+oSj8lr4IDdwd0o8SOcZad9v80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrhShBzoO8h6XGn5LFYtj+3q7efSrdY80GfUyNXNQ+Tmf4s9E
	DFJKSAY2eZOYKWQuFTBWwz1HRpc9cLp7PBl2eebnhnP8zUjA6AmF+qvW6VfLfYux9683L1XEXV2
	Y7LugjtorFIIJBEm4gkelFg9VmxU5rFLzIMIP
X-Google-Smtp-Source: AGHT+IGTqyJALZax478RwJ5kw0jUBmZiI4PXZFZPCOQh2NZNXGF5/4paa1kJ4psKYCjn+3Xprn5TVs/ZIHHKuAqKKg4=
X-Received: by 2002:a2e:be90:0:b0:2fa:c9ad:3d17 with SMTP id
 38308e7fff4ca-2faf3bfffc0mr11399431fa.4.1728032126561; Fri, 04 Oct 2024
 01:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003170151.69445-1-ignat@cloudflare.com> <20241003215038.11611-1-kuniyu@amazon.com>
In-Reply-To: <20241003215038.11611-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 10:55:12 +0200
Message-ID: <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Thu,  3 Oct 2024 18:01:51 +0100
> > We have recently noticed the exact same KASAN splat as in commit
> > 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> > creation fails"). The problem is that commit did not fully address the
> > problem, as some pf->create implementations do not use sk_common_releas=
e
> > in their error paths.
> >
> > For example, we can use the same reproducer as in the above commit, but
> > changing ping to arping. arping uses AF_PACKET socket and if packet_cre=
ate
> > fails, it will just sk_free the allocated sk object.
> >
> > While we could chase all the pf->create implementations and make sure t=
hey
> > NULL the freed sk object on error from the socket, we can't guarantee
> > future protocols will not make the same mistake.
> >
> > So it is easier to just explicitly NULL the sk pointer upon return from
> > pf->create in __sock_create. We do know that pf->create always releases=
 the
> > allocated sk object on error, so if the pointer is not NULL, it is
> > definitely dangling.
>
> Sounds good to me.
>
> Let's remove the change by 6cd4a78d962b that should be unnecessary
> with this patch.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Even if not strictly needed we also could fix af_packet to avoid a
dangling pointer.

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a705ec21425409dc708cf61d619545ed342b1f01..db7d3482e732f236ec461b1ff52=
a264d1b93bf90
100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3421,16 +3421,18 @@ static int packet_create(struct net *net,
struct socket *sock, int protocol,
        if (sock->type =3D=3D SOCK_PACKET)
                sock->ops =3D &packet_ops_spkt;

+       po =3D pkt_sk(sk);
+       err =3D packet_alloc_pending(po);
+       if (err)
+               goto out2;
+
+       /* No more error after this point. */
        sock_init_data(sock, sk);

-       po =3D pkt_sk(sk);
        init_completion(&po->skb_completion);
        sk->sk_family =3D PF_PACKET;
        po->num =3D proto;

-       err =3D packet_alloc_pending(po);
-       if (err)
-               goto out2;

        packet_cached_dev_reset(po);

