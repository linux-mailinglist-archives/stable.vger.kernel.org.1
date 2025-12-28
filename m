Return-Path: <stable+bounces-203447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29116CE522B
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 16:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9866F3002977
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5E2D130B;
	Sun, 28 Dec 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRB8Vix5"
X-Original-To: Stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265E1F1315
	for <Stable@vger.kernel.org>; Sun, 28 Dec 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937111; cv=none; b=Ayxca/o34lmRyQVmm3zZt2PYdnO8NacPBrBwGAuJsjm0WBJd6Kd6y1Dcp1JmckHDYFqx1EV/KQ/gB0dDc2M5TLko1H1O3YLTz3Zi95tVd8BWC8v37BAgO4GrXKzsYFZt4MeTNuciIjHor+krkkSciwOYXOFS80FErEqdcWmIO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937111; c=relaxed/simple;
	bh=Bkavqw10CnB9Sonw91bjgCl8Du/CzS1634r7L7bue2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQj8MRQ2G9yxdWRit7+cNBUv3EZatZ+ljyazjzd+aFOEsTAxKTWaq3idAP7NYQwSGg01gU+WstWIq3Oe4rwwyhTbkxOwCzXHqVnGhII+wjqr2tyEY7o/siEUFb66Z4+xYZkfEJWV7vI+GiZaPQ8GhatWlJF2JqjE7UIR0keCZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRB8Vix5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso9504337e87.3
        for <Stable@vger.kernel.org>; Sun, 28 Dec 2025 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937108; x=1767541908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xDt2nU/HCGuLKi4YQDj2IaYM1PBWLEa/ggxeMOrlmyU=;
        b=jRB8Vix5SUdD0H2nrMady1nzSBAF4AOYCsr40neia5s51XYopy5Sdw3kaaReLa/vwG
         1duHP4sth6/GD4k0eQC+c7x470sc4UnlEIFI9HOikDzggckyOgCORVeIn1DZvSzEaVTx
         78s6wiJS26u6Br3vqwuH7eb4zzYryntdZgmx09Kl6o4hZduhGNY3VcCzmN2B1+qzgUqP
         6eKcZOYAVkrnKFJqJi36Jh7ys/KSLhfXgAuDsqpkDwYjsgKDq8RVIzgTH0FaQ6x4zamt
         oWSZK4e0l8MVRENU4KJ0nVu9OAbDKm8Zb00qfzN+W3aYX2qABktIT3Nq48F4hZdiR3u6
         KZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937108; x=1767541908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDt2nU/HCGuLKi4YQDj2IaYM1PBWLEa/ggxeMOrlmyU=;
        b=BseEbx8/aPx9BWHGFq4HNuvKxjEUbbv8udHVpYsMhVP7F3LZrxZfoGSA+KRMtyuMu0
         izUt9eRbMeTH/1HkO0cK7zKJoHnd+P2Ly8LVXGfEcaLuMehiPigFKG+ell+zsNOspsHt
         SF53he9LLkvkZdUOb3ElW7N/M1t/fJlPrZJ5ym8sjZEXrTwkAfSnEh4OwJ9uv3/Sc5W6
         Mqm8rA74EG7AK7O6uDpDaCyaT8YgyZAb9xbmg7wfeUSBnL6NaoaNNWb/UXj0pY0nzBZx
         igX6/pvcGJmwBifo+qqiqIudQCG5VWuy61vlLCbVFTbgDYIWI4uY5qcAn2/a77tw07Qo
         D1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4uF26kOnNNGB8qlG1Eo4K7KHN0clJfznjgWbTqqPaQPFCF/tSKcWm+aXUTurkdvRjNVFQya8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucowcCIWAbWGNJJ44MVtXetn0tr/2JAH/cmIVN621vkHgTlpP
	oi85DnY6i5R0k15I/votIwhSBFzAC+Dl+AoWB0BvGEcJx9X34MCjmEkS0Od+E8QEX4wEcGyPuoq
	Xw28fjEkah7wPar24N+rVcUnX6uSpfUv5LT09JnJGPg==
