Return-Path: <stable+bounces-262614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wG0ELQlJKmpTlwMAu9opvQ
	(envelope-from <stable+bounces-262614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 07:35:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6166EA2F
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 07:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="kxH//JZX";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262614-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262614-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1D2304E0CF
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A49357D1A;
	Thu, 11 Jun 2026 05:25:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD0349AF6
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 05:25:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155540; cv=pass; b=pmZpurv14ifb+KnR5Cly5s88G4Ko2j1cgSJEX5LqMTPa29Mtx7uuh4Z196ahH83F5CFOwvoFQr8nCZIiEB7yqI4h9gBxfBu1UdfKHlERXYazIfQjDx4FfrO3M3uDESAn888Klxa8vHo4zTRS/Lmb8aysrpJbNgviUfJHTPDBWwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155540; c=relaxed/simple;
	bh=doUH9A5FJeHhSpLTZvYVSKYZvkUfrZzvjQ6bRoxSw9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGrjoFLcs8noWb/iAQRUn+HUCHRGyMPexbF+v3Vce1LZTM8MpeOzDhqSj3dfsUQl7hOreTiMDMHm4U6ePXG6klOp9CkQegfPCplXuCdFiEM9zaTVQhcZHXpeIgJX0++kjOrWsdaP6wZRs6MFGhAPxxaWkAAaVCCkgrgyt2D7EU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxH//JZX; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13721dfd471so9773075c88.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 22:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781155533; cv=none;
        d=google.com; s=arc-20240605;
        b=jj3BOe2S/KZDqmlIpYIyQfzxruwMf429lK5heiJWX0pS+GMDlB0fDksw6wLJ0MPJWf
         fQGHpzn+EiFRsM+sjHT53WT6tywXjEZLk/OOmyrQVDHwXIxJjSIt3HT27HnSvseVED9E
         AkdqjKJPZVTdSRg/ciZRBOGxvSY9D/GT3/0XWC0ASw4S1QB//GgeI/K6xVCwpqhFqCuH
         2bkfVi9ie3oU0I/wYEvsTePVTSimM1jWPimr178HaUbA9bujuURpjZimK/8Ip3h6tcoy
         g/fpB6k9cBzICwcFsMzI6z3qvS1i0AiXwFbeMbSEzjixGXiYN1Vm0lTUdLDQTqfAfZjx
         1z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsXPQ0eSPRjGxPvV6S9kXwYJJ8AOokCaHBCHCpNZoVI=;
        fh=lnGoja6UtjvVMVQ0DchpD5LxYxtnEC83RsZVdWPif44=;
        b=jEu5Cc+n06LtrfKIJqvlESv5jylAqr5w0V6hzj1of+zao5DSR5AH2JCA2cQZ1RUm0a
         LzHIsTNJrehK+/IBWj3149UhauLvc3PirXJ6GV4mv6sArd7xFepYVuucGjwOmhydVMO2
         x5hWisAXIyz+K88mEWPIPlSguLc0mboCQopqIt04Mu2LxCIFLHp/WC2px4dR4mBPWTpk
         xDsXnI5MoUv9KRiTzkDrxKI/uPjw5r6Auyb/S0OqSiz8BrrI5L68typA/xzVuJ7jm7iT
         ZVPKm7QSMua/u5vno/CwKto9IArh9Gc5EWnogf6oiyD5pAOQgkUXy0JsXjJHf+H/VLEV
         j79A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781155533; x=1781760333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsXPQ0eSPRjGxPvV6S9kXwYJJ8AOokCaHBCHCpNZoVI=;
        b=kxH//JZXSfZITF8DuxQ/71UBi7IfevT5VexptsvFppd552u5EQWCvDV4fhj1txugw8
         MveE71rjZ4ApYdzdGX9hCGjzJy9lmatcV7sg3HEHq6MH7sIwILVDMgkw0XuJxH/6Eov4
         vvG3NkW1OAf0PVMd1HFkUIITBdoLtlMRK4afTXVKccY9Zj1RvfJOnkFl3qxhQrVYAUIE
         pY2kt6rkJ0z/sBRE1k4NuPVjsOmgUPK4uNUeF0b0Sj82fbAuJuyTTvpyG6MS5hvp3mXY
         qh36eeetkBGxvF7PdeNT3ciDdk6mu/xGU9FFPJ0lb7LcaP2gS+/+VnI/kXm4MK8Anber
         ZQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781155533; x=1781760333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsXPQ0eSPRjGxPvV6S9kXwYJJ8AOokCaHBCHCpNZoVI=;
        b=llfxoagMEG1KNNAc7NklfdZnuc+O9Qajp+qLVU92y7jrU6CpNMAaDqFoNIC4PGKBJm
         1hoTL4uitfk/HaSJTO/5//pmvK6ugJN57mvV0eMn+0k3dBlGWuIQgszTwiR3EE5CyFv2
         q29dDCg3HOFjHFwA1ba8yZ07418NwfUxGwjwC5ZvyJVNt+1RYHiQ43a9wdw/tQUZAFlN
         Fz+mgbdbgfdqK9n3yKQdE7pXnXm/rAVJHBmQDkw7cMQrepo2pH306073AOKTYREFTiI/
         4SVXJ3Nzk4FDrM+aC04E0/Zjj0fNGhKkS+k8ZKP15GBLvR9CDEJWQFq0yxhySZutvrs2
         DRng==
X-Forwarded-Encrypted: i=1; AFNElJ9b0+w4FIqcbMV4Y8E3feev44EpiY+bbYwNVaLUT3Lt5dq796kAz8bkUBOreM9r9sieP5v1kmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2N97UVumKhsARjGFPogA/Ooyk40ijmR6rhrm8CMJ2GaKt/MiA
	Q/G3rCawc+NjtZr3blMC5CQhGe36xMXVwTsnVZ7LknwpycaW/OJxxa6cKy8vKq/kTH8qfvShXK0
	eaSdZ36jxDea1xbZ5pPDCWMuGH26vrNQLHf+2dRwu
X-Gm-Gg: Acq92OFb42J4ohNr0QhLbqu/EHenA6KD4INyJMO+5OwDjH0gk8s4Br0tB8Xej9LMc83
	Xrv79mtGyycikatxZCbEOpWid88kca65XMDRXravRdwA6jxWlGGbs3pxcUTDyqekCRlFgYkgPr2
	3snj7HAIcf3V1W4Zxdw69m7q9CTiPGdcuLcbraAXkcuMlzK7sgvtp/gkKUXmZT31dF4TuVadLhl
	qbKVDRNGr2DNychwcPwB1YrZWJA+K9XxDncIJmWZydeoDiWydkpsJ8U7nqD8lYT0aukE6480C/i
	4i1s6KGka4Djp4FkMJ0Kq8m+v6un1jtSOW/+bUhfoB4ITPuPRGnXdQFxBA/uvNR74TipzV3Y2lS
	Wcexl8e0fT/RIovUnx36V+8/07+wyj7jDvVMiyO20Rv8muCRT9etWRmda4iWegKI=
X-Received: by 2002:a05:7022:fd04:b0:138:243e:ce97 with SMTP id
 a92af1059eb24-1384211ed0amr814067c88.4.1781155532797; Wed, 10 Jun 2026
 22:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com> <20260609163110.1717419-2-maoyixie.tju@gmail.com>
In-Reply-To: <20260609163110.1717419-2-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Jun 2026 22:25:21 -0700
X-Gm-Features: AVVi8Cfeeen7lsi6FYsubpu0yMJSyRS-lpOJ_IEl5eZUW7gNg_gtEJK7dUFJJ50
Message-ID: <CAAVpQUAzWFyif353QDyOXCw9BHCFasbWHh+gKKz=EF9Ot_ODBQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/7] net: ip_gre: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-262614-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,ip6_tnl.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2E6166EA2F

