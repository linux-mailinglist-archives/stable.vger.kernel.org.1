Return-Path: <stable+bounces-233175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJLGHnqnz2mZyQYAu9opvQ
	(envelope-from <stable+bounces-233175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:41:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA6A393C71
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50AE23044A55
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32C3AC0DF;
	Fri,  3 Apr 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEg8/pBT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599E21B191
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216331; cv=pass; b=nCfX2IdAiVdpO3iDeZ97s/XxmErbdO3wU10WE2adf5S7jLWr4kXd674O89A27JSmKcRQlWSajiOj+oPx/f9xHe9FoMGreNOwMwhfJBOcARZSAikLjXVJq29AhQ/sKGyI5rWJ99eJc22NNQIzxUYhuHbLlaOPSJNgNKdnrUeSlVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216331; c=relaxed/simple;
	bh=H8sKRlQ3+ZzjIE9MX97CM/8S795K+wCmu9114lqHi/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gq+TjNJEZOPJQeUWnQuOnUyindZcHUFj00yfznB0Sy9OGrQnG8QS2x1VsteRzKACEkiybsNeN8mV30DUzV5IYzARcqKDPxKBgX5OP+Q7RQp77hAsfPewgWCgk3eOVwCQ5n3h5cODFKNOsCK1PxwsjYlMy+oOqmu2Jn4qkithplk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEg8/pBT; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50904a8f421so19110721cf.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 04:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216328; cv=none;
        d=google.com; s=arc-20240605;
        b=E0mkvlJ33Jv6j7uXnByR+cU6FfvDqiPZaOm9mwuyQp8MuhoMnil+XZaX1hbcPMzl+0
         KUd0ZCK/2KQY3VaiwQb7qM2LbOvWdeIMQJdJLjwGIM+++bF8pUNkDr1jt+209IovkQPR
         EWvFe99OMlGURMQ2nPnlhrFP7PIvoKosBsSyS+IY9dKL3IizL2T+Jn7T4T6DHxeR5CMi
         W9V412u+5DJk35AdHqQu1V5tjXMa8iCyeQrhQUU4FWGW8cbU+6zhn5BLjyaFpNMmMIRp
         +Rot41gv+Lh4p91R73DSXszCs4zy9017MdUCtxF/VPXoBV59iyBq+TGRC9Li09jPcTng
         YPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVNHDhWYudXQme+89+nP//p0066kVABIVtlnSuAq2G8=;
        fh=aaGrT1MXlDgBWWFk+ugN8HvViL9abq18D3eCm/nX+Lg=;
        b=BWp2M3J6hkVz3Zrfx/IwvFI1yyAumi5xvmEiSjcU1XPSTUZB9iSlewSrq6LK1JE0nI
         PM4AHkbtgb2Qa3siZ2qGIgofzrovAb7lK0ajDhZp0e+11T3L/iIK5QCSfV5d45h6vAk8
         5Drvtk1pikuaI1AUDhTJv50GCZuyr8nP/oFwyBxzo/WRPqcLMc75lbJqkoQRnrHLmPfS
         CsVGb5UQaWiOJTksIHEJVUDajuP2w2ZJpaZDeadlEJJcMI2wbU8VwiLzGjcpGT7NY/iZ
         rtkES3G0V0VZLgRzy/RTwIZGNlAPCKYKeQvE6pA0piZPxNyf6NcBW1m6mXVB5qZAvsYz
         K6ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775216328; x=1775821128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVNHDhWYudXQme+89+nP//p0066kVABIVtlnSuAq2G8=;
        b=AEg8/pBTTH3oqPYWSfBKBn3xBCvsKxHNV2AT9mEYrkYb8u6g/e1RfMWZ5V75nx2yDV
         b8K62t71Vb/iwVrPDJ5bgaWoCC4AU2rpPHERHhA+e3OdzlICW8kAHENqFEBcyA0VzGyS
         gbo5aFZ5tljdZ6cmdyWT+YuqxwRYLBDZeArFJ8kHA00HR4KrqZ+9zLUUrfhvtALqjxiT
         Mqk1IXozj+Qey2uIniufbR3+mvNq9m/wSBXZWIXgV9TcrsgZITSFs+CHgl5wja97CgHv
         OD84US9fZ8cIgdpzZckiO/9rP2kvm4HW+z42dQ5Bsa+IoLyh6A5TkulGbMHcPOyyxaO7
         U2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216328; x=1775821128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVNHDhWYudXQme+89+nP//p0066kVABIVtlnSuAq2G8=;
        b=fBFsL6pDHQ1TMusAEosACuWiyrQ8l0UNvnGBm81vHKt7EeirmRAVZUu2dDTM0EvyCh
         2Mj6KVGEdjQxFJoT97YJGxsXDfIs+wOR34C3tCwnaSK5P9WJKjPSg41InIx61Qw1n/fZ
         IummxzBlQPEn0sXgz2BRtSnJ4y3+MjxH5XSWTnfzskLhsPJ1Gp2B8HOl27NKF69EvcZD
         tpWFMwZwQ+5cNmMZlBnFUjp0Yp8pSTyAW38ZV9O5FDgE+XaP7PqZdl2PcTSnBjE+f4J3
         gfJWuECGcWptJyw2jjj9dhDFNNVOBXyVwlZYJQFqFFD/lDd7mrFeu5vBEfgrvsq6vXOK
         p++Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGlXW7/Wb7199npf+8jPDmFyTmAxNS0EqDG1sUmvmJBm9H51Ed3VFiLNiRYdqOsWcv/JQhLhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwJayJhTIQHXIulO+x8ePFiGgwJc/dO9nn8t4b2GlRrHkeLNZ
	54rq0aRMAXJX56zSkvn0APhfD5UGJ+BHy15mMxDrkRSD5sZjRdI9iqHmyDL9jk+AWuZrhqnm+yR
	LNQaai9O3zrvrEt1/kqQbBN0yTg0lzLXIwjfkzvfA
X-Gm-Gg: ATEYQzyP4NVt7YEYIwzytECkR596f5xgOa7AwtrE2sD3ZuqIEIuesy9+PNdt6wS/UPh
	dGAUnIiZJuVVDOa0CHre5FVDrKqB+NT6KddwfIqYOV6hIjS76xLIwHCVhTe5Uku8P3a5H7RfoeZ
	txCTOShEs7ncNrCs8O2DXSBx3a2//W+y4oPOgXDxSQkJ1RMt8F71ipZPgUYJIcdBitOrOHxjf26
	b+UofSUdPth3s0/41K5fb1i4tRRHekQh5MhOFSHTTF+KiVA6nbTBm7VAKvPAZaE745GNim42byj
	l7mpfWlROXm8nCMytw==
X-Received: by 2002:a05:622a:758b:b0:50b:3d9f:3846 with SMTP id
 d75a77b69052e-50d62adc9e0mr32334821cf.50.1775216328024; Fri, 03 Apr 2026
 04:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403110238.16596-1-devnexen@gmail.com>
In-Reply-To: <20260403110238.16596-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 04:38:35 -0700
X-Gm-Features: AQROBzBobV1nZUDBbz3MMM4_4uWlxzWA8wOrJ3E4mzFqSRyYMLaiPv5QHm5Rddo
Message-ID: <CANn89iJiB6QQ6qPQSnXLOqG_NhsqV-5J5ndSyKcf27pN3EeiMw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_nat: fix inner IP header checksum in ICMP
 error packets
To: David Carlier <devnexen@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233175-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEA6A393C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 4:02=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Update the inner IP header checksum when rewriting addresses
> inside ICMP error payloads, matching netfilter's nf_nat_ipv4_manip_pkt()
> behavior.
>
> Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/sched/act_nat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index abb332dee836..cd1d299da57c 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -242,7 +242,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb=
,
>                 new_addr &=3D mask;
>                 new_addr |=3D addr & ~mask;
>
> -               /* XXX Fix up the inner checksums. */
> +               /* Update inner IP header checksum after address rewrite =
*/
> +               csum_replace4(&iph->check, addr, new_addr);
> +

~20 years old code, are we sure this fix is needed?
How was this patch was tested?

A selftest would be great.

