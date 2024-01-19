Return-Path: <stable+bounces-12244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90611832515
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 08:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FCB286449
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880FCA4E;
	Fri, 19 Jan 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5+KXAKQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376ED50F
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649838; cv=none; b=sY1ZTNrPPhTNgbxZr4Ku/dS00r4/HRQ1mBFv0UsZCTjG3Yw8LPeQewD4AuMJ9vUCP4/+ZJa8x2OeVvGJTdltJ1nqadrt4b5C0yKLV2aTu4uvSVgaYuNXFMvSbHpg0r624oUpIaJs62ngmILNRcw2PdStNvmsvKcZXJESXSdvjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649838; c=relaxed/simple;
	bh=wnMv6grck/8JUvYsXcxoc9iHXWWkN00HXHmU8cOzKA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFwtBokA8rWZogZVpBlhxWjlf5pS3Sr9eHj1GB19J/GTcNCL7GUIuJ/E1V/lRyOfOhRARMW9Dz3/9ZTBk7vVGyVJtJ7VZdLFaIMzxByhbbNq4OzhqF5Qe+rycAYaWWslkWOTHzQRVkP9O8YAT0DYv8fpl9M50nXNf5r5PXLthBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I5+KXAKQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e775695c6so4118905e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 23:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705649835; x=1706254635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRVEGEADVnU1rj2ZsZLhkpAgQRXYe6tlf4fK3vtgXN8=;
        b=I5+KXAKQik2A/4uaJFwGY78VJkT3ikShSZt9pp+gU0mn96D7lMYsT1IEABJZacB0Bk
         uuxcQ2gR8sczJ8eV7KM9CH9rqVdKZ+MROm1xyCpuaZu0/B0mmgiaspPl84O+DEnrN3Hr
         Rh5HkvwEpAaCZGtH17deI3J+MVD/dl9VXTTXVD+375JzbOoYztyCYhn529TONifCihvX
         aw78e2LQtEOJcD+CnlRKNgHDVB4SbDmCMX3931jUSs8gasXkJM38qrvVWdpjq1EIyU8Q
         xvNaDr+p/gp8PA0VvDu6BcK1rdpmkltlK0AeIrdzfp1tDJpbYBC1jyAJsKDv+9EKiW8U
         p9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705649835; x=1706254635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRVEGEADVnU1rj2ZsZLhkpAgQRXYe6tlf4fK3vtgXN8=;
        b=gMcoizOX3hKQlDYuf/p4FKnQ7/JTn34Rmehs4YWgn9ums3qccYaYcmB/WjNyxRoLZE
         /8MaBLB5Y0co8bDoA+LxrdGROmpPK1knn0553S5VSI4HBxB5lxM370D2Ymq5ipsPUSWi
         fYP1KGRjyi10rEz2sDkxYpy2nAB9UGbwiXJCs+xPIrNSlHn34ZydPl9gOHoUbFA3JDuf
         4WAXiOojoPQ1CKeNaCBWsvE71EwuKkr62NFuhSZUrJccBENYyYGM2szKdEZMpm9NMnfe
         HMrBLkSm4lCc/mQ6fkBzCLaHRHuDfZsCEi5vBmC03R9F9RJOFh288KIT5uam3skGzq3M
         O0QA==
X-Gm-Message-State: AOJu0YxOOmu3sy9W1/zp4j/vRz/WuwZ1ljkiAHDf1SOXWbO7piaVhCU5
	ucQCLxgTVCKGc/E1qYWpuZ8DMyI6h8R7CcdEVKEhHCWdJW1/1ZrHK/MJkJkLO/j0TV563I3yRMj
	I
X-Google-Smtp-Source: AGHT+IGuGmikPGSsHZHY9FIadEyh4MkIKPIZmnPKnfXBLGan0KHUJRVxzqp0unv1usUGifgHR7kXog==
X-Received: by 2002:a7b:cbd7:0:b0:40d:87eb:fa98 with SMTP id n23-20020a7bcbd7000000b0040d87ebfa98mr1344916wmi.28.1705649835643;
        Thu, 18 Jan 2024 23:37:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm31782328wmq.44.2024.01.18.23.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:37:15 -0800 (PST)
Message-ID: <ac6eb9f9-9a5c-472d-9a57-ee509d9589f9@linaro.org>
Date: Fri, 19 Jan 2024 07:37:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] ASoC: qcom: sc8280xp: limit speaker volumes
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-4-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/01/2024 16:58, Johan Hovold wrote:
> The UCM configuration for the Lenovo ThinkPad X13s has up until now
> been setting the speaker PA volume to -3 dB when enabling the speakers,
> but this does not prevent the user from increasing the volume further.
> 
> Limit the PA volume to -3 dB in the machine driver to reduce the risk of
> speaker damage until we have active speaker protection in place.
> 
> Note that this will probably need to be generalised using
> machine-specific limits, but a common limit should do for now.
> 
> Cc: stable@vger.kernel.org	# 6.5
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/qcom/sc8280xp.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index ed4bb551bfbb..a19bfa354af8 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>   	case WSA_CODEC_DMA_RX_0:
>   	case WSA_CODEC_DMA_RX_1:
>   		/*
> -		 * set limit of 0dB on Digital Volume for Speakers,
> -		 * this can prevent damage of speakers to some extent without
> -		 * active speaker protection
> +		 * Set limit of 0 dB on Digital Volume and -3 dB on PA Volume
> +		 * to reduce the risk of speaker damage until we have active
> +		 * speaker protection in place.

I would prefer a 0dB here instead of -3dB, this could become issue if we 
are testing speakers without any pluseaudio or any software 
amplification. ex: console


>   		 */
>   		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
>   		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
> +		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 1);
> +		snd_soc_limit_volume(card, "SpkrRight PA Volume", 1)

It would be nice to consider using component->name_prefix here.


thanks,
srini
;

>   		break;
>   	default:
>   		break;

