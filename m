Return-Path: <stable+bounces-189129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BF8C01D6C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B383A10E5
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C7832BF3A;
	Thu, 23 Oct 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTyOxWJq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4C22333B
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229981; cv=none; b=UeocH1NHKvq656TV7gPgkZsXrqC3b1TfHC1WV3q6Ka3z1ywAVyiROhjz988ExOd8b63LK8YcODCqCWoFH8jUdo5Ln5dE7UZ/uaqT6eXaO28kPhwTmhYDGXu3Vbi59fRzs8XdxTg4kFcb7AfGlNCOLRmlRfiqNCy1S3HolQzpvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229981; c=relaxed/simple;
	bh=t/hYkpSlu0vnttqha26zv1xBx0fPlg003PIh1Nzd1PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUXpUnIURpKJ9sGbm10z/YbdjMF/I34o+uIwyZmDWAesz/2CUDkpJFaN3gcESfslk3CrK6ie9z4XMPeOZ05xGl4HgacexNB5Nkg1fD5y+8fUFDX2bPAAGG6GusZDHnurHme0HySIIjmwDezuBs09oLtsYKIdsPAOvs2QlmthOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTyOxWJq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-784a5f53e60so10757557b3.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761229979; x=1761834779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/xc9UniwAv60m+Rz/agyhA5vluzV9PNM3+eKoA9NbA=;
        b=kTyOxWJqcZM8nlau9IrXueA5RcKeQeIGhEJTI01tHcOj8Gib5WZUxbxi9vL7lr6C2w
         rDcGskdQcK2j/8mttEsqFc+FvhMwwVD3sQrPpBsOkk1/aJYqbgaPCvRy/PKaeajbqixq
         gMp4MJd3c65ITMzke34hWouNBdRiMX7sS1ErImhVoFOoJ5OEwtMZCCXp7/qkQAl1oWiw
         Dzp1LYPLpEIISq/HZL1xayhiKOuAGEnmFm/sPQrfyXvF3ZP792b0Lz34hwPqFObvaW6h
         /3hz835Sy3xI4s2C8H9oxTYDQeW5al/IM7SGOt/Vemi+bAV10jjzCTQQCTlxrkI7MNYD
         scMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229979; x=1761834779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/xc9UniwAv60m+Rz/agyhA5vluzV9PNM3+eKoA9NbA=;
        b=wI1lvPtcuZgP0BhFHgw0IVSvztTRtRxpUUYZUeeiThC5bp1TINrACosjnQA1RoSrQl
         obPjMBAWe/ETtSAAWqpRIYUpIMcEsbpbJXpE1tm5Hzhfq433AZI2IiAzJKnfUjc54Um/
         sQOHq+gCzo1PSe91D1uTFEA+u+yz/PO+rqSiyZRl9FEb3AcoB6NJNoVlm0vLDRoh2ebn
         /ZlPvXxr8IVbhQcIz51dOZBykruqylxXLehl1xmF9pYaguxJStQYZmrr+rbDeH93wlep
         R4MizwONGEuJZhG85DcYQc+0ku1/YPQw/i/Fph8nraWa5UBNtkUMhORUY7aBX/OyPu0P
         rrkg==
X-Forwarded-Encrypted: i=1; AJvYcCVkPm6XyChpExO5Brv5tGSo7mFSv509n6ctcUakIo5m0fZFnJJbhxtpm41KzYdHiXRtrp8CVOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo+uSh3Sp4pra7QIr1Sgcy0pB2bixo0lSj/GexhtIrAlQxq3U
	aeqzaUF+pbGTChp1iOGW+EnT0uSudNkYizvXkTiyYThOmPawntB2ka9tPLjuyyF4JSe9lRktE8i
	8h7O3AIUIIt1Tg5ajz+DfJz2zTCpdM+H2rEbhSfPC2g==
