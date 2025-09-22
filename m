Return-Path: <stable+bounces-180984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12068B92100
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DF8169747
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E10302164;
	Mon, 22 Sep 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AJj3luLd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C87307486;
	Mon, 22 Sep 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556383; cv=none; b=Wu88HAOhbKdvYW3pKYNBYd5NkYRvDEOKuLRDOQquWv1OgMbn6U2ZRXYGwVbpBmsmPVbi15QK9LxxTt9k+6SyaJwj4t7GrAOO1WOLRB7Zm0TLc5bRm+thXj7SYDbaNwevqgDQlIcHcSh9L5r+AomgLlAu7pPtGxJMrbnOGqbcbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556383; c=relaxed/simple;
	bh=Ffwye/JbVrXIKu8cIrK/pOcB8IdFpHDSAu6vrUoG2SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOI3/EGjvd3xBTtaP9VYe6F5DbB3VnSLNVu/KNNeb/a2MLCPsJlMLGIlsO2xccJZBz5RZwSYgCFgu0LhV5dZdN/7U9lPToprKLlhj/23Yim9gVK7/EAD7f1MxKpS3hgnY+6G9ULVcHIpZdEW88fI/NTzhUb2y6M5HXBkWGV1Kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AJj3luLd; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 0ihNv1uZQ6fJ30ihNvRBh2; Mon, 22 Sep 2025 17:43:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758555813;
	bh=FkpL0tmHxowKoCQg6KgQE7aVVXQ8VXFIV/me0DgJOe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AJj3luLdsdZm6Hh9cs8v3hu1Xrx/xtjz6njOnl5bdrsltRGWoLkcpzbo3ji7oS6mC
	 5YZaQyvvjYyK1wwjrJP8l42XJEaw/Dq5KvFKbSBJWHzyAk+lqlHGJtxMIGEHBwgsf3
	 pYd8pmC4hcZpAGD3ZdEPKpVlCzjgF8D97oDt92/q7T6CTj7umly4owlqUQfQSZ+sZw
	 Zf/Kw+b9ryh7irWVLdjOEhvLQ2DEfal6jZBAZiSy5YmyFLth7HKC3Y17SdKeVQdC0l
	 iC53qyWGA6KOu0Y98FUDUUbm0XISxieirL48iwVUOnd0qPfRJMgpsWp3P2EwI9YZN0
	 DB2lcqiMlrCRw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 22 Sep 2025 17:43:33 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <dcb6023b-8c14-4bbd-9bac-2933e91ef553@wanadoo.fr>
Date: Mon, 22 Sep 2025 17:43:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: mediatek: mt8365: Add check for devm_kcalloc()
 in mt8365_afe_suspend()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20250922153448.1824447-1-lgs201920130244@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250922153448.1824447-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/09/2025 à 17:34, Guangshuo Li a écrit :
> devm_kcalloc() may fail. mt8365_afe_suspend() uses afe->reg_back_up
> unconditionally after allocation and writes afe->reg_back_up[i], which
> can lead to a NULL pointer dereference under low-memory conditions.
> 
> Add a NULL check and bail out with -ENOMEM, making sure to disable the
> main clock via the existing error path to keep clock state balanced.
> 
> Fixes: e1991d102bc2 ("ASoC: mediatek: mt8365: Add the AFE driver support")
> Cc: stable@vger.kernel.org
> ---
> changelog:
> v2:
> - Return -ENOMEM directly on allocation failure without goto/label.
> - Disable the main clock before returning to keep clock state balanced.
> 
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

This should be above the ---

> ---
>   sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
> index 10793bbe9275..55d832e05072 100644
> --- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
> @@ -1975,11 +1975,15 @@ static int mt8365_afe_suspend(struct device *dev)
>   
>   	mt8365_afe_enable_main_clk(afe);
>   
> -	if (!afe->reg_back_up)
> +	if (!afe->reg_back_up) {
>   		afe->reg_back_up =
>   			devm_kcalloc(dev, afe->reg_back_up_list_num,
> -				     sizeof(unsigned int), GFP_KERNEL);
> -
> +				    sizeof(unsigned int), GFP_KERNEL);

you should not remove a space here.

CJ

> +		if (!afe->reg_back_up) {
> +			mt8365_afe_disable_main_clk(afe);
> +			return -ENOMEM;
> +		}
> +	}
>   	for (i = 0; i < afe->reg_back_up_list_num; i++)
>   		regmap_read(regmap, afe->reg_back_up_list[i],
>   			    &afe->reg_back_up[i]);


