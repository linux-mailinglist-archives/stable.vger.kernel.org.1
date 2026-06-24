Return-Path: <stable+bounces-268099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmiiCLOVO2oXaAgAu9opvQ
	(envelope-from <stable+bounces-268099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:30:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FA6BC936
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:30:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268099-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268099-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 258B4301BBA1
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AC230B51D;
	Wed, 24 Jun 2026 08:30:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9322B8DF
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289840; cv=none; b=FWqygkfGz0UABcVk5v4a/8m3ZCog08BeiB/fwdRZRMbTqXcNkUPOgAZ39OEXonVcSTS6TpTO7mY039HjUx/xQjQGr0ObICuv/q+O9mi656zX+ROcwuCrirxI5h32/B+qVg2a5ecHqoHO5uzrCgXDkpyWynOZnpi5MWXTSJmrljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289840; c=relaxed/simple;
	bh=5CF8cFIz9JsZnjEH1f50kxL+eYfAhO4O/Gce54YfmRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4ZwPD7fKRfWecHnytl6crKdDnUXngrbh17OKz1QB0xvEKJpAr+NBps9QmB4rjjpyhA/ft3KTT3ESXQX7aDW4hQW4QotPy02g2MfUz1GEO5AFgi0QXa7DES5RNcsjWqi/QReYKT41H58v7ELIDYi5wFF4wIos4jOL2ZikAuVv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6c79d2bb687so524018137.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289838; x=1782894638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89wiNQbsCWZPPjgDqVOCo3AjyyLFz02UvWNpcf/m8V4=;
        b=qnlwipL/7PTA6JM5g1CUwGgONmxee6Kb04A4srSMAZ/jkdaGvucrPHY8HfgmP89Yzz
         Po6AI60QCJcj4Q1MWeIoF9AbUC5QqhjlRUH0T6URM8z4xQGNjSoWaxXM0pT2bzcKjpV4
         VsRvOeF6XjN64q7tfJQ+02uSJQiaTJt5YUj3cI9UfAGht+177aoyvEMnVntgI02ivuY9
         +ZoOiWLUNvZmVQ8B4FgUYw+KxdMyrX9D8J1SN1CqrziVrcjjnojODPgSmSNc7w7/5Nbq
         XVLIhpVxucFEZY18uV3AoyzpLf0vpIl4rkVdMtHywUPwbEj8pQYKwhVaLNv3MiwLuocF
         ggMA==
X-Forwarded-Encrypted: i=1; AFNElJ9YVZqQF1/49w9h07WttqMmYwDymimhQBgLyRSUUQuPU38oUGaSc18u80hSoPqyj9cHaI4wuo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/8DwvOnFXynzxxCaomHfxxnbmra+G1wMNIkaK+ouFIrtGGbQ
	Vz6bZLRdpPD6EdCImHKcGYbUwbmSoTo4ht0C3ZHGBOAcCy4KzeIVOhRK1WHuJWeJ
X-Gm-Gg: AfdE7clHGp9jNpymsV13DyBEAiXlQP1DLOhovSNpTnQ8v7N1tJ+BRiH8wg9h1oBeGra
	KAJLCL3otdMEbKgEcUjs75XZ2TdPa2La/Ix4cWblbD0tCzmvo+5P17Y6d9iiKdlWt9wL21h/dsy
	+dVdJr5FeowKgsyBy/tN0xogVrLIyYSsiqZrJuQ5vYHiYAAptE1Dcjwr2fBNLO8PQmWiK0br8HM
	jcDF2d+nsx6qfQ+XNQuLcMWJabXMriT7Qr3gyJwRh/FdSnKoNkSAnun8+b9DXA1qgRpf23fXcFb
	TfvWampGW+3y/ynmAVcomVrJ83xsVbN4zTqopcE7nXdBawS3LHeQkjnrLmRe8nCglOfjzOVQrUI
	gCPVSJDzHyVriqRRJZ0FCU+stCXNVwyX4OgltBiuXIMq+BlpqNYoCsspajQswEeiik8lbsc4zlA
	LlmxBYchRfbnQgASAnnE9M47ih8ygaHp6p/UpY0cUriTVSa9byIA==
X-Received: by 2002:a05:6102:54a2:b0:610:1c78:9531 with SMTP id ada2fe7eead31-72fd7d61099mr3449021137.24.1782289838318;
        Wed, 24 Jun 2026 01:30:38 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670bf154bcsm9906483241.0.2026.06.24.01.30.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:30:38 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6c25b040555so447770137.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:30:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9LUodNdwfBgbBRbbQPVRrYP9sOECvgztfv5d31xY/lbzbG9k6LTskruNJ3k7SKv2b9yMaBENY=@vger.kernel.org
X-Received: by 2002:a05:6102:3708:b0:729:a7d8:e56d with SMTP id
 ada2fe7eead31-72fd816537cmr3656691137.27.1782289837712; Wed, 24 Jun 2026
 01:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508120601.426115-1-johan@kernel.org> <20260508120601.426115-3-johan@kernel.org>
In-Reply-To: <20260508120601.426115-3-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:30:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyObfgZye=J5S6JgLsf6StJRUqTmkE2Zo04fyCc-LO0A@mail.gmail.com>
X-Gm-Features: AVVi8CfdwmwOOsnd5yEjNBJcUgiSzkCluaAL2vL_KKyznHLiRVb4X7RtjMgEn6k
Message-ID: <CAMuHMdUyObfgZye=J5S6JgLsf6StJRUqTmkE2Zo04fyCc-LO0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: kfr2r09: fix i2c adapter leak on serial console setup
To: Johan Hovold <johan@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Magnus Damm <damm@opensource.se>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268099-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:ysato@users.sourceforge.jp,m:dalias@libc.org,m:glaubitz@physik.fu-berlin.de,m:linux-sh@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:damm@opensource.se,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux-m68k.org:from_mime,linux-m68k.org:email,mail.gmail.com:mid,opensource.se:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A87FA6BC936

Hi Johan,

On Fri, 8 May 2026 at 14:08, Johan Hovold <johan@kernel.org> wrote:
> Make sure to drop the reference taken to the I2C adapter (and its
> module) when setting up the serial console which prevents the adapter
> from ever being deregistered.
>
> Fixes: e6d8460aca63 ("sh: Improve kfr2r09 serial port setup code")
> Cc: stable@vger.kernel.org      # 2.6.33
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thanks for your patch!

> --- a/arch/sh/boards/mach-kfr2r09/setup.c
> +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -418,7 +418,7 @@ static int kfr2r09_serial_i2c_setup(void)
>         msg.flags = 0;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
>
>         buf[0] = 0;
>         msg.addr = 0x09;
> @@ -427,7 +427,7 @@ static int kfr2r09_serial_i2c_setup(void)
>         msg.flags = I2C_M_RD;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
>
>         buf[1] = buf[0] | (1 << 6);
>         buf[0] = 0x13;
> @@ -437,9 +437,16 @@ static int kfr2r09_serial_i2c_setup(void)
>         msg.flags = 0;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
> +
> +       i2c_put_adapter(a);
>
>         return 0;
> +
> +err_put_adapter:
> +       i2c_put_adapter(a);
> +
> +       return -ENODEV;

I case i2c_transfer() returns a negative error code (the other
possible value is zero, right?), you might want to propagate that to
the caller. However, the single caller ignores the return value anyway,
so I guess your patch is fine.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  }
>  #else
>  static int kfr2r09_usb0_gadget_i2c_setup(void)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

