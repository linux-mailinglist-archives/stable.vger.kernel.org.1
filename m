Return-Path: <stable+bounces-215931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mtczEw2fjWnv5QAAu9opvQ
	(envelope-from <stable+bounces-215931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:36:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8612BE71
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF44306CEE4
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F672D0C68;
	Thu, 12 Feb 2026 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SciaKszj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6A17B418
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770888970; cv=pass; b=nDr7dN2kIGoIhCUdczczhe1vOZVyRiMGbCsOjIA6K65nzXbgDEXtosL9BdMmXZbQks4NZ36DtTVo0FI8nhsrAevQit6JvxpdRNxtcOZB76BAvvwBdwqQSE/s1CYz5r496ubK5BrrgNpKtuxpZqkRtVaFxFpFPPiMDuz/Cei8yrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770888970; c=relaxed/simple;
	bh=92uxc6KlHViWMwKYKjNTsEWd7ucmY6Tt+XUlURwlqPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNagmIFhOVOjmLRhkalE8B2e9PzRNqNVyE2K0cBW9T4vhn+y9BszRDQv0WJoLcl4j2VnW/rf5TuFFOZPnhFGdDba5/nPQSDx6cZbz2PzPG2gd4W79wbOqpv6qK9eslAqjT/1S2LvvSLr0sDu5RTeGsR2i2HZujvHMB4fANV80LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SciaKszj; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502f101d1cfso26563931cf.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 01:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770888967; cv=none;
        d=google.com; s=arc-20240605;
        b=NUs+vZxQuYUP1zlDbWBd96BUPKiDLCR7fYuKNCLKFgRaQ0EpKQaVY8JLvtRdtB3Yu7
         p/VKMyodJePJXbRAOb1OaSmbbe1S9UgpF7p7b9hwhtc+e18g44A0xFw/4Lm+QPvl0JRl
         rSTLe1irofT/jQt0noCHDYqh2h4PBVgcyNsixUNG0a2jMvje4dMaKbcx2Kyd36sNm/6O
         RLTH6bAmy23B+smb7sNeoo4SqfHa1OXoq/FNiujbmBNyWkWv4BH5UiAtWwK8KB0W0Xm6
         7CY2GDsyhVqwVdCGFc8cdWJDfyeEXTpJXBve4MqtqBUMtURzwPizSzdbupeivpaaBv16
         upMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aaNajqUCbVH6NKKZgFxe2XVZqsv9heTJ6/BgQI66ZCU=;
        fh=NBqO8Sw0bfFoS+w+J1Jw5sdwenJ7f2CdmXJ4Gm5hcSw=;
        b=b/qnvD+m9/XheeUlvuRzx1bkERw9D5CB/8AYd4/4Ql5alsvdIvVUmsn3Rq9P9j8AE1
         dW7OHfUvt3C1wY3X+xbmA/8oU05TlYadJsQcnahSYzchd9gTk9wIuwpf+8rb2xQ9pvMU
         60Cg5kRfD2Ng6E/PecImWvQyIyooH/f+OWJyqSnVHSO96Y91l5d/vP03ufR9dYCuDVQR
         OX4uNh+viYLl19KGekkYhpOFmdlkstdPStNT+E/wIA2cpdPuHDhLnnT/5+nmLH5OKZNB
         iJcq4kCzzICy+AESQcnu8uzosjMSHaIYq5e0jBHvK7GItlaaga0XwSvrRgkIOTxAaS7q
         A/0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770888967; x=1771493767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaNajqUCbVH6NKKZgFxe2XVZqsv9heTJ6/BgQI66ZCU=;
        b=SciaKszj20wA4bn8EMdaB5FTwKAGnBbdnIhbUW87q592TnmbPxcPhSl04MUasVPlrw
         0KNWpYIEeHu4Q/MAlIsq+WwW2R76/Oaul2YsyoBXYrpvqKoS1+ZSBJHtC3TthraeSpzg
         d+o4yOcK2g9AO6yEKPrR8745D4QCcZBVpdkLOf6QCIcIPCFJjEHRQrMpVOxq4kNvtigj
         ivc+xILxRGdqTy3F5Tvf2iFmarQgIYs/kO24+wHPoQXy4Nn7AzTXwf/1leio0UIz2CnX
         FcS5y/W09jdrkFC14bXhHWpoPvtLiqPqJlJGgbh8M5haSreXJtOqv+7XATuhv9ooeO85
         gJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770888967; x=1771493767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aaNajqUCbVH6NKKZgFxe2XVZqsv9heTJ6/BgQI66ZCU=;
        b=onYvdPAV7RGeR5V2D5i2tZE5rtrHS6Ns1xsarFi/9RS1JpUfL7qJI1pqa3G3QddPkv
         I+QkGWFkf3H8CIIdBbiFlqWZZSngNeJ9vQkNZGiXpPIimFNx0zWSnnRfJB3ohv6uDqsW
         5TaafYhTxL4Zmj3sW+BkZuUW2Rs43UZ796+mX64mR0d6b5DXVrVVLtWoI6gZEquaeNAb
         IMpkQbWhAHzpcO05WUiLGZd1AKHIF1qWaHt28G6ozIl+xV80lLv05CbO4jq6pWLdCiUo
         v5NyS6xS2tMlyQ03SgFnGgep2ubKA0NOfTmUug1Bi7EwI7YgAZF/Dx/b8iherBXEzU/A
         UQaw==
X-Forwarded-Encrypted: i=1; AJvYcCUS1O38kuFN5aHWlJbgdxHACVSvW21PY/TR6K0Sh9AAmG0e1FNLplJSltSO8TQM2IBR24eQORc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/F5QyycnXnyExPWnUSD8VFdjt8Qzbc78/ZVs+GdXcqecpKlvG
	MnoNQWymYPbOCPeeHO6UH5UNjLmCHdbmtsf8i61LW19W1TtM6JmDSL26mlTODiI0rOEt4PIIpPX
	qrblr/QbdZzICzDV0m/9OLS8ClkFmcBwDxLQfBvp4lCxFvHJ5E9deHy69+wQ=
X-Gm-Gg: AZuq6aIkWpTvAK6QMbwqtgJvtiWIM+HzdJiaYZQWWjdsPqegO8QMkOZ0Zf4EZrzrgb/
	mAEap4jFvue3V5zq9ZrxU2iUY1v7GNtx5gyklM8UyEN6GwPb40O2k345zAZaWkBEJGl2i97uHKz
	QXlPIjAlOBoHc2gmcFeltFf99Lic8K2usQxxbr9nTyNAkIfC5nTVrkvkO9cy0nrUx4Ap34qFlW3
	cRSLwihtPxWqzezna2ooKopCmfwOg9fnWMGfqPP7bJBysU8a3bLDCPxm2i3cYy6pCtV5YONP3ll
	ManvzBWu
X-Received: by 2002:a05:622a:1110:b0:502:9ffa:1ae6 with SMTP id
 d75a77b69052e-50694f0a623mr15968021cf.82.1770888967284; Thu, 12 Feb 2026
 01:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212075909.2952-1-xnguchen@sina.cn>
In-Reply-To: <20260212075909.2952-1-xnguchen@sina.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Feb 2026 10:35:56 +0100
X-Gm-Features: AZwV_QjXnpdhtByLqaQj244aO5GysHO27XP9rX_DzW677rvDS0863mqAwuPafJE
Message-ID: <CANn89iK+hLmcGL88m+DjubJiRegTg-En3bk9Ndg9_G6SAO7a5A@mail.gmail.com>
Subject: Re: [PATCH 6.6] tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
To: Chen Yu <xnguchen@sina.cn>
Cc: dsahern@kernel.org, kuba@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215931-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sina.cn];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.cn:email]
X-Rspamd-Queue-Id: 9BF8612BE71
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 8:59=E2=80=AFAM Chen Yu <xnguchen@sina.cn> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> [ Upstream commit b62a59c18b692f892dcb8109c1c2e653b2abc95c ]
>
> Use RCU to avoid a pair of atomic operations and a potential
> UAF on dst_dev()->flags.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-8-edumazet@google.c=
om
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Minor changed due to 6.6 doesn't have
> commit:a74fc62eec15 ("ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_ne=
t[_rcu]") ]
> Signed-off-by: Chen Yu <xnguchen@sina.cn>
> ---
>  net/ipv4/tcp_fastopen.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 408985eb74ee..27339cc7342c 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -574,10 +574,11 @@ void tcp_fastopen_active_disable_ofo_check(struct s=
ock *sk)
>                 }
>         } else if (tp->syn_fastopen_ch &&
>                    atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_tim=
es)) {
> -               dst =3D sk_dst_get(sk);
> +               rcu_read_lock();
> +               dst =3D __sk_dst_get(sk);
>                 if (!(dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK)=
))

This is a wrong backport.

Really, a74fc62eec155c ("ipv4: adopt dst_dev, skb_dst_dev and
skb_dst_dev_net[_rcu]")
can not be avoided.

