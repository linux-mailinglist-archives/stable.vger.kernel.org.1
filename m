Return-Path: <stable+bounces-192182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CCBC2B2DE
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E721891805
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9512FFFA9;
	Mon,  3 Nov 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi4W+XX6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836F2F8BFF
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167430; cv=none; b=M6gJULkP93arRnCkEx5sfsUQIDNojJ+YX5DiXH4BAGmsSNeWg4+m2RWIAy0FTZ2WcRNWx3rW2MpLe0LoVK3iMW78fNaX3SkO99wezhzFjDMIy5hPS5g5AVW/9B+iMXn62X8TNLOQgOhDu1B2j0wn6YvRV4NEZ+4aKf1ObQOHt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167430; c=relaxed/simple;
	bh=e7fjHsFD2eyrJ5RrOquWq5GjtIlxXdTSBusZrxSeweA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzqoAk0peAA7cVfpynMYyQ6F6AIoOS8fMu8IEKUZA3b3gIsRzff07k90BycWUc7DLkHd0K36x6DnGqB+dixyUqUu4FYhwlbcRbD4nlEEIaC6RiJ4/H26PLhmMJH2zCnx6x71vw3InvwuoSQ5fdH1EHQPGb7q4gDL4QIFSN7iAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi4W+XX6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fc536b5dso2679052f8f.3
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 02:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762167426; x=1762772226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmjPsfyNQFfTt8C+gqJW0+KGVvRLkw86W7Sj1YjfJ4U=;
        b=Hi4W+XX6zgl9APxR0oXKmmoS289oiaDxbEsNqd73CznP/n3J55OKXfOfITm3q4eQhw
         GdGyOm697II9SB14tK2+RBCAxfBBCiw2dARQYWbtMV8wftdAy5GZwjBVMXZfFBD8Wsyg
         pDYs6PnE/45pqDMy0dAKI3pAc+AXfDqRkpB+aKhNcZ7wLbt8qhjt9/A8Jp8D6Qyr+hRL
         bwo7iLmOjrNMnRyCuTlNydY3XO6e8pFnFgJ0XqivX/TCxStPnFTvsQ8+KP442g9VLT/d
         KH1SQ7Oof36c7u/e+iZhvGZnLMj9JZ7tk1e2YXcHkxtH6m7fnV7qfWEzkNii/j8Acu5u
         gDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167426; x=1762772226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmjPsfyNQFfTt8C+gqJW0+KGVvRLkw86W7Sj1YjfJ4U=;
        b=rauEyjK5oQGQp8UV+N0p2ManVhsMA3Gg/66k38A99M5aFKBqKvn09VM/KR1tbJeJpK
         v4CT+5TGKGx6Q5xsI+gvbN3FkmtqU+sBy1vYpl/Ie8M4RzSG/x0fi32ybo8gKQrLObL9
         rQ07JLtzcpi8tT4b7IPpFwbOoOC9uoEQlwgawR3jOFlu+6pDwohv1AIT/VN1/UsIVX2E
         QOYM4BY6UR8WYjoR2j8e2Ta7nkbipcAVAvN+3UEp16QGIxb/NmTqb+KQobGlwmO8uMiy
         K40vZp7Qs7Yf1pfgi4RAOujPSmuviQD0NSChIjl2KFkXm4+i8vRpQAeR5sDHkBwz34g5
         JbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtn5lLcvrhDgDVhQV5YYX/lkzBcEc2/5mciI6bcQvncwNkU7C3X81dmJx4v4ApGKUQjqb3MH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgqA6sROi54W5Dk8JG0NYhPG7nj3aY2wHNjYULds318gm738v
	dTXjIoevgRWmdHEhX/D18Pa4Wje0OuqF0COtj9+Ix6nyA9Ym8QkLC1gI
X-Gm-Gg: ASbGncusf0bXz8WSKWTa/FPNnlafb/Kf0rBpLob310uANBVkRTGp9Kym6DMfiA9BOaU
	g9VCVyGtjXG0aLCaP2nMxta0utwOXk57yRkUB9ak7su/3FvpzF+f60WU02UqksE0GzmQOU+HKpq
	wrUQUmnH2FrMC+ejSoJBPzl+aEmce+BffAuCZ/X9J0mZJ3AeHqULxZFvYt43iISAG4CauR55Gco
	SsLgAUUWobhJvzpuqYjq9x2GnYHJWCJ7C8qBSzzRPEoLo5QbEVx0LfKim3Go3BjFV4zoFFrG2/2
	RQhGorBxdrmjwZD3wR1bQojT7EyFL7s0B5eNnrXLtQBmbQ62r91OKQlQGdilXBa70nZS5dDUPi/
	hs5VayoP3lbTYDz12inNxvW5V720kIfAOEoyZ7FBIURf7ybJjoLhzMkfI1eDEv8Ik4OHKWuk3dX
	JhyMk2fQxVFJN7d5cyhdc=
