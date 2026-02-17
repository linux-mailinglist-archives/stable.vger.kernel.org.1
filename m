Return-Path: <stable+bounces-216782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIeTB7NKlGn0BwIAu9opvQ
	(envelope-from <stable+bounces-216782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:02:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834514B1E2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 851F5303338E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2432ED4C;
	Tue, 17 Feb 2026 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB/iGyuJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2332BF46
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326102; cv=pass; b=VZHWHur7vDmrZ/wBx2vW8YhgYyXZ20CfUuul6d6+y3ST6BtGKOVgti1SA1gMvOR76EpV21zlaI/qGx3/tvQ0GZLE2QzR41gUI/svIcL7J5gcZer3k0tH+vdsby5nL/lwMA7fyBDTSi+PihvPyf/H0TIWFe2NNSfEgTJEOSoXZSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326102; c=relaxed/simple;
	bh=NejZiV/V3YzcLdOEsrDKIlM3Cm8jcTsCrNvnU8CR6xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3xDWSPrH/eQL8NZ4Bx/qPnYqbgbUls4SmjGVOlSJSiyGatKecDxDyoRy3ynf6B1K01NbM53fHBtw5GtDpz+0ZCaoRUHhYeeVpIY4/tHufYCJJ2Jj+wMN2X6rLjaZ4X4p2gwGNdi0OdDSiA6d7ZBIOsfS/OVQtsvDq5y+6luhDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB/iGyuJ; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79652789a0cso4516227b3.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 03:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771326098; cv=none;
        d=google.com; s=arc-20240605;
        b=NahrgKlfdRjmeytFkUaXiHtBmK2uM3GK/7p/hoCqcQfML8rOxDNblnLvJbmA5/0aNj
         EY6+pQUTw8psXN+D3fsI0ceKndlNng4N0YZdfHsagZ+wnF8Wcsbtz6RRr7Wwd0bBp2f1
         ozhnBhwo/2/oqghStfMHyrAHdUaSx3FqcVBPhkeAGqDI1uBTR6XIJyHGmqT1O2hK/f6k
         rMeRsmWvkYoHD1hyvrxV4kwDsfwgSwFlBSDZRA/E2P/fvN3xgJGMhuPP0oM2FC5q7u8C
         eiX2z7S930ENl0h93eGl8b3yMhz9qt7H/RGAda/KRZystdILDGxJssJv1/CqtA0P/Pbm
         DM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNlPguOObx+yXshPeTIquRndnBus7h4jAK1vKKf010E=;
        fh=e16BWeAbMIYbW9ZynnHxjgSscrTzf6mOVU1+bZqxfMc=;
        b=bIh4rNce/Xb/6As6OhX/FEdAOq5WpA2L0k4GPs9Fj9ThA7QbZNYhBYhHOVWH3O36de
         JBIMXsuKOrZI8olFAbCmgkNtUiiWGW2rxCQ+2Jd+GORrCet7PpwIXFm12XSHaAZIQQDJ
         jqhoTfDlSahEHtZUyCXjnQxE9pi6ZaDFpAK89FBjxH1iTFv5k9DRYn1Sp+AWBQiErBHS
         o+FErQznpLRmolnHizeVvnKTwCq0WXieQHUYk0RIXzBAHKyFx7HUNc8OAsynZYZTrkvZ
         1yLfYMQCoAHhWSfgTo5XQksAHcfqV2ia/8wwjlPLyTacBnxc9L3sjgGhJjxX1Kftbj8g
         NIFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771326098; x=1771930898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNlPguOObx+yXshPeTIquRndnBus7h4jAK1vKKf010E=;
        b=WB/iGyuJW6p7cB2vylJaCC0PyE5AAIqvDkktIm+UAJKZeojOKob6paNG7uhr1StEo+
         JYylY50A7PiKGCH9GMFZBY4vad75ufeE9wNKBUnqOpQZAe+fp8KbUQuuS4A5QpTxT8Kz
         s5IUSTWBXTyPV9KWmsca5fZTaD62J9iT/V5Zq7ilgxoz+orGyQzN8hIZXt1xMp95lhBQ
         skdOWvqCFCWxP64dKx4iERmUh5gOq0xpBVhnrAfyvdrfjpJKtn5/tt8otXuxQ2Myh1Ph
         9TQyGTKY2lmxHeRgmequFggg8qFHgYPBEKBAivYVycDTYWzQ06ceTxSqNFFuRcAz19DR
         SQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326098; x=1771930898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNlPguOObx+yXshPeTIquRndnBus7h4jAK1vKKf010E=;
        b=CgqXsEhyFhL87stoL208BHcNNbg6z9F4tc1vbOFNujD7Gje9+vPLYfyEPgFf9+BWSX
         prG5t02Y1BM9ukYfaENQZzbaFg0JpAFcwnNaPxCK+kEeFFNroO/jyOslBS/nPqwGPNlS
         UQ2JtorP9cXag0/KmCIwtswKXd6uHB90z5jYVLs2pPZdytkBNgZNHWOj0l0fQJCUnLFr
         U4lYS9BW4QLRxLZw4n+9Dg7XbXLugkXoHIQPfOIJNeP98qxDRQc0AsWBlvMNJNiH16dE
         BvKiixchfaPWRZODVwVEyNsmr4tvU4FL7SCLunYOgxL2SuukjClY526XRW0kBfWK1FaQ
         q0nA==
X-Forwarded-Encrypted: i=1; AJvYcCWtZPV3i9Towg6c3KKYB6QxhBvZQkxDq+SuhDZc09Fg3SYl4mHEHnFy47D3FwMWKeG3FCorx3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWKrtd9+zQUFEOpynPiFSkoa387jRNGKSoMCqGaY1pu3V2MPZ
	7WOIGae3OqOYLxdlag61qX1nRa1selEXs8Q6DZkIOZqPKX6zymG6DXPCC/h1bzZONo26pnPgI4e
	1QIJgrQ3gkEwoLQGbwYNqWnPlwTaoLtA=
X-Gm-Gg: AZuq6aLplPb1gm9anYoQ232b8s342vkqKURnONgvyf7ttYdQHkDMdB2cX/jM68u/DwL
	EH7mOma+3L4QQlKJtNszk+skEcRxBMaJ7EAWPSHKgP91TDtsgrXM7rmZhahB5FEZQFCzEl/GuMn
	k6u6o4Djg9kUjpe6jHrO3rKpiDzH0pCs5cE5HZUpdyxA3AuhEr7FCJFPentUDlC/l+hx/vETtbP
	czbPQcdtABMv2gDMCUrf3HqNxL7e3CEhEmeyIMZCsSiHTv/1i8p/QuS7X/jldrUl6HmInxGyFKY
	FD/HUSgSV9ljKn8=
X-Received: by 2002:a05:690e:4004:b0:649:bf2a:71d with SMTP id
 956f58d0204a3-64c14d8c91dmr10695377d50.4.1771326096397; Tue, 17 Feb 2026
 03:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215205152.518472-3-thorsten.blum@linux.dev>
In-Reply-To: <20260215205152.518472-3-thorsten.blum@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 17 Feb 2026 12:01:00 +0100
X-Gm-Features: AZwV_QhRbxpAvpo2UBR8-Y_jstIAD1Nkb3C6Xx--Z_yv-x7ERa_X4u_C0YYTw2Q
Message-ID: <CAFXKEHbzStf-8egh4QVdxz6MmAn_fBh1A4G-sb4gg+pxU9Qdkg@mail.gmail.com>
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix error codes in OTP reads
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	stable@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216782-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 8834514B1E2
X-Rspamd-Action: no action

Hi, the change works (doesn't break behavior at least) verified on
hardware, LGTM.

I remember that time we had a small discussion on what is the right
approach with the return
handling, and at least me was unsure about it. If this puts it
straight I'll take it for me as take
away. Thank you Thorsten, and sorry for the fuzz.

Reviewed-by: Lothar Rubusch <l.rubusch@gmail.com>

Best,
L

On Sun, Feb 15, 2026 at 9:52=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Return -EINVAL from atmel_i2c_init_read_otp_cmd() on invalid addresses
> instead of -1. Since the OTP zone is accessed in 4-byte blocks, valid
> addresses range from 0 to OTP_ZONE_SIZE / 4 - 1. Fix the bounds check
> accordingly.
>
> In atmel_sha204a_otp_read(), propagate the actual error code from
> atmel_i2c_init_read_otp_cmd() instead of -1. Also, return -EIO instead
> of -EINVAL when the device is not ready.
>
> Cc: stable@vger.kernel.org
> Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
> ---
>  drivers/crypto/atmel-i2c.c     | 4 ++--
>  drivers/crypto/atmel-sha204a.c | 7 ++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
> index 9688d116d07e..ba9d3f593601 100644
> --- a/drivers/crypto/atmel-i2c.c
> +++ b/drivers/crypto/atmel-i2c.c
> @@ -72,8 +72,8 @@ EXPORT_SYMBOL(atmel_i2c_init_read_config_cmd);
>
>  int atmel_i2c_init_read_otp_cmd(struct atmel_i2c_cmd *cmd, u16 addr)
>  {
> -       if (addr < 0 || addr > OTP_ZONE_SIZE)
> -               return -1;
> +       if (addr >=3D OTP_ZONE_SIZE / 4)
> +               return -EINVAL;
>
>         cmd->word_addr =3D COMMAND;
>         cmd->opcode =3D OPCODE_READ;
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204=
a.c
> index 0fcf4a39de27..6b4e2764523e 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -94,9 +94,10 @@ static int atmel_sha204a_rng_read(struct hwrng *rng, v=
oid *data, size_t max,
>  static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u=
8 *otp)
>  {
>         struct atmel_i2c_cmd cmd;
> -       int ret =3D -1;
> +       int ret;
>
> -       if (atmel_i2c_init_read_otp_cmd(&cmd, addr) < 0) {
> +       ret =3D atmel_i2c_init_read_otp_cmd(&cmd, addr);
> +       if (ret < 0) {
>                 dev_err(&client->dev, "failed, invalid otp address %04X\n=
",
>                         addr);
>                 return ret;
> @@ -106,7 +107,7 @@ static int atmel_sha204a_otp_read(struct i2c_client *=
client, u16 addr, u8 *otp)
>
>         if (cmd.data[0] =3D=3D 0xff) {
>                 dev_err(&client->dev, "failed, device not ready\n");
> -               return -EINVAL;
> +               return -EIO;
>         }
>
>         memcpy(otp, cmd.data+1, 4);
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>

