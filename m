Return-Path: <stable+bounces-235440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGaiLonP12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:10:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E513CD70C
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87ACF31D184A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5E2FB965;
	Thu,  9 Apr 2026 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6PdEhvo"
X-Original-To: Stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051530CD95
	for <Stable@vger.kernel.org>; Thu,  9 Apr 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750027; cv=pass; b=ax+qfL0NuBkxZ0zSENLkqlVO4nu8EMqLE02WOWJryRl6fTk9sh/3/KO0XMmgvv1ywoPeyuJDFNjS7jCCQ6rkVn/EZggdNorZbvCSvTyvbUSxVlSmfGXP5mOwkPXQRu3SfZDiKnPCjvLgcPCiA9H5S7ez1BmrbSDUJSZgSEnfkKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750027; c=relaxed/simple;
	bh=wk+hqJ0iUTT+wwqkPfh8Q7mvsmKh/oz7GCJX6dFdqD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0EHUgu9tdSDQwqKq3jJ4ytBV9oU4hepZhf/4TAOS1XNm6lCOGILV0UJ1jXREulN6vk8pYSaezL0hexfpHK6OFnmi0kFt0fAlCUFJoGMA/f1uTAxn1uiBMazgFEzM4InlliUlqSR+RUmD+ut++37YeoaBuGzV7A1vSuUBmBkCTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6PdEhvo; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a337552604so960651e87.2
        for <Stable@vger.kernel.org>; Thu, 09 Apr 2026 08:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775750024; cv=none;
        d=google.com; s=arc-20240605;
        b=jYeBdU/wV9EphxzEXqF7WRUnGEblyLuQPobo+sggoGLga/2BdGNElPxhbEqXy0H+vQ
         SYILHXQZkIexWsZxrmlgNlCTrWwpY/OeD2oqoAswzeNISLEwahD1UuqMZlVu4VD0LJh9
         FwrU2cAk2dgqiox3dOyPncdJo8q/XaJxAUsyU+qUREnnETp6dcr+8IMoC/3jCRxSrTC5
         8MLv3U6rxIPLmaih66ZIaUSayTP6LcfZj6nUt2+pm23AOtNpJt9iy6aanPHQKpT3Z0op
         7j0NqIz2mEu+xATXuDSn8HPIsdTlaQuLmvNvOtQXbMLeyb9wVsK25FbPmRFZcn/0LEWw
         fHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dv4qdWsse2g6Hs6kPBq8xuq0aEEIapLlZcENiVgDIrA=;
        fh=WXt2C26qsb5HxE1CbS/K7Tr/VAEYpaVJPk6SyCOpPrg=;
        b=Quk3wFBXyjb+hP/tYiFrd3byLIpHAmIBVAMYOgdlE5nt8Xc7X3qbQ8qgsqIqBga0nc
         5WozAhXLN97kEr9TGGS0KXAwwfBrRohY1JKeQm0/FE+eNQMemjc4GgBsc8hAkLwInQYV
         SnAqI+9SrRElYmRhG9uLTWeRNkiG7lLdQyMj/3hZxiMjxrEq5XPNnjHjNn67qg72+K/z
         GnD2POI6h7lHaeA92apyXgZ9T/pRedw3skyYOm6uhhcF8gj0JYkFOgCbe8vR8wvcf6GW
         FIJphfOmNsD1P52VDPXwJvL1sHYAqjleaBfaXlDE7EJjmL48b/CTfT7wDiCvC8h6VHhT
         gmtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775750024; x=1776354824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv4qdWsse2g6Hs6kPBq8xuq0aEEIapLlZcENiVgDIrA=;
        b=M6PdEhvo4f8MXyR+Pv4ed9jICMJFpxnHbhAWH7PosHK/C35QLr+4syZfBWvGw9Z3bO
         Glt+1sHAOASw5U6YMoOwoea7pLb9WqYAdlcy8z9yrvNYXY7JAi7OK5jm4o74zWo4sR/A
         WP12HiuCt63nrl1pfPBcuAAL8poTOhum6OvZrDPj6xxWO3/VPbBlm4iX7yMvvBC6g3f8
         axBjPpqQkEqvNBnvgEf8C08CtVyuqf31ZuA4xJNuogvc7nHeuQZ1nKBL529xLzk25UaT
         8+KQloLUU5l/IiNOcr4qq1jnDxl6H4O+tWVhQ74N18OMiOm7YiOgvLhbQL5zJAi1Jv3n
         OxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750024; x=1776354824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv4qdWsse2g6Hs6kPBq8xuq0aEEIapLlZcENiVgDIrA=;
        b=KE2vhCQFBYb+dt9IikfqK/ZFLClzOkgNeegpu4h7331vgS5M8euVu4I6zsUvgVDg5h
         hbl7mhrvatJcoOZwvbMETl6rjY9pKR1LmrLSvxC5cUk3evUFukpfUAKfNfKDy91SsA+7
         LihJQZSid3zSmg0U3zUkKDtPEGevNvtkdAJxulp9FO+9anEwEzxofcZRG94bnwuGB2Xr
         4HfxMOMG83G4pLgei7Fh6Vz6S4FLW7yQFVHkdt3eV+zTsXYKh3PDkLwupfpc5v5Cjnke
         1dP8dTp6TaaMxDlCRhySmP1Y7KMWmHB7K35LVN8Nj0A7Bx5d999nVHNxLqnOBrGD4a4Q
         Yq6A==
