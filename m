Return-Path: <stable+bounces-222723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLy9GbsOpmmFJgAAu9opvQ
	(envelope-from <stable+bounces-222723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:27:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237D1E5628
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61E59330B1A8
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E571D39FCA6;
	Mon,  2 Mar 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b89AdYD+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B239EF37
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485204; cv=pass; b=mFvD0+RFoZ/U/EXcjLfxl5w9hfwRfDABz2k9VIAqMNNuVf8DS15U8VKWsj4NSG5EXJYRBv/miczbG1tePoj85INxpcViNVXCUise7NONf9LyTeu/lis+AgE8qJaUS9Rey3CbRpl3GHYmanH6MDO+miTo4c2V5JiitUsL+Emndsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485204; c=relaxed/simple;
	bh=KjgbAzL1E1IdcmiEt5GtmmF34JBS0gwFcSJFm9y6PXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9PrxK/4/9kLKbv2e0PO0JfgTAC6CwSwKQcGk/O/0/3Nh1WHZTwTZ1UA6ERXiSTkpFC5kVuY6dk+P9ZBUxxCxKOAuUm9CR1cYtB+vld4Ov4BeCQ4TFM6NwYfhndLviZ0YiGdoGsJ38v4bJSuQIaMwjoLTGaRSbe0P1/eMbWo154=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b89AdYD+; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4612384eec.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 13:00:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772485202; cv=none;
        d=google.com; s=arc-20240605;
        b=IoD9SV7Up6G7YZGH+EBgYtWt46RKoSDrdOQMPIV1AH7TynX+kDUM0lssjr2OGhci+R
         6XOV381SceTkkm1Ap03lWcqO58kvWpvoVbxTKgB/iAj/H/JHXbMpOsi14w/+4pKBVdPq
         /nobxuN7ZePPb/1ldeJ5Zshg6Fm9HtmrnXChl3ExFLINUdLoFHdzIrllWcu2z/GpqCQY
         Cbf2qY9Bz+ERvfYFgM/gCq1vz2jgQnEkq/28dnb4AVw2/snUGtpFZ6hlWIncShQqlHEr
         ctptGZmJUzd/iIpbqYaZIFv/Ak5FqecPfKQ7sjZiyBu3P38sSlDkHSNH/e+ZuuTCQ8ol
         +HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LJpwXOwpNuN50/jhnvI9Iu6aocDAFHqTStHaEOppP4E=;
        fh=CC8WSIdXVUcYnbVdw4bL/Nw5DT9cbxh9ZwQR28Fxd1g=;
        b=QPBSrv+dldqNkH6js3xCcK/BqfhawKDy6aKzNEqJesLD5nvs6wyFoD2NDS6RNJqPsS
         mlus1rl14sbyNTuQjObP08rhAvJWZSEILIq06tIN+Xw6AEhyPcMl9DE6BeXjt7LIJV5y
         sTbryosnb7t0kq5NVpSeG+cwbLbIMNyAsiPEXk6qLhwhQzg7m2ZSBLhM23DxYbiG70HG
         6ub4OogGYdjjC+RkcY2vdJ63/JE+xYgFtBEmd5dUhRnISrC7nC9h4rhXHxg4lcUb7MCp
         hX8BRs04LYca+Au9nlPFJpTm4KHt6O8wn37/yGpU6qrNCBZ/SgiE7bvdCh2D7+3FipTG
         7Y7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772485202; x=1773090002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LJpwXOwpNuN50/jhnvI9Iu6aocDAFHqTStHaEOppP4E=;
        b=b89AdYD+VhDkxxWNjWXPUvruqjHpT9mAICFNkE2SU5wfIyERnLN/cMLYA45Vj3FtnU
         WfUnEcw8mS8wSDvSj4jm/nvcdCCfiE4WLy+VvNomgkxw1vIEXt6OlNRSqEOLel0v5we+
         8JU4O2zO3c8rghNL/V05MbR9HMArzrCMt82cCn0KA4CKu/McD1u1rVuYgjGM+JIPVO/h
         Lm18wjuJX/CvwCKV/sh1o4FsnSuCCF0z7JJYxFsvENSHlC/yyk9PcwlBYUWs3chDrhk5
         cX64aYFPCMSq2URvn8kmh0ksSely8MdXek9YxNjxj1d2surlkyVZUo3kp5IfGTdSs32r
         VxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485202; x=1773090002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJpwXOwpNuN50/jhnvI9Iu6aocDAFHqTStHaEOppP4E=;
        b=RpP6hPg6NaTlIIkXvDZTrv/+seAvj3GJHrq6oN4sP0wKbWRsS8IdJsqYsfiKPKnDw/
         MFvtyvjXbXoSyF1F+gBiRFYRsjmOEO7dESY1wW4UKQWRIrLg8g/L1Cy2Kuk1aluc2HOF
         plJCnuGzEZJK7ily30EDCp3cUmFEJK47hkSh/H4AD8v6GZULuj1WkY+Oz8X/bK9Vpn2b
         9zpJETJ+1OR44bFAuiqYikaZwAgtY/Gjs2h2oH1y1Xg6iv2V2jGfXmBPNC1ns8DmzTLx
         BZe/e1Q0FCaxeILRzeGRO9wM3ADjlyGlRcgEmv2xcvw8CRCflt7oSJPgRDyJDrQctL34
         qisA==
X-Forwarded-Encrypted: i=1; AJvYcCXZh2g2bg+MvYApGlTux9wB9sZamYZkVVz1PVV0rVaIyYF5H8kFwzO68iNvz7RfX+NnDXTNE1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQx7q+tDq7Oyzk3458BC0UVSdBkmQR2NK58zvPMNmNErRrNgYM
	39g2sSM9aenRBQnvVk4byaAyBTy0lxozsEIMqD+DDJTN4GT/PgU8KojMDPmxs3cYcgNudhwCqT2
	Gtoj2QWBW0Wc7PnmYPVEHQZiqzSfbsLk=
X-Gm-Gg: ATEYQzza1k5bb3LEEapYj5xGOGEP+TiYpL9bZliJrnLGRkOajvHeOkJxT2d2gs6cGYF
	1nCsj1rj0Z9Fdq7WmtZpZIhrkXKgaWCEx0fu9GPW5tkcAEnaEnwnYQ/DVKQ5M62/xm1ACoHs4jg
	U4n567qHnM4pd0lZwYhZA2IfXUnwcb+SbmODdqv9Zy2DbKceJVGfq4kiSw32QnKyHjYRBT8aq0S
	sdj3y/ynclXAKCAEV7jYqFn/rDE5hNzxLxdMo6hdP0F6NWn4JX8sdf8PwR5OouHNTXS29CwRJVI
	xq82C0kHgQUsK8JdPalBcFoty02zuKIgNWPx5wSXrA==
X-Received: by 2002:a05:693c:409a:b0:2be:8da:321c with SMTP id
 5a478bee46e88-2be08da3393mr1740887eec.2.1772485202409; Mon, 02 Mar 2026
 13:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302203600.13561-1-ebiggers@kernel.org>
In-Reply-To: <20260302203600.13561-1-ebiggers@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 2 Mar 2026 20:59:50 +0000
X-Gm-Features: AaiRm52sgjZJdZRrfWpXsEb9jJIE1M7aZEwhGDOdaP19FXauiP7ZogndER0-Nag
Message-ID: <CAJwJo6Yt9v8pscqFB7mfuHGhwNSOE2no4Y5fu8o67atn=EtnUA@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp-ao: Fix MAC comparison to be constant-time
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3237D1E5628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222723-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arista.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 20:36, Eric Biggers <ebiggers@kernel.org> wrote:
>
> To prevent timing attacks, MACs need to be compared in constant
> time.  Use the appropriate helper function for this.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Thanks, Eric, LGTM.

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Could you also send a similar patch for TCP-MD5?
tcp_inbound_md5_hash(), tcp_v{4,6}_send_reset() would need the same change.

> ---
>  net/ipv4/Kconfig  | 1 +
>  net/ipv4/tcp_ao.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index b71c22475c515..3ab6247be5853 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -746,10 +746,11 @@ config TCP_SIGPOOL
>         tristate
>
>  config TCP_AO
>         bool "TCP: Authentication Option (RFC5925)"
>         select CRYPTO
> +       select CRYPTO_LIB_UTILS
>         select TCP_SIGPOOL
>         depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)
>         help
>           TCP-AO specifies the use of stronger Message Authentication Codes (MACs),
>           protects against replays for long-lived TCP connections, and
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 4980caddb0fc4..a97cdf3e6af4c 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -8,10 +8,11 @@
>   *             Salam Noureddine <noureddine@arista.com>
>   */
>  #define pr_fmt(fmt) "TCP: " fmt
>
>  #include <crypto/hash.h>
> +#include <crypto/utils.h>
>  #include <linux/inetdevice.h>
>  #include <linux/tcp.h>
>
>  #include <net/tcp.h>
>  #include <net/ipv6.h>
> @@ -920,11 +921,11 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
>                 return SKB_DROP_REASON_NOT_SPECIFIED;
>
>         /* XXX: make it per-AF callback? */
>         tcp_ao_hash_skb(family, hash_buf, key, sk, skb, traffic_key,
>                         (phash - (u8 *)th), sne);
> -       if (memcmp(phash, hash_buf, maclen)) {
> +       if (crypto_memneq(phash, hash_buf, maclen)) {
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
>                 atomic64_inc(&info->counters.pkt_bad);
>                 atomic64_inc(&key->pkt_bad);
>                 trace_tcp_ao_mismatch(sk, skb, aoh->keyid,
>                                       aoh->rnext_keyid, maclen);
>
> base-commit: 9439a661c2e80485406ce2c90b107ca17858382d
> --
> 2.53.0
>

