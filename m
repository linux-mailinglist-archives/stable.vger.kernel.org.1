Return-Path: <stable+bounces-127701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D0A7A748
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8CD172840
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250E250BE5;
	Thu,  3 Apr 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhPJRBOq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BF24EF8C
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695472; cv=none; b=nxV87sO2jZeXkAyaPrL9O+Mf460KgkO81rcItwV5uanw9GNH27e3SC+9nprK3ANI0q6Xfi8dPqXYLZeFZkE2qM9dsU1o+JkeUnjYJToPXwOh84WRgqfJXfCPs4E9exW7caPMyRl4M9IqOOV5ZD3m6zMDAUnwMcneham3NqCov3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695472; c=relaxed/simple;
	bh=1e7yC1eFo1tl/1ENpe9JTpIuYNl2ZAT7YyhwQFdruYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/hMgTWdo/UDVTga7VOccl22Q8GMnJsc1rW/W6g/ysPZcKoe/Kgu8LjApLt2VODTw+mSERnRc5SsHgIxMpelJKEn/o9mIvqpScOO88Nw1elrC5VNYCj9ymuxdt/WB9dyVp5rqv2Viigk/NwdaJwoiEyba9Iq7BxTRL5t5JfMi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhPJRBOq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39727fe912cso557304f8f.3
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743695468; x=1744300268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2J2QLWZnqssrV8zudx3h9XG9hVG/cM/mFGc7QsgYvPM=;
        b=bhPJRBOqUY4hMHCaq0W+ifsy4tq+slLDGBRyil1QVrzPpK1Kp52EfjFz5yjeCulCR9
         EZirYvgHHA5F29F+M3CqCVgLMXqbvRhiboUBSNATBj8HHnTswZQQiIebVJwBrbxJTeBy
         Jen5e4eASPa29iSo3/ws9Gx12EzypAIjByF/LVbsU5hcDVWIRCo5ElcJKy5LU94R6Lf9
         t1Rv+7TSinG8dx+GW5KORoP3RP5ekK5Psd/Z0BMj+1U3Ny02MRmS7X4jytJcmqgx4ZvT
         gHSOA+1k4AAD2jH3YMF22QL3X3CZen3Ke5qVFk9UPP8MFqkF30GL9H7mNV7LQd1qnPCr
         78PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743695468; x=1744300268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2J2QLWZnqssrV8zudx3h9XG9hVG/cM/mFGc7QsgYvPM=;
        b=nhOq2x2YKFmHNVLJVxin3B1U4jm5+61GupfSaj9EzVopJo/gyZeFsE1d1ih1HS9g+/
         lvxlcPvAXC91OigdwYS0hl2GxqcPAVgcgxxud1z2beNZCpT7MK7X/rxQfrLppCD27OVG
         IO0P0A1bavvTfoX3hgGf+jG+nbB86gXGq+wwDqhXBZhkAY/FkrWwLhQQi1tv/vvnnsZx
         c3t5T8Q0Qam4B8yzYVf2xMKKwJpi5hFy/MLrnC4U1iRZ7GeemveaAjnM8YiJr9Yv00XU
         E0qXNs+NhNnzGoBwa/YKKC1JDwKnVVCDMHIVe5YGdGhcxkhhKhGE0J6+RfHj4DkS6K9Y
         fFzA==
X-Forwarded-Encrypted: i=1; AJvYcCU1tYGBtceZNq3CkwaKTyOGJldJhI5JXEghshh3g1GoMC7VnV9+8kb6CqOmniiJ40L8vHUe30U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyuwLDUfCIgo/j1iLwaeW5eAJ01FBGbh0jZvIrLY0Ea/C5mKkX
	OJfDXrWJQWzcx4Kl9Qjq0uW8jDRwExasC0PX14puNv7Qmix5aNprwmH7YKm2qAQ=
