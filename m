Return-Path: <stable+bounces-166629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0945B1B51A
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FFE1608AE
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368A274FDC;
	Tue,  5 Aug 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eB1fS+MC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585F274FD1
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401258; cv=none; b=fJdnMyQZ2zvm/n+MTr573BxkiDJiQGsxAJq7zxrgAiveuIes1Oltc/52TGwc9uh2kvpEUmDzFyFBxYKoF35o4vILyVDUQGX/a5vitDmu1fvM2FB1Adn3vI+txaMPjvPGhb+Y7r3B7zELJ4M2feZYkcGVcV0szwZxlxLDaohMEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401258; c=relaxed/simple;
	bh=Y5XpQDLAYczhxAMP1ZJKkbQiznCZNfdj2q/5MX9YvY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2aD4C3kuxF1TxgWS8AcaQqQZxznzmIJNvIX8FxWhctk/rn5QgjAhMxOjQaP7Qym0QiXyzD9iClanfY1xm21CDNlheH0pl+NNaHzW9ZHLp7RKVNI9DJZkdhrQmD/lWAtCOiuvIQosf1kzS5cXEKTxBdLb5SmNv8FnWEJMOE9yRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eB1fS+MC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754401257; x=1785937257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y5XpQDLAYczhxAMP1ZJKkbQiznCZNfdj2q/5MX9YvY8=;
  b=eB1fS+MCnpfRUHJaZ4S/fms94+TwJnAnaV5fiwaFT9/ebTI723h4zzBY
   zmTMbB7W15locnxZ902RlciIAZSiHGymp88ZGbs39ZCqBfXGPbkOnxfAX
   V4N1qwiNr4uBEcT0gNE6Ow0BT6q7ptCg4QWLbooAykJBmwAsULvZXD6lB
   4f3OKTMLh/qCViEzpTikvYeMtdNRHG9s38WT8YIzjjU9vs8kEzxEIwpB1
   eHoWmwN8/ZivcEe4mcMFTY+GtyvYuKOJLPry+hxjK70t7pFKZ36pWnojQ
   7vjy0K+GHXu5WZYJ87vBw79R9RUb/SfM1nRKNvjn7ROdlkcQSh4WPt0iS
   w==;
X-CSE-ConnectionGUID: wTcPGxCXR2CEYL3mVKYkEg==
X-CSE-MsgGUID: NdHafA8CQfKC73YgNgXaIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="82143307"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="82143307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 06:40:56 -0700
X-CSE-ConnectionGUID: X8xNhcgISce8jnz3JY3Oqw==
X-CSE-MsgGUID: 3o3ONoUKT4WZUUdJ+c9zNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="201682708"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.244.5]) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 06:40:55 -0700
Message-ID: <c4346dd6-ec12-46cc-93c2-7bc3aa16c6c4@intel.com>
Date: Tue, 5 Aug 2025 14:40:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: Defer buffer object shrinker write-backs and
 GPU waits
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: melvyn <melvyn2@dnsense.pub>, Summers Stuart <stuart.summers@intel.com>,
 stable@vger.kernel.org
References: <20250805074842.11359-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250805074842.11359-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2025 08:48, Thomas Hellström wrote:
> When the xe buffer-object shrinker allows GPU waits and write-back,
> (typically from kswapd), perform multiple passes, skipping
> subsequent passes if the shrinker number of scanned objects target
> is reached.
> 
> 1) Without GPU waits and write-back
> 2) Without write-back
> 3) With both GPU-waits and write-back
> 
> This is to avoid stalls and costly write- and readbacks unless they
> are really necessary.
> 
> v2:
> - Don't test for scan completion twice. (Stuart Summers)
> - Update tags.
> 
> Reported-by: melvyn <melvyn2@dnsense.pub>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5557
> Cc: Summers Stuart <stuart.summers@intel.com>
> Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/xe/xe_shrinker.c | 51 +++++++++++++++++++++++++++++---
>   1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
> index 1c3c04d52f55..90244fe59b59 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> @@ -54,10 +54,10 @@ xe_shrinker_mod_pages(struct xe_shrinker *shrinker, long shrinkable, long purgea
>   	write_unlock(&shrinker->lock);
>   }
>   
> -static s64 xe_shrinker_walk(struct xe_device *xe,
> -			    struct ttm_operation_ctx *ctx,
> -			    const struct xe_bo_shrink_flags flags,
> -			    unsigned long to_scan, unsigned long *scanned)
> +static s64 __xe_shrinker_walk(struct xe_device *xe,
> +			      struct ttm_operation_ctx *ctx,
> +			      const struct xe_bo_shrink_flags flags,
> +			      unsigned long to_scan, unsigned long *scanned)
>   {
>   	unsigned int mem_type;
>   	s64 freed = 0, lret;
> @@ -93,6 +93,48 @@ static s64 xe_shrinker_walk(struct xe_device *xe,
>   	return freed;
>   }
>   
> +/*
> + * Try shrinking idle objects without writeback first, then if not sufficient,
> + * try also non-idle objects and finally if that's not sufficient either,
> + * add writeback. This avoids stalls and explicit writebacks with light or
> + * moderate memory pressure.

Just one question here, with writeback=false it doesn't really influence 
which objects are chosen for shrinking, unlike with no_wait_gpu, right? 
Will having another pass just with writeback=true yield anything 
different, assuming here that the previous two passes would have already 
hoovered ~everything up that was a possible candidate, so this pass 
won't really find anything in practice? If so, does that also mean we 
never really end up using the writeback=true behaviour any more?

> + */
> +static s64 xe_shrinker_walk(struct xe_device *xe,
> +			    struct ttm_operation_ctx *ctx,
> +			    const struct xe_bo_shrink_flags flags,
> +			    unsigned long to_scan, unsigned long *scanned)
> +{
> +	bool no_wait_gpu = true;
> +	struct xe_bo_shrink_flags save_flags = flags;
> +	s64 lret, freed;
> +
> +	swap(no_wait_gpu, ctx->no_wait_gpu);
> +	save_flags.writeback = false;
> +	lret = __xe_shrinker_walk(xe, ctx, save_flags, to_scan, scanned);
> +	swap(no_wait_gpu, ctx->no_wait_gpu);
> +	if (lret < 0 || *scanned >= to_scan)
> +		return lret;
> +
> +	freed = lret;
> +	if (!ctx->no_wait_gpu) {
> +		lret = __xe_shrinker_walk(xe, ctx, save_flags, to_scan, scanned);
> +		if (lret < 0)
> +			return lret;
> +		freed += lret;
> +		if (*scanned >= to_scan)
> +			return freed;
> +	}
> +
> +	if (flags.writeback) {
> +		lret = __xe_shrinker_walk(xe, ctx, flags, to_scan, scanned);
> +		if (lret < 0)
> +			return lret;
> +		freed += lret;
> +	}
> +
> +	return freed;
> +}
> +
>   static unsigned long
>   xe_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>   {
> @@ -199,6 +241,7 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
>   		runtime_pm = xe_shrinker_runtime_pm_get(shrinker, true, 0, can_backup);
>   
>   	shrink_flags.purge = false;
> +
>   	lret = xe_shrinker_walk(shrinker->xe, &ctx, shrink_flags,
>   				nr_to_scan, &nr_scanned);
>   	if (lret >= 0)


