Return-Path: <stable+bounces-88174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4589B063F
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA6F1C20E19
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10B15AAC8;
	Fri, 25 Oct 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxPRzMDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC313E40F
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867938; cv=none; b=OsQyMpGCBs/KTgl7GUdbgG+YOXpXIM79++uF9fa53P4xJQAnjGQCnp5/fbfCOhojQZsVoPep4dWPw+TJwFwNRRYRndpYsO94DNiLKncd6YYUa23PvaqjGY/eoIlPsj2/kaLnDLvpeqlbvfWXA3M6pfCs2JxwU6wNz3fmG94lqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867938; c=relaxed/simple;
	bh=5IckEMkS1v2w7MlR9TIpxfK3GkEl6figDrhQ9A8m/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxdVtup89RHTnGY3lOnzasu2shrNqObDd1B+WG1/6CJCO6oy/f4AfWrrsRxZ7eDoGlukLAokbno84m8ouVf/yHY47BRuwxQ/ljoCE/yqwYoD/TI+scufAPl5wt+V+52vASrdLHK6NBMJxdt8DM7JB77cPrXEBwYkEjBYlgRTQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxPRzMDg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so2749867e87.0
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867934; x=1730472734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6xxM29JGW9/m5jgRsXar/Ma8MndkZnSYP4n/2yVQCs=;
        b=jxPRzMDgG0z2wgeZAJC9lbdX6sZ/q3tU/ENdouq1yk10peHc4d3c4YQX/0wbn17W8P
         LThicsXB7c4J+lt5HxFgL1yE1qGIUMSFLzQcLT1umEgPh5BjstoL/xdzHHe0moMaF+mt
         aKSCa7b1GVgq9HuZtyDCcoD2o8GmE0tjfZ/GF3s3jV885Ex6P4kY6dF0AlW9Hu3O4Y1Y
         8KiY7onYqDahAL1UkA4i9d8ojNggND7NtDGe4SZ+Ob1LpWzP94c5lEsAKvcIxNTMplQZ
         1aJl4LQFltxH0gMTcLzUO6+56TkXJ2lyEvix7m6TMsRsAGY4DTtSh9xYZo0VOEQTVu3d
         fk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867934; x=1730472734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6xxM29JGW9/m5jgRsXar/Ma8MndkZnSYP4n/2yVQCs=;
        b=sSmHV8DSm0gk7ipq9xj9h8dOqD/R/ybYEX1K/DQ3/whw2t31W0jftBHj1GsEz5d1gJ
         ocrZo+fdqjgBgDbdsYLI0dmaYCTeO66wAdQS1hJSmK2xZqqHMVLw3tG3tOVD1WXyjOJ8
         zexHiTRpsjfBW6Dh+myZzOj5RdqYYDXynjoBa+ksffG6bePcPgtUH0y+qGAlVU4Ehc6S
         LxpWubfrLr50V7ljwWqYFU9/RmvbvlkoIKal7jP2OEAYUm1ijiOF4pfacD56o5sp/H6o
         MlQ3IQ7lDvzlayN3gbFxAn4MR02/4i1+IMX90ovfyAQBO3cmcza0qyVIkeF1Ej2X+SBT
         ewtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSHl+fPX6IVHjA8fynxjk2jsic0bBaC4y6vEdyHUgUSJ3IMCYntWffrL2Ndgp79EwX3pVtlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmKh67riQ+B6bmKUAbOBAAqixzGgj2dekVlTNkpxU+qg3MxbY
	IBB1RfTpGoW9G3cY5L9mxYG4wa/GhHsXpg3P7hn2SR0RXHyHf+clYIw4Xg7fY1hLzKBOKFlmsZP
	4X06yazYXuFs37fdhs+jPfMziAIE/6Bz75cDTSw==
X-Google-Smtp-Source: AGHT+IHQkI55s2R4KWCezWYix7qWa1t/64NsxwgDAYWhmOO6jr0QoGtNrSBZQrP9LyXay6avpMCJf2b26b8MEVlloPs=
X-Received: by 2002:a05:651c:501:b0:2fb:2e27:5334 with SMTP id
 38308e7fff4ca-2fc9d309a05mr57096061fa.15.1729867932645; Fri, 25 Oct 2024
 07:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021153227.493970-1-avri.altman@wdc.com>
In-Reply-To: <20241021153227.493970-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:25 +0200
Message-ID: <CAPDyKFrhda1k=zQXzYK3uzYX9AXo7XAa+cQiUZg_E-gGbECnsQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:34, Avri Altman <avri.altman@wdc.com> wrote:
>
> While reviewing the SDUC series, Adrian made a comment concerning the
> memory allocation code in mmc_sd_num_wr_blocks() - see [1].
> Prevent memory allocations from triggering I/O operations while ACMD22
> is in progress.
>
> [1] https://lore.kernel.org/linux-mmc/3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com/
>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 051913dada04 ("mmc_block: do not DMA to stack")
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Cc: stable@vger.kernel.org

Applied for next (as it doesn't apply on fixes), thanks!

Kind regards
Uffe



>
> ---
> Changes since v2:
>  - Fix checkpatch warnings (Adrian)
>
> Changes since v1:
>  - Move memalloc_noio_restore around (Adrian)
> ---
>  drivers/mmc/core/block.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 04f3165cf9ae..a813fd7f39cc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         u32 result;
>         __be32 *blocks;
>         u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> +       unsigned int noio_flag;
> +
>         struct mmc_request mrq = {};
>         struct mmc_command cmd = {};
>         struct mmc_data data = {};
> @@ -1018,7 +1020,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         mrq.cmd = &cmd;
>         mrq.data = &data;
>
> +       noio_flag = memalloc_noio_save();
>         blocks = kmalloc(resp_sz, GFP_KERNEL);
> +       memalloc_noio_restore(noio_flag);
>         if (!blocks)
>                 return -ENOMEM;
>
> --
> 2.25.1
>