X-Gm-Gg: ASbGnctwJoZPx6Lg5ezAMtlEej67Qfe9rLSYpFS4vBD0mjOB8CiO8m0bc7hAOF597XR
	E75X4q+4Hddl5GOJuvkdgfpr1v3XaXMMIMceUbVFUJYUdhbhji9OxoNnxinnDV+LdUhcuNn+Frh
	uCYebXmE0JJSkRRixyOI63JFF9M+02qVUDXDPwAqPAZ6DoxmnIg4vfqCi3oPApCpdROPQHQT9kM
	pG3oDr5/aalUSI4/QbeK0f7k0EpSjPCG7I58pEZaFtlw5+KAJuCi8f7xxUlTypisGkxj5nu1dx/
	o/aOn3c=
X-Google-Smtp-Source: AGHT+IEgTaJNjs+zzx0IN94FnxxGv00PXrNGgqAoXFF/nPcpR+yDxafMeAv0ZL1vvXVSoKr9Z2ifvzlZrapBz2hajVY=
X-Received: by 2002:a05:690c:9a01:b0:772:72d1:1610 with SMTP id
 00721157ae682-7836d2eded0mr218084217b3.32.1761229979006; Thu, 23 Oct 2025
 07:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com> <20250619085620.144181-2-avri.altman@sandisk.com>
In-Reply-To: <20250619085620.144181-2-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 16:32:22 +0200
X-Gm-Features: AS18NWBhunMkKx-6DMartf6yH0-vixyPCnlYDOpeAGGrdcY4scIzm-2scSQ7xYs
Message-ID: <CAPDyKFqgY7nVW+GYSk8xMH721Ar2myvFjFAb6EWQHYrk8zGbQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core sd: Simplify current limit logic for 200mA default
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, 
	Sagiv Aharonoff <saharonoff@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 11:03, Avri Altman <avri.altman@sandisk.com> wrote:
>
> The SD current limit logic is updated to avoid explicitly setting the
> current limit when the maximum power is 200mA (0.72W) or less, as this
> is already the default value. The code now only issues a current limit
> switch if a higher limit is required, and the unused
> SD_SET_CURRENT_NO_CHANGE constant is removed. This reduces unnecessary
> commands and simplifies the logic.
>
> Fixes: 0aa6770000ba ("mmc: sdhci: only set 200mA support for 1.8v if 200mA is available")
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> Cc: stable@vger.kernel.org

This has fallen behind, sorry!

I have dropped the stable/fixes tag and clarified the commit message a
bit, before I applied this for next, thanks!

Let's try to move forward on patch 2 too. Avri, if you have the time
to do a re-spin? Otherwise, I will try to get some time to have a stab
at it soon.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c    | 7 ++-----
>  include/linux/mmc/card.h | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ec02067f03c5..cf92c5b2059a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -554,7 +554,7 @@ static u32 sd_get_host_max_current(struct mmc_host *host)
>
>  static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>  {
> -       int current_limit = SD_SET_CURRENT_NO_CHANGE;
> +       int current_limit = SD_SET_CURRENT_LIMIT_200;
>         int err;
>         u32 max_current;
>
> @@ -598,11 +598,8 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>         else if (max_current >= 400 &&
>                  card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
>                 current_limit = SD_SET_CURRENT_LIMIT_400;
> -       else if (max_current >= 200 &&
> -                card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_200)
> -               current_limit = SD_SET_CURRENT_LIMIT_200;
>
> -       if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
> +       if (current_limit != SD_SET_CURRENT_LIMIT_200) {
>                 err = mmc_sd_switch(card, SD_SWITCH_SET, 3,
>                                 current_limit, status);
>                 if (err)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index ddcdf23d731c..e9e964c20e53 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -182,7 +182,6 @@ struct sd_switch_caps {
>  #define SD_SET_CURRENT_LIMIT_400       1
>  #define SD_SET_CURRENT_LIMIT_600       2
>  #define SD_SET_CURRENT_LIMIT_800       3
> -#define SD_SET_CURRENT_NO_CHANGE       (-1)
>
>  #define SD_MAX_CURRENT_200     (1 << SD_SET_CURRENT_LIMIT_200)
>  #define SD_MAX_CURRENT_400     (1 << SD_SET_CURRENT_LIMIT_400)
> --
> 2.25.1
>