X-Forwarded-Encrypted: i=1; AJvYcCUmrVcJsOBZ/ThZnVRBHdpcRjK+ea/Nq4O2pdIEt0FLxZcgOORirJV0rMdn2W1mQ3Sz8FTNWBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JYy6IshrnwqK3dNnyzmvQCdh/WT7I0hWauXjwRRpWFtQEgYI
	M2Gtz3npSL9cC2IxWfgcqv+DWeLsHV+2QZgwLTlaC6gsMAVXjKYKKcv7XWVBz6uz7BP9+ik8ynU
	sSuiP3u5uAeT2vCWOboEePWOanKX8QfsVPP0EGTzF9A==
X-Gm-Gg: AeBDievnGUplMfp7EIFkHmQKJCh/jrVgOzs64Lpht8W7hCBzHPOc8r3yVmhLH0e++ie
	T/gwoiSxt3N+IRlx6Zu/IbpfUmWNdmMJ716f/8M50D14CxjVU29nhrNMNln4PykgRD6akCxZ3wM
	mK8AGEKKDgP7rTaW5JUC3f49lUkMBKA4d+gRouL4TpTrFq4U+mWj1DQswsDocz7wz7yLzmgI85T
	AiCDHlHXWxvTIbVMpY32GYY/Pqbd8QI/NriT09rVy8CWLv7hWEZRp6Uu2iulswfQKB5noWucVWH
	+hwDGCJe
X-Received: by 2002:a05:6512:3b20:b0:5a1:381b:fae1 with SMTP id
 2adb3069b0e04-5a33755cd01mr8745197e87.10.1775750023584; Thu, 09 Apr 2026
 08:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1775632729-22841-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1775632729-22841-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Apr 2026 17:53:07 +0200
X-Gm-Features: AQROBzDtN6BuSpifx1kELMTA0xEfm1HADbBZ4h8KffOIIm2mDqIQjdmC0mk4g-w
Message-ID: <CAPDyKFobhyGx6yCX6GEA5sCxXnsaB4_5JQN-K6wghOXU=Q502w@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235440-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 19E513CD70C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 at 09:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> According to the ASIC design recommendations, the clock must be
> disabled before operating the DLL to prevent glitches that could
> affect the internal digital logic. In extreme cases, failing to
> do so may cause the controller to malfunction completely.
>
> Adds a step to disable the clock before DLL configuration and
> re-enables it at the end.
>
> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

It's getting too late for fixes (unless we get an rc8), so I decided
to apply this for next instead, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - Fix compile error while amending the patch file by mistake
> - Add Adrian's tag
>
> Changes in v2:
> - Add a comment about why passing zero to sdhci_enable_clk()
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 6139516..0b2158a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         extra |= BIT(4);
>         sdhci_writel(host, extra, reg);
>
> +       /* Disable clock while config DLL */
> +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
>         if (clock <= 52000000) {
>                 if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>                     host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>                         dev_err(mmc_dev(host->mmc),
>                                 "Can't reduce the clock below 52MHz in HS200/HS400 mode");
> -                       return;
> +                       goto enable_clk;
>                 }
>
>                 /*
> @@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>                         DLL_STRBIN_DELAY_NUM_SEL |
>                         DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
>                 sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> -               return;
> +               goto enable_clk;
>         }
>
>         /* Reset DLL */
> @@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>                                  500 * USEC_PER_MSEC);
>         if (err) {
>                 dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> -               return;
> +               goto enable_clk;
>         }
>
>         extra = 0x1 << 16 | /* tune clock stop en */
> @@ -868,6 +871,16 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>                 DLL_STRBIN_TAPNUM_DEFAULT |
>                 DLL_STRBIN_TAPNUM_FROM_SW;
>         sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +enable_clk:
> +       /*
> +        * The sdclk frequency select bits in SDHCI_CLOCK_CONTROL are not functional
> +        * on Rockchip's SDHCI implementation. Instead, the clock frequency is fully
> +        * controlled via external clk provider by calling clk_set_rate(). Consequently,
> +        * passing 0 to sdhci_enable_clk() only re-enables the already-configured clock,
> +        * which matches the hardware's actual behavior.
> +        */
> +       sdhci_enable_clk(host, 0);
>  }
>
>  static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> --
> 2.7.4
>