X-Gm-Gg: ASbGncv42C1Xxw+habGV2rRDvlSQugtILz/9oBMMTNb8gSVNs8AsvCCrWHaF0EvZiLZ
	z0cwNQI4Vw1/m2RfHhSxANWc3gTqp0eyt3lwv4G0h15kj2fKoDmpOR+On2xJ3HDPo9SuQYUQDb4
	EpOSpJ9B7ri4FeW4+d97UiGz6rw/iQ/aqTwCVh9WdbbiaqJBP3lHY8oztBeGRAdN8oOFMCWIv1a
	sErD9AOjzJ2n8WMXwLm2z7Kat7vCvRk8Wlgsui7Cz4VAIpzVkd1YfOpkmTdvdrMr7xdpSaskX3q
	eEJUhgLS0cbtbap95gZxe7cWwAbQSgOcasy1qpMFgq20CM2CZwsP37nul3Mav7E=
X-Google-Smtp-Source: AGHT+IFfmB17gjHz9nh+1iS0Zop96uQ6lrjEOfXp/zRFvcGY0csh6X1W8kAngr57zCaj8+UAvkqhKQ==
X-Received: by 2002:a05:6000:40e1:b0:38f:2ffc:1e99 with SMTP id ffacd0b85a97d-39c29805ec2mr6623824f8f.49.1743695468306;
        Thu, 03 Apr 2025 08:51:08 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020d5d1sm2146603f8f.77.2025.04.03.08.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 08:51:07 -0700 (PDT)
Message-ID: <69e32e9d-f263-4ed8-bd25-5e09dae9c20d@linaro.org>
Date: Thu, 3 Apr 2025 16:51:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of
 enabling vi channels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Manikantan R <quic_manrav@quicinc.com>
References: <20250403124247.7313-1-srinivas.kandagatla@linaro.org>
 <20250403124247.7313-3-srinivas.kandagatla@linaro.org>
 <pzyw3swuj4gqynxtp7kxbludyf6qq7fdfjaphw73tezzqocrda@i3f2knhbocme>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <pzyw3swuj4gqynxtp7kxbludyf6qq7fdfjaphw73tezzqocrda@i3f2knhbocme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/04/2025 15:35, Dmitry Baryshkov wrote:
> On Thu, Apr 03, 2025 at 01:42:47PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Existing code only configures one of WSA_MACRO_TX0 or WSA_MACRO_TX1
>> paths eventhough we enable both of them. Fix this bug by adding proper
>> checks and rearranging some of the common code to able to allow setting
>> both TX0 and TX1 paths
>>
>> Without this patch only one channel gets enabled in VI path instead of 2
>> channels. End result would be 1 channel recording instead of 2.
> 
> Could you please rearrange the code to make the patch more obvious?
Will try it in next version.

