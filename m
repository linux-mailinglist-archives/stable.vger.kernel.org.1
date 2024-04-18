Return-Path: <stable+bounces-40206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EC8AA15C
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822321C20DEF
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC0176FD2;
	Thu, 18 Apr 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lefzVpvd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE317556D;
	Thu, 18 Apr 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462538; cv=none; b=d6ToJzqW1sNgE8uiebeDNGsEM7MNB5/W1mbGGt9jGjtTfINGCtapDhsSBCkaL8CwK0Fx6fVaWE85fSxhRAYwEGGxpPLfAQqYaW6puL3/9nNLNdHre6ebpB36xDPWvFNa1zt4CuCzLSyXSufZ66hoVElzMBDqnvtulL47TYzWATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462538; c=relaxed/simple;
	bh=P2+1M5xlz5nO98fQHEzHTaHBC6pZovHWDXMrzDKvvkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4oLWk/K1obeLYo5ZVeeVLFUUpSryVYrcRqr3eiXpOiIEOfavFyrgffrgQdUg1YURe+P/uhHMCL2TGY51Wj6B40/hIPSZbG+w/4Xus2cIuTLgIe3dkZTj6qda48fJDP+smHtpTYhalVxHMvh7Nex6h/t3vSUc5qtJWtrgqDNWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lefzVpvd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso15166511fa.2;
        Thu, 18 Apr 2024 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713462535; x=1714067335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWjRP/RRJQ8mM83fkHijl/axycbWYPWuBIUVY65UOGA=;
        b=lefzVpvdhSmK89ZXjbG4ujrLhIF769iRqcnzoiAvU2S2q6T04padjjOVi4weBjduae
         ZmZM0ldexer7TeynnsICi8pKc9UWMXqQS0UfJGXcoIHz8J3XKQv9ZRizwXl7cMUn6CV7
         2QuDRtjdaWGojfZBFOpoyCQyGTXgsIkZ1ghBuRnN7IV0+GPSart/xOimzX06RqJwLB+E
         Lvd5xaTDCrjwIJeo2w0mZhrHURsiftDX+HLg0zl8pfHxgQ4nlNK911UknkQ2/Amwnnq2
         Ht+7VW7n/Haj9mlMbe8wnTXBdVEJN7m+atdn9RtvrqlknJYV4nZ0+Awv96fOoCmCz+Py
         saOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462535; x=1714067335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWjRP/RRJQ8mM83fkHijl/axycbWYPWuBIUVY65UOGA=;
        b=FN+1L6kZ9/1IHALKblwvVk8hJAxsVoxkNIl6dDfzUDUewhAKxBWKTV5Vy00frfDW41
         5edzCCCDfSEfywlxnUkMEj9PGodLy5KmhgefIzDScjPi5VpFjLFbY2+bL7MvyvItvS1w
         vGc9WtIwWadkYOwd0fhF9IpYmcuDolSKHfaiVyWtU23renthFtiYs+rWnWoUIwLMg2R2
         DoWKhbrrWXexRcDsks72kvfcORaxJg1o8Zft+PGQ1F9r4sSc5g+sjbeQ88uSWRoDewei
         TIQBMLk3pIma50YTrwraC0IdQc/fucQ+za/veUNznXZoGId+VBnWqXGbc5LfdrRvpWY1
         6u4w==
X-Forwarded-Encrypted: i=1; AJvYcCWEzbOMhbPjEVLIVjD0QgbiLfGs9//NCovId+K2TCsS3srATyhq7toHPox52zfWDWDvAmdpCpjWK1EJh6ug4hUKu4ps/nvtxtuJlpy6SUbL7cN2S45SdFyu6DgnSATYbnI1qEAC0gy+ZUDkztNyFlNpzlY4bmmgksKCphHVLD/0Ayc=
X-Gm-Message-State: AOJu0Yxbi2tw32ll7l47hVYQGOL/Wl4WNSUDvyXOtjv5SyfTam7FtlVJ
	SNUhGWHrFpO0EfknIKbVAtzjWkWxdj4eF89a/hZSiBOzVbgrnHpq
