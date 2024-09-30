Return-Path: <stable+bounces-78281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC598A7FD
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61070B2805A
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883B19258E;
	Mon, 30 Sep 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcapffqZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36E18E755
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708331; cv=none; b=fJN1R9v9S4iGLXXzlQhYV9Et2UmbUfT0volg5zgdexF5CJegxnkxnMCxsWya3MmaIBRnH1ngBLGAxxKmTee5wvadAW6pXVlznxRljeBGZY0kJuqtVPPXtdE9Y0ixFJ14tRaRN++tSfC9V2RHweR//x4atHJrnpYB5pwVRRpDdME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708331; c=relaxed/simple;
	bh=v8YbEUoGkpfFcfExcW7wZUzrYppDBHCK/mjIr2MxhEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQbOvzxyZP8C9oLQC1WEPP+OW02xrBXH+BApiv+Wzdt+a1UH/03Wvrp6a/Ml+lNGjTvhkRpelQr/6qghej+7qPR2t9enzp/JtMFzue50XEc/Eezg9DeCzVRcjAsIT8mTax9efEaP/WqGPFufQUngWXtNxZZ3yZW1j0MbU5+nAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcapffqZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727708330; x=1759244330;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=v8YbEUoGkpfFcfExcW7wZUzrYppDBHCK/mjIr2MxhEw=;
  b=gcapffqZxwm2tbQvZ4la/ccF6Ih27R5kZwiUHeLto0mWlj2tPNAgp1Ly
   9+yi9EGdJW5aVgUnWZwVUDsxFbVp8DLVM65pqbWpqNl8/gt0AoKrlkJWE
   H92bv2/JsNKesH0bFjSp3wiraGX6B5pvThHmQf12U1TYuiEdGSk2TKCPs
   D50lwCNZxadj1T39KFQaKDtUyWoAoxLmEOPjkGMt2jsKPIweEQlGh9t/n
   4sAxjewUrVUBuo4ILSqEPJ16b8wbSEZix/6wPSYhtj6FDQz+5MeXv/Aq8
   nW9zi6gpONsM0LR+sp7f851jTO5CzEEujEddNqPGJsG/2Wx3LOrN0nsCI
   A==;
X-CSE-ConnectionGUID: wW4cUOprSSyKiT0JT2ykkQ==
X-CSE-MsgGUID: tYsnZotHQEOBuikpJzNcXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26754058"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26754058"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:58:50 -0700
X-CSE-ConnectionGUID: 9CNfmsIXR86Kea6ixBktTw==
X-CSE-MsgGUID: SZU63O85RH+Dw46TNTGIlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77869227"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.136])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:58:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Matthew Auld <matthew.auld@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Anshuman Gupta <anshuman.gupta@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] drm/i915/gem: fix bitwise and logical AND mixup
In-Reply-To: <11901d29-f211-46a9-96ee-cf52558e4eeb@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1726680898.git.jani.nikula@intel.com>
 <643cc0a4d12f47fd8403d42581e83b1e9c4543c7.1726680898.git.jani.nikula@intel.com>
 <ZvXGwFBbOa7-035L@intel.com> <87r095ze2i.fsf@intel.com>
 <87wmitw8kc.fsf@intel.com>
 <11901d29-f211-46a9-96ee-cf52558e4eeb@intel.com>
Date: Mon, 30 Sep 2024 17:58:33 +0300
Message-ID: <87cyklw5ly.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 30 Sep 2024, Matthew Auld <matthew.auld@intel.com> wrote:
> On 30/09/2024 14:54, Jani Nikula wrote:
>> On Fri, 27 Sep 2024, Jani Nikula <jani.nikula@intel.com> wrote:
>>> On Thu, 26 Sep 2024, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>>>> On Wed, Sep 18, 2024 at 08:35:43PM +0300, Jani Nikula wrote:
>>>>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND is an int, defaulting to 250. When
>>>>> the wakeref is non-zero, it's either -1 or a dynamically allocated
>>>>> pointer, depending on CONFIG_DRM_I915_DEBUG_RUNTIME_PM. It's likely that
>>>>> the code works by coincidence with the bitwise AND, but with
>>>>> CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y, there's the off chance that the
>>>>> condition evaluates to false, and intel_wakeref_auto() doesn't get
>>>>> called. Switch to the intended logical AND.
>>>>>
>>>>> v2: Use != to avoid clang -Wconstant-logical-operand (Nathan)
>>>>
>>>> oh, this is ugly!
>>>>
>>>> Wouldn't it be better then to use IS_ENABLED() macro?
>>>
>>> It's an int config option, not a bool. (Yes, the name is misleading.)
>>>
>>> IS_ENABLED(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND) would be the same as
>>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND == 1.
>>>
>>> We're actually checking if the int value != 0, so IMO the patch at hand
>>> is fine.
>> 
>> Ping, r-b on this one too?
>
> r-b still holds for v2, fwiw.

Thanks for the reviews, pushed the lot to drm-intel-next.

BR,
Jani.

>
>> 
>> BR,
>> Jani.
>> 
>>>
>>> BR,
>>> Jani.
>>>
>>>
>>>>
>>>>>
>>>>> Fixes: ad74457a6b5a ("drm/i915/dgfx: Release mmap on rpm suspend")
>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
>>>>> Cc: Andi Shyti <andi.shyti@linux.intel.com>
>>>>> Cc: Nathan Chancellor <nathan@kernel.org>
>>>>> Cc: <stable@vger.kernel.org> # v6.1+
>>>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v1
>>>>> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> # v1
>>>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>>>> ---
>>>>>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> index 5c72462d1f57..b22e2019768f 100644
>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> @@ -1131,7 +1131,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
>>>>>   		GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
>>>>>   	}
>>>>>   
>>>>> -	if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>>>>> +	if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND != 0)
>>>>>   		intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
>>>>>   				   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
>>>>>   
>>>>> -- 
>>>>> 2.39.2
>>>>>
>> 

-- 
Jani Nikula, Intel

