Return-Path: <stable+bounces-112027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61530A25BCA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4C163B9C
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1D205AB5;
	Mon,  3 Feb 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeoOaB41"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9302A1A4
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591496; cv=none; b=llGZxkKfIOE/Iz+2uqlZs9ugJjxbqDKT8khSI10VyTE0q7J79YXckZAHgxXrJrGPrzGYrPSIUrOpGfqzhorj2VO8tDf5aJju6MzzZN9obXhblJikuc9aVMBsD8kbrbsb97t9sjhSVg3xw8KV2qHkNWCbY7gJviIATcmLgtI0bj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591496; c=relaxed/simple;
	bh=TXJnyxnZJmXNK7Qr/0ocqomhEyCISrE6NMMIXWvv41g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gf6qR68/z+93TP8kb2R9o5QcMxQ0cqUXsn635cIIDrAmIkG3bOX7a4zNhWCwHjmtsYrLdmvDVaghaehPwTsGqC05djoNiSvmHLsln320XSFjT79YhVWvPEHRXKbi3Yp3pSD63V7iqG0buk1qvYI0gM4E5cxA1QXxOvJlBOdV6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeoOaB41; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53c9035003so4066256276.2
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738591493; x=1739196293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs2EHxUDMxq+Baz9mBmpS68Jbe8XGEdWwve18lbP/Cg=;
        b=MeoOaB41jXI87K3iClqKnxDCl35saNRQm8EIREOrI5DuhqV7R8mlLJCT7e0Zw3SwGr
         pvtvpMSozUly1xTQbc00s1T5H2jdsbN+1Mp987lXzP7GcZkpPhGD+3whfKVYoZ+ggYGC
         ExSkCiJlgjXZQ9bxlahHUQPJz2rTC5ailUKm0EzpgGo7KC1juUqpHhJoWnEjMsmkcnUy
         Zp5xQhI6NPC4HmYZpeUMEgGiGDlNZs/60OTNh6Z1lNPusAGsithEApYGS5LQAa8ks7sY
         zTg1P5eanAICR/riykehy9T/f8vK91IjvZFLNWGwX0f48OUCpSU5PmzKGfIuVtW7e8uo
         8iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591493; x=1739196293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gs2EHxUDMxq+Baz9mBmpS68Jbe8XGEdWwve18lbP/Cg=;
        b=Hsl/36tvcIu+4oUE1S+ReI7DMK3fvhdBqtyYJbZe37Oo8lWNhEQ7Z19zAApL3ANK/m
         jKUGaPnKXxTTWNiJLVFxTjwgyrIW6vqrF4mdr6LKIt1xKSPJedE+g8d0zKr2iIVaSMnD
         bRMKwy4C27VuHZDyPfvX8k+V66y57fXH6RMTKX629BsW5UWGyRzbF8fpcD4Zri0UJn60
         lnHX/YS71oKHHcQju5WE0YElt6sjaYsdf6Ly3hojLTetH4TDucdU3HQFeGwRrYrdBCWU
         blJNzmojtOt0ZKw7jsPKDG8OR13V7SbR+kSScJaoSOvWtOG1/8JZVixdw6ODkr/f9lXG
         3yow==
X-Forwarded-Encrypted: i=1; AJvYcCXY35CI1Dx0V2QAT838ae0tGOkJgJpKJ77At52SH8e8xHwuMeGt47N+r9WFjdqxaLeW2C/80Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOe/u3pahJ/cAypUM8qEFhUhTLoI6lAX25ihAgHXJvDQQyxgs3
	dRkR/ayklI6CBJe/EQy/q7Ocv2XrCu9LV7KmklFbAfMm8DcZ7t2NSRmGjV3TJubBODGpUckGXqV
	/DjSyKnVyl734WUaRQ7qpl+bmVdpyIsuikioEKQ==
X-Gm-Gg: ASbGncu/0lRyhS8BORlcGZcwN9whd4pGH4D5q8VMnF3O84iRHZLYAdG5IWDLb2jHQBN
	4x0ZVgdEaUYxL4E/5t3+TcAMc6A5+FbvnrvJcTxorN6UWWfXK4N1NKlptbmeo6o8/nBoO9ntvxg
	==
X-Google-Smtp-Source: AGHT+IGtg5NkrdgYScCRmI/OmJ7Dav6l6O2tNODPfC6EZHSpdKj02qXroe7xo38HtwQW79jYwAn/G9iInvsvRkTxKKI=
X-Received: by 2002:a05:690c:25c8:b0:6ef:7c8e:f00e with SMTP id
 00721157ae682-6f7a8424724mr174604677b3.35.1738591493192; Mon, 03 Feb 2025
 06:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
In-Reply-To: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Feb 2025 15:04:16 +0100
X-Gm-Features: AWEUYZk6xEPi1SMesWD-n8GvcXLzo5PaGCWwFhzEnEsJ_1yCwEJdTyoJEQJDy2c
Message-ID: <CAPDyKFqdKj5EVPGCSUw1YN-E2q9=dQtNGMPVOxBHGK7svGoQig@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"
To: Josua Mayer <josua@solid-run.com>, Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rabeeh@solid-run.com, jon@solid-run.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 21:12, Josua Mayer <josua@solid-run.com> wrote:
>
> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
>
> This commit uses presence of device-tree properties vmmc-supply and
> vqmmc-supply for deciding whether to enable a quirk affecting timing of
> clock and data.
> The intention was to address issues observed with eMMC and SD on AM62
> platforms.
>
> This new quirk is however also enabled for AM64 breaking microSD access
> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
> causing a regression. During boot microSD initialization now fails with
> the error below:
>
> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.115348] mmc1: error -110 whilst initialising SD card
>
> The heuristics for enabling the quirk are clearly not correct as they
> break at least one but potentially many existing boards.
>
> Revert the change and restore original behaviour until a more
> appropriate method of selecting the quirk is derived.
>
> Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
> Closes: https://lore.kernel.org/linux-mmc/a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied this for fixes, thanks!

Kind regards
Uffe



> ---
> Changes in v2:
> - Fixed "Fixes:" tag invalid commit description copied from history
>   (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
>   (Reported-by: Greg KH <gregkh@linuxfoundation.org>)
> - Link to v1: https://lore.kernel.org/r/20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com
> ---
>  drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index b73f673db92bbc042392995e715815e15ace6005..f75c31815ab00d17b5757063521f56ba5643babe 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,7 +155,6 @@ struct sdhci_am654_data {
>         u32 tuning_loop;
>
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> -#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>
>  struct window {
> @@ -357,29 +356,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         sdhci_set_clock(host, clock);
>  }
>
> -static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> -{
> -       struct sdhci_host *host = mmc_priv(mmc);
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
> -
> -       if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> -           ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> -               if (!IS_ERR(mmc->supply.vqmmc)) {
> -                       ret = mmc_regulator_set_vqmmc(mmc, ios);
> -                       if (ret < 0) {
> -                               pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> -                                      mmc_hostname(mmc));
> -                               return -EIO;
> -                       }
> -               }
> -               return 0;
> -       }
> -
> -       return sdhci_start_signal_voltage_switch(mmc, ios);
> -}
> -
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>         writeb(val, host->ioaddr + reg);
> @@ -868,11 +844,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>         if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>                 sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>
> -       /* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
> -       if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
> -           !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
> -               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> -
>         sdhci_get_of_property(pdev);
>
>         return 0;
> @@ -969,7 +940,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>                 goto err_pltfm_free;
>         }
>
> -       host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
>         pm_runtime_get_noresume(dev);
>
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250127-am654-mmc-regression-ed289f8967c2
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>
>

