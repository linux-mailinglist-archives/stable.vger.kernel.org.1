Return-Path: <stable+bounces-144497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D143AB826C
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0603D4C6061
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B329672F;
	Thu, 15 May 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQ3KVbEF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62028AB11;
	Thu, 15 May 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301004; cv=none; b=rW/U6gvQogRgnY6peb9erSCXau9A2lne2++wq7kQHEliIWsL5lBeBGc/b0y5DUTKbUdDt6JlRFxbsVznmUxLCn6bOrULjaXx2bYRs3jUfnZ0VFqNvbrkSKBlKJ7ErihRfzPMdf3/kJeIh0egfqAI6mcKnDJwcw+SiSFZ9JGEbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301004; c=relaxed/simple;
	bh=btmW+zkcYyC6oGW8tMaCdxp7dary/VfHMiho7JQVNZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvrEnR8cWgSMHpVj+Psgu66rkc9EgonYobu3x0YnVNp0hl5oVX8I52NmMG3cOMZDFYbeBkyoXcGefTceiENkGJXHoiBMLhuQ8+t+jQra+gAzAmYsdE704dnNQZAzhPzdrtOWaqa9BMbDQiSo+hqa1ofB0zH2ENwLYZ/7tJKM0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQ3KVbEF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747301003; x=1778837003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=btmW+zkcYyC6oGW8tMaCdxp7dary/VfHMiho7JQVNZQ=;
  b=dQ3KVbEFtyr9AkdVhl6YxpKlARWlB30yA2/K7V0IjpyXSyc94rfcypQE
   mebadqIUEYFMkNurwXpB3u5PXTziEbifYdrmm9H/iR+Xv9Pcujw8vq1Rc
   y6B85AtXA4YTUzx5luqlY/8dtYRggRlX1B4QsdmuzC9FkNwQSrkMrtHJy
   Is5QwUzKg04xWzPP8It6SqrQ6GqEvk11Je3BQNM28Tz4dW5vCQOE2BVRy
   k4s6SatOzNgGxKM7JrDGE55E0qQi9Tn7ywaDD2JkU5RHvCf5XmVcOftSO
   Dfgt2uWxuQnpsuzY5HS1sZV5NXG2LSOzc/2MuvpQDSUDpVip4eIlzmHn+
   A==;
X-CSE-ConnectionGUID: AwlH46NgTZSF1FqR/5HhYw==
X-CSE-MsgGUID: umWKg5akRI29/Ji+yQ0V2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60628645"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="60628645"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:23:22 -0700
X-CSE-ConnectionGUID: cvEmsxZtTkKupDat3bkVdg==
X-CSE-MsgGUID: YD2vX8q/TtarDO2hxI4MHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138722709"
Received: from sbockowx-mobl2.ger.corp.intel.com (HELO [10.94.8.84]) ([10.94.8.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:23:19 -0700
Message-ID: <86cdafd1-f77c-4c15-9777-0197e91cf0a5@linux.intel.com>
Date: Thu, 15 May 2025 11:23:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: nau8825: Add null pointer check for
 snd_soc_card_get_codec_dai()
To: Wentao Liang <vulab@iscas.ac.cn>, cezary.rojewski@intel.com,
 liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: kuninori.morimoto.gx@renesas.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250514140433.862-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20250514140433.862-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025-05-14 16:04, Wentao Liang wrote:
> The function avs_card_suspend_pre() in nau8825 calls the function
> snd_soc_card_get_codec_dai(), but does not check its return
> value which is a null pointer if the function fails. This can result
> in a null pointer dereference. A proper implementation can be found
> in acp5x_nau8821_hw_params() and card_suspend_pre().
> 
> Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
> pointer dereference when the function fails.
> 
> Fixes: 9febcd7a0180 ("ASoC: Intel: avs: nau8825: Refactor jack handling")
> Cc: stable@vger.kernel.org # v6.2
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   sound/soc/intel/avs/boards/nau8825.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
> index bf902540744c..5baeb95cd5a6 100644
> --- a/sound/soc/intel/avs/boards/nau8825.c
> +++ b/sound/soc/intel/avs/boards/nau8825.c
> @@ -220,6 +220,11 @@ static int avs_card_suspend_pre(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
>   
> +	if (!codec_dai) {
> +		dev_err(card->dev, "Codec dai not found\n");
> +		return -EINVAL;
> +	}
> +
>   	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
>   }
>   

Same as in other case, where Cezary commented - this is not needed, once 
card is loaded codec should exist.


