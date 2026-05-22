Return-Path: <stable+bounces-253680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGx+LfHED2qJPgYAu9opvQ
	(envelope-from <stable+bounces-253680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:52:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180205AE2A5
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4599130166DD
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA130FF05;
	Fri, 22 May 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii4G48o2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8823395F
	for <stable@vger.kernel.org>; Fri, 22 May 2026 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418344; cv=none; b=OgLtnjDFcJ9zgCbdjS+ngm7rdZS35AUsP5tacuOPeg19vestsUz8kS8abBTLqb0jWMBhPTnOxo6FsOXQ6iLa6rv8pQnbkQ3SV9T4L5mxwkXvHdgogWagdimVKGfkY34SVSx7AuzyauVcy1FpQRZsNzKE0vWBfkpZ0L1oqoc1DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418344; c=relaxed/simple;
	bh=ox6bxPIZcQ9pA2poXV11dQdhfB6hdnT42WTbPpl769k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGAeiqWDJ7aXxH746sCrL8zlLGH2ZLiuWkWwfP9AV0zQBehnnv9xRnDBlkRYPa0ihR0u+xvFOtMK52JzV7WHO62yCYcq0dBMjSDG8q/fxJ8lX1y9TYDf1HkIVdFsFRrInhT3+5j64MVPaXWxmjv28RmUGiw54kBgboZKxs02Z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii4G48o2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFF31F0155D
	for <stable@vger.kernel.org>; Fri, 22 May 2026 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418343;
	bh=add7O784fB7u3KgFvBd8EhJRw2Ch/7z+5srxbj+5fbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ii4G48o2zZI0d+oJlEwHvSxRmvlU88HXjsXH6k5Z8BAkXNvanS+hWZTiP0FmlqNnd
	 0GMLQaQQcqxbMvo6e9tqFjBPe6bb17QES5OzuI/nJxp6yDfeou9tEfmiYWOoJmctWm
	 XWV7zMWD2ZJ6HJE/LaqVDv4HN34aYzyZlLescXqFd4aJIh4SggNK5gl2JQ9tY6k4gn
	 T6ha1XiYcQDBRm5XF6vxK5oRB/0BoVpfTSyAt1wklhmA0NTPOfSORvKmr2ACzTuVxL
	 25j95+UXnrHGI5jioLLVtli9pHDrazqSmjYcaZBIwttUIt/nw9Tlt1BdE/9QH5vruh
	 kwXmnM9kRX+nA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso1269952066b.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 19:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/OngKwSf3h5RhvQd0itezgwJ39PhtdoTaibtLsrC+ac/wtKFOZVLyNgtsEzPO2H0XPnbUJegc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOaLTV25d8WA1bhKLF9Y28GZ4oDuy39RdMqiKne9lCUlCJA3s
	Ovvdm6bB4H7/VWy4xLo+BFG59g5EacRcXtkSHyFM9iT/6yu9d+SBususHYHNb4GGzKuZZbw/9s+
	iMQkIinVBPYFu2Bx6e934Oq6Im2cBbPI=
X-Received: by 2002:a17:906:fe02:b0:bd3:1a18:cc64 with SMTP id
 a640c23a62f3a-bdd2580c51cmr104098866b.31.1779418341722; Thu, 21 May 2026
 19:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522022525.12976-1-ebiggers@kernel.org>
In-Reply-To: <20260522022525.12976-1-ebiggers@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 May 2026 10:52:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cDnWKxBobwRErRyvG8671e6VXsBe6w1RkX9rfn7CVFA@mail.gmail.com>
X-Gm-Features: AVHnY4LY-TOi84C9U6iPkvfzojtdl72PfdB391W9bREXD-FyusIkwq7iXYp_NFY
Message-ID: <CAAhV-H5cDnWKxBobwRErRyvG8671e6VXsBe6w1RkX9rfn7CVFA@mail.gmail.com>
Subject: Re: [PATCH] crypto: loongson - Select CRYPTO_RNG
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Qunqin Zhao <zhaoqunqin@loongson.cn>, Yinggang Gu <guyinggang@loongson.cn>, 
	Lee Jones <lee@kernel.org>, kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253680-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 180205AE2A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:26=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> This driver registers a rng_alg, so it requires CRYPTO_RNG.
>
> Fixes: 766b2d724c8d ("crypto: loongson - add Loongson RNG driver support"=
)
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605201622.qWOiiZTV-lkp@i=
ntel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/crypto/loongson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kc=
onfig
> index 15475da8fc11..f4e1544ffbb4 100644
> --- a/drivers/crypto/loongson/Kconfig
> +++ b/drivers/crypto/loongson/Kconfig
> @@ -1,5 +1,6 @@
>  config CRYPTO_DEV_LOONGSON_RNG
>         tristate "Support for Loongson RNG Driver"
>         depends on MFD_LOONGSON_SE
> +       select CRYPTO_RNG
>         help
>           Support for Loongson RNG Driver.
>
> base-commit: 6c9dddeb582fde005360f4fe02c760d45ca05fb5
> --
> 2.54.0
>

