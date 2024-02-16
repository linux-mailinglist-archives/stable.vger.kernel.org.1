Return-Path: <stable+bounces-20347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C2857B3D
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 12:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0162820B6
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF975813A;
	Fri, 16 Feb 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/5BDUtK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB8208BE
	for <stable@vger.kernel.org>; Fri, 16 Feb 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081893; cv=none; b=XStfQT05js1mOhyCBVKks97KNcKzvHv3pDA2/bbOhB3phgbFgZBpnjBn/fMGoKasYybYPOtWf4f1wsvyn7jTN13agUkCMpRL6pNDDvhDiMB5tWB7NHVEkuaG+fAQNJlYTQC0FFMnl/dBAWloMUlD3ZovEt2/fhMEkeVLaPQgsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081893; c=relaxed/simple;
	bh=fuakVQ+w5J5dRCD3xndm2lf2GT+CZM+1xiGreXTQAl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNtPAmW1Mp6EZK0+/Z6FcvNK0AnAYO5pl8wlEq7o4pvXaino+2CgeBsTt12MizZBOBWOL2gOM7IY6ELPg9dxchspxY6vROQiLGh8bhGXO1hKVrGaBDglRim8EZpmVuJOHpXXURkBLjxfi+3l17DG/8idiTM1U7KmsxklAizi76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/5BDUtK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708081891; x=1739617891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fuakVQ+w5J5dRCD3xndm2lf2GT+CZM+1xiGreXTQAl4=;
  b=U/5BDUtKM7JEDGFvAHzefuYTGn/LIuHdS+6wSBOxdhNXTfUWO3H8Xo1R
   sPNZuBStk6X+weAj5Yi8ar6qb0778dINpYsy85l7V5r4pcwckZ1yTJf6b
   /RmDs5h5n7wB8bMhECjbeUgEPU8WKM7pRLojAhf8aaYCoLs6o7WODoVyy
   uxjjd1zetLevKXryjAHv4fplHGWKKWTTM9We4qNC0MenxopBHC3ahJWU+
   pM6XNuoo/16sT3btxKzXEk+2rdugc4fvwCAbbREYrONpIBmNsTIKHK+Am
   nf9QsdtfRkbW5k6L1YsNDDF8DiD2snK0/i7DozmkGI91p1KzVAyXD7su3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13310598"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="13310598"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="4105486"
Received: from fcrowe-mobl2.ger.corp.intel.com (HELO [10.252.21.243]) ([10.252.21.243])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:11:28 -0800
Message-ID: <bb158180-c354-458b-8aab-bb224bcb3fbc@intel.com>
Date: Fri, 16 Feb 2024 11:11:26 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/buddy: Modify duplicate list_splice_tail call
Content-Language: en-GB
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 mario.limonciello@amd.com, spasswolf@web.de, stable@vger.kernel.org
References: <20240216100048.4101-1-Arunpravin.PaneerSelvam@amd.com>
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20240216100048.4101-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/02/2024 10:00, Arunpravin Paneer Selvam wrote:
> Remove the duplicate list_splice_tail call when the
> total_allocated < size condition is true.
> 
> Cc: <stable@vger.kernel.org> # 6.7+
> Fixes: 8746c6c9dfa3 ("drm/buddy: Fix alloc_range() error handling code")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/drm_buddy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index c1a99bf4dffd..c4222b886db7 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -538,13 +538,13 @@ static int __alloc_range(struct drm_buddy *mm,
>   		list_add(&block->left->tmp_link, dfs);
>   	} while (1);
>   
> -	list_splice_tail(&allocated, blocks);
> -
>   	if (total_allocated < size) {
>   		err = -ENOSPC;
>   		goto err_free;
>   	}
>   
> +	list_splice_tail(&allocated, blocks);

Sigh. Can we extend the unit test(s) to catch this?

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> +
>   	return 0;
>   
>   err_undo:
> 
> base-commit: a64056bb5a3215bd31c8ce17d609ba0f4d5c55ea

