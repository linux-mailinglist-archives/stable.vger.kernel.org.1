Return-Path: <stable+bounces-217673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPYwD2I3m2mVvwMAu9opvQ
	(envelope-from <stable+bounces-217673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 18:05:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1A16FD8D
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848353044A77
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5035B621;
	Sun, 22 Feb 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhFEelBx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB82153D8
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779835; cv=pass; b=Ml+S0w6R5Ayewd/8svh+61l9vR7dJUevDwhcWii22AbFDUSvmqpPB9ytK1eQgla9ky/C/F0mGshfS6qMQO0XaconRlI/ZSfTNYjh66GpgQhqkfny7urdj9CuleZtXm003obTkh3jqEze7WIx4MohNiK+T0k1XIKf1e/+v/jmNn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779835; c=relaxed/simple;
	bh=gfPxTAcGn6GgS3LFZjQMK6EB0WGi51aqWGuEHQrQwqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wsqil3psM+R7U8xdV9qQOdYlDfyDwkARcN6iZX+3gvunJoim2ZPaiTaHXZ4997ECrrTyVWX9DTAitizjk4hqZvybBcJECgd4tGmQlklw9tb9QZH8dso4vlw3tBvdMavlymAS5Q3n/wsqw/4oW7YPHLyaRMJm8XGXYom3osp3Dbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhFEelBx; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ae58222aaso509161d50.1
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 09:03:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771779832; cv=none;
        d=google.com; s=arc-20240605;
        b=hERAgqKHLFSHM7OwZERrLL5LtZ0BLRVXUxYjIuuHsDOur6K85FWpiY+7i78mi3n+9e
         eM1gUmGRLRfFfsoqJN3psr4stnx43flT3uczgpYg64HoIJ0eYxOVGvF/TLLqDPnxtZ62
         JoWloKfbG5CCnjgRKAj7Qy8J6ejURXdSc6nsQqSqiBx6Q0kYI2mu35azgtL6kYztiPJD
         Q6gpOofMCDoufU02wFdIX7yAdRXd8KeW+bLhVeDsDl5tiH2+g3wC/l8Qehzw/IK3bYW8
         yhoISOsvVLOGQanxRBSZQ3vXCUVAE3QhFgdzkw23XGTsww8nQmqg3saO/08Ua8R3QpKg
         vmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBykXcry3hRl95wYDSUTJ/cR3J3An6RSzJqIbZMk+XY=;
        fh=c+me+cyWp440Wh+hEce0vwFMPPm/5HgjcGDhodm3m8E=;
        b=Z8jvLOCEZbjPtWZaxp8haFZdw56JUkBFTNvUZMFPbvFJbw3yAfzADaKglJcydugon7
         XgqMEDgUQqOVtLeaNzT65Z9w8nmyT0D0d6kynziaMqTRUWAkV9msOku26MCTGztQWpeE
         AbgBu34+fR1dKBNE1btShxr/Fcc8Nrwr366ACHt8if0gEcW6td1a4mHYRlrwhY6Vxdqp
         9lxLwZSF7RYOPL9ckQi8wUMgOjelEcob0XiFuTHoxRkKUhkF8ZeUEab4GSNmUUSApwa8
         0TDUUjasxBEHG7oWiXmCho/3r5RE52V+85bJ/TPnmZzHyMXbEeMOab5spjKi1p7fvLdz
         9kzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771779832; x=1772384632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBykXcry3hRl95wYDSUTJ/cR3J3An6RSzJqIbZMk+XY=;
        b=mhFEelBxILapHAdw/HYaKg34ulq0t6tjFxadbe6MiXapvc1Rz6AwtnKd2ec+kWbESx
         tUpXBcBZhclsZffi3asUHwCyPiV5pial1yZ3TuEWW0JJD4XLrXySlalOST5JBpTnR9DX
         FY4y5yfitsCzMiNwUN+aWVziCBKBaXZ516faTQG3mQXgUPDPoA0Ome9gnrvqCbO0oL0o
         bnbUepcgeGuTVSH5HD1dxTeaFgP6wU/gm6Z9NwWsce++YSCdWRsNzP5mpBqtU2nQj8H5
         CGSiVia+pu1YXVR1cavnDD1nruRYpkEz6jRsOFb4wEMJJ7jDZpRJXLk8+5eo8I4x4n7C
         2fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771779832; x=1772384632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBykXcry3hRl95wYDSUTJ/cR3J3An6RSzJqIbZMk+XY=;
        b=KdCNiSAYNKu3FHlGtH0UQfGA1Nudz7pD9dtErcwr4WuKixVnvIer8mhUQcH8wPFlxl
         zmCc5icpvEm2R6T+/EcIH7VwVGNvvBzD2DnNG0VzYB8STa+SkYnImC2awoWYa9gN9Y75
         zFTQSvMAiTcvhCGrUywUBIKqHbuC1wC6ELhkPUzGKZVBoU8B1LdKJ6nNIFDwWIF+QPyE
         hKnhgm6Vq/52NHQiTYg5qHi77hWxeAOyvhMvF47N9tZdb190cCE1lWEHx2ghgPjWkj1V
         kGvT5zdXJJ0D7u8/rPDoYc+5gPZ9ZTodnUe1LV77jfVXAX4oZW9jEivmKz+psztZSAUm
         bRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG0IDCUIDdWIajFO6wHVDz3T8ePywOcUYnjkgnfoXe++hZ6L2VHKTPkPA2mjdFRt9nkV017nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxqGpFa1n8gzKgY3KgKo0FlbWaDf2gg2oW91o0eI0WRICCRpB
	BGSYvu1APgO7q4hsSp/zHu+to0ClE6yuRyFiB1JhWhU5hdd4szQrvmo7blX0fpRS5o7ynd1vYFj
	8FPdscqfiKm6O1bIoP1ElwGz1L9+fhm4=
X-Gm-Gg: AZuq6aJo9MDYpl6QAICm2wU3ZgQpiOqCQd/5pJgUyD8g8HwogZcqIicqjaDY4OcDMtJ
	1l4M7LYxN6j7B5lcPPSLjXdQSg4/1LS7JwBbG9SxV1LSKh0SrXZkp9UJAB+ESFXo6WKaFDPRjUu
	tU1MJtJhRHrhHnJF6X0lZw1ZaguVPZlUJT6Hj0HGUYRgdA2ugnXeRTFeNQAGGWcCn1QGvcIBdzL
	pmWrZaLMVm6lsbkcSYpgcLyFrKJ0SrxgPb+E0dvc78xtBF1aAyA+9+R3UNXKY/uy7Yd9Zmh82Xv
	I9XF
X-Received: by 2002:a53:d009:0:b0:649:c3be:a387 with SMTP id
 956f58d0204a3-64c78d3e730mr3895155d50.4.1771779831946; Sun, 22 Feb 2026
 09:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215205152.518472-3-thorsten.blum@linux.dev>
In-Reply-To: <20260215205152.518472-3-thorsten.blum@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 22 Feb 2026 18:03:16 +0100
X-Gm-Features: AaiRm501A03rgVMp3fr1R-CFD3HgkD42BVCx_r2SycJdlIw_EXWDQ4yLRJnqDhk
Message-ID: <CAFXKEHZ9TTZMdzKr8_5UesUdajGoQNm_u_paakggtGONbzjPcQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217673-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmd.data:url,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 92F1A16FD8D
X-Rspamd-Action: no action

Hi, find some comments below inlined.

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
Since I2C bus errors are caught here.

> @@ -106,7 +107,7 @@ static int atmel_sha204a_otp_read(struct i2c_client *=
client, u16 addr, u8 *otp)
>
>         if (cmd.data[0] =3D=3D 0xff) {
>                 dev_err(&client->dev, "failed, device not ready\n");
> -               return -EINVAL;
> +               return -EIO;
The cmd.data holding 0xff here is not a bus error. AFAIR it can have
to do with the locking state, pre-initialization,
typically the atmel watchdog kicked in / timeout, etc - so the
response is invalid, although hardware connection (I2C) is
supposed to work. Currently the caller of this function does not
distinguish anyway.

But why is EIO preferable here, over EINVAL?


>         }
>
>         memcpy(otp, cmd.data+1, 4);
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>

