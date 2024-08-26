Return-Path: <stable+bounces-70154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BD95EEB9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B71B2171B
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7A149DE8;
	Mon, 26 Aug 2024 10:45:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CC13A869;
	Mon, 26 Aug 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669118; cv=none; b=NR22otmw8D97j1OQcJQeDzxuX3T85FRphaVR4czmQ2kxshXKKUBwxGAgqdzS+fHjaAmI/i1fB1hs47f4CoeWS7KnLnRmYiZ2jBQI+7rvTfgWFtkC072ymW3kqmXF5V9ZH4i5BA7oAQuTfco9EJX1Eii6UkstETLiAUR7BAOI0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669118; c=relaxed/simple;
	bh=5gWYyrNgg6sVsuz/4qTpQ/yQgUCkgur0kDiqSfQAaZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ugUMzWl/svTP2vpqo2rn52/X+2oQvNM6oCQpe0hRaINjZvACv/uAyzqpQEYy7XmdgaWgdCxJAxzwxPfQAYjTCgwgdrj7vxn0r8rT+GzeWncbKigqNGz5EjGMyMrHlEcXH0fzQOWVRuuMCIOS+HGNr7wnJJXXHlzmNSHnZrmGoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 26 Aug
 2024 13:45:13 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Aug
 2024 13:45:13 +0300
Message-ID: <56362df7-7502-4b35-81da-f3fe9ff7da47@fintech.ru>
Date: Mon, 26 Aug 2024 03:45:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/guc: prevent a possible int overflow in wq
 offsets
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
CC: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>, <n.zhandarovich@fintech.ru>
References: <20240725155925.14707-1-n.zhandarovich@fintech.ru>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <20240725155925.14707-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hi,

On 7/25/24 08:59, Nikita Zhandarovich wrote:
> It may be possible for the sum of the values derived from
> i915_ggtt_offset() and __get_parent_scratch_offset()/
> i915_ggtt_offset() to go over the u32 limit before being assigned
> to wq offsets of u64 type.
> 
> Mitigate these issues by expanding one of the right operands
> to u64 to avoid any overflow issues just in case.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 2584b3549f4c ("drm/i915/guc: Update to GuC version 70.1.1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> index 9400d0eb682b..908ebfa22933 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> @@ -2842,9 +2842,9 @@ static void prepare_context_registration_info_v70(struct intel_context *ce,
>  		ce->parallel.guc.wqi_tail = 0;
>  		ce->parallel.guc.wqi_head = 0;
>  
> -		wq_desc_offset = i915_ggtt_offset(ce->state) +
> +		wq_desc_offset = (u64)i915_ggtt_offset(ce->state) +
>  				 __get_parent_scratch_offset(ce);
> -		wq_base_offset = i915_ggtt_offset(ce->state) +
> +		wq_base_offset = (u64)i915_ggtt_offset(ce->state) +
>  				 __get_wq_offset(ce);
>  		info->wq_desc_lo = lower_32_bits(wq_desc_offset);
>  		info->wq_desc_hi = upper_32_bits(wq_desc_offset);

Gentle ping,

Regards,
Nikita

