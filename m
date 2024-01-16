Return-Path: <stable+bounces-11333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1764B82ED74
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FB11C231F9
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18931B81B;
	Tue, 16 Jan 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGLyEaeL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1BA1B7EF
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3376ead25e1so7622641f8f.3
        for <stable@vger.kernel.org>; Tue, 16 Jan 2024 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705403508; x=1706008308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3/2mxTMu2HoI1Jv/k7hB7V1HLoXtW33tUIuUh5/szw=;
        b=FGLyEaeLFttqdgGh6OR8zpWpP697XAPgOkl995PZcG6mj4JWvvKZZLSpJbJdQGlI33
         xh14QvxqsyOSguzWp6Cv5hs05q7nLfdVHdBneyNLAqge3d3QvPRPmtllRiXnNBhN3dyq
         Rf5sb/uZNFsqSIvjr4nf6pKqIZF/xX6uhUMi26z2m0EU5N+ognkdyTYy6VfN5dhC7/bP
         qe6ilYAnmThY/TQiY2JuZMj/fhQmvEDYFJWGl9kuGMBSH2FeDBL9r/SjmyY7LbB2TaQO
         RUIE0mHOb9mokhCN56dEc/hkEFgS4Acr6sLKR6R0x6uJ/EoFclPJRJa6uh+3edkmnDgc
         Q3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403508; x=1706008308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3/2mxTMu2HoI1Jv/k7hB7V1HLoXtW33tUIuUh5/szw=;
        b=NeAyDJEVc83PKrk3dVAzQ3Oeab/yTIBu76ELJFr8wd9MwsHukLK7gojny5d2/HHhlt
         BRuUIfXAsgnvXlN+upFwfIBIRUjsoY1T2vCbWgCSNWuT2fa/QXofy337pCyiYIBBOROs
         WoZRkLCKtUF+r2ASjp2jdLwS2ndh7onz/52ye8A0GkRC7Cb5cGOzXl0baLkoVWlc0xhL
         PVLt2tQbUP6v6FE9/cMyDR/54IiL8SxnkKFNnH+sqlP/hfmTPF7HoAyEPx33Gv2i2dor
         TabhndKbj48N3aA0JRDw1u4A44u/NXan/fDkY6URyaEGpBa7fsgIWLS5ym2VD/DKbwyu
         F7+g==
X-Gm-Message-State: AOJu0YxHgMPYh+bD6KGOBfxXG8MNAVbsnTlcwK+1R5NBweoTdA6PdQnQ
	7v3vcUX/gnRYWTMXQGkJG6T97qDlnW5P2w==
X-Google-Smtp-Source: AGHT+IEvcX7jOOP20mKvB6k51ceMA1wWTsYpVIS9UashjuFwSv4C1JzPa/zSeg1loQ2qcxWtv1b5Gg==
X-Received: by 2002:a05:600c:4451:b0:40e:71e3:139d with SMTP id v17-20020a05600c445100b0040e71e3139dmr2071966wmn.154.1705403508583;
        Tue, 16 Jan 2024 03:11:48 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id iw7-20020a05600c54c700b0040d604dea3bsm18593723wmb.4.2024.01.16.03.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:11:48 -0800 (PST)
Message-ID: <1cc50979-741b-4341-9e9e-2fdee1dd2e65@linaro.org>
Date: Tue, 16 Jan 2024 11:11:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] ASoC: qcom: sc8280xp: limit speaker volumes
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240116093903.19403-1-johan+linaro@kernel.org>
 <20240116093903.19403-2-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240116093903.19403-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/01/2024 09:38, Johan Hovold wrote:
> The current UCM configuration sets the speaker PA volume to 15 dB when
> enabling the speakers but this does not prevent the user from increasing
> the volume further.
> 
> Limit the PA volume to 15 dB in the machine driver to reduce the risk of
> speaker damage until we have active speaker protection in place.
> 
> Note that this will probably need to be generalised using
> machine-specific limits, but a common limit should do for now.
> 
> Cc: stable@vger.kernel.org	# 6.5
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

LGTM, We can get rid of this limit once we have Speaker protection inplace.


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

> ---
>   sound/soc/qcom/sc8280xp.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index ed4bb551bfbb..aa43903421f5 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>   	case WSA_CODEC_DMA_RX_0:
>   	case WSA_CODEC_DMA_RX_1:
>   		/*
> -		 * set limit of 0dB on Digital Volume for Speakers,
> -		 * this can prevent damage of speakers to some extent without
> -		 * active speaker protection
> +		 * Set limit of 0 dB on Digital Volume and 15 dB on PA Volume
> +		 * to reduce the risk of speaker damage until we have active
> +		 * speaker protection in place.
>   		 */
>   		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
>   		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
> +		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 12);
> +		snd_soc_limit_volume(card, "SpkrRight PA Volume", 12);
>   		break;
>   	default:
>   		break;

