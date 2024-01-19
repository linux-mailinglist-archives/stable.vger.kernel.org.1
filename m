Return-Path: <stable+bounces-12241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC78324F6
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 08:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224FB1F23A69
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B68F6E;
	Fri, 19 Jan 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lL+8NVOT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6467484
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648538; cv=none; b=gzSYrmDrpAowKGTlSrT9kCvC8oBT2fO1pHiIWC/niXQsQZXSv8+9UCoB0b9RRGb8bRLDiJNJuUF4n97OkXmZXjroxvdL+FXpGZ7v7i7Tv2wyG3ilSayH3hyHLax31eXuwgJIuFClOD8IiEGAPdAZ/hinqAOt0Vlh2vaLLnhNYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648538; c=relaxed/simple;
	bh=bu6TtoDHXYj08cbRRnS9+PBQHmEtpwdovbn9SIGetKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bvwp0VJbeOT4WgP0I85wXSBVYyYarfEii29fkcmw1tKBZrZC4F8mP9CQX7bS1WR1OVpy+NuRv5lfoesS26uKZ8kHboESDF/z8aWj37dwrryGtnQj1LrxP7N13+yjkiDKqZh1t+tvGb6qC1BE/hbl6QKP3Z0/GzoY3Z4pwDX46xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lL+8NVOT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so4981635e9.1
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 23:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705648535; x=1706253335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHFKB+KTysp6kwejewof3DWQa8w1eNlV5qVrsykVh5c=;
        b=lL+8NVOT2DoyAECiwYaZdY4tyi9WitC3A/pdglurzXyAlNpLK5z8JxX+Cr5H56bNuN
         kbaoRjdj63Scat/VgeC6B2S8TMT2+BkardZvgx5bBenFDYlRmztjij1wIjftqQcT8kkP
         GaW7DP5whohr5nymAxh/W3hhhY8evCi4HMuabnztJvzGE14dxLdFwXk6QNZvKNnzuULP
         e6gTBBH+vBBDtquAxFwiwSCZQYb4EwqREnY/x+KECitnNn3KTAho6CRsFjNewsxGRHCk
         M5N05lBamJuYqt8mfR8L9XS4trf6SFQxhb+u85zwyLvjkkqHiMftmdsV+dYQO5z94WFO
         EOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705648535; x=1706253335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHFKB+KTysp6kwejewof3DWQa8w1eNlV5qVrsykVh5c=;
        b=eQWqd4Q5w2tPeSRIHtKBI4RCH4T4/aKftHD4sgooP3t3DrxE5Dwrf2lidwQsmv37E5
         H5wxywNU/D2DiOmuA4Yp8AqJf+igqyk5J4wNKCRXh7J0CXtGGsmdS0jMAVfJfEGbm/uf
         ttrrzasiktJzblpIUpeTRTZ8TjRssqQQ2nKpdYtJEyGyk59vOul9ixXG7w8RrUE1MmJa
         FJwlLE5Qsi2+UaA5yP2PgzbbuYNYkF3exz6uWVlKHaaX8negjGklWNApVIIsaK92csPb
         YvlzLnNEdjBcgIY+/gJwlW2t1Lx6mv4+AxEWP1WGxFExmB/8CLBAo/eJEtmuhJPqrZ7f
         he5w==
X-Gm-Message-State: AOJu0YzOWy0HIqATmQ4nA86n2Fz/pxvLwS2nO1rq0gvqoW8xkjAIs+9c
	/uHOTDFLUc7A2kWCTtmG3KO2ZEE5yBwL4FbhK0c1oNzuDnm1vpVy6zBO+SS4hOw=
X-Google-Smtp-Source: AGHT+IF+flK3TANqdZk9xzA4fDQ608SzAK+XwelcQRt5520BMqyeOX3b4lxpmwKeq2jytRjqDhs2ug==
X-Received: by 2002:a05:600c:54d2:b0:40d:5d07:55d3 with SMTP id iw18-20020a05600c54d200b0040d5d0755d3mr849828wmb.177.1705648535092;
        Thu, 18 Jan 2024 23:15:35 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 2-20020a05600c020200b0040ea00a0b75sm14034wmi.0.2024.01.18.23.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:15:34 -0800 (PST)
Message-ID: <63e000c7-deae-44df-8d82-a74ffe303e9a@linaro.org>
Date: Fri, 19 Jan 2024 07:15:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ASoC: codecs: wsa883x: lower default PA gain
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-3-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/01/2024 16:58, Johan Hovold wrote:
> The default PA gain is set to a pretty high level of 15 dB. Initialise
> the register to the minimum -3 dB level instead.
> 
> This is specifically needed to allow machine drivers to use the lowest
> level as a volume limit.
> 
> Cc: stable@vger.kernel.org      # 6.5
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/codecs/wsa883x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index 32983ca9afba..8942c88dee09 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -722,7 +722,7 @@ static struct reg_default wsa883x_defaults[] = {
>   	{ WSA883X_WAVG_PER_6_7, 0x88 },
>   	{ WSA883X_WAVG_STA, 0x00 },
>   	{ WSA883X_DRE_CTL_0, 0x70 },
> -	{ WSA883X_DRE_CTL_1, 0x08 },

this is hw default value.

> +	{ WSA883X_DRE_CTL_1, 0x1e },
>   	{ WSA883X_DRE_IDLE_DET_CTL, 0x1F },
>   	{ WSA883X_CLSH_CTL_0, 0x37 },
>   	{ WSA883X_CLSH_CTL_1, 0x81 },

