Return-Path: <stable+bounces-249733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAWlL2gmDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:11:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78558714A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B664930028FE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D16332638;
	Wed, 20 May 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIeOIMQP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416030DED0
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246651; cv=pass; b=e8mTi/ZInPJ53CSipfQbE6BpxD9dHhZ6qMcS0eEA0dyIAroX6Qp9FIRfH6Cmc2tf4sdbcw4FXQv5d9F6rlIokcyfOLil+nBh6jFdPBjwHIw+dWhQkw9Acq1ZnVvI7vqKzOvvslsdN57D8/maoC8W/mhwBDhqzBTdJj1XKzvsOzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246651; c=relaxed/simple;
	bh=BMHrQTe2c6EDMZGb7kDM0vRuhZGlq/BxcLHexRcE3Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jx/g+u5cQgEzbvBMIGzOhl7CpWXlmdJ4NhqXjrHYkUD0//AlgEFZzD/liQDkTjubU4oMMaPuQlH20pKjpiqsStv6gHNAqC9FJIfjNHCCl/RwVWP4BQJhIatbCxRv01XAC5ornE5ZwKIgchZ9L2+Qn6KnAyiiYB2LHZm6lBh4uGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIeOIMQP; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45e7c636e74so2014092f8f.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 20:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779246648; cv=none;
        d=google.com; s=arc-20240605;
        b=JP1YPFh1ovm3jrW1Mp+wlWD+5Aimg7QF4dBSt/IJUtI92yij91hMXO19JfoPM6IobV
         qC65HHgvFGNx7GdaDRij9L0om3urb37DcMIoMqaBCfmN/S54/EGTOq3qFiZzuVq54ZAb
         9eNAan+CJ8jkWGoEjuYgKFZdqkOxvw5FAlAyFyNA2woS4a0hAWTy5IN5eiiQhBZWcPEy
         yk+lY5qdy6TCE4BXxun14D3yIb/wnytQDsqOMNtk+exIY2VJ1r+xREP+OGF67S4qION2
         3nLKFHlNpw6u9EdLn+LCVmPZvEva7bzZWQ4qOFmcdVslz159UKukAcoIZZBR35eQAwzR
         Nneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QsR6q5JfX7B48DESnaRhiDdBNO0p5N+mlvbf9lr1YNY=;
        fh=oxrKwNFCuVqG0mkwaxkIZil7lVzqkSKC55yYSAr6ZFo=;
        b=URFgI9TG8jsJB1GG4MCdauAxq8Y37TX6es/CemT6fNXIiBNIsIg1Bqt67FnrJq4Fuy
         LYlNfoae8U2Gs5zWS7WLgkDeyq89vJvcVrauujwPyl5eNRVwqLMHPZ/8xtMXBICmaKIT
         qRxuSdDn6VRFUetnOIqVLV4HAI1Vkf15dwC/RUbc4ycVozyqlZdlqi17UOp544za4pBo
         huOhzb3lkxS0RerbClmofeaVWSo+0ugo9VIXOAMX7RhZmLxByC9oX9Tw+Do1U3l5kqy8
         TCm1ID92tqPI1vZPE1WYfXvfLTNGve1GbB7eM321TQxPxwsOT9anDAmFysGSWsK6rSc5
         ZP4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779246648; x=1779851448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsR6q5JfX7B48DESnaRhiDdBNO0p5N+mlvbf9lr1YNY=;
        b=sIeOIMQPUIb8QCimCYGH3Gf+pgfLizgI4Ra0uzoKuHNIhdcfdzXtUUSFqVhuUNUdUf
         VhWn6pcwR1ELimwN7wer2QgWVlrNmYKuADHlqYtuUZBloyHqA5V2HQT2275c4C544670
         2MWNdnWxtFXmxC3zq0CZcHUQ2Ng8cgJtEXU6ctB5bGkHWhAGPSSxIXAAUjy5LNyXz6CF
         BXLUkqFXcablD31ebBlWOThyFj9HF+PhdYDkeKI223WDCxUPVbEGcznITVg7RknCmOQm
         LYxbLzBXBwOBhM+2r9cJd5ouR/0unj2hdONSejimFcABkagFKx3eFZv8JhpMuFPgon9j
         DotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779246648; x=1779851448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QsR6q5JfX7B48DESnaRhiDdBNO0p5N+mlvbf9lr1YNY=;
        b=mf0TlbDjulPdDvehP6l0Wffm42PebG4inOLoeCvqIQ8m7Ffscw1SoX4Nhdd+37lN4e
         h8tZh+wvMChFDzqSknQyFSoLfBT31Ab9bYuGRMX9gpJEbr0NgVmOzSnMT0NdRYI7VB9l
         lFhoo/zqkzts/xotMCcC61JvVIcP61fVE3mR1ouyfjsfCtTjnZ1vH9aJd7KkIy8zhEHk
         n8qprVUMjdeJqrDxBtdfrTglJ+Q5EvH5s9uw9e2sxnNA+CZMzUHlJugAaCBWnaytExyc
         u6d6SZypSM8juYbk9mDk9xT7FWQlxnMMKCotkEf9RmKQUjtqFMr1w8iDwMSBe5jeliXY
         Dlvw==