X-Google-Smtp-Source: AGHT+IE5AQkFM+XV2z5/8xPw0v/KrOs+8F52m+pF9B5viDBT2kts7kP09Ga+4II7Li7wpof9PXB5UQ==
X-Received: by 2002:a05:6000:1846:b0:429:bc56:cd37 with SMTP id ffacd0b85a97d-429bd672607mr8359558f8f.6.1762167425415;
        Mon, 03 Nov 2025 02:57:05 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ca375a1dsm12889836f8f.27.2025.11.03.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:57:04 -0800 (PST)
Message-ID: <952b6f1c6f917f197fceab5b5f01494ea7e3502c.camel@gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Fix irq assumption regression
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matti Vaittinen
	 <mazziesaccount@gmail.com>, Stephan Gerhold <stephan@gerhold.net>
Cc: linux-iio@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 03 Nov 2025 10:57:40 +0000
In-Reply-To: <20251103-fix-bmc150-v2-1-0811592259df@linaro.org>
References: <20251103-fix-bmc150-v2-1-0811592259df@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 10:36 +0100, Linus Walleij wrote:
> The code in bmc150-accel-core.c unconditionally calls
> bmc150_accel_set_interrupt() in the iio_buffer_setup_ops,
> such as on the runtime PM resume path giving a kernel
> splat like this if the device has no interrupts:
>=20
> Unable to handle kernel NULL pointer dereference at virtual
> =C2=A0 address 00000001 when read
> CPU: 0 UID: 0 PID: 393 Comm: iio-sensor-prox Not tainted
> =C2=A0 6.18.0-rc1-postmarketos-stericsson-00001-g6b43386e3737 #73 PREEMPT
> Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
> PC is at bmc150_accel_set_interrupt+0x98/0x194
> LR is at __pm_runtime_resume+0x5c/0x64
> (...)
> Call trace:
> bmc150_accel_set_interrupt from bmc150_accel_buffer_postenable+0x40/0x108
> bmc150_accel_buffer_postenable from __iio_update_buffers+0xbe0/0xcbc
> __iio_update_buffers from enable_store+0x84/0xc8
> enable_store from kernfs_fop_write_iter+0x154/0x1b4
> kernfs_fop_write_iter from do_iter_readv_writev+0x178/0x1e4
> do_iter_readv_writev from vfs_writev+0x158/0x3f4
> vfs_writev from do_writev+0x74/0xe4
> do_writev from __sys_trace_return+0x0/0x10
>=20
> This bug seems to have been in the driver since the beginning,
> but it only manifests recently, I do not know why.
>=20
> Store the IRQ number in the state struct, as this is a common
> pattern in other drivers, then use this to determine if we have
> IRQ support or not.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Instead of a bool has_irq in the state struct, store the Linux IRQ
> =C2=A0 number itself and switch behaviour on that.
> - Link to v1: https://lore.kernel.org/r/20251027-fix-bmc150-v1-1-ccdc968e=
8c37@linaro.org
> ---

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/bmc150-accel-core.c | 5 +++++
> =C2=A0drivers/iio/accel/bmc150-accel.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 =
+
> =C2=A02 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bm=
c150-accel-core.c
> index 3c5d1560b163..42ccf0316ce5 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -523,6 +523,10 @@ static int bmc150_accel_set_interrupt(struct bmc150_=
accel_data *data, int i,
> =C2=A0	const struct bmc150_accel_interrupt_info *info =3D intr->info;
> =C2=A0	int ret;
> =C2=A0
> +	/* We do not always have an IRQ */
> +	if (data->irq <=3D 0)
> +		return 0;
> +
> =C2=A0	if (state) {
> =C2=A0		if (atomic_inc_return(&intr->users) > 1)
> =C2=A0			return 0;
> @@ -1696,6 +1700,7 @@ int bmc150_accel_core_probe(struct device *dev, str=
uct regmap *regmap, int
> irq,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (irq > 0) {
> +		data->irq =3D irq;
> =C2=A0		ret =3D devm_request_threaded_irq(dev, irq,
> =C2=A0						bmc150_accel_irq_handler,
> =C2=A0						bmc150_accel_irq_thread_handler,
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-=
accel.h
> index 7a7baf52e595..e8f26198359f 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -58,6 +58,7 @@ enum bmc150_accel_trigger_id {
> =C2=A0
> =C2=A0struct bmc150_accel_data {
> =C2=A0	struct regmap *regmap;
> +	int irq;
> =C2=A0	struct regulator_bulk_data regulators[2];
> =C2=A0	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
> =C2=A0	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>=20
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251027-fix-bmc150-7e568122b265
>=20
> Best regards,

