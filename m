Return-Path: <stable+bounces-274519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id udrsEFqLVmoB8wAAu9opvQ
	(envelope-from <stable+bounces-274519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 21:17:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 364AE7582B3
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 21:17:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rbl883hR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274519-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274519-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA7E53014210
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E402931E3;
	Tue, 14 Jul 2026 19:17:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E02931D4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 19:17:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056636; cv=pass; b=CeFxUD8ql+/ZF0AbQMBrBcX4EYB0SEOC4MNBDEHmWB/CpAjh0oa8vC4Lf9MAzFvofvG+rXHw6LqCIXND6sFn7G9y+X47KOar3axiTM1Sgm3CV484+wJ3a4f5YaI9y/Rp8ubJT1ELU4DKCe28kNPxPIJja24/pdg1XxJI6wj1Jf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056636; c=relaxed/simple;
	bh=03SHA63Ly75PsSBm1H26G0RiDGofkvShlM+yXEyaBO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=serxTBgcfg4vIb8VXBvImI+fVcCBdZ6U3lD3+G4CSl+mlcYD/d2P7GC8Ljz5QKDyPKUm96syjIkRdeHWRVz0LIIzJSnHeWXct/KXZjjyUjWM3cAYKIBHKLRu3yNGgEDAEYNu+6slYeplLTbe2AQ0MSwLWOF+uKQpsSN524bHnX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbl883hR; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848595b338cso5493040b3a.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 12:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784056634; cv=none;
        d=google.com; s=arc-20260327;
        b=i0b62gzgt8ddOTWRTWsniMSw9r7MzC779XdVV+/xwazNURLztYXMKsL3vK5ppyWdri
         wUFM/We9jbVMY49czJ8yT2kBIcF0dqTQycdBZC293xktiJSXjlCxWo6mYEZ8KNsE7T+M
         FJFwAJW1RJcehf/ZxXRX0EcQCegz5bEr3t06br8JxlIp45sQnNp9NDHNjU4tjvZE7YFn
         QlsJpireMIAiY4OChq6NWZzRMb/ySaAQKVdpADikQ3f8TwTrcrmv/4/dioX6ZaR1OdPM
         IDrnqZLBJncGG7e3PTjqI6MW8BVntqw9m3Sj+I0ODFu5JfnE43zOJH5Nuk1ICNLKuson
         FzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8hPgzdKqAAXiK6RO6TPJDACvUtDM+GsrhUQmJNvsxo=;
        fh=7jG8m3EqW3K9ZhoWJtMIMu2Ep4z7u2zama+fVQjgvkc=;
        b=XJ2lfGnGRa2PnVZwO7npMYqzHul784moZe+fbDCDMqiaVxNfvU3rr7iY1hi13sBfFA
         g6slTiERwmNH2yZiNH2FLYi4/IV7PjuyEgDmYlwJQ0JfYc9mdHjBYU7ShkA211l76453
         zc2znObW9h39qQCWHQ3es4yIVWYGgHV8RL5ESCwM6s//tva0ce4YRKA1jpYvq5mDHUkF
         AsPx+gT8itUXMiesxsaN64D/v5bn4ceUTfxtdaMk94F9UI0DvNufIF1xyOhSpSlf4nm3
         GyCGWyjOTGXdNy7Vv+oFPc7oA1RjFMgdLHppyjZXDYEyJ+cuCZN+Y3cTdqCa84AipCH8
         VHBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056634; x=1784661434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8hPgzdKqAAXiK6RO6TPJDACvUtDM+GsrhUQmJNvsxo=;
        b=rbl883hRwNARWpe/8CyJyE/k4StNNBOoHeAWkCSPmu0M+/vUrfBy+VNfmny+JVhxyD
         MTX6iOqYNaEY+m2bwrqGH4phq/UR+OuPlaIq501xmMDuu5XcWsmLbpyp6e0w5U9wpXh7
         h9/B5yZkNRWLh1drYHopAyrHPxbZXjYaz2ldjNeq2a06QHkeVHitk3CgGBE/u8j0p86i
         EsNOrqZ7FfaynUY7B3cTQRcv1xOyBcNdmqI68WKeDHeSkGFUlVvhHrCzvoQYoPpD95ln
         XjRHDCDDdWakrltbGV1mU6c6I40Tp1Gc6BaWHCndqUq9wooBi0g9o0X31hiJ3LrWZ71V
         XdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056634; x=1784661434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8hPgzdKqAAXiK6RO6TPJDACvUtDM+GsrhUQmJNvsxo=;
        b=iYRy26/qUpKZ6NUVlJr98BL9e+BWLncFJauDXRmwxgbgSr0Hy3LAEgxzy0nRDicqvE
         IcTe8BkWlV5bp+yaHlARlj+OvWJT+YHeCsMP/59wBtYFxPuRekJQlXnaWsFStTPN+3/X
         UNSeZfW9FzhJlni+hkHpmfakTEBmcn+eIehOUKxz3t8FYXNC/ID5DDhpPWgIWwGysfzP
         8Ai2B1KcwHrA/RO356Tmr/VwRptGZUtdsj/nXiixaIa6iMYwgFfBytlo9aoD2lAsD74f
         gEW7B4qa2uu0K37fSYFssUtAvEPfsOF0htnZEs4XkggghUAearalqCQSknQyBErzPVDw
         Al1A==
X-Forwarded-Encrypted: i=1; AHgh+RrjDwilrM9WbNmCYZQPlAP2ZxfufVjx65wI8NbyAVLqSoxLMFUJvekjQHGHpDNMUPPool05IYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqsLx75Dh70UkBOSpCy7fWQPj41noVI/RJ0zxnX7FvsdZyZyk
	cUjruV6RaPEbRI2phHYNEthdMdoKuFTHwhYaTgmCMQ4XJc/CpJywzyY8HiIf0qg75Zc33gSytES
	SZpmyhj8ShGgkK5X7KLYeSjDpD4GH43I=
X-Gm-Gg: AfdE7cnhhAetI+Wk7j4fob6DFOxlW/vjD0c3ZVe8nAkXAeVAfGfO8+RhXHjK86VOI3R
	C0+3C6/LcPBuZL0SbmlQBVuIwDf1W2aqd/TtTWI6d+yj06KsWE9vFsnaBtUio5V1iaA+emZjWGt
	v9NXr+atsz4IBEP1vQXy6O0z3FKCzRg6bDzvvRb5FwOw0V2wxnLwlpQOk0O0hlyuJNLfh75yIT1
	PpA9u6I38VajnkhwWxamwXQieFqJ7lv8lKDmqKe6Njq1IC7HYi2ZTL/WTpM+h1PRj7t5WgiegEM
	NfNr5YM1P5gEgQA4zXiStkuk7dDfKbsQVAX72j7Q0ZVLq6/BQEqQcLKiHH6SjejbMU5pw/4k1+2
	DuK3mmAXHhUyJn7A3NZbFZzFovSTA
X-Received: by 2002:a05:6a00:27a3:b0:848:3d18:2700 with SMTP id
 d2e1a72fcca58-84a558868e0mr3675149b3a.71.1784056634582; Tue, 14 Jul 2026
 12:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714062740.79126-1-yangmingxuan.ymx@antgroup.com>
In-Reply-To: <20260714062740.79126-1-yangmingxuan.ymx@antgroup.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 14 Jul 2026 15:17:03 -0400
X-Gm-Features: AUfX_mzH3PiKLXZOup84hcCniykODWJPF3dMr97EXJhAUSzU99V9qlqP9r5m1PQ
Message-ID: <CADvbK_d8GQpRQc-D48itTFj1r+OK4z3ou8U9=YL54qtsWYYaKg@mail.gmail.com>
Subject: Re: [PATCH] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
To: =?UTF-8?B?6ZOt5a6j?= <omeux327@gmail.com>
Cc: marcelo.leitner@gmail.com, security@kernel.org, 
	HanQuan <eilaimemedsnaimel@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:omeux327@gmail.com,m:marcelo.leitner@gmail.com,m:security@kernel.org,m:eilaimemedsnaimel@gmail.com,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-274519-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 364AE7582B3

On Tue, Jul 14, 2026 at 2:27=E2=80=AFAM =E9=93=AD=E5=AE=A3 <omeux327@gmail.=
com> wrote:
>
> From: HanQuan <eilaimemedsnaimel@gmail.com>
>
> inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 bytes,
> the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the netlin=
k
> INET_DIAG_LOCALS attribute and then only zeroes the bytes from offset 28 =
to
> sizeof(sockaddr_storage).  The same pattern is used by
> inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.
>
> The IPv4 address-filling helpers sctp_v4_from_addr_param() and
> sctp_v4_from_skb() only initialize the sockaddr_in portion (16 bytes) of =
the
> union sctp_addr; the trailing 12 bytes (offset 16..27, the sockaddr_in6-o=
nly
> region) are left uninitialized.  Those bytes are propagated verbatim thro=
ugh
> sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=3D28 bytes) an=
d then
> copied straight to userspace by the diag fill functions, leaking 12 bytes=
 of
