Return-Path: <stable+bounces-247313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEOYHU2DBmqdkQIAu9opvQ
	(envelope-from <stable+bounces-247313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:22:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5B548B4B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B2730A0E8C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF83126DA;
	Fri, 15 May 2026 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G992P9eW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE73AA1A1
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811521; cv=pass; b=dsB5q2tE9hfoVEkOWHuHjzEX59Ht1AMwhGzMQtbT3wGB9+3bTXzfs+BOuRk+CcHHpDHhz4Rrnvg0/anMuQB5u1yBkmgm+3vx4DIZwgdM8qeEEy7oZwvQwC/ozooT38sA0wj3VZw8xK8YTs5pbRs6srVUsi+M0SSiO/oYEgZapzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811521; c=relaxed/simple;
	bh=LZfwwb8fx/as6YLcdeGq22qzkOPv2+qLbXYDfiS6RJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGZu7a2iubwdbYDoBVy80cV512zBsJoKy4xjx4UTThK2xg3qjwEtSBCFyv36ZNz9atybHNQLh+iqYVotH7CefoWoIW+4yp0qPmzDpOoE4uIAr5UY6SQEqm+2Q9nrLt1SzsWIQv20u1ECVgi2X3a68Hmi4CL646l13dk8qfBV2aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G992P9eW; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso336217a91.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 19:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778811519; cv=none;
        d=google.com; s=arc-20240605;
        b=a+4iRzVKsq/B8Sgb6huSMyEXlnWQBqggnqYSRVnleWU+vREGPzQSR7u3wovnPmwUhb
         CBcEDTB2mEZ0wJa6+S4KKDuABD58SUgNsYa+9riMCqoT6xN8urmAsVZr+Vj5PLKvvvTO
         jO2ixLc4gq5/gPjesSECEp70n6okhnhDXpIcoyoeMftbYYGcSjvoFlJLbA14YOgo8aYB
         sFpnoL2NIkF3SH9bwkeDDOsSKVUXTTAw6xr54GeCiZt3pr9CK/3Zyrj5cd3JeVTPSG5u
         AtMHP72warEVXPG68XNj6h3usSlRJBOYf4egfR7nL7uyZvx9aXEMKrKsrKKoTolvlKms
         L0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        fh=hcu2Y9X7aSaaJg1iRAz5rG2i1pIdIMRouW8sod+S7Tw=;
        b=cVaMECgA2BjfWq09v2xb8mMJh3wfQWQU31HQuzIS5m1bB9dmKSJeja2X+hMfZAOL3T
         xAy62KoRq707KWAF4vGmB+pG0YbIjDXHSOOk2P29vlNZ8nOGAQ/oBga9uA9ZLFdg0gOt
         l+xc3UszwGZKQWF+x07EdNGyg9x3lssu58uBcxkrp2sCoCsU0OvPnpC2mhVht2sohwmP
         bacRmAGcBCc3MZ95V7RuC6iAi1k4uNOk9OhzKZwH+jAnXTY8XnITFLsYbPQR4NvrZpJS
         Ls2DcX2PqtTDZou97Hh/EwiVne0p1fO/HN8jJ93naDyLlyf0juGK2Zc6wjcX7TUAxjPz
         sEqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778811519; x=1779416319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        b=G992P9eWdXzOST1NPfVhWUChW/fW9OY9YgWHA1f4orvFCJ/XqpJs8olPposAGISlu4
         hSLbvRA6506FtLco1NvZ8rJOpafcPaIlXKSgn4XwrqkA3LIcdG2p4j2FnoknJQDsio7J
         WRzE7j2vBlVES+U/BcL8Cw7oGRpF/iRAqkXswNSE3xbvft2FvJ5Nk+7ZeRyGF5P9zsfo
         BXs2z+lH/x3wq1+XoSMq4dhVJ+tpRxJ7OPNrFuz3G6wL64jCO4p0AlbGgkWI3ZCMQHIS
         NcOQh6MPfYZClsIRsb8GXP1RiLp4JQH6LVCrrqUt10PKkqW+uXj4OpD6Ane2GLVN8aTk
         pOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778811519; x=1779416319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        b=p1Ca3TYemb1sdqpATD4jzmEQDXGDKXsQB6bAKYK55ajPiy4+crORiGi14wKWBdV6T8
         /Js+3Q1FOPJqEMmZBEvdKBmv39Rm7sowfwdkFabmLewkIpD+FdS/1mSaXoXjOWxOWEcG
         ThABMpTT9xsV7x+uxb51czE2FQKrbTE7vP51DTxTg2pBBuBkoN/kz00xUsnJ4Wko2J5Z
         hwqI7U0IWJMxPiD+8czUHAdlenE6qeLaOhV+BohL4EK/rjKtgdshQyPqaB3Kuaawl33p
         OurUcCocW2abErZq7Q4Y5OJiuEHpxkSLSRAVsA7Fih6e1mkwIUA2tiA5rV5qmXyIWbch
         P0wQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UkXbL2kLd2T78DXHIpGJ62T5b+9h5/caXVqjgQkFvLxQIa95CsmpBZGpLkpc1zHYl4pN4UzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5oUNlHE6QNb4SLZqFhfdaEfpMVsctuXPDyybzu4smT0iqFs5K
	mMOasqIesSpJj7Low/87xm8wVfMU7XYt/dYQcL689eITWSfb2kv1CBdljFdmA8IbPN75Stt0KSj
	lyUsSbG7UuJQ6w6txE5QzS8FeUgjcAI9krfqHuVxA
X-Gm-Gg: Acq92OHSUHcYbGhZRdDNZ4AUFpZMu7FAstuTkTcuvksHJwSzabCZ6p0esuKV/Mqde3D
	jhjbK34GKC6t3+Y+GvPEbu4mQC3guER5pNIyPwqaYBxSaAcIIz/Wo2uuwbmK1EBChY5NY1xiGlX
	ssedjehlQbjk4/Do5vkY5uR+SbHB0bEx8T5rjAzZNKJVyT3DJ0Pn2Po0FxIAwGOk2tYdnWFpuYF
	Jq+eP0BXK3BMRDd7VHFbBS/rGyLuzYjxP89DZnoJnfT3+/HpAXpN8Iihjv34rZx1dIBTtSsNQzS
	MKRWFsA=
X-Received: by 2002:a17:90b:4b8f:b0:366:5283:cddf with SMTP id
 98e67ed59e1d1-3695149a001mr1414760a91.9.1778811519322; Thu, 14 May 2026
 19:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514165139.436961-5-tpluszz77@gmail.com>
In-Reply-To: <20260514165139.436961-5-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 22:18:25 -0400
X-Gm-Features: AVHnY4KwcYaSMM6ME_zDmyreBOKsbOgGqvR0byjCKHroUrtDuoM0Rdy3xLGdKoc
Message-ID: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail
 in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D1C5B548B4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247313-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:url,paul-moore.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:52=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CIPSO option in the IPv4 IP header
> via cipso_v4_optptr() and hands the bare pointer to cipso_v4_getattr().
> The consumer re-reads cipso[1] (option length), cipso[6] (tag type),
> and then cipso_v4_parsetag_*() re-reads further bytes from the skb.
>
> __ip_options_compile() validates these bytes only at parse time.  An
> nftables LOCAL_IN payload write reachable from an unprivileged user
> namespace can rewrite them after parse and before the SELinux/Smack
> peer-label consume path (selinux_sock_rcv_skb_compat ->
> selinux_netlbl_sock_rcv_skb -> netlbl_skbuff_getattr).  This is the
> IPv4 analogue of the CALIPSO IPv6 trust-after-modification fixed in
> the previous patch: the tag parsers walk the option using attacker-
> controlled length bytes, producing slab-out-of-bounds reads whose
> contents feed into the MLS access decision.
>
> Validate the option fits within skb_tail_pointer(skb) before invoking
> cipso_v4_getattr().
>
> Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
> mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
> returns the payload, showing netlbl_skbuff_getattr ->
> cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
> end-to-end past the option's true bound; with this patch the
> consume path short-circuits at the bounds check and the counter
> stays 0.
>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP opti=
on")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 4af8ab76964e0..ace561a2904a4 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1393,11 +1393,21 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
kb,
>         unsigned char *ptr;
>
>         switch (family) {
> -       case AF_INET:
> +       case AF_INET: {
> +               const unsigned char *tail =3D skb_tail_pointer(skb);
> +               u8 opt_len, tag_len;
> +
>                 ptr =3D cipso_v4_optptr(skb);
> -               if (ptr && cipso_v4_getattr(ptr, secattr) =3D=3D 0)
> +               if (!ptr || ptr + 8 > tail)
> +                       break;

Similar to my CALIPSO comments, I suspect we would want to return an
error here, yes?

Also, how did you arrive at the magic number of '8' above?

> +               opt_len =3D ptr[1];       /* total CIPSO option length */
> +               tag_len =3D ptr[7];       /* first tag length */
> +               if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
> +                       break;
> +               if (cipso_v4_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;
>                 break;
> +       }
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6: {
>                 const unsigned char *tail =3D skb_tail_pointer(skb);
> --
> 2.47.3

--=20
paul-moore.com

