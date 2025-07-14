Return-Path: <stable+bounces-161831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFBB03D21
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A3516FD04
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F132246781;
	Mon, 14 Jul 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmh39Dmd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED85246335;
	Mon, 14 Jul 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491823; cv=none; b=sD7jmTJ0ultFzs6fgzEztJi/nO5Ew3eLnvQGt3qkzJwWb/YZfnUiVVTvmXMWjIArAPqw5khyWRFw50JYE0XzQIMJHu8Dr2xpPbY+L+VOsOAS2A0gpTo2ADcFLGcIa2/qsEwZnQh9rdmfCBmL61b4KUpBeiRVoCOccBbdWuvnUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491823; c=relaxed/simple;
	bh=jtFx4pL8Anx9YacgOth1/BoSyAI2lXPJpKUkYMiMZ0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD6i0WMEZgM3GFvQuArKJkIyqza8pYSRt2dZsCGqjSh1XQ9c+FjhhD+Hcxu8rhWhpk8EHeY7JnuAtXr3BAxpGQaTESyIQzEUnuRLY79GtUy50ApTlapyVc18e7UA+XZX2QmJ9qPJDDOOgxy8KtBFVVx08YiuW7wW+WU+I7NTd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmh39Dmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6298C4CEF8;
	Mon, 14 Jul 2025 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491823;
	bh=jtFx4pL8Anx9YacgOth1/BoSyAI2lXPJpKUkYMiMZ0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bmh39DmdnJqlVEk8Apn85g8bf/zyCT0fjzAZnVL6JfcP+yzjmCWZjIsSMUwUFKnXq
	 3euu6NqvVwe7u+XxG5jGF5/m5TINYmjSHHhIe5bTyz+0+PsoScfT+w3JGAq6aEiUvB
	 TssCfiBT/5lrppJz0m+l5pZ6MJJy6Ymvlm0zChhggNGMVjxzy8siHvcV4A3hl42Faw
	 qpsfo/WYlJllfZiBIQ0AeY+28jSd+AnC5XWj8l94U5AOkM1d7iYYgW8CnOmz8gWbno
	 5FyYcD1h1pBqQXnDvAnl/gglydARAyPHUTiVtJEJeL6+CMG4h4xCWVtzwnpuQmbSkc
	 watzM8CYiUnUQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73afbe1497bso1625206a34.1;
        Mon, 14 Jul 2025 04:17:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7BEA0gQISSm5YzDokuLWKyStKsU9zMLsfi/zv+DuCTmtS6ri2SdXUzxCa1FynfhQCpT603FoDoxN8330=@vger.kernel.org, AJvYcCXmjrm7Lr9iycrsR1P3dFAYOtmNju3eJwg51DeVz5vMqigHljIReruSQrxB4eLvGV6N+0dcsHeo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Yb9Td+KVfovn9bYJOMeJbfb3DFDOlJqooRRiW5RiXg1bm73r
	MEEFsFG++9P8MBdvcLEppKyPWeEI1xxkUckG7m17+Auz/uhdCamYpLHGrGFTQdWIEanqEUXhLwv
	1kAzAwv6xFIXqiESwsxnfK85UJqDfSps=
X-Google-Smtp-Source: AGHT+IGu81YkXnXVR4uYHMbNBn0ya2L9Bqlk0fyDImYRai2coJ7nBh0o00WNlU/NsflWHQzpCxj0h0hdLZmmo2v0vko=
X-Received: by 2002:a05:6808:4fe9:b0:403:56f4:8780 with SMTP id
 5614622812f47-4150fd907camr9016209b6e.9.1752491822980; Mon, 14 Jul 2025
 04:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522091456.2402795-1-Vladimir.Moskovkin@kaspersky.com>