On Tue, Jun 9, 2026 at 9:31=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> w=
rote:
>
> A tunnel changelink rewrites the tunnel in its creation netns. After an
> IFLA_NET_NS_FD migration that netns is not the caller's. The rtnl
> changelink path only checks CAP_NET_ADMIN against the caller's netns. A
> caller with caps only in its current netns can then rewrite a tunnel
> that lives in another netns, and it picks the endpoint addresses.

nit: This paragraph is not precise (e.g. even without netns migration
a device can use two netns w/ IFLA_LINK_NETNSID, "current netns"
sounds like current->nsproxy->net_ns but not w/ IFLA_NET_NS_PID
etc, also I don't get the last sentence after "it picks...").

Simply state that changelink() operates on at most two netns,
dev_net() and link_net.

>
> Add net_admin_capable(). It requires CAP_NET_ADMIN in the tunnel's netns
> and is skipped when that netns is the device's current netns, where the
> rtnl path already checked the cap. The other patches in this series use
> the same helper.
>
> Gate ipgre_changelink() and erspan_changelink() with it. The check is at
> the top of the op, before any attribute is parsed, because the parsers
> update live tunnel fields first. ipgre_netlink_parms() sets
> t->collect_md before ip_tunnel_changelink() runs.
>
> Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
> vti6_siocdevprivate().") added the same check on the ioctl path. This
> adds it on RTM_NEWLINK.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  include/net/net_namespace.h | 18 ++++++++++++++++++
>  net/ipv4/ip_gre.c           |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 80de5e98a66d..17fb71a78cb6 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h

net/core/rtnetlink.c is a better fit.
It has rtnl_get_net_ns_capable().


> @@ -358,6 +358,24 @@ static inline bool net_initialized(const struct net =
*net)
>         return READ_ONCE(net->list.next);
>  }
>
> +/**
> + * net_admin_capable - test for CAP_NET_ADMIN over a network namespace
> + * @net: namespace whose state the operation would change
> + * @cur: namespace the operation runs in, e.g. dev_net(dev)
> + *
> + * Returns true when @net is @cur, where CAP_NET_ADMIN was already
> + * checked for the running namespace,
> or when the caller holds
> + * CAP_NET_ADMIN over @net. rtnl changelink paths use this: a device can
> + * be moved so its state lives in a namespace other than the one the
> + * request runs in, and the cap must then be held over that namespace.
> + */
> +static inline bool net_admin_capable(const struct net *net,
> +                                    const struct net *cur)

