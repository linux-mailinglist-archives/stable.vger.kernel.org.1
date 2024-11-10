Return-Path: <stable+bounces-92039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5E9C316E
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9431281BDB
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4F14B962;
	Sun, 10 Nov 2024 09:04:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2613D244;
	Sun, 10 Nov 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731229467; cv=none; b=EBQgH2V9AbqZNKqx7prdAuPLJd0nsYEZDNLxFFo2WA5phUG5s48VvzbUmcpJh+R0ZS1mGxuLOH3AZlPcVWVWREAhFo5uBke5Nk0Bw4tECIOa2AIEh1ff67LS983k64lSOf4S6VEzD/4uxIQIrvxB4dfW/Ydt+06f6ysl3M3n8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731229467; c=relaxed/simple;
	bh=9D76VTSvQj4qIs157AAY7CHs1PwRQ61N7EvhyoBYfm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tfpk5yvWM73he6Sc5DpmNkuCJ1f8HM9ntUqOJyr4+1cgSjG3mDUTHvh5cViRTJSxkN6oap2kDZ+Tyw4k8InUjNkWqR/2EsrbcaSWJ+9SfcUNg20EsY/M8gnVvnCut+6jIV2ZHLKJxkru9CpBliohdk8qpVdIHnqZ3zNiK5uzAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb49510250so28244491fa.0;
        Sun, 10 Nov 2024 01:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731229462; x=1731834262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wtpfkEmN9TnpSt9kWyIfHjD/NJzBYrneyOwbFIleHc=;
        b=r5NVKANtZ/sQnhIkV4HIRzrgGT/s9EEwYYPCVkzBodf3/Ejy1FR9J0gMTUgjBC3OOA
         fCxeYLf/k3OaY0fzQ696JV+HX1L1KOdxR96yeXqy80hHt2oThuL+BnEt7QeEDE6qnsLU
         pCFTB+lwmve0eetEwl6zmQCY/sSE0JLW75DvCkaOCbfgOHr74YtG+x65FkzkLlPZvCI8
         wWkGIMKUaJmUnnYU20v1LC305f3BN8fVbU73nXGxjMEiTp9AvTpGUuE9xEHZ35kWZeIH
         SbWT6Vykb/Rodkb3e9nu2YnSjUFtR+B1k5WNhsbuJK3jgJSZPUEh0+ZkTYL8cL+8Dz0v
         Z55Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYfGNiLu/W/O2A3TkOcB3sSYK0gW1Lfze8ghEChskoJkdL7VZ/vrmkvEkmxfLOZgb0ZywrQYMBD/0=@vger.kernel.org, AJvYcCWLg7vvr7m8dTOd9vCJRo+ePVZfMNIWu+I+b/FM+gj93W1WJr7R5YFaqrri8mGyacud1wpHwUld@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkHiO8ON0xjRa912yYTaoLM7BKNGLYYwZ8wJ6ElNEiF9a1EJF
	S/JkmaV/MGL3jW/lnRojyaJ3SntSFnpsx2VOQPgWEYp8RGHU6MsUI9pcvC2s
X-Google-Smtp-Source: AGHT+IFy4pePmfOdy8XCKaGA/w6XuoOWaHpoYfYYfApg7WYXGMPzjOzUsZ0zb7HM5KSpcv2jZdHOEw==
X-Received: by 2002:a2e:a887:0:b0:2fb:6277:71d0 with SMTP id 38308e7fff4ca-2ff20280dadmr39523951fa.22.1731229461932;
        Sun, 10 Nov 2024 01:04:21 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17991a30sm12890061fa.87.2024.11.10.01.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 01:04:20 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5111747cso29510741fa.2;
        Sun, 10 Nov 2024 01:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURsHAOV+Yak/dFc16lWtiPWCMvLgYqsf/Lbi9/D60WDmWF6S72qpdvjEWNxY8080XvMaMdCmN1Pvg=@vger.kernel.org, AJvYcCUydZnaPAxmw5LwZYfY+yc+ME06/O0Mf2T1pZjsOv2b9R9vcN5WO2AoJRjx5FkHNdbeDoGdKVz0@vger.kernel.org
X-Received: by 2002:a2e:a552:0:b0:2f7:58bc:f497 with SMTP id
 38308e7fff4ca-2ff202e1810mr39484121fa.28.1731229460191; Sun, 10 Nov 2024
 01:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107014240.24669-1-andre.przywara@arm.com>
In-Reply-To: <20241107014240.24669-1-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 10 Nov 2024 17:04:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HUp4Xwgc3fw1fMVTBQFV2kHSVbs7=XBufzJpQ9hkuzg@mail.gmail.com>
Message-ID: <CAGb2v64HUp4Xwgc3fw1fMVTBQFV2kHSVbs7=XBufzJpQ9hkuzg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix A100 compatible description
To: Andre Przywara <andre.przywara@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Yangtao Li <tiny.windzz@gmail.com>, Cody Eksal <masterr3c0rd@epochal.quest>, 
	Parthiban <parthiban@linumiz.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:43=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> It turns out that the Allwinner A100/A133 SoC only supports 8K DMA
> blocks (13 bits wide), for both the SD/SDIO and eMMC instances.
> And while this alone would make a trivial fix, the H616 falls back to
> the A100 compatible string, so we have to now match the H616 compatible
> string explicitly against the description advertising 64K DMA blocks.

Would be nice to know how this was discovered, and how the correct size
was determined. As far as I could find, the A133 user manual says its
64K.

ChenYu

> As the A100 is now compatible with the D1 description, let the A100
> compatible string point to that block instead, and introduce an explicit
> match against the H616 string, pointing to the old description.
> Also remove the redundant setting of clk_delays to NULL on the way.
>
> Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d3bd0ac99ec46..e0ab5fd635e6c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1191,10 +1191,9 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_=
cfg =3D {
>         .needs_new_timings =3D true,
>  };
>
> -static const struct sunxi_mmc_cfg sun50i_a100_cfg =3D {
> +static const struct sunxi_mmc_cfg sun50i_h616_cfg =3D {
>         .idma_des_size_bits =3D 16,
>         .idma_des_shift =3D 2,
> -       .clk_delays =3D NULL,
>         .can_calibrate =3D true,
>         .mask_data0 =3D true,
>         .needs_new_timings =3D true,
> @@ -1217,8 +1216,9 @@ static const struct of_device_id sunxi_mmc_of_match=
[] =3D {
>         { .compatible =3D "allwinner,sun20i-d1-mmc", .data =3D &sun20i_d1=
_cfg },
>         { .compatible =3D "allwinner,sun50i-a64-mmc", .data =3D &sun50i_a=
64_cfg },
>         { .compatible =3D "allwinner,sun50i-a64-emmc", .data =3D &sun50i_=
a64_emmc_cfg },
> -       { .compatible =3D "allwinner,sun50i-a100-mmc", .data =3D &sun50i_=
a100_cfg },
> +       { .compatible =3D "allwinner,sun50i-a100-mmc", .data =3D &sun20i_=
d1_cfg },
>         { .compatible =3D "allwinner,sun50i-a100-emmc", .data =3D &sun50i=
_a100_emmc_cfg },
> +       { .compatible =3D "allwinner,sun50i-h616-mmc", .data =3D &sun50i_=
h616_cfg },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> --
> 2.46.2
>