In-Reply-To: <20250522091456.2402795-1-Vladimir.Moskovkin@kaspersky.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Mon, 14 Jul 2025 20:16:25 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2YqZw6R0A+b_Zs3CipsCba5KbDusi=p-TVurJEmsuCGg@mail.gmail.com>
X-Gm-Features: Ac12FXxqq5mhiXy3LZLFUD6OBsxjckT2-FYCgt6nnAJddoCZeqPUwb29u4MOsZA
Message-ID: <CAGTfZH2YqZw6R0A+b_Zs3CipsCba5KbDusi=p-TVurJEmsuCGg@mail.gmail.com>
Subject: Re: [PATCH] extcon: fsa9480: Avoid buffer overflow in fsa9480_handle_change()
To: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, 
	Jonathan Bakker <xc-racer2@live.ca>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Thu, May 22, 2025 at 6:23=E2=80=AFPM Vladimir Moskovkin
<Vladimir.Moskovkin@kaspersky.com> wrote:
>
> Bit 7 of the 'Device Type 2' (0Bh) register is reserved in the FSA9480
> device, but is used by the FSA880 and TSU6111 devices.
>
> From FSA9480 datasheet, Table 18. Device Type 2:
>
> Reset Value: x0000000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>  Bit # |     Name     | Size (Bits) |             Description
> -------------------------------------------------------------------------=
--
>    7   |   Reserved   |      1      | NA
>
> From FSA880 datasheet, Table 13. Device Type 2:
>
> Reset Value: 0xxx0000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>  Bit # |     Name     | Size (Bits) |             Description
> -------------------------------------------------------------------------=
--
>    7   | Unknown      |      1      | 1: Any accessory detected as unknow=
n
>        | Accessory    |             |    or an accessory that cannot be
>        |              |             |    detected as being valid even
>        |              |             |    though ID_CON is not floating
>        |              |             | 0: Unknown accessory not detected
>
> From TSU6111 datasheet, Device Type 2:
>
> Reset Value:x0000000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>  Bit # |     Name     | Size (Bits) |             Description
> -------------------------------------------------------------------------=
--
>    7   | Audio Type 3 |      1      | Audio device type 3
>
> So the value obtained from the FSA9480_REG_DEV_T2 register in the
> fsa9480_detect_dev() function may have the 7th bit set.
> In this case, the 'dev' parameter in the fsa9480_handle_change() function
> will be 15. And this will cause the 'cable_types' array to overflow when
> accessed at this index.
>
> Extend the 'cable_types' array with a new value 'DEV_RESERVED' as
> specified in the FSA9480 datasheet. Do not use it as it serves for
> various purposes in the listed devices.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: bad5b5e707a5 ("extcon: Add fsa9480 extcon driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
> ---
>  drivers/extcon/extcon-fsa9480.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9=
480.c
> index b11b43171063..30972a7214f7 100644
> --- a/drivers/extcon/extcon-fsa9480.c
> +++ b/drivers/extcon/extcon-fsa9480.c
> @@ -68,6 +68,7 @@
>  #define DEV_T1_CHARGER_MASK     (DEV_DEDICATED_CHG | DEV_USB_CHG)
>
>  /* Device Type 2 */
> +#define DEV_RESERVED            15
>  #define DEV_AV                  14
>  #define DEV_TTY                 13
>  #define DEV_PPD                 12
> @@ -133,6 +134,7 @@ static const u64 cable_types[] =3D {
>         [DEV_USB] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
>         [DEV_AUDIO_2] =3D BIT_ULL(EXTCON_JACK_LINE_OUT),
>         [DEV_AUDIO_1] =3D BIT_ULL(EXTCON_JACK_LINE_OUT),
> +       [DEV_RESERVED] =3D 0,
>         [DEV_AV] =3D BIT_ULL(EXTCON_JACK_LINE_OUT)
>                    | BIT_ULL(EXTCON_JACK_VIDEO_OUT),
>         [DEV_TTY] =3D BIT_ULL(EXTCON_JIG),
> @@ -228,7 +230,7 @@ static void fsa9480_detect_dev(struct fsa9480_usbsw *=
usbsw)
>                 dev_err(usbsw->dev, "%s: failed to read registers", __fun=
c__);
>                 return;
>         }
> -       val =3D val2 << 8 | val1;
> +       val =3D val2 << 8 | (val1 & 0xFF);
>
>         dev_info(usbsw->dev, "dev1: 0x%x, dev2: 0x%x\n", val1, val2);
>
> --
> 2.25.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

