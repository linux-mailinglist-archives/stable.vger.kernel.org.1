Return-Path: <stable+bounces-262866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JaQ6AhKuK2omBwQAu9opvQ
	(envelope-from <stable+bounces-262866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 08:58:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2866770EC
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 08:58:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tDnnLq66;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262866-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262866-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E821333C7DB
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB13AA1B8;
	Fri, 12 Jun 2026 06:56:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6039936B
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:56:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247368; cv=pass; b=mR3kq0F5NiEofAN3KEOpVkqDIGLXuS5xHX8SOHHRfFjfYvDCHB0LjH/Nx/b4P7H8NbTMvpieXs7izUMzr21VcoL0wSD4Rak5h8i/BoBgVTXtyJdphoLeMo77P9CRfFSG7iP/Cx3TwaDW/HO81qTF+IiA5zkar4XexkzWmhYD2Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247368; c=relaxed/simple;
	bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFA6jvOqgsUAwIATpCnDBgQ7Ue269vx889VI2mj5B0QrQd7T+YYq8vtuNSZmrhHHSjehevk6N4O1eydoIrEA+4De0psVq2K9Dk32PnDWRobWc9aEi2obXRIIbLZ1mLnl04BkUpvf9DYaIFCbbCHda9d+SBAWMzUH6YCtdNq2hlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDnnLq66; arc=pass smtp.client-ip=74.125.82.50
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13807d2f898so726812c88.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247365; cv=none;
        d=google.com; s=arc-20240605;
        b=XsOXrCjwUnJHzjnLsEnfDzVqfGcqLE/eayvMLWLvHx29zXVb2tj6hawpXMp83r8BTF
         k0TK9jz3KcnpPZdKl3HeNA5HFAYPDL9ntVHDTIaPHBQDobSHNYuGp47dxW0sWtXpS11Q
         BF9s00bE8RJrHEqjht+S7axBxIJy5lB4pxMFU7asSmnR0DyioeeHYpjsUM33O2vwboV8
         xr+ox3Y+JqhlcHpfBZ1/NN4eOxuRyXuajMDzkVUrzATUG/ugKL+kJLndl9z/JOAeUNe/
         GIH9EUZolgaDjhLcfPeudBQm2XPK0TuvWAB9qzM0XK7gVoeaa194yKSDnh9GkfuJBk9S
         1J2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        fh=rjsNYrmaXFSXt/EtUwBLRXcxpsTXBxCTKmWLNwB70FA=;
        b=Tjx33jYvxaNqWpObN3ZQWAN+fJeA7lG6NG9hTpwW+P5asrvnqE0up+OjJtKtzIzIGy
         NLk8yhd+K+qrexd8byAyfF6UFglD+5MSW66dyqtSj8JaAxRcg4bgrx/Roq2jTAjCavNK
         ia8xwGnAQ4icERxwZV0RE5oKJ7PGt/38iehkcNxYnd6UH1PNNcocRBm7a4cvjfWbprRe
         vIDHve9UkHy4F29t0Ie97ILuOPOt7r2J+3EITGfHd8qW1xfutzjy3Z1F8oTTaQBKBc/f
         +lKBJPgqI2ExorIT5pwTr3PZIGloYB7FY9J0K8SBswkUNYrkF7YdiUV/APcsRK1tWX3U
         64uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247365; x=1781852165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        b=tDnnLq66U/7YriXO/p3hf0xPPUBvccDxaEvLMPzkHpgINh1BfVj8jd9tniKdCjQ00O
         bpHWoby/guzin1dGMSWfGjdqN9xcP7DUFcS7wMDaEuMPms6XTQ0fESFvGBr2GYHPDofX
         10/tBTgDBflQxktWRoBjSGOxXtFNLTx4zEeQFWD8x5e6UqbR1fOygVVWcFi9IjDBulh4
         hvYiRePGKLZoemC1huqsCRQv5551AkWyRH/b69I+XQbAMY1tWkgtfw5fQ+Y2BaRIgfTy
         TcEh+0dn3C76VLk0oDfr61KI8OkznPfPOM+JFJHavCoOj+K0YyAUxp18ewG0uguteNg3
         c2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247365; x=1781852165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        b=TsKwU/MPrGlU9f3dEvopmsmc0ms8De6RBMAm9OWhjF5c91zyKFtoWRCDfI39VPNhI+
         v71E/Ec6RQkD8Tdb4bAiEv72IaP6aYQF9P/EyIuCkbQz1WLVyGU4Bucneq17XfsCVhlJ
         y0kmQsNJ1o4q1V04vTQ+1R8p6N7mK5z9tD+wVQ7rqmY9buivDF+uIsc8KlYf8ZVslf4j
         +CXZFzLZDbMgysK8NrkB/6bRZ9i/Egp1mmjxgDLhf4V9MiHP+0PA3bZHDt1vd0rCalTf
         muhTRVS6XGmO9bVUBhk/oK7UsyqPnOhGaeMneAceQ77dGncBNaDldE68o5R/+CQV2xDT
         rM9g==
X-Forwarded-Encrypted: i=1; AFNElJ9AS+fA0XirSV11yZPyafMLb7zh5qTwbVdTu9tvcwQzMxyROoc7nFIgCLOyYogZfrxxqMbwQ6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxypOsWPa7L3SRUvtL0citS9WSIjlgZxCfO9uRu1+bRla/Kcrdj
	7HqD8d5+g/ThXMW4mXfai8ljXrzz2EK1trBKMalCor0n1SHoLkKGDtWaEkXbWL3zuVvN9uWrhcW
	wuPrSzoDkRUbljmvD9wKdH88a/BXEuPHssoo2b+LM
X-Gm-Gg: Acq92OFP59U77Az8J52e8xRKV4vF+NXe1wUqs+X++pzCpiRX14VkVAMkqubReZzT6Wk
	iQf+SFxcoXlYDzET9OX3fEPZP0/Ypnd+NgQhulE6/h6O2XglQYfkbSjxwAo/EW40u8LkXV/D5wb
	2qW+O961tCP9MQLUdhu19S4eP+dx1Urw03MpO4q7pYio2iLHmgGbFs6erIlu9c1ShTyd3JotSA1
	nZfhqkRyfEFRycTQR/+RHwR0ysrSLOI0n9DpqlH3eh51sdchuXmszt45I1kBFEimvTrzn7qwX58
	u/jaF5fLyym1VR51B6vxgeILScYsEzS4EtYkr6FrsobKQgJn6XtyZu/HueoQU9QdUxzbMmYuUuJ
	zq2NX42+SvfDirB8fNBROM7tFZn0+ZHQ/b1TyL/K7TZ9r9LvJlxwC
X-Received: by 2002:a05:7022:799:b0:138:407c:1d0e with SMTP id
 a92af1059eb24-1384bafed35mr979348c88.9.1781247364686; Thu, 11 Jun 2026
 23:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-6-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-6-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:55:53 -0700
X-Gm-Features: AVVi8Cf1GPdShmUPANLnqMFhkLhcgfZz7kJnzsrHhuMtqU_Vi6lWkaFdf4-H8sw
Message-ID: <CAAVpQUDgZuLGpY1UisY1inkiage1m_Yw_FEtLzxq=yFK3oi8gg@mail.gmail.com>
Subject: Re: [PATCH net v5 5/7] net: ip6_gre: require CAP_NET_ADMIN in the
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
	TAGGED_FROM(0.00)[bounces-262866-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E2866770EC

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ip6gre_changelink() and ip6erspan_changelink() operate on at most two
> netns, dev_net(dev) and the tunnel link netns t->net. They differ once
> the device is created in or moved to a netns other than the one the
> request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
> against dev_net(dev), so a caller privileged there but not in t->net can
> rewrite a tunnel that lives in t->net.
>
> Gate both ops on rtnl_dev_link_net_capable() at their top, before any
> attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

