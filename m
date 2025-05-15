Return-Path: <stable+bounces-144498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B9CAB826E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846404C627B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BFA29673D;
	Thu, 15 May 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlSg03m8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B6289E03;
	Thu, 15 May 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301025; cv=none; b=emluqKjMyMImP051FOTA4p0ZAkmQL2cLeHri2R8vtTW30ABBBp+DfsaaAKvO/5RbwCHyL0dO7lFY57j77BSlbybL1jth6HahUKHs2zMCsrbLAvwp1MeGNuyt2pcx81qUULU2jlcizkkTT+AHrtgnitv0K6zCF/fbAcJ0Ivx/Oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301025; c=relaxed/simple;
	bh=pmh0bU9D30ShKkm22QJjwQKrEY0tzBBAail+x8L+Wfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eh1rWGYHMjTB804HsQbOF639VQxl93wog57BS9XHHm0nAAIHW1Qw0DBw7cBuaUjGXek154O/9sJPtfCFTa0Df5v8KSaF8ZhUsICnrUbrPIj0qrNjlq+9mXxfwXtf7Nr+J9VvWvwir34As8JSEoZWp09E+IT094N4IGrATWaQfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlSg03m8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747301024; x=1778837024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pmh0bU9D30ShKkm22QJjwQKrEY0tzBBAail+x8L+Wfg=;
  b=DlSg03m8IylNEUUW6MTQCJbsnIW1G5ZqugPTa9crCmTTof/LzSwLVNwW
   p6UUWLidHo1FWZhA7Hv46RNa5US39hUZLWtM6dOhCV5OyOhWjpPmiGO+W
   Cs3rXQESMYyfwhw1ajKSf46uvlapHDeHn2NLjtdVwPsSgUZZoecF+7Z2g
   bMevLfNCsfz6F6Td9j82XOEqObov4pislEOrrcba2I/7sTEDA7HhslZJo
   JVsl5jzlzGABmr5uWYWtzndHtQ8NdLIitlyD+ZsSnB/7QwFVmzAV3wb3E
   LfHScJLzNkXUSsXle79B0gwdH82PjRVvI8Z5rfvhroqimx82UlUJvigwg
   Q==;
X-CSE-ConnectionGUID: EXXIF+x5TYmRhL2w2cqnTQ==
X-CSE-MsgGUID: /V05UTTsTuqqotMANPi2TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60628654"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="60628654"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:23:42 -0700
X-CSE-ConnectionGUID: Refl9nmdQnCSQuH4FV2QOA==
X-CSE-MsgGUID: J3wJnCFwRly62bB+1zlDUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138722753"
Received: from sbockowx-mobl2.ger.corp.intel.com (HELO [10.94.8.84]) ([10.94.8.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:23:38 -0700
Message-ID: <3470451d-6768-42d4-93db-2783ffd9cbab@linux.intel.com>
Date: Thu, 15 May 2025 11:23:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: rt274: Add null pointer check for
 snd_soc_card_get_codec_dai()
To: Wentao Liang <vulab@iscas.ac.cn>, cezary.rojewski@intel.com,
 liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: kuninori.morimoto.gx@renesas.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250514141947.998-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20250514141947.998-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025-05-14 16:19, Wentao Liang wrote:
> The avs_card_suspend_pre() and avs_card_resume_post() in rt274
> calls the snd_soc_card_get_codec_dai(), but does not check its return
> value which is a null pointer if the function fails. This can result
> in a null pointer dereference. A proper implementation can be found
> in acp5x_nau8821_hw_params() and card_suspend_pre().
> 
> Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
> pointer dereference when the function fails.
> 
> Fixes: a08797afc1f9 ("ASoC: Intel: avs: rt274: Refactor jack handling")
> Cc: stable@vger.kernel.org # v6.2
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   sound/soc/intel/avs/boards/rt274.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
> index 4b6c02a40204..7a8b6ee79f4c 100644
> --- a/sound/soc/intel/avs/boards/rt274.c
> +++ b/sound/soc/intel/avs/boards/rt274.c
> @@ -194,6 +194,11 @@ static int avs_card_suspend_pre(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, RT274_CODEC_DAI);
>   
> +	if (!codec_dai) {
> +		dev_err(card->dev, "Codec dai not found\n");
> +		return -EINVAL;
> +	}
> +
>   	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
>   }
>   
> @@ -202,6 +207,11 @@ static int avs_card_resume_post(struct snd_soc_card *card)
>   	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, RT274_CODEC_DAI);
>   	struct snd_soc_jack *jack = snd_soc_card_get_drvdata(card);
>   
> +	if (!codec_dai) {
> +		dev_err(card->dev, "Codec dai not found\n");
> +		return -EINVAL;
> +	}
> +
>   	return snd_soc_component_set_jack(codec_dai->component, jack, NULL);
>   }
>   

Same as in other case, where Cezary commented - this is not needed, once 
card is loaded codec should exist.

