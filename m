Return-Path: <stable+bounces-180544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317CB8548D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19909B61B85
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AFE2D7DFC;
	Thu, 18 Sep 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YCXsqEsh"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE021CC63;
	Thu, 18 Sep 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206255; cv=none; b=seI+WYgDhsO/zWt8O83wlZwpmmL7yYw6emj41DNEYbifLp/mA8pJZj2VklFuWKU2zEpmLtaO240fuWkQwqJy+D260tkGcZQpux9bz7YHg7n9ZF4DTBn+zoTTvWdh9k/EgB56ACsxiizu1LlY5P5z46BgJ+P7DJlaYJyR+JWQjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206255; c=relaxed/simple;
	bh=4hr9rb0pYa4kk0rjOBPob6luIbfpKkRsa9dhKhkV/gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNujms2YaAbU0myMd/csB9xLmnEk/YZ7dZtfsZlyRH0ecnXA94fwREvakOQpjMptvJmdS7E697B+jjKZJ4SKyyGG0uvTEderngAwV3s3F4dR1OMa52AcMl1vZN1KU6RmF3sifYZPM2kdXtKpOapbUIG3BEcxg18l3LIOfC0sXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YCXsqEsh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758206251;
	bh=4hr9rb0pYa4kk0rjOBPob6luIbfpKkRsa9dhKhkV/gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCXsqEshUU3oC8vSADi0fwGu7/Qk89HQVbpwmQdk0UYTC4ezWdlIW7ygx8Rj4jDZw
	 /QZMUXuIILEsTyIlC8a74n715k5infeKOhzHwOQEuKQgqSPCmTBZf8ug/X9VhdJ1oL
	 bTgYV7iXzLRZeg8OgSTblUbiRkRdZk8mAQaJJg2iiwAofn6Bl/+GJMrkdGybUibqSe
	 uwEU0e06NgcZQWtgk+XfIV+gG5r+Bf4BX2Y65PCvPQpsppuU7ArjCYUB2AICnGdQ1R
	 krpaRKeV3CqVIwYk1S/D/okrEBDbl2hajRho8jeAfz8KP0xn1aYBaK5Q2XRAJxyI7P
	 3GQFLD6IsO7/A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C65D917E12C4;
	Thu, 18 Sep 2025 16:37:30 +0200 (CEST)
Message-ID: <71f50716-2f8b-432b-970c-9436fa181856@collabora.com>
Date: Thu, 18 Sep 2025 16:37:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8365: Add check for devm_kcalloc() in
 mt8365_afe_suspend()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20250918140758.3583830-1-lgs201920130244@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250918140758.3583830-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/09/25 16:07, Guangshuo Li ha scritto:
> devm_kcalloc() may fail. mt8365_afe_suspend() uses afe->reg_back_up
> unconditionally after allocation and writes afe->reg_back_up[i], which
> can lead to a NULL pointer dereference under low-memory conditions.
> 
> Add a NULL check and bail out with -ENOMEM, making sure to disable the
> main clock via the existing error path to keep clock state balanced.
> 
> Fixes: e1991d102bc2 ("ASoC: mediatek: mt8365: Add the AFE driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
> index 10793bbe9275..9f398d1249ce 100644
> --- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
> @@ -1971,22 +1971,26 @@ static int mt8365_afe_suspend(struct device *dev)
>   {
>   	struct mtk_base_afe *afe = dev_get_drvdata(dev);
>   	struct regmap *regmap = afe->regmap;
> -	int i;
> +	int i, ret = 0;
>   
>   	mt8365_afe_enable_main_clk(afe);
>   
> -	if (!afe->reg_back_up)
> -		afe->reg_back_up =
> -			devm_kcalloc(dev, afe->reg_back_up_list_num,
> -				     sizeof(unsigned int), GFP_KERNEL);
> +	if (!afe->reg_back_up) {
> +		afe->reg_back_up = devm_kcalloc(dev, afe->reg_back_up_list_num,
> +						sizeof(unsigned int), GFP_KERNEL);

Nothing else can fail, so using a label here is unnecessary.

		if (!afe->reg_back_up) {
			mt8365_afe_disable_main_clk(afe);
			return -ENOMEM;
		}

This makes you able to avoid adding a `ret` variable, and also the goto.

Cheers,
Angelo



