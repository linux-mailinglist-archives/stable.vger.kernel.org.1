Return-Path: <stable+bounces-92827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2379C60AA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90F5283FE1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD521894E;
	Tue, 12 Nov 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEcRZ+Vs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC0218D92
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437063; cv=none; b=ejGNScBN4/qktP0XsTGsAmIX4aOCc0wtJeGkLeXZQR6wWSS77AaHeu2g9rB9CLHGi08i0ivyczK1BvMqmaAxyQuwVsygcrf1d8r9Wp4vuqDc/jrkLUcrEG9ldgxcBivxFOqXQU5SIe1cxNXzeB9rvEq3AFUoV650qbIZzdNKLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437063; c=relaxed/simple;
	bh=uHjhDIOGd3wI/ode4gAXftJ4tsv8f905E8g2pYGetwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4MpY2B484mt4mmxCTv2R75kJN9Vr9y+k93h5DmjV4QN12YXzFTtQU7rE1jJbJZSWWu96MT1iNuO27SC0cvx2Nlj8lKk8uVepccOtr/5LovUbsqSZPVhxQp1o6sQY1BscJCMcbSUVhmRvA51UD/N/5fznbiz2ghqttPGsOovY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEcRZ+Vs; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e9ed5e57a7so49016907b3.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 10:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437059; x=1732041859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YQwoM/nTuzFKhK1k/SOzLnbDeI0RWCoU9qRRxql+gQs=;
        b=AEcRZ+VsPenKwc6b2gFRQA2+Teb9C3liP/MkKnJEL0TWA727LDelcynuvKlu9RaEp0
         +jh+UkaFyqeDdfbMJXVFmU7P6UDMzYcTEWb9DATDk04VSbiAmYWeODLrlDvTu7vC0+Ev
         r5tVNzv/+jvcMJqIDMjY0oFgJ9vzcEvjim7JDM/DnbzM8BVwlhI5BLEhn/1SZDcqkOFA
         GKla50Q1J8VoQjBpOOcb5jGydHQgOjJAj7LjU5OWB7UtHfRM48bilk6A3RREpqI7cG/3
         tOx6wPe3O3kw4xCiVoJ4//pDe4WMzpV+/evZiNTmfCfOMXIU4NNd3QP72N8HuwUaQwfW
         UPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437059; x=1732041859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQwoM/nTuzFKhK1k/SOzLnbDeI0RWCoU9qRRxql+gQs=;
        b=B3n1aMww8NR1XLPMY4JlTCY0HwHLj5ddNr7n2x31D5RonGTlTLd00gpx6NCLcdo59J
         9OvzSTmPLfksKPK0SwEp+pp/GBW/w+F07OaO0aOFgTUYv806inisVxUsQcQ2d7vnoU3f
         adyfCibzsgxD68h3seSMBbk6sFcw0NLIOo6KcOzdC4sjcuTxLLvyYH8lsPckcvJLnAut
         hou6PNqUMgwGc0Sl6l3GxKOZ88L03y/ATFy3MNR96WiyNX2lEtl7QS/2+OzuNKnA7aHs
         ftmgassEBMB4HCoEkAUOOWNhuXeVShlVRj2kXm8IL1Y6gzGijiLwIbS4j20jSokrlR43
         lcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM/Lxa3njeB4t5BSWxF7n9SUrfhm6aL++wYnNZAF63rPT27o15l92sTHYgH88TZEytnG2zzP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0gUxKplAbfkqYTu5r6BUzjRubKgsYZ3u7L83GABdwB083qFI
	jWoKXCr/m+f+gv9U2xbCIg/deViMo5mRrt7H8LRmZQbgBhe6BNgpzGIa/QFudQ0+h4zjtGLw/yf
	QuVlCGuzzqMtoF+Lli8UVL3UBgWeC3Y7IwgQfrg==
X-Google-Smtp-Source: AGHT+IGaU1lE2PJipy6pOIUqOpY0yqY/1qPuB70C2Kl5meeHsB3avJig4SV+FxxLDBmZG/DPvhBkYkquOGMWKK2QHIU=
X-Received: by 2002:a05:690c:6888:b0:6db:ddea:eab4 with SMTP id
 00721157ae682-6ecb359db6cmr177507b3.37.1731437059301; Tue, 12 Nov 2024
 10:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107014240.24669-1-andre.przywara@arm.com>
In-Reply-To: <20241107014240.24669-1-andre.przywara@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:43 +0100
Message-ID: <CAPDyKFoTyMy9wv+6nfr=-TK_da_t5rojrpTgyiGm7=sK-RK+Bw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix A100 compatible description
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Yangtao Li <tiny.windzz@gmail.com>, Cody Eksal <masterr3c0rd@epochal.quest>, 
	Parthiban <parthiban@linumiz.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 02:43, Andre Przywara <andre.przywara@arm.com> wrote:
>
> It turns out that the Allwinner A100/A133 SoC only supports 8K DMA
> blocks (13 bits wide), for both the SD/SDIO and eMMC instances.
> And while this alone would make a trivial fix, the H616 falls back to
> the A100 compatible string, so we have to now match the H616 compatible
> string explicitly against the description advertising 64K DMA blocks.
>
> As the A100 is now compatible with the D1 description, let the A100
> compatible string point to that block instead, and introduce an explicit
> match against the H616 string, pointing to the old description.
> Also remove the redundant setting of clk_delays to NULL on the way.
>
> Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d3bd0ac99ec46..e0ab5fd635e6c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1191,10 +1191,9 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
>         .needs_new_timings = true,
>  };
>
> -static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
> +static const struct sunxi_mmc_cfg sun50i_h616_cfg = {
>         .idma_des_size_bits = 16,
>         .idma_des_shift = 2,
> -       .clk_delays = NULL,
>         .can_calibrate = true,
>         .mask_data0 = true,
>         .needs_new_timings = true,
> @@ -1217,8 +1216,9 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun20i-d1-mmc", .data = &sun20i_d1_cfg },
>         { .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>         { .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
> -       { .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
> +       { .compatible = "allwinner,sun50i-a100-mmc", .data = &sun20i_d1_cfg },
>         { .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
> +       { .compatible = "allwinner,sun50i-h616-mmc", .data = &sun50i_h616_cfg },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> --
> 2.46.2
>

