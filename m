Return-Path: <stable+bounces-176638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6977B3A63A
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B225117DA85
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3290322A00;
	Thu, 28 Aug 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACc3dzC3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313D2E0915
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398455; cv=none; b=T7Mj/qfUcDy2pAzAke95CYFq5YztaQM9HikgJFz02VXQoDuBJSN/367BHqI8y0+aRlhZaQD1fHD20BG4vO+62TDP1GIoDxU7eXbRwXeqxPSq1vcCBku9wP/T2QZ6/dYL9LQgKceAylEkxACI5uQ8TgDyB2b5uHCEzkRPn/gYWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398455; c=relaxed/simple;
	bh=Gzmlsz0c+uAb7yG+44ZDMHsMhRsRJFrqq/GsdUtnYFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm1uRVuXnPk4kczTM1mAanWZnU/TDEYcXuwxBZ2aqQc2G1gzpnPIPiKj2RsKe8lh4qbm5xVwyQ+zKwKzXSchZxTmMHaDOhKlQqKO+cV8mRPN/eiCCwz99BsbOOoutmIInwaimxUZXXO1HYYFI4P3iaKkaLdqrDgPfc5JAEfm3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACc3dzC3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756398454; x=1787934454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gzmlsz0c+uAb7yG+44ZDMHsMhRsRJFrqq/GsdUtnYFc=;
  b=ACc3dzC3WleCpfEaVCi5n3UPVeleRJUjffd6znsPkErkINt92IWkFpSA
   uIPwd6ml7LPopLsRIc6LClwbwoOI+e7gdAePaVB6GzSAiuyzz729sgntx
   9hyV+s7k2KULU0ZbVsIKJarPYgXAUV3WDxoLtKNK15dkfi226IglPCsSh
   9Wtpf0lYNQYqkb/hdosAlVQ+FoEvI/bVVM1SrBSUdQZcMIdMk/VflmXDU
   aZZhMJvwaJs7X5SuOcoNfjRb5qZfMp6DIhUB/oJ0727yv/FvKpjA5y1Dg
   6RncMP4RwSMO8rrCZ+v2RpV1RGm/+nfuPkhAaTN6iONSG0R19+d16d3gH
   w==;
X-CSE-ConnectionGUID: gpNnKlOYQN+p14rAoOSeNA==
X-CSE-MsgGUID: pL6G4mQMQMKXzKYG1gEODQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76276379"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="76276379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:27:32 -0700
X-CSE-ConnectionGUID: ITO9GkawTg6J0OIi22IjKw==
X-CSE-MsgGUID: S2lf7kAYSAS6sSuKOVvm4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="175432494"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:27:31 -0700
Message-ID: <45c42d43-658e-452f-8aeb-e7a32f4838b2@intel.com>
Date: Thu, 28 Aug 2025 17:27:29 +0100
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
 <8621165a-68d0-467b-8fe5-c28b500c0d5e@intel.com>
 <ba4a969ad501922974c796e354292b7d5451dac4.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <ba4a969ad501922974c796e354292b7d5451dac4.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2025 17:06, Thomas Hellström wrote:
> Hi,
> 
> On Thu, 2025-08-28 at 16:59 +0100, Matthew Auld wrote:
>> On 28/08/2025 16:42, Thomas Hellström wrote:
>>> VRAM+TT bos that are evicted from VRAM to TT may remain in
>>> TT also after a revalidation following eviction or suspend.
>>>
>>> This manifests itself as applications becoming sluggish
>>> after buffer objects get evicted or after a resume from
>>> suspend or hibernation.
>>>
>>> If the bo supports placement in both VRAM and TT, and
>>> we are on DGFX, mark the TT placement as fallback. This means
>>> that it is tried only after VRAM + eviction.
>>>
>>> This flaw has probably been present since the xe module was
>>> upstreamed but use a Fixes: commit below where backporting is
>>> likely to be simple. For earlier versions we need to open-
>>> code the fallback algorithm in the driver.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
>>> Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags
>>> v6")
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.9+
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> ---
>>>    drivers/gpu/drm/xe/xe_bo.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c
>>> b/drivers/gpu/drm/xe/xe_bo.c
>>> index 4faf15d5fa6d..64dea4e478bd 100644
>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>> @@ -188,6 +188,8 @@ static void try_add_system(struct xe_device
>>> *xe, struct xe_bo *bo,
>>>    
>>>    		bo->placements[*c] = (struct ttm_place) {
>>>    			.mem_type = XE_PL_TT,
>>> +			.flags = (IS_DGFX(xe) && (bo_flags &
>>> XE_BO_FLAG_VRAM_MASK)) ?
>>
>> I suppose we could drop the dgfx check here?
> 
> Thanks for reviewing. From a quick look it looks like the VRAM_MASK
> bits can be set also on IGFX? And if so, then it's not ideal to mark
> the primary placement as FALLBACK. But I might have missed a rejection
> somewhere.

I was sweating bullets for a second there, but it looks like it gets 
rejected in the ioctl with:

if (XE_IOCTL_DBG(xe, (args->placement & ~xe->info.mem_region_mask)
      return -EINVAL;

The flags get converted from the args->placement, and VRAM should never 
appear in the mem_region_mask on igpu. If we allowed it I think it would 
crash in add_vram() since the vram manager does not exist so 
ttm_manager_type() would be NULL, AFAICT.

> 
> /Thomas
> 
> 
>>
>> Either way,
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>
>>> +			TTM_PL_FLAG_FALLBACK : 0,
>>>    		};
>>>    		*c += 1;
>>>    	}
>>
> 


