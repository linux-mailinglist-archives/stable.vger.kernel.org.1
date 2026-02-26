Return-Path: <stable+bounces-219861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AENEGcq5oGnClwQAu9opvQ
	(envelope-from <stable+bounces-219861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:23:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E68001AFB0E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15EF230138B9
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F68428463;
	Thu, 26 Feb 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcTg4KAQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F63033EA
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140968; cv=pass; b=hLJeVBYE/owBVxY+MrZuGiHPSN8Sy8n/2TqDpATWJV87sK36S4/5bykL0sKdhSgV2fwxuxTtLapthq2xctL3ndruZrSJLgp3nfW25imBluynEIMAv/sSS44RZLOqQjmQQuTCWU3J1M3k1nj++tGtLwz9ZixMc+Q7UDeFt4htvMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140968; c=relaxed/simple;
	bh=ivaSk08hsOQ+TfXEHtIOfQ/rw2QIDNUh0XWawt6aHAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am+T3E1gammjGYCcgVbDfM67AhLYnEuFdJ+6/U059zanApDeWBeV/43/TcmqKkax4LOYqfMox5wyFzQmWLF72j0Nnq47C/4wmKVf798UaV9usHRCCwInnLw0Wee4kv0yKJ4xZ2+dmNG/CMCvEKDhsVacgO7BVNCtmBPgk/Yoc3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcTg4KAQ; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7986b4e59d1so1449937b3.2
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 13:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772140964; cv=none;
        d=google.com; s=arc-20240605;
        b=M9Xst06f1ghQCLgjB+g2O0K5CQLO2tGkSwpejpvCiHPWIc1hyvfy8aVV0hSXUDmR8I
         gGHuQ6c9/JP05krtM4cmaM053qfAE5Xu6xzNP0TgFk6BYZDZ/YizzagmSYl1qXiM0iWv
         0yf/Te+n5GWSAH25jPE1o03+uPQLzgCFFVb+r6kqPcaI6fPvb3lkK2ppzGa5pQYqPu0M
         +ycTMFzfdMQfPyAQXKxtAsOdhoOISzSElU8bEvXnscUQg6MaWRdznunAV2RjoC1kaMzD
         ilcbiAIvk2/rDXviwyLh950WYeKUE6PxOIAV10vjMA5ebqwEGXxiRxrdbMPmp1JpZNy3
         TfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JB4+0Jjmsb7WCQkN35VAE3lNJIaVQsTkaWwYNjZ0X0I=;
        fh=jKPM8lcv3rYJwYFxohrcPH2S/Zbj69+bjL7r5OXd/zo=;
        b=RtD47uTs3cLPeRGcks4DlIocU7HGf39UPl0SYS2rEDWdYoot9ZbesUPGp0U6SRz+Mf
         pQnpE6Nt8USU9UiVS+kz5AevTJcnvYhrYOedOMK7CFJw+NbMD4TYLTVsQESLk2a2kWX0
         r/dUJk7GLaOwEqBTgmD7cPIKT8jENGvx2ubkImwYhSrdnwCPFcWVEQg+DeBkIJjQJUGB
         aLNKxPe/FkrkK1Dv2vhJDDxC0Z2unePzXG7kWB5PTa1CXTuN7KI003Wo7XkeEtbXZPdz
         2prDosH31dkaTLzX5azI7QLCYZZ34K2xfjCqE110vD8h4pUakDnm3jaavwy9OdKZH7gj
         uuhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140964; x=1772745764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB4+0Jjmsb7WCQkN35VAE3lNJIaVQsTkaWwYNjZ0X0I=;
        b=KcTg4KAQuH2dAQInBo4qSx7S9AmZ0QJO7TrzIofQaql1R/aciIGi6yWC75nTksszdN
         dt0UinD/NhIQLPDfI/OdTEbfT5uWjy8FIk0Y5c3dh4K2zgvSntImkGUi3DYZMfT4dDAZ
         VaoJp1TW2NZzP0PjE11/S3BGjqm3Vuv76msbV4JRQLaXNOoco0rgt6AMI2Iv7FL0zZD8
         bipIWSG3D6YkFqtp3XjaPYtoq2qFxePTXCvU8y6pq5xtZpyUoXz9lQE7595fPTSZwksF
         MVNNUVA56ZRycP+LLv47wziusX/ZYcUwfanzNQn6d3F9aBJ9OyrtnJk7fzL3OCoRfNyb
         jxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140964; x=1772745764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JB4+0Jjmsb7WCQkN35VAE3lNJIaVQsTkaWwYNjZ0X0I=;
        b=H9NB9DLkzzeKnz+lbb0Uzn9dSezELBtgPXoLGezv0Avv/begyeLPepEFUC1qqSMSLW
         8g9QaKs1ImuJguTuc1SkxW+RAKQbwSjqh3cZ1OkdQlkY7JEFryDCUUS6NM5F7jDv4RFs
         hqpCbCGkO6Ye6EVIn6VshfMoEjPBgzMzoBvt/aDMaAs3XoHAsx839UEcxpEl/DOjreI+
         Pq6wdz4Gpd7VKzbsKh6d7e7fy65xAEEfzu1Yge2n1q3ENfwGafLqa7gY2GBeShgWbSQu
         JnFEcDv6U+zaIMdVp3awNVuSp5fv3VbGHhGIMFUGOEvnGBVq8hhvQKiFJ81i3P7WFHQP
         VBmA==
X-Forwarded-Encrypted: i=1; AJvYcCXObQDOeOWmRNqHl0xDJNuiqECNVAlvihMKHcm1q+GnGz/mQsdUWbj5RK5AXWjzYSdJZZT8dsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0w2J+VtUGbwNZclP0HLj1/OdSiPmKo2+DNhicX4ZmGUldNagm
	/rtzdzLemKuVyj94aZrQVRwcOYUAHmZjxH+Nbr+T/geNlwi2p6DXyBo0d4c4Vnfvf6knY9VSs2L
	+0fTFUzP0OFkZyXrAvpG/wuXq5kdFhe8=
X-Gm-Gg: ATEYQzys5Zl0JrO4zSNgRgYLWUTjQdqgqyHQNn5KeORkqUdHq1pq8xCpgemnmMXThEy
	UaHK1MapbtgEO7/WNl7sE3mdqBeU8zT/lH2PBlYJEwE2Mnj6o+TmhYwdVoFJKvxcfXsKtIW47b9
	Efk3wx60q3JFpKYEiyplzrh5Q36I4nm5hgjtomu6koC3FSshgtJPdOJcF4G3UzhQwtNwco34t2k
	Kz6gS7OAxhiWHuFmkPLleQOThBlk9XgtNe0KshejpNCem5y+MJeIokvfb2DUm23sq39QKZ2mM20
	Sttu
X-Received: by 2002:a05:690e:1596:10b0:64c:a2fc:807b with SMTP id
 956f58d0204a3-64cc23341c0mr449268d50.6.1772140964164; Thu, 26 Feb 2026
 13:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224225547.683713-2-thorsten.blum@linux.dev>
In-Reply-To: <20260224225547.683713-2-thorsten.blum@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 26 Feb 2026 22:22:07 +0100
X-Gm-Features: AaiRm52It-aXFcuLq__go6bqOZfdSs9Bh4efwCHuAs4dMiL1mpRRlFj6QRKv3qw
Message-ID: <CAFXKEHYTZHT1sX0rNhbZoG40eEkn2B1Utrx+9Jn4a580sGj7Ew@mail.gmail.com>
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix OTP address check and
 uninitialized data access
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219861-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmd.data:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: E68001AFB0E
X-Rspamd-Action: no action

Hi Thorsten, thx for squashing. I hope this goes ok with the maintainers.

On Tue, Feb 24, 2026 at 11:57=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Return -EINVAL from atmel_i2c_init_read_otp_cmd() on invalid addresses
> instead of -1. Since the OTP zone is accessed in 4-byte blocks, valid
> addresses range from 0 to OTP_ZONE_SIZE / 4 - 1. Fix the bounds check
> accordingly.
>
> In atmel_sha204a_otp_read(), propagate the actual error code from
> atmel_i2c_init_read_otp_cmd() instead of -1, and return early if
> atmel_i2c_send_receive() fails to avoid checking potentially
> uninitialized data in 'cmd.data'.
>
> Also, return -EIO instead of -EINVAL when the device is not ready.
>
> Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lothar Rubusch <l.rubusch@gmail.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
>
> This patch combines [1] and [2], as suggested by Lothar in [2].
>
> Lothar's Reviewed-by: for [1] has been preserved.
>
> In [2], Lothar questioned whether returning -EIO is appropriate; the
> exact error code can be adjusted if needed. The errno is currently not
> propagated to userspace, but [3] changes this.
>
This was just more curiosity, nothing to mention.

> [1] https://lore.kernel.org/lkml/20260215205152.518472-3-thorsten.blum@li=
nux.dev/
> [2] https://lore.kernel.org/lkml/20260220133135.1122081-2-thorsten.blum@l=
inux.dev/
> [3] https://lore.kernel.org/lkml/20260216074552.656814-1-thorsten.blum@li=
nux.dev/
> ---
>  drivers/crypto/atmel-i2c.c     |  4 ++--
>  drivers/crypto/atmel-sha204a.c | 11 ++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
> index da3cd986b1eb..59d11fa5caeb 100644
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
> index 8adc7fe71c04..b0480d3bec70 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -94,19 +94,24 @@ static int atmel_sha204a_rng_read(struct hwrng *rng, =
void *data, size_t max,
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
>         }
>
>         ret =3D atmel_i2c_send_receive(client, &cmd);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "failed to read otp at %04X\n", add=
r);
> +               return ret;
> +       }
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

I compiled this patch, loaded and unloaded it, sysfs entry also still
working. LGTM.
Reviewed-by: Lothar Rubusch <l.rubusch@gmail.com>

Best,
L

