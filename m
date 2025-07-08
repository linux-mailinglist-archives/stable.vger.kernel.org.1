Return-Path: <stable+bounces-160501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5BAFCECA
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C24189357A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E52E0931;
	Tue,  8 Jul 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4PZWCrx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC92E0929
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987678; cv=none; b=FrRFKwR3x4l3M4yYVWRsj+YPqpDbAuBYloo9MoSe/AcdLZhx4hEe45+7P1k1ioJ+CNCrrp8fldtdfabtxHiNVfxSsGA68AMmy1CuhNP1rtCmczIpsbMbrSsastZkc6BHgMRpWfXWFVlvtktBvDz8ezR8nRKVUjKs7z28/W+BZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987678; c=relaxed/simple;
	bh=XD+ajlWQHE+HxXuJVKxnMKX/D7lXuezMqrzi6l7iWv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7Tr7nb1JY9DabT+8AZLroXLBRupTEfXtf94YcuhwZrjct8iR8YUHGtg4lJbIdoOkX12XyakO0uvVmhLx/IU9L836dHPjLf5A9gQ+QzJx/tY6QtR4EgZacpF7/jVEa1MKXlNLNfgp0Fn8kMGEFq+o2pLjawlvmo85w4d6vUlEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4PZWCrx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70b4e497d96so40317847b3.2
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751987675; x=1752592475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6MHv0o5tTzfPie41UtU7o14Wz6rrFQd68dfor33PjXA=;
        b=e4PZWCrxZjpUzSsp6HwHnzzgkOBAWFFt5YJ53A06Xk8B78yqwsE5AecokmYGcclPvy
         nf7Byq1/yo79eTL7j80m8XFpI0CYF3o3QkVk3z+A6HJBrt5GaDpPPFPG2ZQPtrVj5JS/
         2Za1XkLD6aHiQFXQh+6h1rjYRPuDLatIDFdbHzZUO9M1e/+ENRGAQ0RgPcjORDx/MWA/
         BT1VUEVU/XSQTzGMrOz+UM+kTxZ0RKfP8A1aZUlHdzyI/qKeHqR7Be/VTMRcdLADntMh
         6bP/U31j0uHj0mf26UenLqH1NolUQNG8hB6R4H2ScbJCQI/F44zzKt6ygw0OaNWDTZIA
         gGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987675; x=1752592475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MHv0o5tTzfPie41UtU7o14Wz6rrFQd68dfor33PjXA=;
        b=VVdl7ZrwfK/0RybtsOleiNniEoTbEKRh4p2VSyidWz3b8EGkS2N/Eoi+ZyshNRyH9N
         WpHTEHnrBsUOc0oAI5T0V3skbf7L38FTBD8kY3Rp3Ur/UtBV4cdU0/tITW0f4sRsC7qp
         JhLpJ1EfZRoryZ97r8dOxgai5ooYGuxPmPRYsb2owJMx6lU8onl4UXzYEmLNm772IlQD
         qmyFv/tdjVQ1HPEEDaU6KbWp6SsLdx9ogreqZ+skjvbfdKjpp4Pqt5nQ6ljP+EYmIqmB
         ARjEAm9n+YsD+I01I/oHgjd8Y62/QmoISdxDNm4T4GZZxneLh5snn0QlrEKY021zxBs9
         tQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxy1hX0YbvEiOkA7zjguIwyrV5eT/DiP5R0YsNf1IyYzhfg1k1c7m6Klk6LpKq1gbtX2Mj124=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDfnySQ++26jJRFaHGd99CXVmuJme7hnwz5DjNpSrDHW86XJ4
	31JrMKQBHRqjbq1oo6gkgje2y8mD5Myp7FEPranRP4Updn1C5jlnbN0PqAihkZKemysK55gaH6K
	v9EOD8PbiH27ZJqWR4fghDyx02TGFrClGh7RpvUqAFw==
X-Gm-Gg: ASbGncs791Yqd0aM9X9x1Sie4suHB8K4lTAiK8mGs25Zk3WT8+4MPT6vvIgZI1MtH57
	F5rThDnP1puet9jkgdbWagCig2TZY/jf96/iySZ8ba3wf+VFZn6F9OsVdZL+wbVR1/NhxrGesYF
	mb1wmwpN+Kj2sJEiiILtsj9rZp4p26sDoj4mKj6/0/wKTm
X-Google-Smtp-Source: AGHT+IEI/0SYYzeHymxh2jUoAdEcJIpNy9ZCqz0S2cxSvyilDCrGKDo4QnaaMh/qd3Hhuan88jUhczUtvtCgWdfVKV8=
X-Received: by 2002:a05:690c:61c1:b0:70e:142d:9c6f with SMTP id
 00721157ae682-7166b7e87b5mr240830887b3.28.1751987675368; Tue, 08 Jul 2025
 08:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com> <20250619085620.144181-2-avri.altman@sandisk.com>
In-Reply-To: <20250619085620.144181-2-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Jul 2025 17:13:59 +0200
X-Gm-Features: Ac12FXwpp13xdvAYpe1Fj9PimvoQ7v6kLZY-lacmlgJQAaeTFthvCA4UVEyI9VU
Message-ID: <CAPDyKFqJR+HwnVZU=Lerk0eJ3+_9J7KD-5DWv84t-YG3r5NYuA@mail.gmail.com>
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

I am not sure there is really a bug here. To me, it rather looks like
an optimization, as we are avoiding one unnecessary switch command.

Otherwise this looks good to me.

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