> kernel stack residue per local/peer address to any process that can issue=
 a
> SOCK_DIAG_BY_FAMILY dump for IPPROTO_SCTP.
>
> Fix it by computing the actually-initialized length of the address from i=
ts
> sa_family (struct sockaddr_in for AF_INET, the whole union otherwise) and
> copying only that many bytes into an already-zeroed sockaddr_storage slot=
, so
> the uninitialized tail is never read and never reaches userspace.
>
> Fixes: 8f840e47f190cbe61a96945c13e9551048d42cef ("sctp: add the sctp_diag=
.c file")
> Cc: stable@vger.kernel.org
> Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
> ---
>  net/sctp/diag.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index c2a0de2adf6f..ec12f3f03318 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -68,6 +68,7 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff=
 *skb,
>                                          struct list_head *address_list)
>  {
>         struct sctp_sockaddr_entry *laddr;
> +       size_t addr_len;
>         int addrlen =3D sizeof(struct sockaddr_storage);
>         int addrcnt =3D 0;
>         struct nlattr *attr;
> @@ -85,8 +86,11 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buf=
f *skb,
>         info =3D nla_data(attr);
>         rcu_read_lock();
>         list_for_each_entry_rcu(laddr, address_list, list) {
> -               memcpy(info, &laddr->a, sizeof(laddr->a));
> -               memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
> +               addr_len =3D laddr->a.sa.sa_family =3D=3D AF_INET ?
> +                          sizeof(struct sockaddr_in) : sizeof(laddr->a);
It's better to keep this consistent by defining addr_len either inside the
loop in both cases or at the beginning of the functions.

Also, it would be preferable to use sizeof(struct sockaddr_in6) instead of
sizeof(laddr->a), even though they are currently the same size.

With these changes, please resend the patch to:

# ./scripts/get_maintainer.pl net/sctp/diag.c
Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> (maintainer:SCTP PROTOC=
OL)
Xin Long <lucien.xin@gmail.com> (maintainer:SCTP PROTOCOL)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)


Thanks.

> +               memset(info, 0, addrlen);
> +               memcpy(info, &laddr->a, addr_len);
> +
>                 info +=3D addrlen;
>
>                 if (!--addrcnt)
> @@ -114,9 +118,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_bu=
ff *skb,
>         info =3D nla_data(attr);
>         list_for_each_entry(from, &asoc->peer.transport_addr_list,
>                             transports) {
> -               memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
> -               memset(info + sizeof(from->ipaddr), 0,
> -                      addrlen - sizeof(from->ipaddr));
> +               size_t addr_len =3D from->ipaddr.sa.sa_family =3D=3D AF_I=
NET ?
> +                                 sizeof(struct sockaddr_in) :
> +                                 sizeof(from->ipaddr);
> +
> +               memset(info, 0, addrlen);
> +               memcpy(info, &from->ipaddr, addr_len);
>                 info +=3D addrlen;
>         }
>
> --
> 2.43.0
>

