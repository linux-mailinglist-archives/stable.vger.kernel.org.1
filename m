Return-Path: <stable+bounces-206281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C84D04618
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957473338778
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF642982A;
	Thu,  8 Jan 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikUL0ahm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8F3A784A
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863961; cv=none; b=h7avw4joMsvFDfw0e6IpVJWpJAz4wBlVi4gb7OZqO3NLfJ6WCF/ME1+MEvwT0VyWtmMR5GuH/6EpaLnCqg+PzXAD6edp1q1ilruLZrn7AGC5LdHoF2Uuqce1AVYvIgrRbqe5ancDdQtk/ZFpAjc3O9Teq9Wd4mBZ/Vd/2VlNmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863961; c=relaxed/simple;
	bh=jV78XJ6O40FDPwiLgk5A8HYUIXjC2sGd8nAD1eWJ9EI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6JULdDXfnn79sFHu6nd2AbJpM5PPaivccW02U73Btycn/b6QlPYDxlcgI+oGCQc67qqnQzrnujz14f9Q/uN3jj8evF8Tya+dxp9wrn/BJ/ihUjF9hyw47Z6x/WhgZAGtKT3yyxRe/DSNb3T5SOmeeMuxbm2rnhtFnKvLYuIKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikUL0ahm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so27274425e9.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863951; x=1768468751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9DTedFkxfZpbrTY43saTnYYT7K5wYApweERenFBQ1t0=;
        b=ikUL0ahm6bZN8LNDLsEGUVaUue1usMtphVdvo3VDOk3GqAr0MbtRv4I9bsyql7qHGp
         WF3Xf+nyp9fS08Y5mE3V0oErWCsYkCwnclDE/OK6yfyJW9VuEnfzRHzenb5FvLx/Pacv
         4NdXbBxe5rdbgEoU5/CPVHyLsbjoYpt8R80bFN5EVmLAIhYpmsAungBx/w51MGgqFbJZ
         d1ggIqJ/TbSjWAlxSm4HQ6F4p7iL2CiRsfPekzV+tG9KtTwK3dmx3H56MJNvfDUuwEz1
         HiQvkpG+xgvUw+VhGq9N5ZVsSpuhoU8A26VBMB0fQXCxeeLJJCwWvtI54kCzJ7kGQOx4
         qxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863951; x=1768468751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DTedFkxfZpbrTY43saTnYYT7K5wYApweERenFBQ1t0=;
        b=nt9sSdvgoElt4A9+Pcx02PLOxo2ae3UbvL7gr+YzgDOfP3rtgHJwilMXhV/QYYGP5h
         RMK9rUJKMfKzaLDvGoWJWD++4d1F5na9TIBqTBregjyrEvlNfOfuE5pg12a1mioaZ9Kk
         6djamWURDUFDGdFuqwZ+Dk/6W0EMVAHqr6sPaVWLGnTAmCl7fIxwQnhFIuwJIY+ewXdM
         He2StiZVX7gjfpOP7phgKNiilMN7RGtYrMCX7ne46ia2LNJgXu8wO21yf5LPBpt5c0qK
         GtHWkphhNoV2IF0iRec9JBBW/rioEKCd73EkZoWwoIk+bO2me+fTlW7RTIdfmiSlyVSO
         Nlfg==
X-Gm-Message-State: AOJu0Ywz0sFnh59+0wQ2abJmiC0w79GwNJXNvI6nSXgaW1BYNPuNFmhJ
	u2VEwTYpBIwnobI8Ez4f4xkzIWq3blxWagv/IIioUltjUgTKWLFULHYu
X-Gm-Gg: AY/fxX6dMTN0C1FICacNV39bQmjRCemp9RfUVSCFc9RBj5+Qz+63eH8n5EoAlIe+UI1
	RGEe5youVttW8lOczc0Rd09184c7CskqXFuNsu0cujoFZpcnHy2SFN7NVKgIWfdT+y5aHnRwo31
	PAquzyVPK2CfKhr8jJlhOW9z3x771Q4hELWQz7gTbGu959EUbyfgOzgJUag/qo2rYUOqD6j0RPJ
	C4dPREVzPKanrhYNNsh1nduguYXWSKyNA3DtXerM04oFc8Vyt5XrpiJV0nOH98R2qpBbFuVV8B4
	xXgbUbfzpcmEkcUxzxyduWc9ajjmuqDlan1azpUQKv6CzXXjnZEgou9+O0Z+gG50QaCRund9nWn
	31nt2UQjvlmDC+wS1M3wctWwKrShHYiE93hdwmc6BVhSrkoqfCbMC5UCxkcDhYrj4qiPrOfte7X
	H9dAAorpXis5EQvWd7tCI=
X-Google-Smtp-Source: AGHT+IEoQLJeAv+HJpl12zu93SIEGorHgDFuoc7t0XEvsbgVpjzAcyKSAAMPmLqVFQ1N4GGatbdnoA==
X-Received: by 2002:a05:600d:103:b0:47d:403e:9cd5 with SMTP id 5b1f17b1804b1-47d84b1fce2mr52304405e9.11.1767863950459;
        Thu, 08 Jan 2026 01:19:10 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm140163855e9.11.2026.01.08.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:10 -0800 (PST)
Message-ID: <b40e19122f340f106ae744dd568d6f04fbc525d4.camel@gmail.com>
Subject: Re: [PATCH v2] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
  Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Thu, 08 Jan 2026 09:19:52 +0000
In-Reply-To: <20260107143550.34324-1-linmq006@gmail.com>
References: <20260107143550.34324-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 22:35 +0800, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer. The code incorrectly uses 'count'
> as the index for null termination instead of the actual bytes copied.
> If count exceeds the buffer size, this leads to out-of-bounds write.
> Add a check for the count and use the return value as the index.
>=20
> The bug was validated using a demo module that mirrors the original
> code and was tested under QEMU.
>=20
> Pattern of the bug:
> - A fixed 64-byte stack buffer is filled using count.
> - If count > 64, the code still does buf[count] =3D '\0', causing an
> - out-of-bounds write on the stack.
>=20
> Steps for reproduce:
> - Opens the device node.
> - Writes 128 bytes of A to it.
> - This overflows the 64-byte stack buffer and KASAN reports the OOB.
>=20
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
>=20
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v2:
> - update commit message
> - v1 link: https://lore.kernel.org/all/20251027150713.59067-1-linmq006@gm=
ail.com/
> ---
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 41b96b48ba98..a9578afa7015 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct =
file *f,
> =C2=A0
> =C2=A0	guard(mutex)(&st->lock);
> =C2=A0
> +	if (count >=3D sizeof(buf))
> +		return -ENOSPC;
> +
> =C2=A0	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> -	buf[count] =3D '\0';
> +	buf[ret] =3D '\0';
> =C2=A0
> =C2=A0	ret =3D match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_sour=
ce),
> =C2=A0			=C2=A0=C2=A0 buf);

