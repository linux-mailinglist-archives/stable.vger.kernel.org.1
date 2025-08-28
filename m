Return-Path: <stable+bounces-176636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EADB3A517
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857447B3DFF
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA825744D;
	Thu, 28 Aug 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ia1VGh7T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC325784E
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396751; cv=none; b=ZsNn9uH5S85P0aILJX+/jl0WESi4ZWrMS6Usjdct0WzLExsVVq0KHfjCk6YxUvN19Gzz+CNhXDm1dQ5ClM/KoiTuvEvogoOnoN39TrB2nWtIb2JnCImzTRtFSbyR8YwO7UPlEw7jZKIQ4801CcxBBWFKJc5S3sFVom/fCq5ILyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396751; c=relaxed/simple;
	bh=qH446A8JxTvE5pekJJF5poG5cTIN4FMdbv4TKf/QINk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0SAURdj9lRJNKbMChW16lFp72cDG0oxrQZXxCrioWZ/1YmhXXOBVwT6027214xriUJRd+1+OCNFBBHHzYpvMgVqlF3LSkTKSdv/mP6gaLMQtbA0tUbPXaUVhWDfd+ynskWWNFKFT2jTeZUGyg9LsFUkOk7oYoQcW4PSVaYm+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ia1VGh7T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756396750; x=1787932750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qH446A8JxTvE5pekJJF5poG5cTIN4FMdbv4TKf/QINk=;
  b=ia1VGh7TOgu6NhbCMmkKMbG5o5QRIIEm16Dul1Er4naYz78iWOFKOsJz
   uYg750cZV5tx/SuTTkBe3CM2yZoWfoYA2LB7WMkRUOcr6US8rheJKNmSL
   cTja2Zt4fFhpYiKHDsXoaHZ3MFzMHFOD9ZLQvOzooI5Y/T0+1WT7wqgIJ
   /sCOJRN0wzKY9UWhwG1NAe5O9v6doCdJoSdggaUM+uOeVcHXx5mV1qU6J
   Tl7aGozt7t6j6W/6hCMj+MjQkYSSTrltzf2vGtuBUvlD76heG3RJIzrmz
   ra3MM9KKru/Q6n59uOv0TD62pGKjKBga6SBASy0mOeznvcLrt1ZRAaDhz
   g==;
X-CSE-ConnectionGUID: kXKQckH5SkmnxXdEcg7xww==
X-CSE-MsgGUID: tDR94dZmSaCc/eFSX+WfgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="61304583"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="61304583"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:59:09 -0700
X-CSE-ConnectionGUID: iMUXeLYaR628ps+8NlhPxQ==
X-CSE-MsgGUID: 8ykOVGRgTE6KHGbqG/QAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="170537967"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:59:05 -0700
Message-ID: <8621165a-68d0-467b-8fe5-c28b500c0d5e@intel.com>
Date: Thu, 28 Aug 2025 16:59:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Attempt to bring bos back to VRAM after eviction
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2025 16:42, Thomas Hellström wrote:
> VRAM+TT bos that are evicted from VRAM to TT may remain in
> TT also after a revalidation following eviction or suspend.
> 
> This manifests itself as applications becoming sluggish
> after buffer objects get evicted or after a resume from
> suspend or hibernation.
> 
> If the bo supports placement in both VRAM and TT, and
> we are on DGFX, mark the TT placement as fallback. This means
> that it is tried only after VRAM + eviction.
> 
> This flaw has probably been present since the xe module was
> upstreamed but use a Fixes: commit below where backporting is
> likely to be simple. For earlier versions we need to open-
> code the fallback algorithm in the driver.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
> Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/xe/xe_bo.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 4faf15d5fa6d..64dea4e478bd 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -188,6 +188,8 @@ static void try_add_system(struct xe_device *xe, struct xe_bo *bo,
>   
>   		bo->placements[*c] = (struct ttm_place) {
>   			.mem_type = XE_PL_TT,
> +			.flags = (IS_DGFX(xe) && (bo_flags & XE_BO_FLAG_VRAM_MASK)) ?

I suppose we could drop the dgfx check here?

Either way,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> +			TTM_PL_FLAG_FALLBACK : 0,
>   		};
>   		*c += 1;
>   	}


