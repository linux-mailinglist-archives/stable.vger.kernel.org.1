Return-Path: <stable+bounces-92828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649FF9C60B2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187091F2151E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55121218335;
	Tue, 12 Nov 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNZTecwv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147B219C9F
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437077; cv=none; b=u8+XTfapv/2GQuEE8YK6xNzXBoTj48UMx+Aqy212pVCgcNao5Ek5e9AW+VdmiGjkF2wq+3RDUNq0XiBVuGyB9Xa9jvVPnFW16qFWF2k4OAXai0TcXg5uIaUrjsqFskBOKgdHNhE5ZgPvBv4s+WMKAmzlbJ1czu7eEUkSQlB7nbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437077; c=relaxed/simple;
	bh=Oa/YrficsfeyjH0/jTjfnABLWOfA6T78uM65AF9s+o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuZL0G+QQi+wmQvtZtKh0ejNJyTI5zFJrDbIg41XZ/e/oPp74Gmy2ResR19915oVmKN1gcamZT+MFY2VKZMFFyO+YRVi/x4wlnQtehXyhMgYk5/Gef0vmMkgKvTKUVI66HrpkXwhjdlCvc2OrfCIDcpFk34BgA24PrHCw7kUQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TNZTecwv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e9ba45d67fso55975177b3.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437073; x=1732041873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGvVgCeLO47x1MsXySaQq6071hjPH/NhHOthZqYhKSQ=;
        b=TNZTecwvlx2iw0NB+5v5GER1r97bOxENB1eMz5KB28cOyVBciLOVze0vhbmFNskiIt
         iD/lRXPfodp/5YeLrbpyMMqdOhSkqLdIp80dkqWUST5hc8JwXcCizlA5A9HF3sMMLGQo
         UanHNml33M3SSmTxkqbFYpfZ5RQd2pe8NrG/bKY6f92RKZ0NrFmnTGu4WtwYXL9ASfAc
         XVhHDMhDD5YqURN7lFoA8LyFLSeNMOSOeikTz9Zal1LZOFZbBXaW9m3n12Vze65n0Miz
         m8CyvxWhiaZVQz2fpXkHCwgr0Tz3m+PynHPnL0X292CoDpa2y1+Qj3X/Dpk3hCxPAfLZ
         QNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437073; x=1732041873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGvVgCeLO47x1MsXySaQq6071hjPH/NhHOthZqYhKSQ=;
        b=bAzmex1jXdoWWV2bQaYpBWjFwBnCNsFO57sMYNQJQKGI2lARbfIkGhOAMEQDwPPWpB
         E4Vg+fRZLPf99fe2KbG6U6W1zU17UFBUAj2JWX0Y5WeblfayyxQV/aNQTi/E0WCB2yIW
         9scdOHH+mpL4/iSysjNrjrASp4lSj7ekLeD+oy5BfL47CaCU/K5bPDw3hMMEqk87C+SX
         1eOVoim38aDaIkNnpuWskwrMS7YV8+FfGCT3pETMN0nD3WUOKCoiePuNS/z7h7GcKceW
         XoMGRgSoyf5+61/lj7IFnoFX8XOLKGG9ECyCjhGtd011dr4yBg+GbzwS1GPRdsmTdJW1
         WA3w==
X-Forwarded-Encrypted: i=1; AJvYcCUsS7FrOc7LWy4fE0/rGgunaxRX8+uirHrswY47OnHTwttIWpo6gJrbRGW7YGUCotFm3D11veo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6M1nxkVIzjaALJFy0n1YQPh5SSSZNTbkKMU9ITyEJxO3O0G92
	8AGOgtz8AZa26eKTXwKhu62TpwIuxTdxmHNS9ig+CjMwpR7v5/vu9O1Q1Tv0Cfx29Fp5wz7TCpg
	Tuo+3MjE/g1elQ9+eSp6ygEM0sEAlBQV4nuqmnA==
X-Google-Smtp-Source: AGHT+IEe8csqC3Pg0F21RvUMA9aG223tYNBFweh8Drp5qTSmfQtunv7apTIfO3K79mr2mEtEH9f9z4XcBwW5aOMunNg=
X-Received: by 2002:a05:690c:2501:b0:6dd:cdd7:ce49 with SMTP id
 00721157ae682-6eca4640ff7mr44651927b3.6.1731437073569; Tue, 12 Nov 2024
 10:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110114700.622372-1-aurelien@aurel32.net>
In-Reply-To: <20241110114700.622372-1-aurelien@aurel32.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:57 +0100
Message-ID: <CAPDyKFp4t0zHo_sJ3F7D1atwiPK+e38KbhTfcr76Jv+32yUw6w@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc: Fix IDMAC operation with pages
 bigger than 4K"
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, Ron Economos <re@w6rz.net>, Adam Green <greena88@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 12:47, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> bigger than 4K") increased the max_req_size, even for 4K pages, causing
> various issues:
> - Panic booting the kernel/rootfs from an SD card on Rockchip RK3566
> - Panic booting the kernel/rootfs from an SD card on StarFive JH7100
> - "swiotlb buffer is full" and data corruption on StarFive JH7110
>
> At this stage no fix have been found, so it's probably better to just
> revert the change.
>
> This reverts commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890.
>
> Cc: stable@vger.kernel.org
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> Closes: https://lore.kernel.org/linux-mmc/614692b4-1dbe-31b8-a34d-cb6db1909bb7@w6rz.net/
> Closes: https://lore.kernel.org/linux-mmc/CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com/
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I have posted a patch to fix the issue, but unfortunately it only fixes
> the JH7110 case:
> https://lore.kernel.org/linux-mmc/20241020142931.138277-1-aurelien@aurel32.net/
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 41e451235f637..e9f6e4e622901 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2957,8 +2957,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         if (host->use_dma == TRANS_MODE_IDMAC) {
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
> -               mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> -               mmc->max_seg_size = mmc->max_req_size;
> +               mmc->max_seg_size = 0x1000;
> +               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.45.2
>

