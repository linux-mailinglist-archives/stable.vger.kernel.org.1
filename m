Return-Path: <stable+bounces-202806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E2CC793B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49F8A30D1945
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664D33F8C3;
	Wed, 17 Dec 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRub7yU2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F182BD5A2;
	Wed, 17 Dec 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973799; cv=none; b=eH7GFpadBpMOyQTz7yl4m9J+vEyluvSQXdi8xQmYKYucskAEtJuqtVv4aonwiqa9qLjjGtcErX52FoZomQciNErJEJIWMELy/EG5MvW9yb657TyHbQIbWke3KWtQOLGyl4HXA1qosnBR2nsiaQqj/JaS1WSUcTWK3/c4IQazgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973799; c=relaxed/simple;
	bh=x1WQFDyw2PW3xAAxGV5+getQ3w11p28h7Xj2MXGFW0A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=agd80LQSDWBXGDAWPO4d23ZwNIW/T0sKu0x09fnS4BZa52v6VKPqMHqNao/W/JJr59vRgh4cOKtinF8deg9h7pkeh4mzUEmMwcfjg5WHvpGX0ZSNxpMY2q7JzfpBJzB/OBE/cGibnWywwUwRHGfXtv8GX/LPcX9IupSszGZpmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRub7yU2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765973798; x=1797509798;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=x1WQFDyw2PW3xAAxGV5+getQ3w11p28h7Xj2MXGFW0A=;
  b=fRub7yU2BK7ilI8RK8CDNOib4qaOPEA/p0hYN31UbSiNFpRDrgLIzzf/
   nuqiQ9+3l3OH3GsYDs265vyxlIAJLKduXP8P0OebuabARS8GIOcQQLHAg
   OE8dEY2NRsDA8ra93L1Vh3sxrp/U0aPqk/J6bnkvjOGa7NXSnpBewetuf
   CPDphgub7e41sy8niHzT1UMGw5iMevCpsTVw/LbkDCufrpaq5eWO7tnDE
   wVi3JebXTJeZysyDHyovdvRsy24eWelwHbAaRpfWd1w6z9U2rVmQug+Od
   vbt7zNPCaA+qU6G/Dydy8pWH0LLi/NOzxgawpsjbK5xO4hOw0HuuCAJLX
   g==;
X-CSE-ConnectionGUID: TwOo6YgVRcOfJMRVMFR1EQ==
X-CSE-MsgGUID: XtSR7N8TQEWtxzOndmgZzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67792912"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="67792912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:16:37 -0800
X-CSE-ConnectionGUID: L1s/1CuARiiVa2QtnhcafQ==
X-CSE-MsgGUID: 6pgUO7q7TmmG/9tmN3qvwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="203389726"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.187]) ([10.245.246.187])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:16:34 -0800
Message-ID: <404fca17-4505-4b7f-8e2a-ed75a8fac1d0@linux.intel.com>
Date: Wed, 17 Dec 2025 14:17:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 seppo.ingalsuo@linux.intel.com, stable@vger.kernel.org, niranjan.hy@ti.com,
 ckeepax@opensource.cirrus.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/12/2025 14:06, Peter Ujfalusi wrote:
> In 'normal' controls the mc->min is the minimum value the register can
> have, the mc->max is the maximum (the steps between are max - min).
> 
> SX types are defined differently: mc->min is the minimum value and the
> mc->max is the steps.
> 
> The max parameter of soc_mixer_reg_to_ctl() is the number of steps in
> either type.
> 
> To have correct register value range in clamp the maximum value that needs
> to be used is mc->min + max, which will be equal to mc->max for 'normal'
> controls and mc->min + mc->max for SX ones.
> 
> The original clamp broke SX controls and rendered some of them impossible
> to even set, like the cs42l43's Headphone Digital Volume, where the
> min is smaller than the max (min=283, max=229 - 229 steps starting from

when the min is bigger than the max, sorry, will resend with corrected
message

> val 283).
> 
> The soc_mixer_ctl_to_reg() correctly uses the max parameter instead of
> mc->max, so storing the value was correct.
> 
> Fixes: a0ce874cfaaa ("ASoC: ops: improve snd_soc_get_volsw")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/soc/soc-ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> index ce86978c158d..6a18c56a9746 100644
> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -148,7 +148,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
>  	if (mc->sign_bit)
>  		val = sign_extend32(val, mc->sign_bit);
>  
> -	val = clamp(val, mc->min, mc->max);
> +	val = clamp(val, mc->min, mc->min + max);
>  	val -= mc->min;
>  
>  	if (mc->invert)

-- 
Péter