> 
>>
>> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Manikantan R <quic_manrav@quicinc.com>
>> Signed-off-by: Manikantan R <quic_manrav@quicinc.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/codecs/lpass-wsa-macro.c | 112 +++++++++++++++++------------
>>   1 file changed, 68 insertions(+), 44 deletions(-)
>>
>> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
>> index ac119847bc22..c9e7f185f2bc 100644
>> --- a/sound/soc/codecs/lpass-wsa-macro.c
>> +++ b/sound/soc/codecs/lpass-wsa-macro.c
>> @@ -1469,46 +1469,11 @@ static int wsa_macro_mclk_event(struct snd_soc_dapm_widget *w,
>>   	return 0;
>>   }
>>   
>> -static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>> -					struct snd_kcontrol *kcontrol,
>> -					int event)
>> -{
>> -	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> -	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>> -	u32 tx_reg0, tx_reg1;
>> -	u32 rate_val;
>>   
>> -	switch (wsa->pcm_rate_vi) {
>> -	case 8000:
>> -		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
>> -		break;
>> -	case 16000:
>> -		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
>> -		break;
>> -	case 24000:
>> -		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
>> -		break;
>> -	case 32000:
>> -		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
>> -		break;
>> -	case 48000:
>> -		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
>> -		break;
>> -	default:
>> -		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
>> -		break;
>> -	}
> 
> This can go to the wsa_macro_enable_disable_vi_sense().
Not sure I undestood this, v4 looks much clearner without this hunk.

> 
>> -
>> -	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
>> -		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
>> -		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
>> -	} else if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
>> -		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
>> -		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
>> -	}
>> -
>> -	switch (event) {
>> -	case SND_SOC_DAPM_POST_PMU:
>> +static void wsa_macro_enable_disable_vi_sense(struct snd_soc_component *component, bool enable,
>> +						u32 tx_reg0, u32 tx_reg1, u32 val)
>> +{
>> +	if (enable) {
>>   		/* Enable V&I sensing */
>>   		snd_soc_component_update_bits(component, tx_reg0,
>>   					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
>> @@ -1518,10 +1483,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>>   					      CDC_WSA_TX_SPKR_PROT_RESET);
>>   		snd_soc_component_update_bits(component, tx_reg0,
>>   					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
>> -					      rate_val);
>> +					      val);
> 
> No need for extra renames, they complicate reviewing.
> 
>>   		snd_soc_component_update_bits(component, tx_reg1,
>>   					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
>> -					      rate_val);
>> +					      val);
>>   		snd_soc_component_update_bits(component, tx_reg0,
>>   					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
>>   					      CDC_WSA_TX_SPKR_PROT_CLK_ENABLE);
>> @@ -1534,9 +1499,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>>   		snd_soc_component_update_bits(component, tx_reg1,
>>   					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
>>   					      CDC_WSA_TX_SPKR_PROT_NO_RESET);
>> -		break;
>> -	case SND_SOC_DAPM_POST_PMD:
>> -		/* Disable V&I sensing */
>> +	} else {
>>   		snd_soc_component_update_bits(component, tx_reg0,
>>   					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
>>   					      CDC_WSA_TX_SPKR_PROT_RESET);
>> @@ -1549,6 +1512,67 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>>   		snd_soc_component_update_bits(component, tx_reg1,
>>   					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
>>   					      CDC_WSA_TX_SPKR_PROT_CLK_DISABLE);
>> +	}
>> +}
>> +
>> +static void wsa_macro_enable_disable_vi_feedback(struct snd_soc_component *component,
>> +						 bool enable, u32 rate)
>> +{
>> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>> +	u32 tx_reg0, tx_reg1;
>> +
>> +	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
>> +		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
>> +		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
>> +		wsa_macro_enable_disable_vi_sense(component, enable, tx_reg0, tx_reg1, rate);
> 
> As you are refactoring this piece of code, do you need tx_reg0 / tx_reg1
> variables? Can you inline them instead?

Ack.

> 
>> +	}
>> +
>> +	if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
>> +		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
>> +		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
>> +		wsa_macro_enable_disable_vi_sense(component, enable, tx_reg0, tx_reg1, rate);
>> +
>> +	}
>> +
> 
> Extra empty line.

Ack

> 
>> +}
>> +
>> +static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>> +					struct snd_kcontrol *kcontrol,
>> +					int event)
>> +{
>> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>> +	u32 rate_val;
>> +
>> +	switch (wsa->pcm_rate_vi) {
>> +	case 8000:
>> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
>> +		break;
>> +	case 16000:
>> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
>> +		break;
>> +	case 24000:
>> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
>> +		break;
>> +	case 32000:
>> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
>> +		break;
>> +	case 48000:
>> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
>> +		break;
>> +	default:
>> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
>> +		break;
>> +	}
>> +
>> +	switch (event) {
>> +	case SND_SOC_DAPM_POST_PMU:
>> +		/* Enable V&I sensing */
>> +		wsa_macro_enable_disable_vi_feedback(component, true, rate_val);
>> +		break;
>> +	case SND_SOC_DAPM_POST_PMD:
>> +		/* Disable V&I sensing */
>> +		wsa_macro_enable_disable_vi_feedback(component, false, rate_val);
>>   		break;
>>   	}
>>   
>> -- 
>> 2.39.5
>>
> 

