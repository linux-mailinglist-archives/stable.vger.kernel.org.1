Return-Path: <stable+bounces-183633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CABC5FF5
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C8420F8D
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551228D83E;
	Wed,  8 Oct 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyCG0l6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35429D27E;
	Wed,  8 Oct 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939959; cv=none; b=XISO4mjukDLNGwuaWr0+RTqAGccikBUBdbcHgYW2Kf++JjrZEf8aqxPFM9wZ/wE3ZpR9xiDIMaK4xwysRTzDvboQ39+2Pw5TqamjGPY2Ojo+oEqmfY3LR4Bpl1fz7yucwsI7+CBOpxOq+9Th2eQvmE7zTXGcoTyOyXG4A7XFAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939959; c=relaxed/simple;
	bh=GSLhHE+jLJmDn587I8Vc9P6oopRm4TApxDA0Te8Um7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/d+hDg6JZf3l2m3ieUC5Gv2o/SPWtizMszCz8RiqXOwxykM+wUiibhmU6dUPGBnyDZFbAde9syPfjRPxWh5kEifg0t8FmeFi0EpWkM5oMjiC6SZVNABxmRk7fAMvrjRSaV7Tzl+5ZS1d4P77vu/+5+y935TgD34xzStpMAwSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyCG0l6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D7BC4CEE7;
	Wed,  8 Oct 2025 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759939959;
	bh=GSLhHE+jLJmDn587I8Vc9P6oopRm4TApxDA0Te8Um7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tyCG0l6tNTE0LM6z0M0layIp6vBh4VNNHNBa/SGRxsVOOEdRJIIBdOwqyrhZRkeCv
	 sgrsrVK+1KX3X+aV0Bnym6cxMRswiYTzx9pWlr6oDe7+sNGwRizQ/9LjgecMeXqf7i
	 qg0DuGX2IDkkxULzyYm37hP/NH7N53pmYqKHAK5Nm1uWTs/WPNZCja8Yc8FwTFu4Se
	 g96mH9yMeC392Ws6EhaNdVAStiU4kUy4J4F1XCJzjE4y7eVZaRM/BYAKNBwaPG7wgx
	 GBhOnjn1wT37A9td91fmo/Adge0RrAItJia1WFQeNBSplHxO0OnV/6sS4lQnouSemM
	 40MjkyZEU4UDw==
Message-ID: <317f4edc-0592-492f-8c3d-f0cdb0d013cd@kernel.org>
Date: Wed, 8 Oct 2025 17:12:37 +0100
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
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
 ajay.nandam@oss.qualcomm.com, stable@vger.kernel.org
References: <20251007023325.853640-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <d9971ca4-1911-4204-b175-1ceeaae7c238@kernel.org>
 <b257d715-cc12-46cc-ba31-7f7fc257f763@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <b257d715-cc12-46cc-ba31-7f7fc257f763@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/8/25 5:08 PM, Mohammad Rafi Shaik wrote:
> 
> 
> On 10/8/2025 7:16 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 10/7/25 3:33 AM, Mohammad Rafi Shaik wrote:
>>> In setups where the same codec DAI is reused across multiple DAI
>>> links, mute controls via `snd_soc_dai_digital_mute()` is skipped for
>>
>> Please explain the problem.
>>
> In Qualcomm audioreach setup, if platform dai not specified in DT, then
> cpu dai using as platform and initialize as static dai-link and created
> pcm device and link-dynamic == false by default.
> 
> In existing setup if dynamic==false, it's skipping trigger snd-ops and
> the codec is always on mute state.
> 
>>> non-dynamic links. The trigger operations are not invoked when
>>> `dai_link->dynamic == 0`, and mute controls is currently conditioned
>>
>> I dont think any of the Qualcomm upstream platforms use this flag.
>>
> 
> Yes, we are using dynamic flag and it's set to true in Qualcomm platforms.
> 
> Please check: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/
> sound.git/tree/sound/soc/qcom/qdsp6/topology.c#n1093
> 
>>> only on `snd_soc_dai_mute_is_ctrled_at_trigger()`. This patch ensures
>>> that mute and unmute is applied explicitly for non-dynamic links.
>> How is this resolving the issue, mute on these codecs happens at trigger
>> level instead of prepare.
>>
> yes agree, but if link->dynamic==false the trigger ops not getting
> called, which leading to codec always on mute state.

This is because you are using something very different solution to what
ASoC kernel provides.

I dont think this is a problem with as long as you use kernel ABI..

This patch looks totally a hack from something that does not belong to
kernel, so is  NAK  from my side on this.

--srini


> 
> Thanks & Regards,
> Rafi.
> 
>> --srini
>>>
>>> Fixes: f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute
>>> stream during trigger")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Mohammad Rafi Shaik
>>> <mohammad.rafi.shaik@oss.qualcomm.com>
>>> ---
>>>   sound/soc/soc-pcm.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>>> index 2c21fd528afd..4ed829b49bc2 100644
>>> --- a/sound/soc/soc-pcm.c
>>> +++ b/sound/soc/soc-pcm.c
>>> @@ -949,7 +949,7 @@ static int __soc_pcm_prepare(struct
>>> snd_soc_pcm_runtime *rtd,
>>>               SND_SOC_DAPM_STREAM_START);
>>>         for_each_rtd_dais(rtd, i, dai) {
>>> -        if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
>>> +        if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd-
>>> >dai_link->dynamic)
>>>               snd_soc_dai_digital_mute(dai, 0, substream->stream);
>>>       }
>>>   @@ -1007,7 +1007,7 @@ static int soc_pcm_hw_clean(struct
>>> snd_soc_pcm_runtime *rtd,
>>>               soc_pcm_set_dai_params(dai, NULL);
>>>             if (snd_soc_dai_stream_active(dai, substream->stream) ==
>>> 1) {
>>> -            if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
>>> +            if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd-
>>> >dai_link->dynamic)
>>>                   snd_soc_dai_digital_mute(dai, 1, substream->stream);
>>>           }
>>>       }
>>
> 


