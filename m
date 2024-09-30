Return-Path: <stable+bounces-78271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625598A6EC
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC377282A46
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8A190045;
	Mon, 30 Sep 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt3yD4HG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D02CA5
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706245; cv=none; b=Yi9dtkvxoK4fgYrnYImsx2d48Cs87SBT1g/JiUeUbTQjwwLc5gMuTypHPzg6EE2ouqTXVkGWVrj1JuoKnaIocpgjHSR1uKiQKJymTarMbLqdkHKMtxxySf0PuDsRGGncJzNQauqf9UZqAk/FhrZUGRRxfdTmq/Dg3fMrqcTlO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706245; c=relaxed/simple;
	bh=+AT0cDoqlMSbjyS9IijBKjMnEZchu8U/6VUciEy9GXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLxKV31TCvpcx/OZDytPFBNQZjuQnh53lmpX/UauGHxk2oD4XOjpgEOmpL1UniDf33Jsogv7L+OhnTIJG+bueJ2fxYXuLMiojXalUJLR/sEhO3TZl/xv0WajZ7n7tvf37cBkfSxrHF53BOCo2p7VouJDd/Xm1qXVdNhsZ9XlifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt3yD4HG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727706244; x=1759242244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+AT0cDoqlMSbjyS9IijBKjMnEZchu8U/6VUciEy9GXw=;
  b=kt3yD4HGm0NHZYF5cHi5JOzgFgno6xZBaswLDZUwlnHBZnSw8gayT3qY
   TNpXj/fFLqQd+4ALj6zsnK8gcO6ysyY/mNI67joK8hsU1HuHOyCnCABtC
   ha4+318urbf4Pga2lqERRzr+BhF1NPVRoMBGux2+whQigRA+NDBEMc9gb
   CAaG24uQ4ukg5UP99pKTsUJdX0P5zvAoy9zfPCJbgHuZ3P3TGmpo5KYEo
   b/0jMEGTsNXZPKDFziAVEZpSjLEtMsZsiO2fu6i58rRsMU//zj+Kr4Nuh
   MbCTU6uSmQnG6X7VNGHEVcsUTW1k32R8C81sKRqpgS6uPuRAEjF3mNd02
   w==;
X-CSE-ConnectionGUID: 0gPlOeJyTiiKEZkUaBwbrg==
X-CSE-MsgGUID: 5b7FSpP2S7a3o3tkzQ+F1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26975018"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26975018"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:24:03 -0700
X-CSE-ConnectionGUID: fIX7myOtTxmoTcYrOaTItQ==
X-CSE-MsgGUID: c/llip9tQqOgPBrSxgoMRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73290205"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO [10.245.244.244]) ([10.245.244.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:24:01 -0700
Message-ID: <11901d29-f211-46a9-96ee-cf52558e4eeb@intel.com>
Date: Mon, 30 Sep 2024 15:23:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/i915/gem: fix bitwise and logical AND mixup
To: Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Anshuman Gupta <anshuman.gupta@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org
References: <cover.1726680898.git.jani.nikula@intel.com>
 <643cc0a4d12f47fd8403d42581e83b1e9c4543c7.1726680898.git.jani.nikula@intel.com>
 <ZvXGwFBbOa7-035L@intel.com> <87r095ze2i.fsf@intel.com>
 <87wmitw8kc.fsf@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <87wmitw8kc.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2024 14:54, Jani Nikula wrote:
> On Fri, 27 Sep 2024, Jani Nikula <jani.nikula@intel.com> wrote:
>> On Thu, 26 Sep 2024, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>>> On Wed, Sep 18, 2024 at 08:35:43PM +0300, Jani Nikula wrote:
>>>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND is an int, defaulting to 250. When
>>>> the wakeref is non-zero, it's either -1 or a dynamically allocated
>>>> pointer, depending on CONFIG_DRM_I915_DEBUG_RUNTIME_PM. It's likely that
>>>> the code works by coincidence with the bitwise AND, but with
>>>> CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y, there's the off chance that the
>>>> condition evaluates to false, and intel_wakeref_auto() doesn't get
>>>> called. Switch to the intended logical AND.
>>>>
>>>> v2: Use != to avoid clang -Wconstant-logical-operand (Nathan)
>>>
>>> oh, this is ugly!
>>>
>>> Wouldn't it be better then to use IS_ENABLED() macro?
>>
>> It's an int config option, not a bool. (Yes, the name is misleading.)
>>
>> IS_ENABLED(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND) would be the same as
>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND == 1.
>>
>> We're actually checking if the int value != 0, so IMO the patch at hand
>> is fine.
> 
> Ping, r-b on this one too?

r-b still holds for v2, fwiw.

> 
> BR,
> Jani.
> 
>>
>> BR,
>> Jani.
>>
>>
>>>
>>>>
>>>> Fixes: ad74457a6b5a ("drm/i915/dgfx: Release mmap on rpm suspend")
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
>>>> Cc: Andi Shyti <andi.shyti@linux.intel.com>
>>>> Cc: Nathan Chancellor <nathan@kernel.org>
>>>> Cc: <stable@vger.kernel.org> # v6.1+
>>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v1
>>>> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> # v1
>>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>>> ---
>>>>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>> index 5c72462d1f57..b22e2019768f 100644
>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>> @@ -1131,7 +1131,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
>>>>   		GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
>>>>   	}
>>>>   
>>>> -	if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>>>> +	if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND != 0)
>>>>   		intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
>>>>   				   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
>>>>   
>>>> -- 
>>>> 2.39.2
>>>>
> 