X-Google-Smtp-Source: AGHT+IFLN8AVKD6AbFTXCtyt/i2xPnyVSWhKPGW1JF/2/FqWjGy5naOgcXt0w7tJVCAdQgHvWpQApQ==
X-Received: by 2002:a2e:8807:0:b0:2da:9ebe:e35f with SMTP id x7-20020a2e8807000000b002da9ebee35fmr1923468ljh.22.1713462534894;
        Thu, 18 Apr 2024 10:48:54 -0700 (PDT)
Received: from [10.0.0.100] (host-213-145-200-116.kaisa-laajakaista.fi. [213.145.200.116])
        by smtp.gmail.com with ESMTPSA id p12-20020a2ea40c000000b002d80b78c1e0sm268671ljn.117.2024.04.18.10.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:48:54 -0700 (PDT)
Message-ID: <f0dcab9a-1f9d-4db5-b886-0d2174070f37@gmail.com>
Date: Thu, 18 Apr 2024 20:49:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Fix race condition during probe
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Jai Luthra <j-luthra@ti.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/04/2024 21:41, Joao Paulo Goncalves wrote:
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> 
> When using davinci-mcasp as CPU DAI with simple-card, there are some
> conditions that cause simple-card to finish registering a sound card before
> davinci-mcasp finishes registering all sound components. This creates a
> non-working sound card from userspace with no problem indication apart
> from not being able to play/record audio on a PCM stream. The issue
> arises during simultaneous probe execution of both drivers. Specifically,
> the simple-card driver, awaiting a CPU DAI, proceeds as soon as
> davinci-mcasp registers its DAI. However, this process can lead to the
> client mutex lock (client_mutex in soc-core.c) being held or davinci-mcasp
> being preempted before PCM DMA registration on davinci-mcasp finishes.
> This situation occurs when the probes of both drivers run concurrently.
> Below is the code path for this condition. To solve the issue, defer
> davinci-mcasp CPU DAI registration to the last step in the audio part of
> it. This way, simple-card CPU DAI parsing will be deferred until all
> audio components are registered.
> 
> Fail Code Path:
> 
> simple-card.c: probe starts
> simple-card.c: simple_dai_link_of: simple_parse_node(..,cpu,..) returns EPROBE_DEFER, no CPU DAI yet
> davinci-mcasp.c: probe starts
> davinci-mcasp.c: devm_snd_soc_register_component() register CPU DAI
> simple-card.c: probes again, finish CPU DAI parsing and call devm_snd_soc_register_card()
> simple-card.c: finish probe
> davinci-mcasp.c: *dma_pcm_platform_register() register PCM  DMA
> davinci-mcasp.c: probe finish

Interesting... Thanks for the details.
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Cc: stable@vger.kernel.org
> Fixes: 9fbd58cf4ab0 ("ASoC: davinci-mcasp: Choose PCM driver based on configured DMA controller")

Just to note that the DAI registration was always before the platform
registration (ever since the DAI driver started to register the
platform) and I think most TI (and probably other vendor's) driver does
things this way. McASP does a bit of lifting by requesting a DMA channel
to figure out the type of DMA...

> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index b892d66f78470..1e760c3155213 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2417,12 +2417,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  
>  	mcasp_reparent_fck(pdev);
>  
> -	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
> -					      &davinci_mcasp_dai[mcasp->op_mode], 1);
> -
> -	if (ret != 0)
> -		goto err;
> -
>  	ret = davinci_mcasp_get_dma_type(mcasp);
>  	switch (ret) {
>  	case PCM_EDMA:
> @@ -2449,6 +2443,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
> +					      &davinci_mcasp_dai[mcasp->op_mode], 1);
> +
> +	if (ret != 0)
> +		goto err;
> +
>  no_audio:
>  	ret = davinci_mcasp_init_gpiochip(mcasp);
>  	if (ret) {

-- 
Péter

