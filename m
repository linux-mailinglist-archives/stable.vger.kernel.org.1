Return-Path: <stable+bounces-216777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSWA3dElGl3BwIAu9opvQ
	(envelope-from <stable+bounces-216777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:35:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1B14AE55
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ABB5301F164
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BC32573D;
	Tue, 17 Feb 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgBlfZ44"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4B325720
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324532; cv=pass; b=VLSyRkSZ03jUcNsvyf1AH5FYEGJRWAl4XjivGqjwGGFxJ7K1d7e2z7QK88UlG9dElYGXG5aCxJsmwiwxzlG3uyl+tnZ07A6Ds6NRPikZRz0QeW+GSbdPpLSiqXZ1rxkxAygVWereworS8ha2u6rePtu/y23lpz7JDSCfJl2po6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324532; c=relaxed/simple;
	bh=hQ/FqnZ9bKw+6nwRHG3ZTJKdNXpanN5b0OW3+szbKJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcDdA04dyBaF1KNr83w6YU2etPp7JDkilt6jJ8R3HFXnMCfntKmFbNjz0meBcbzxQg8FqhCV8PFlQ+qVuMxF2gTNfS4xKsRHoKGjq2jRW44MPkfzoFaAf269JeFf2qRQx56glC7MTNmsSeVDlwDeAJi596Rlbgpf5JXFAH4TzPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgBlfZ44; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c28495b3dso200897d50.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 02:35:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324530; cv=none;
        d=google.com; s=arc-20240605;
        b=RrBmwMhspgpNSLFKjTpmdVbuRebw6GYQZpFyRfCkyVY4SjutjNGtgiPytVQNw0eLJi
         bqynNRgaOWcRotD/fWNvDHWYEzaRLhYJc0TYH2rrWASEzXOCI61wvUItnwJB1I1B8N3F
         zRRANXZmeOKbFikTa5ZutLUqHLsvfHQGm3HVarXkkpgcEuKV7hiJYKt+5n9yMWHLCWSX
         QibV8wsLaFsXJYjTUFg5a69QWej7pdd5A/mXyg75DUrnZaveKEmT6Jlmv2B0acxHx9S2
         yjjUFs8ywC6qaBAujztzNeuYQirzYcB0fb0dg2FOdsYOLK+7320qtnI0INdMcz0ZAKPm
         rWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uo6JCEeQIxQJPR/F/WxTJBoUZKo4YM7XMzFICKJsqXE=;
        fh=VGWxgfZKx6Q/EjzXYOZdWDgwMXIouoLhPBLDYRHnRo4=;
        b=IgVbNe/bZtumbS+a8DRekKzI1Qq2w0IJjEsfk66bOiMr7jA9YsTMu8ovtVZhB1Dm8a
         iFQcRrnPQFFoqv2zURoFaheelfJzGdhsD3EceOmrlEZbHwbXhDB5dfJppdQbr5WY6Xr4
         WGYtEhvhrRVkk8oM8NAgiF5/+EuK9mvV0goW0yY+B02+lF7+2xsPYf5pqjV3Dyh+dD8h
         32BQj2TMGZ6j1g3RTOZXeZMuFDa4sKzy2HQAKCU1a2/qSeCfMFH3G3waNF9Rk78aJuu5
         M/lY3paZrNbigVfTEQ6NP2SZ4/0BIfKTW/EMwPL8Z16ulko+Zo30Bg96TYR9ZKB0hjhc
         SCSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771324530; x=1771929330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo6JCEeQIxQJPR/F/WxTJBoUZKo4YM7XMzFICKJsqXE=;
        b=EgBlfZ44TKAVsRNIWRXtLTs4YKdfVcek7m4w4lc6E2M22Q0r5g4qWAG5nZIs4mSa56
         5ugKCZBzu5v+/FHoWrxvMkCvhkxFu0ZgpPXQETMlNPSBpnmhYJPi4XdS60mDljF8veJD
         J6OMMTOtiVT9K2sIwgGcrR4gTEFntxQ+aO7+zVfhGJ1JDWnEwV4Ce7Uz15pG6Ut2Pujq
         /RRajVbYgUz29qYaN0LRJN+xczInUlb+qiSJEfwOpNwssUu6zOCLV6APta73BueT/PzF
         H46yVyTFElIbLXklgR0RMcNXe6/pKqggHgg4wfjQHWgHPa3wZw5/rLr48xeKzxnNvpKi
         SLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324530; x=1771929330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uo6JCEeQIxQJPR/F/WxTJBoUZKo4YM7XMzFICKJsqXE=;
        b=WCtcUyh+FFULvuSRatBYHBCEona4faBdhD8nCdxr1r5OgqD/ai6VeWshOmzC5D789t
         FtTFevspMttDaRoPIQlbJ7ZRI3Nsyzq3ooAGozTJ98KFymwWVpaZurIXxwfQriU+VmQp
         /PqxxrejC/NtaVGA0jBrODJqdR7V0a5UuWxq7GAjft3zSUEtVURZq/99hWM00SbgGUEa
         Pjbq0i363hKh4T0vVvpGuY87HUQg6XQ2KlsV8k1WolCmUgVegA+491amYISTiMzb4VLb
         Mif8McLd0G9YPlJ8ACJGBDpvWAp+HazmlC6hM43snHWPvrUElkaRq9gkw1TVS19qR8Zs
         zYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhbNxQUFUAkaHS9Z0RCwmPQwzGjlSVOCqZFatdjS4KfbFSdKG2STyKsq9+enErLiazKvuTt8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YysK3mWsSNn0WtjGQYvJeDVJEznVxI69hL5iAjIn5BqPJxA5AGV
	HMZwz8UlGl7BMfKUKXDHDR3eR+khQXF5iSaGV51dc2guTu5BaYQmZXwolz9nabMzU181e1WXqNY
	WncaCD5xgKWUWZ1S6pTk0cohskPX9t0fUuRiC
X-Gm-Gg: AZuq6aKGfA/e3dBnFI4lyGDq3kNTDvIA+bp8CMN+3Ayrrysui/Hfu2gR0bmA4HSZ6I/
	N5DWKEWbBGg6IFSIAuaMgPHnKXkwQ0hbqwOlQI57gRKFdA4bBysqgP/bBBtqTV2V17D21Ah2US8
	Hvnu/izDK5FytjEXamPCuiLZIc9mKAarRfKcGNhq8Wwh+yGVVdeHDjBaDwQqC8KU4JnMX94KHZD
	LIMwdoBplB+Inaygzn6Cm7VybaDbZT5A8D2aZ8l/9FoUfk27x+xaloGcVONUjvddMmdzfjUrmn2
	Y2pqEGVDXbdS11U=
X-Received: by 2002:a05:690e:1c1c:b0:649:f09d:a6cc with SMTP id
 956f58d0204a3-64c14b29c19mr10556977d50.1.1771324530052; Tue, 17 Feb 2026
 02:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216074552.656814-1-thorsten.blum@linux.dev>
In-Reply-To: <20260216074552.656814-1-thorsten.blum@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 17 Feb 2026 11:34:54 +0100
X-Gm-Features: AZwV_QiWJubl1SYRemd2GYIh64zSBa8SJWZKFL5Plf5tVXdnNSQH30MoF3bKYeE
Message-ID: <CAFXKEHbveJdNM9gEiJ5P4kExvFii=V7KtP4TnQLVve5_3FheMw@mail.gmail.com>
Subject: Hi Thorsten,
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216777-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E1B14AE55
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 8:46=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Fix otp_show() to read and print all 64 bytes of the OTP zone.
> Previously, the loop only printed half of the OTP (32 bytes), and
> partial output was returned on read errors.
>
> Propagate the actual error from atmel_sha204a_otp_read() instead of
> producing partial output.
>
> Replace sprintf() with sysfs_emit_at(), which is preferred for
> formatting sysfs output because it provides safer bounds checking.
>
> Cc: stable@vger.kernel.org
> Fixes: 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
>
> Changes in v2:
> - Return the total number of bytes written by sysfs_emit_at() after
>   feedback from Lothar (thanks!)
> - Link to v1: https://lore.kernel.org/lkml/20260215124125.465162-2-thorst=
en.blum@linux.dev/
> ---
>  drivers/crypto/atmel-sha204a.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204=
a.c
> index 0fcf4a39de27..8af767f903ea 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/workqueue.h>
>  #include "atmel-i2c.h"
>
> @@ -119,21 +120,22 @@ static ssize_t otp_show(struct device *dev,
>  {
>         u16 addr;
>         u8 otp[OTP_ZONE_SIZE];
> -       char *str =3D buf;
>         struct i2c_client *client =3D to_i2c_client(dev);
> -       int i;
> +       ssize_t len =3D 0;
> +       int i, ret;
>
> -       for (addr =3D 0; addr < OTP_ZONE_SIZE/4; addr++) {
> -               if (atmel_sha204a_otp_read(client, addr, otp + addr * 4) =
< 0) {
> +       for (addr =3D 0; addr < OTP_ZONE_SIZE / 4; addr++) {
> +               ret =3D atmel_sha204a_otp_read(client, addr, otp + addr *=
 4);
> +               if (ret < 0) {
>                         dev_err(dev, "failed to read otp zone\n");
> -                       break;
> +                       return ret;
>                 }
>         }
>
> -       for (i =3D 0; i < addr*2; i++)
> -               str +=3D sprintf(str, "%02X", otp[i]);
> -       str +=3D sprintf(str, "\n");
> -       return str - buf;
> +       for (i =3D 0; i < OTP_ZONE_SIZE; i++)
> +               len +=3D sysfs_emit_at(buf, len, "%02X", otp[i]);
> +       len +=3D sysfs_emit_at(buf, len, "\n");
> +       return len;
>  }
>  static DEVICE_ATTR_RO(otp);
>
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>

I took the patch as of link below. I verified on the before described setup=
.
https://lore.kernel.org/lkml/20260216074552.656814-1-thorsten.blum@linux.de=
v/

worked, LGTM

Reviewed-by: Lothar Rubusch <l.rubusch@gmail.com>

Best,
L