X-Gm-Gg: AY/fxX5Qq8aSk77vjB/Pvoi6FBY1aPX9JrQxAKUexFPmaR0uQu4bi8rVf4AlYszzvVa
	ND5D7CV8O13kblj8pHC4iPx6ciF+XazgXz1yRr6YLGSYlqHP/i74JfOggQExkB6Z9HMsZ/DSRLP
	IIXwIxGgUF/VDB3pxzzyD1gmrvVnA39Ji9qfnhVB1mhs8aBfebfcBAEiwW/547jW/PNvnqL3ASu
	+rkN8VrNzUzncWvrXSdN3xHB5YcxBAYvgfHkLiSe5t0yZCysgaGysswPL94w7rAal8bgb0fXf1j
	RqV0Hqk=
X-Google-Smtp-Source: AGHT+IGU1N8QBbdq+8B2sBGxa7sL3yjutJLHsa+eD4d/4O/IOXbvlkTxqF+kvhbF6vdkbcVRxjuHnPzltz+HFIkKUD8=
X-Received: by 2002:a05:6512:124f:b0:599:105a:67ce with SMTP id
 2adb3069b0e04-59a17d727c3mr8952951e87.9.1766937107517; Sun, 28 Dec 2025
 07:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128041722.3540037-1-macpaul.lin@mediatek.com>
In-Reply-To: <20251128041722.3540037-1-macpaul.lin@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:11 +0100
X-Gm-Features: AQt7F2rKehWvSimlxiGz9Dfw_4j8BvE8_7xLSPYZyFy88f7zjPyzLM7SIUxe60A
Message-ID: <CAPDyKFranQ=UU5waLcw27E4SG30bps80DmGs+zZs6N9=iZa_zg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mtk-pm-domains: improve spinlock recursion
 fix in probe with correcting reference count
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Weiyi Lu <Weiyi.Lu@mediatek.com>, Jian Hui Lee <jianhui.lee@canonical.com>, 
	Irving-CH Lin <Irving-CH.Lin@mediatek.com>, conor@kernel.org, krzk@kernel.org, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 05:17, Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>
> Remove scpsys_get_legacy_regmap(), replacing its usage with
> of_find_node_with_property().  Explicitly call of_node_get(np) before each
> of_find_node_with_property() to maintain correct node reference counting.
>
> The of_find_node_with_property() function "consumes" its input by calling
> of_node_put() internally, whether or not it finds a match.
> Currently, dev->of_node (np) is passed multiple times in sequence without
> incrementing its reference count, causing it to be decremented multiple times
> and risking early memory release.
>
> Adding of_node_get(np) before each call balances the reference count,
> preventing premature node release.
>
> Fixes: c1bac49fe91f ("pmdomains: mtk-pm-domains: Fix spinlock recursion in probe")
> Cc: Stable@vger.kernel.org
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Applied for fixes, thanks!

Kind regards
Uffe



> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> Changes for v2:
>  - Rewording commit message.
>  - Add Fixes: and Tested-by: tag, thanks.
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 80561d27f2b2..f64f24d520dd 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -984,18 +984,6 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
>         }
>  }
>
> -static struct device_node *scpsys_get_legacy_regmap(struct device_node *np, const char *pn)
> -{
> -       struct device_node *local_node;
> -
> -       for_each_child_of_node(np, local_node) {
> -               if (of_property_present(local_node, pn))
> -                       return local_node;
> -       }
> -
> -       return NULL;
> -}
> -
>  static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *scpsys)
>  {
>         const u8 bp_blocks[3] = {
> @@ -1017,7 +1005,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>          * this makes it then possible to allocate the array of bus_prot
>          * regmaps and convert all to the new style handling.
>          */
> -       node = scpsys_get_legacy_regmap(np, "mediatek,infracfg");
> +       of_node_get(np);
> +       node = of_find_node_with_property(np, "mediatek,infracfg");
>         if (node) {
>                 regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
>                 of_node_put(node);
> @@ -1030,7 +1019,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>                 regmap[0] = NULL;
>         }
>
> -       node = scpsys_get_legacy_regmap(np, "mediatek,smi");
> +       of_node_get(np);
> +       node = of_find_node_with_property(np, "mediatek,smi");
>         if (node) {
>                 smi_np = of_parse_phandle(node, "mediatek,smi", 0);
>                 of_node_put(node);
> @@ -1048,7 +1038,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>                 regmap[1] = NULL;
>         }
>
> -       node = scpsys_get_legacy_regmap(np, "mediatek,infracfg-nao");
> +       of_node_get(np);
> +       node = of_find_node_with_property(np, "mediatek,infracfg-nao");
>         if (node) {
>                 regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
>                 num_regmaps++;
> --
> 2.45.2
>

