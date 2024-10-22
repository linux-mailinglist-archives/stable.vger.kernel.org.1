Return-Path: <stable+bounces-87717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B89AA25A
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6161F2315B
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DC19D88F;
	Tue, 22 Oct 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgwRdPxM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B419D89B
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600999; cv=none; b=GjRmJgr6qHInv1vsGMJkqAQoR/0dZHzRR1ZfZVy3kt6d11P72oGd0b0e5WD/CUBt1n2+4948BDn79MBK4J9r2tikQzCnHo3mzhDZcQ7EtcmDC6lpxkDvN6G2kOlO/PeWbuF6pa5nw0mIP0e3NVe7xiKKSNQOSKUQ/DrU3JiCQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600999; c=relaxed/simple;
	bh=n182y8nWJul8CKXkhxxnsz1hFzVx0xF9GJjauPoJ5as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByMARLgq+ndaiJu+cym0tGnZdKeSrfT9+oi0HOXyVDf21VI3yh00aAHXy0yY+Wfu6TTRFoQIlCNjjPax4NYKyyP/dXbnQ3fF0/hqDs0MCly1iUTjtws0z2iDv2oM8HpZgQKuSQ4PhrWL1HyPpvk5G73cRR3tk2A6Ojhz9+SK0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgwRdPxM; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e290e857d56so5632000276.1
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729600996; x=1730205796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SaOXu7NaxTVENXCsAQaNxc71DXxVkPqm5aNi9pXqVVY=;
        b=dgwRdPxMombofqsZb5d7UNsV2tbwQvJuk66jsYSu+UkTzjetWtMxL7LevusVaVY9IS
         ux10hyFMNHQhSDR32s05IXiK50Ear8qiQOwEnJCvWJ7n+g6Z0ZC92ItvoGuB8DoXT72O
         fpDLK+REbDvvSRJOA2iqOIMVn9N8NbDTjkYnsqAt/l0vd561mxoI43n0z78vYwqnTNMZ
         OzC+v8Wmgw3N+KeFd9cpMZgKrnULiZZdQj4Z4cmlLU53k7izpWIWUtg+6oi6zBIwvtUm
         29RCsCofH8EdyYGtzNLTn9cGYWGMNnAOV82G2Bo+nKomMEmgfzMxbBV8T6hqolWcVjEM
         oD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600996; x=1730205796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaOXu7NaxTVENXCsAQaNxc71DXxVkPqm5aNi9pXqVVY=;
        b=JlEjPE2vY0zbgVkuO6J9rJncdHXelNFXO48EQiFwmWMLj06hEa6gUjy+QM93/h8eCn
         v05CaMepSPtradcp8cQr0pauofi35xVzhQuVlXVXDEhzQG4hfeyF5Ql/3H0TJ+OQHo85
         xZERHpTGb2WOUaxWSa0wbtYKBlOlTLV+M2CX9t50JgOUVhuRCDUSNcFG5K/2Y0EerNpW
         WMO8afW2OnUs4AGuRWm2n7ASlzM+j0b8B9hSgGklx2vzptr/ogXDhWaHPfYuFZxBPhLg
         X+t7NVcA7KHl+/dJIdL2QNypHYwXEfFGDEMtYXliX4kO6mh/FRELAbjHlXMTGg+oG0Rh
         APLw==
X-Forwarded-Encrypted: i=1; AJvYcCVL2CHT++wsu4PEtkCtYkXH1SPc7j10ZDms9/boqMnFhXtfmy12VLRDlRMsvvTDuzSkuFQzihc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLAuWvwecp3mcYTex4koRcTndxdpMP11EUfId+ulr/qQ/rKwJ
	0J75iGzegFP0UEFspTkrBn8ql3jZW/LDZLoQJCIcoIWbkhSKXKqNMbeFX8fnYDPrhchGwetChnM
	SsMlMUwRXUt5IrDjEHSeBJWKB29pMP5rR9HhlJA==
X-Google-Smtp-Source: AGHT+IEjUOeNvCGfPmX5CA7E6xqtR1WdLOVX8tlGLznwKB3j619LMDAn9ejkibYgLTVRmf3S4wJdL9yK3QWSPiysYzw=
X-Received: by 2002:a25:8545:0:b0:e2b:d0b8:576b with SMTP id
 3f1490d57ef6-e2bd0b858f9mr7059774276.17.1729600996120; Tue, 22 Oct 2024
 05:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020142931.138277-1-aurelien@aurel32.net>
In-Reply-To: <20241020142931.138277-1-aurelien@aurel32.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 14:42:39 +0200
Message-ID: <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>, 
	"open list:RISC-V MISC SOC SUPPORT" <linux-riscv@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Ron Economos <re@w6rz.net>, Jing Luo <jing@jing.rocks>, stable@vger.kernel.org, 
	Adam Green <greena88@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, sydarn@proton.me, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

+ Adam, Arnd, Shawn-Lin, sydarn


On Sun, 20 Oct 2024 at 16:30, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> The Synopsys DesignWare mmc controller on the JH7110 SoC
> (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> and thus requires the use of SWIOTLB.
>
> The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> "swiotlb buffer is full" to happen because swiotlb can only handle a
> memory size up to 256kB only.
>
> Fix the issue, by making sure the dw_mmc driver doesn't use segments
> bigger than what SWIOTLB can handle.
>
> Reported-by: Ron Economos <re@w6rz.net>
> Reported-by: Jing Luo <jing@jing.rocks>
> Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Thanks for working on this! Looks like we have managed to mess things
up. Besides the issue that you have been working on to fix, apparently
there seems to be another one too [1].

Unfortunately, $subject patch doesn't seem to fix the problem in [1],
as has been reported by Adam.

I have looped in some more people to this thread, hopefully we agree
on how this should be fixed properly. Otherwise, I tend to say that we
should simply revert the offending commit and start over.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com/

> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 41e451235f637..dc0d6201f7b73 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2958,7 +2958,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
>                 mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> -               mmc->max_seg_size = mmc->max_req_size;
> +               mmc->max_seg_size =
> +                   min_t(size_t, mmc->max_req_size, dma_max_mapping_size(host->dev));
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.45.2
>

