Return-Path: <stable+bounces-203446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303BCE523D
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 16:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E44A3010A8B
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A832D130B;
	Sun, 28 Dec 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcvCiOS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA228C854
	for <stable@vger.kernel.org>; Sun, 28 Dec 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937105; cv=none; b=ufO+0Xs+Rl8NuvgMexveknJRAnUl9dtQ5891bDe4U2jm4c+wI/63dsFLCHF0tOiharQnXOkBZRQ1LUAOIoVF12Uh16eTZ64zf5ZeEhVXosKV1lZmmBdTpIP8rQkMeMKW0eYvr6sUXlMbLUG20FVGXW3Tw1FRVRMpry1M0f4N3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937105; c=relaxed/simple;
	bh=UPBdwscMbeewUmZS1YlHhhaecNMpTlEwPf4hXKqUXHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfJ5R2q91SXpSCU901FFQGgg9Vt60H1wlc1JzgSRquq7XMgjXqpjjer9SZvteoy3tTTB8YaKwbDC2FRR1ixQsWKTWCZ4ixWv7uHDfdhroxxEBGV9IhNg7LFBQyYU6PczrjOuzL1AwB+MhbepbDOWbo4uTGKDOXAIszCPARe9uuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcvCiOS7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37d056f5703so62608371fa.0
        for <stable@vger.kernel.org>; Sun, 28 Dec 2025 07:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937101; x=1767541901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMOElam5lFCQ00bwoN+FTpOkP8287mrJpVz34H2qYuM=;
        b=PcvCiOS73VXBn6sRUI444KBAO4fdbHDHkyCBrg6DWDD4JyRDbwpFpQ4LCC1bvghGNa
         10GsuO/8Ywny8uh+D7+bYNA/q0b08kjJv4/NGj69EfW+Xv8tJLLSsVBKCvkMAoG8W2wK
         mWrGHVM7IPqgC3RdQjihLokW8i4tHquXiUB0pojSmZCv/iqCRP6HrzW09AM4X2S8HWZs
         m6YsnsvBglvQe9i6j0ogBfmFwb/9tPKKmOJMgBvFO6VsgP0IDUz+rWIQAyGNijafHnaE
         JymhUEpJ91CIrQjUrmTI6tnmOXh3cJ3XAuffGXnJ4W1CEvstW836H+++YFP1tjlYOZ45
         zkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937101; x=1767541901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMOElam5lFCQ00bwoN+FTpOkP8287mrJpVz34H2qYuM=;
        b=RUMAApvRG1h2E3J0VKEQ5M0KZDFsvMsmHA6qtkMyAeasXZRERISbZdibU3OJhylRqc
         +6zxCXHhNCC+/SX/2HsGoKzROeEf/LtOc29wocGVtZkUnvMamNR0fYpsGcVZKZF1W7z4
         iPWvAwEen5SQoIaSi1gSqyvXDDYJMKgYh2xAbw4Xmuw90U7dMVQURRTufwxR10gXJ4sa
         OkXfQWcHt4G/C2fV0UMaj9PWbwoMn0HojZWqP6BgbMX0nt55nG1Zrpj5CS0sERQVxTMY
         ETgZJJn7pE4dQARI8UA4/9Cr0HR2X2oyRHF1fF5YywC1Q9N75dNsSmfp8ypt+KYsqo93
         /pGA==
X-Forwarded-Encrypted: i=1; AJvYcCWrmqiUydmTqziFrnFYYxjbo+3kGCGu08mRqWpf2D7xs4wq3LbfdRYp306vihKC+VE2C1hqEeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxNrel407BHIsXPryze4tlpRbkYBTa4YffvK3ipTc08XEmSO1
	xyhpk6PhjhKpCjgwzuMHjzGMEtkUUyyTf+7S0TfJd2kjzW7JrlsQ/XVmuHpHa4EcqyGMRWkWdy3
	nilYXqJvIyPJ9Q7pLi/oDPgoIR9tpLld732A+/NKOww==
X-Gm-Gg: AY/fxX7Q+dYWdZz3G+HZ8WCB9l73H90wxRQUI4/l/vI8tyP9iUnbCk6x/OVaiAMrMVf
	ahqzX8V58Y5LTDwPjB8c8b3TPg9gtqAD2ltY7GlA6W/HlSWWLrDfFqOoTZ2gee+rW5H7YjXPao6
	em9BI417uwFt89V3d4LxISZ07YxunpU51fuV/uDa2ZpQHbz9KPKGl7wG2Q+T6OiueZ1J5CekZt2
	ktNh+rG1Lc+wQm7Mu/4HaPqor6Elxc0HL/zVoq2zgTqjmpr+0OqSlzGM0BuG6L0M/2ypahO
X-Google-Smtp-Source: AGHT+IHLUFVsnwRwkLFb3Tq4L6Zc3f/V8NutlxDmQ4VBL3ts9a5/EsxCVdAPRyCi+loA38VXEQC6iUojrpiM88ffZ7E=
X-Received: by 2002:a2e:a913:0:b0:37b:ba96:ce07 with SMTP id
 38308e7fff4ca-38121596892mr81755101fa.15.1766937100554; Sun, 28 Dec 2025
 07:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211040252.497759-1-vulab@iscas.ac.cn>
In-Reply-To: <20251211040252.497759-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:04 +0100
X-Gm-Features: AQt7F2q4HOmCP3AtHKfQGHLB3c99yZpMtVEIsP3Gmo2gfisxBcr_gBvsZWBQEl4
Message-ID: <CAPDyKFrPZqwDmgFuPfbpX+FF3-r9F-r+9+Mm5v8z5Wb7TQJvmg@mail.gmail.com>
Subject: Re: [PATCH v4] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 05:03, Wentao Liang <vulab@iscas.ac.cn> wrote:
>
> of_get_child_by_name() returns a node pointer with refcount incremented.
> Use the __free() attribute to manage the pgc_node reference, ensuring
> automatic of_node_put() cleanup when pgc_node goes out of scope.
>
> This eliminates the need for explicit error handling paths and avoids
> reference count leaks.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied for fixes, thanks!

Kind regards
Uffe


>
> ---
> Change in V4:
> - Fix typo error in code
>
> Change in V3:
> - Ensure variable is assigned when using cleanup attribute
>
> Change in V2:
> - Use __free() attribute instead of explicit of_node_put() calls
> ---
>  drivers/pmdomain/imx/gpc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index f18c7e6e75dd..56a78cc86584 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -403,13 +403,12 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
>  static int imx_gpc_probe(struct platform_device *pdev)
>  {
>         const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
> -       struct device_node *pgc_node;
> +       struct device_node *pgc_node __free(device_node)
> +               = of_get_child_by_name(pdev->dev.of_node, "pgc");
>         struct regmap *regmap;
>         void __iomem *base;
>         int ret;
>
> -       pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> -
>         /* bail out if DT too old and doesn't provide the necessary info */
>         if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>             !pgc_node)
> --
> 2.34.1
>
>

