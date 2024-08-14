Return-Path: <stable+bounces-67642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA2951B4E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAD01F226CC
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7151B012D;
	Wed, 14 Aug 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyq7uAAS"
X-Original-To: Stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2436381D4
	for <Stable@vger.kernel.org>; Wed, 14 Aug 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640493; cv=none; b=mA70f2y1BOezWqs1CRgoOeE53HSHdYWwyP4199EYRE59wDhIZEATtoIbzQynMshWGa1ZKfZkZN6ZskZVYTlJVY31VIHSnsDzGEnHGVwSEJkXRQXm4AQFOKaIgipMbUdTz50MbnjetEeXQFByc9h2E+5TpdNraTqktmQmSKhmlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640493; c=relaxed/simple;
	bh=q/uJbkjsZVe1udBwRTk4Z0NblBdsbyD+dlaoHPUzTfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzQnBR3syAxDGqIwWoa7b/Mz1hOMrycGQiPdCOZ6e9we+O4qlHAyqpJ/B2azeQCzYwUm9AAOgWJutXfLnpvA4wb3p30YXdBDSruRtsErd57tzhH95CbVa88HsG9awtdjhql99mOq/FEF+DH/ZI6lacUHWWfZpdLC5YLiaPni5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyq7uAAS; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0bf9602db6so6412791276.1
        for <Stable@vger.kernel.org>; Wed, 14 Aug 2024 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723640491; x=1724245291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7jfobO0h8PCWvLzZDgipywq+q6ry4w+xtSJdMM8OsI8=;
        b=wyq7uAASsaengzfHPU49sQat/HWe/WmS1L2lwZ9yYY2j3EedHaQqDLk3ZkuNxcF8ss
         S5Ob9Cw96H22xFbaLJO/oEPdsESjpW3vc9HvvGzSon8+6KqZ76LDwBr6EdCcHnbhaCwg
         iNNnAPenqd2k8ECjACCeG1RhuGRm2Siz33T2Zm1B11LrEgLwfNn+mltmnyV5Mcshb1gw
         A8MlisojbKlFsYNgkcwQAyosiWM0xtm2vugCDrgvPIP/1bO+VxdLJXAQH9qPupM4iM8Z
         ON0bie1ck1YaWWsPOmAgerNSipCuAsOzcwLiFqYkRP0KmyIz2+avqycYiTzAOCWuqwBs
         OKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640491; x=1724245291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jfobO0h8PCWvLzZDgipywq+q6ry4w+xtSJdMM8OsI8=;
        b=qcLCeDkaZwIOSWYYBq7BB+nNpljjnKS+KdgOyFRyx1xdJPxgFojZHohm3RvKJBDHN8
         InwcNPRXDqKTakC9J3Pf5J4w4vXfiABR+3NqG/2IXxvkB3DvJhwwqdE9SJMa+gah3Zwc
         3TQezogCQH4gYP7vcywr+2d3vKyltljUWTBaz7BNrQlK6g5Q2eb1qb/z4g+NJzy/NHRc
         2+6ec/yaNnztZ8d4bED62CQUe9QAXJTTmKhgJJA6zFHSPQOzBfGh+QSH1oc3Fwc0DqDA
         gsCqpIhuNMByl1j18oolLrfF1M547Eha9vNJ61QOHwqcWbvwUiHTyjQAwy6ycyawStiA
         PrZg==
X-Forwarded-Encrypted: i=1; AJvYcCVM5eeeHiBcglefFY+59AMJsIWeo1OTbyPiKJ7pU7vthw5vWavSWAYfKAcJhIg7u1yqq7JDVzrm+3lAZ792+D8LfEJYoZv0
X-Gm-Message-State: AOJu0YwZvGhHtdQOryE5QkrsA6s+aL7LPcSa3nrDAppsUTc1PFEBEK1U
	vPSQAs7VXDh8rnHt9XxwEvMJUcuW+HiOTgfUjLmlXjC6tl2CBWTJtu+0wupUfL1VPYam9VHcqRu
	mmYHVrszdcoFmuaoF++adf94yunUUZu5u9Caa+g==
X-Google-Smtp-Source: AGHT+IHrp4Xh3i1XqddMFLTNR0pu3w38VmxhIBnGcCEYDdONQahxkdZEFtRyur/hzKD2ig6aNbR/s73+CN6uArFqY3M=
X-Received: by 2002:a05:6902:2201:b0:e0b:c402:b03f with SMTP id
 3f1490d57ef6-e1155ae6007mr2993583276.27.1723640489000; Wed, 14 Aug 2024
 06:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814124740.2778952-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240814124740.2778952-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 15:00:52 +0200
Message-ID: <CAPDyKFrUyEfSsEdjfXGLX5NJuWaGNBZg1D+kCR=EikG42_eL0w@mail.gmail.com>
Subject: Re: [PATCH V2] pmdomain: imx: wait SSAR when i.MX93 power domain on
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 14:38, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With "quiet" set in bootargs, there is power domain failure:
> "imx93_power_domain 44462400.power-domain: pd_off timeout: name:
>  44462400.power-domain, stat: 4"
>
> The current power on opertation takes ISO state as power on finished
> flag, but it is wrong. Before powering on operation really finishes,
> powering off comes and powering off will never finish because the last
> powering on still not finishes, so the following powering off actually
> not trigger hardware state machine to run. SSAR is the last step when
> powering on a domain, so need to wait SSAR done when powering on.
>
> Since EdgeLock Enclave(ELE) handshake is involved in the flow, enlarge
> the waiting time to 10ms for both on and off to avoid timeout.
>
> Cc: <Stable@vger.kernel.org>
> Fixes: 0a0f7cc25d4a ("soc: imx: add i.MX93 SRC power domain driver")
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>
> V2:
>  Add Fixes tag and Cc stable (Per Ulf's comment)
>
>  drivers/pmdomain/imx/imx93-pd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index 1e94b499c19b..d750a7dc58d2 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -20,6 +20,7 @@
>  #define FUNC_STAT_PSW_STAT_MASK                BIT(0)
>  #define FUNC_STAT_RST_STAT_MASK                BIT(2)
>  #define FUNC_STAT_ISO_STAT_MASK                BIT(4)
> +#define FUNC_STAT_SSAR_STAT_MASK       BIT(8)
>
>  struct imx93_power_domain {
>         struct generic_pm_domain genpd;
> @@ -50,7 +51,7 @@ static int imx93_pd_on(struct generic_pm_domain *genpd)
>         writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>
>         ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> -                                !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
> +                                !(val & FUNC_STAT_SSAR_STAT_MASK), 1, 10000);
>         if (ret) {
>                 dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
>                 return ret;
> @@ -72,7 +73,7 @@ static int imx93_pd_off(struct generic_pm_domain *genpd)
>         writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>
>         ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> -                                val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
> +                                val & FUNC_STAT_PSW_STAT_MASK, 1, 10000);
>         if (ret) {
>                 dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
>                 return ret;
> --
> 2.37.1
>