X-Forwarded-Encrypted: i=1; AFNElJ+HYN8nU4rflAw6tIfisz2Z5wgHyCQCVdhKG8W9qmO3XogFYSA/eGd/hn9LFMsPsor6qjA3imk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+zWtZ1+A2agUlpBeUYfLRgk8Bhqr6WwMTzhbhwonqiLUMdGj
	cqK48jPE0zJITF8RqQsSEsN1sv25IoQDoJHKzLAyygjjgqclpbXFZvek+I+KFS3x4bJXxG5+0S8
	XuH2wHDtaju1li5T8O1qQbaJPgqMYK4o=
X-Gm-Gg: Acq92OEDq4ShJIqLGGe6dV2RpZI0D+gUj+Yixu/Y2SBopOpibAwywzCyrgk0tBj1OeN
	IZ+IDE4vI7f76cTmkpFSn8sdqeCWFY3ipjsLDfJ9ug+IZB+XcbUYBNbxo/lIeNrvGFBHD2W07TP
	hewURalsqaQ6Rvuf5/4IgbMkyoVRVj+vcFDCzupqDy3RJ96vMFd/cXJE+tXCfOD97FXTQcM3fJv
	R/jKhYoANdSqRD2bWAxYNKXyh3c1UpAgsp/pTbkjhHNuHQ8u1eVDwVGLElF98GvvW6bWZdbUROH
	GY6RxtGTErwrxMTawKZp0p74Jk81RafhlcfcfQ==
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fe63263dfmr356252365e9.16.1779246648329; Tue, 19 May 2026
 20:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com> <20260519123547.2055911-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260519123547.2055911-3-maoyixie.tju@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 20 May 2026 11:10:10 +0800
X-Gm-Features: AVHnY4I3AptLgQdP84Anayx_kwHlX9_fdHBoUR4ERtTWNcQUZL0x64t1gnXMsec
Message-ID: <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249733-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,ip6_tnl.net:url]
X-Rspamd-Queue-Id: CE78558714A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 8:35=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> After "ip6: vti: Use ip6_tnl.net in vti6_changelink()." in the same
> series, vti6_update() unlinks and relinks the tunnel through t->net.
> vti6_siocdevprivate() still uses dev_net(dev) for the collision
> lookup. For a tunnel migrated through IFLA_NET_NS_FD, dev_net(dev)
> is the new namespace, not t->net.
>
> The SIOCCHGTUNNEL path on a migrated tunnel then proceeds as
> follows:
>
>   net =3D dev_net(dev)                    /* migrated netns */
>   t   =3D vti6_locate(net, &p1, false)    /* misses target in t->net */
>   ...
>   t   =3D netdev_priv(dev)
>   vti6_update(t, &p1, false)            /* mutates t->net's hash */
>
> A caller in the migrated netns sets the migrated tunnel's parameters
> to those of a tunnel that lives only in the creation netns. The
> collision check in dev_net(dev) sees nothing. vti6_update() then
> prepends the migrated tunnel at the head of the creation netns
> hash bucket for those parameters. Subsequent lookups in the creation
> netns resolve to the migrated device. xfrm receive delivers packets
> matching those parameters through a device the caller controls.
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"). Cross tenant scope on container hosts.
>
> Use t->net for the SIOCCHGTUNNEL path on a non fallback device. The
> lookup then matches the namespace vti6_update() operates on.
> SIOCADDTUNNEL and SIOCCHGTUNNEL on the fallback device retain
> dev_net(dev), which equals init_net for the fallback.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")

Again 5e72ce3e3980 doesn't introduce this bug.

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  net/ipv6/ip6_vti.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -834,15 +834,19 @@ vti6_siocdevprivate(struct net_device *dev, struct =
ifreq *ifr, void __user *data
>                 if (p.proto !=3D IPPROTO_IPV6  && p.proto !=3D 0)
>                         break;
>                 vti6_parm_from_user(&p1, &p);
> -               t =3D vti6_locate(net, &p1, cmd =3D=3D SIOCADDTUNNEL);
>                 if (dev !=3D ip6n->fb_tnl_dev && cmd =3D=3D SIOCCHGTUNNEL=
) {
> +                       struct ip6_tnl *self =3D netdev_priv(dev);
> +
> +                       t =3D vti6_locate(self->net, &p1, false);

Also check ns_capable() against self->net?

>                         if (t) {
>                                 if (t->dev !=3D dev) {
>                                         err =3D -EEXIST;
>                                         break;
>                                 }
>                         } else
> -                               t =3D netdev_priv(dev);
> +                               t =3D self;
>
>                         err =3D vti6_update(t, &p1, false);
> +               } else {
> +                       t =3D vti6_locate(net, &p1, cmd =3D=3D SIOCADDTUN=
NEL);
>                 }
>                 if (t) {
> --
> 2.34.1
>

