Return-Path: <stable+bounces-11332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C02182ED68
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CF51C2315C
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43B1B7F4;
	Tue, 16 Jan 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVhsvvYQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6118EB1
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337be1326e3so212377f8f.2
        for <stable@vger.kernel.org>; Tue, 16 Jan 2024 03:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705403424; x=1706008224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJJy6fD6/lLKmXLx1a8nLqcyCrMSlt89VNd+fRBzGBo=;
        b=XVhsvvYQv2H3MmfN1xPniSP6gkdNp5mN8u64v2llaj4tVrJixTXcPHtRA4EGaqEpay
         xUoMp3SNDvqgvi15O1/6CXQp2H9uY5g4NYppEnnrYgk2BAcpE46Puxw2Z8I8v2nQRQ93
         iPRwHfqMiyJnc1btqCIfFlYsECXaXSGzfXQvHyJj+uHlOtuzeWUAvs6jlskKekhSHpek
         sXSJKsMCvNosPKmkh23zzPGxNMdZLGNcIrmMYYi4xlvRea4iLT60L+s0r3WKdj/sDY2K
         YT+yP3VNBmObHQWwVoF3BZJtlEn0h1B5eW3hR3jniH95kCKxueOssgjqGyGo2DGiqQdP
         OJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403424; x=1706008224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJJy6fD6/lLKmXLx1a8nLqcyCrMSlt89VNd+fRBzGBo=;
        b=txaLo5kix/C266/HMJqQ3BqMnEr9DuhfLpQ+AkkqTqd+N0h5a/waM+qaibeWKJ+ktK
         eN0XnvucbwjjmKDrTm+P3oih+Jkz3ycl12iNOn7fcrvBtYf+GROMBWe08iIFca/Wkvt9
         sep4x5LRTUmTEKiqDXEL0uHmOZUft4U4Kq950sGlr6GMOwyL7iPypHxLky/bAsQ/pulq
         7zOh/3lFO6pPaYmPU+7Bh/1HvoE47WXJqdC7P19SX62MCQv1C3dsdiU/5i3AOUGLjZCJ
         e0IrHFZMe0CZvbgLFA8mSlAuMSO5VIfY+jjifbVWKmYozyaJN4pnytegV+erUBOs1Wkc
         QPSw==
X-Gm-Message-State: AOJu0YwuO3d0Stbp0fBjA/bxlximEpFLlHz6sLGrSfpTZs4vPaHvzhVy
	DvDW65hspLvI+1tAthXR5EmbSHFQMXulVA==
X-Google-Smtp-Source: AGHT+IEEkCSG4k8XHy6r0V/74OqUmJeKY1nvqmtsrCsVsxsyDA1c5yy/u7DZ68mrLYvI6MgazVKOrw==
X-Received: by 2002:a05:600c:4d95:b0:40e:5577:17e with SMTP id v21-20020a05600c4d9500b0040e5577017emr4116191wmp.57.1705403423647;
        Tue, 16 Jan 2024 03:10:23 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id iw7-20020a05600c54c700b0040d604dea3bsm18593723wmb.4.2024.01.16.03.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:10:22 -0800 (PST)
Message-ID: <8bb1cad6-6a85-444a-b881-c03ab0051009@linaro.org>
Date: Tue, 16 Jan 2024 11:10:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ASoC: codecs: lpass-wsa-macro: fix compander volume
 hack
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240116093903.19403-1-johan+linaro@kernel.org>
 <20240116093903.19403-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240116093903.19403-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Johan for this patch,

On 16/01/2024 09:38, Johan Hovold wrote:
> The LPASS WSA macro codec driver is updating the digital gain settings
> behind the back of user space on DAPM events if companding has been
> enabled.
> 
> As compander control is exported to user space, this can result in the
> digital gain setting being incremented (or decremented) every time the
> sound server is started and the codec suspended depending on what the
> UCM configuration looks like.
> 
> Soon enough playback will become distorted (or too quiet).
> 
> This is specifically a problem on the Lenovo ThinkPad X13s as this
> bypasses the limit for the digital gain setting that has been set by the
> machine driver.
> 
> Fix this by simply dropping the compander gain hack. If someone cares
> about modelling the impact of the compander setting this can possibly be
> done by exporting it as a volume control later.
> 
This is not a hack, wsa codec requires gain to be programmed after the 
clk is enabled for that particular interpolator.

However I agree with you on programming the gain that is different to 
what user set it.

This is because of unimplemented or half baked implementation of half-db 
feature of gain control in this codec.

We can clean that half baked implementation for now and still continue 
to program the gain values after the clks are enabled.

lets remove spkr_gain_offset and associated code paths in this codec, 
which should fix the issue that you have reported and still do the right 
thing of programming gain after clks are enabled.

thanks,
Srini


> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Cc: stable@vger.kernel.org      # 5.11
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/codecs/lpass-wsa-macro.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 7e21cec3c2fb..7de221464d47 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1583,8 +1583,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>   	u16 gain_reg;
>   	u16 reg;
> -	int val;
> -	int offset_val = 0;
>   	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>   
>   	if (w->shift == WSA_MACRO_COMP1) {
> @@ -1623,11 +1621,7 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
>   					CDC_WSA_RX_PGA_HALF_DB_MASK,
>   					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> -			offset_val = -2;
>   		}
> -		val = snd_soc_component_read(component, gain_reg);
> -		val += offset_val;
> -		snd_soc_component_write(component, gain_reg, val);
>   		wsa_macro_config_ear_spkr_gain(component, wsa,
>   						event, gain_reg);
>   		break;
> @@ -1654,10 +1648,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
>   					CDC_WSA_RX_PGA_HALF_DB_MASK,
>   					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> -			offset_val = 2;
> -			val = snd_soc_component_read(component, gain_reg);
> -			val += offset_val;
> -			snd_soc_component_write(component, gain_reg, val);
>   		}
>   		wsa_macro_config_ear_spkr_gain(component, wsa,
>   						event, gain_reg);

