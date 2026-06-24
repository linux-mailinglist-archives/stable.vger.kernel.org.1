Return-Path: <stable+bounces-268098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K02sMIiVO2oPaAgAu9opvQ
	(envelope-from <stable+bounces-268098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:30:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684466BC918
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:30:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268098-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268098-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DD1030151F8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F039150D;
	Wed, 24 Jun 2026 08:29:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0292388E74
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289796; cv=none; b=LM5t4+x/+UuLfIIInPkgO+Umh3B7SfLkH8oZg3uoiATckJSwHz5fFCgTZSVugk3EBqIVIgohk9blBQBQqH31Loc+v5J92qEC3pf7+416oaEvoNQjMQu86Twm6gcpiBnRiAU9cHWiQeBsrrVRxyEONpY1MGMDH5Y1XF+qFASxBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289796; c=relaxed/simple;
	bh=DzQURGJ/90KydpVOB8aXhed+8UqIRqbhCdJtOFZaMLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNwVVYYN8EISinYPr3SzztvB2FbF7I+tkNhxWL4KuOeEoF1GE7SxsVZteyveeR61nqVX4oyJEtI8mGcpq3PNCKtLzQi8v13HleEzFxC404lLgw7mIOijD3mqa5uW8DpuS6l4+6RbESeJop7GmqHuZbfhyghKEzOusgwAdfmJ4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6c28cd29891so387089137.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289794; x=1782894594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA19CstQFiQHAhnj5MSb+kW6nAx7O7omGKi1TaxN/BA=;
        b=bXlzab/RkG+kvRELNwZq03uwPF5KLVt9qd4ipoLNw3FD8S6N5fmjjiMuGf4Fj4VqbG
         UmgkBNPRKGfL4epcmgsmtUij6nUG8DXgCrJ4kNXDg9MNR2TfXQwnSYdVXIteZXf/okFL
         WW+ax1DCtGUydJSX63X/zV0Yame1u0dKb4EYUd4RhKKdaT+3mCbd64WhIJhDEzN8U8HL
         XYWT1CuINFFUYINYoJdc3+jj3M665e+gjST7/Vt9pnWHVY/cPwd5ITKai7dHQ77aAF4L
         MWNbjWVFL87Q+rmZGGrNcv9dIe6ZWCfzedY3dwAmHmnzXDWmCOFpkqfueLcv1emEocRj
         7k+g==
X-Forwarded-Encrypted: i=1; AFNElJ8Dw8TF7tgLdqvPGvhU5NUlSIPrm9IXz/YsYjwBL9CZfyuxqGRizqCxAz/6zX9JDNrifair8a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZEcfVJX3uzFtXmeIIke03TNcTN37Ye+FM084VizJCtkr/1/pn
	bD2S6Funop5dahAi+8D0mcK5VSTLL6C0ZhEfOEKXBNZq66b5oMNzNFm7KowpI7gI
X-Gm-Gg: AfdE7cncjFj0MGdNbP8RG7vQK6V/yHOgkJy5ty7QgB7o39Y6e5vRNPHMx8mIkx7Bnb8
	bhpfBtFMf7e6l8F+fY74pCS9HOZ1LXdqrrGjxKG1OhRy3WWzLx/Qgrr0qmO0PMOPMRzeIN80LLd
	D9ff+rLGn9siBPexphYaTcj9u+k7FqccUHrcTcNBpcwN+lV8ymI4FuHMLjHzaHIir+bElAuUP3F
	t8hWGg8uIAlWpuIiV5gTnsPh9QGvBS8kH9flMd3QnWrtxBrrJrY8da/Yx+zmGffP9Sgy5WAaOnQ
	u6ydsdr1t33/+Aq+C9FgJ3zBt8dET5tXzM4vnWcHyJC6WHLy+KEuGccxmFmDF9zepSG/TgzYSTN
	gNq8RL0hl6ZW3x6B1q2mnPMhHnAI1GsKwwcB/FZoigxy5o0CiG+0l0f80NSpIls24Nd+D0bQE1o
	KnXS6Tlef+gcNspBt+aX3NSub7b7xpBXhtMfIgcTXFG3YZOYY8QxTYTA==
X-Received: by 2002:a05:6102:370d:b0:6c5:d55d:c091 with SMTP id ada2fe7eead31-73114d025e4mr929384137.14.1782289793869;
        Wed, 24 Jun 2026 01:29:53 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72ba26ba1d5sm9646351137.4.2026.06.24.01.29.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:29:53 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59ebb89109aso482413e0c.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:29:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9PzmuVX6izOpLFYjsU7WlnKAId0DkYUB5pW4ZoyoUrBTM5q/2unrxKRMnXFjmKacdThH68I2g=@vger.kernel.org
X-Received: by 2002:a05:6122:21ab:b0:5a0:9ad4:700e with SMTP id
 71dfb90a1353d-5bc3eccb520mr942158e0c.3.1782289792438; Wed, 24 Jun 2026
 01:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508120601.426115-1-johan@kernel.org> <20260508120601.426115-2-johan@kernel.org>
In-Reply-To: <20260508120601.426115-2-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:29:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAoZ6+Ch-qUhwbV=47PDHfgkARnZpo4h8y0h_uZP73Qw@mail.gmail.com>
X-Gm-Features: AVVi8CeS-ve8tL-XyxKs66sVTyPqvMhCGD7V1PRdEzsnO6Z7eg-th0wbj2JBfFg
Message-ID: <CAMuHMdXAoZ6+Ch-qUhwbV=47PDHfgkARnZpo4h8y0h_uZP73Qw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
To: Johan Hovold <johan@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Magnus Damm <damm@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268098-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:ysato@users.sourceforge.jp,m:dalias@libc.org,m:glaubitz@physik.fu-berlin.de,m:linux-sh@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:damm@igel.co.jp,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igel.co.jp:email,glider.be:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:from_mime,linux-m68k.org:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 684466BC918

Hi Johan,

On Fri, 8 May 2026 at 14:06, Johan Hovold <johan@kernel.org> wrote:
> Make sure to drop the reference taken to the I2C adapter (and its
> module) when enabling USB gadget mode which prevents the adapter from
> ever being deregistered.
>
> Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
> Cc: stable@vger.kernel.org      # 2.6.32
> Cc: Magnus Damm <damm@igel.co.jp>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thanks for your patch!

> --- a/arch/sh/boards/mach-kfr2r09/setup.c
> +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -368,7 +368,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
>         msg.flags = 0;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
>
>         buf[0] = 0;
>         msg.addr = 0x09;
> @@ -377,7 +377,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
>         msg.flags = I2C_M_RD;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
>
>         buf[1] = buf[0] | (1 << 1);
>         buf[0] = 0x13;
> @@ -387,9 +387,16 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
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
the caller. However, the single caller replaces it by -ENODEV anyway,
so I guess your patch is fine.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  }
>
>  static int kfr2r09_serial_i2c_setup(void)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