Rename the helper and change args to

rtnl_dev_link_net_capable(const struct net_device *dev, const struct
net *link_net)

since the netns we care about here is rtnl_newlink_params.link_net
(if specified) and dev_net() is redundant in all callers.

Also remove kdoc, it just reiterates the two conditions below.


> +{
> +       return net_eq(net, cur) ||
> +              ns_capable(net->user_ns, CAP_NET_ADMIN);
> +}
> +
>  static inline void __netns_tracker_alloc(struct net *net,
>                                          netns_tracker *tracker,
>                                          bool refcounted,
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 169e2921a851..040a0ef95184 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1457,6 +1457,9 @@ static int ipgre_changelink(struct net_device *dev,=
 struct nlattr *tb[],
>         __u32 fwmark =3D t->fwmark;
>         int err;
>
> +       if (!net_admin_capable(t->net, dev_net(dev)))
> +               return -EPERM;
> +
>         err =3D ipgre_newlink_encap_setup(dev, data);
>         if (err)
>                 return err;
> @@ -1486,6 +1489,9 @@ static int erspan_changelink(struct net_device *dev=
, struct nlattr *tb[],
>         __u32 fwmark =3D t->fwmark;
>         int err;
>
> +       if (!net_admin_capable(t->net, dev_net(dev)))
> +               return -EPERM;
> +
>         err =3D ipgre_newlink_encap_setup(dev, data);
>         if (err)
>                 return err;
> --
> 2.34.1
>

