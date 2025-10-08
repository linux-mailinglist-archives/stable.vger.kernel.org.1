Return-Path: <stable+bounces-183605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94047BC5415
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B7B3E1264
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AE249EB;
	Wed,  8 Oct 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9LQa585"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1152868A6;
	Wed,  8 Oct 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931200; cv=none; b=eFKsI6rrunIF8hg4DakGlHUsVak9sYCkNMb+WZdxnkO6wurKLEfucRuCOYAr2EvpONlbvCvYYW+joWPMROyTS21b7lSTik6Le0YfuOgkugV2073XWa/IWYiIAuoymOO+ygqKgSL4KS6wUzmseQHQhJemvCK5gvKXvdmZjIF3sAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931200; c=relaxed/simple;
	bh=a90XkJSi+HSvdj+B0bzNBHHlSx1tcYmSg9puliQptV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJh6jRCatABSpUY/5KS3BZGDG849CI5IRqrpvp5v98gIlIPSaxWd4Pap8ds/C63KsvJXizCMUwgiq+VWiRDEJmq/z0wIMTBvuvvGLJLmIiAePMtNchFW0GmwLMjBDzGmGa/Nes55YpoROAwKRStFxqIC4K5LYnactu0pDwXya+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9LQa585; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE532C4CEF4;
	Wed,  8 Oct 2025 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931200;
	bh=a90XkJSi+HSvdj+B0bzNBHHlSx1tcYmSg9puliQptV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u9LQa585egVxdmqn73eRMaF3kMC+FnGiVDQlN2PLDrJjGJNANyaOHcD0CWMyAUt/S
	 Mrq9g7/wiIkD3C1nXDjLe6MNlGpd1SfRELlIcABCBp7n/SRBPy67TPw3AulmLnrf5P
	 vDvsBINzKEuwBkZjx3sfqRFqo9zt/WaDr93TQkb5dx5J0Pkv+acdB6n3oJvKXgzxnp
	 zBkX82Gbkblbu2CbpZPuGq70XE1jWo5MWbcneSzjo0utAvCldOxsr5cMie7f6KBqSL
	 Hnm8FQvRkiZa87WW9gf+12YOIhAnucUWKvSGsgp4fOkhueP+fCRPNhJNTlu1axhJj9
	 9YPlqAwKY9s/w==
Message-ID: <d9971ca4-1911-4204-b175-1ceeaae7c238@kernel.org>
Date: Wed, 8 Oct 2025 14:46:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: soc-pcm: Fix mute and unmute control for
 non-dynamic DAI links
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
 ajay.nandam@oss.qualcomm.com, stable@vger.kernel.org
References: <20251007023325.853640-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20251007023325.853640-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/25 3:33 AM, Mohammad Rafi Shaik wrote:
> In setups where the same codec DAI is reused across multiple DAI
> links, mute controls via `snd_soc_dai_digital_mute()` is skipped for

Please explain the problem.

> non-dynamic links. The trigger operations are not invoked when
> `dai_link->dynamic == 0`, and mute controls is currently conditioned

I dont think any of the Qualcomm upstream platforms use this flag.

> only on `snd_soc_dai_mute_is_ctrled_at_trigger()`. This patch ensures
> that mute and unmute is applied explicitly for non-dynamic links.
How is this resolving the issue, mute on these codecs happens at trigger
level instead of prepare.

--srini
> 
> Fixes: f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/soc-pcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 2c21fd528afd..4ed829b49bc2 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -949,7 +949,7 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
>  			SND_SOC_DAPM_STREAM_START);
>  
>  	for_each_rtd_dais(rtd, i, dai) {
> -		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
> +		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
>  			snd_soc_dai_digital_mute(dai, 0, substream->stream);
>  	}
>  
> @@ -1007,7 +1007,7 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
>  			soc_pcm_set_dai_params(dai, NULL);
>  
>  		if (snd_soc_dai_stream_active(dai, substream->stream) == 1) {
> -			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
> +			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
>  				snd_soc_dai_digital_mute(dai, 1, substream->stream);
>  		}
>  	}


