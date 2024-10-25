Return-Path: <stable+bounces-88180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A59B0915
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEF1C220AC
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59897082B;
	Fri, 25 Oct 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5CwBdCi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECA21A4AA
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872218; cv=none; b=oHphsh2du56JoEeEuUhSrdDOey1uUmGu3NThyOYKMiQQV4moTBn4TKyQXXo5O5X5uFpMBnfGNF/6XATLD5NHlIa6pcVcblXCI/DIcaPcdcRMtznL1hO9oYuKVaYmB2FGBqP028V9oXi5NeT09lr7WSDtwvWBsJ5U5QKtY0/nm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872218; c=relaxed/simple;
	bh=HKIq9hY09BFUFtD+j2pgeoxjWnH5WfKCnBFvl6IdW5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6ofYv+x3j3DPRRagzENKVs1I4hQDQI7inQZJVRJHXo9f+MNls1uZ/n7puQkfHkP5mEuMy8fVy3Tr1cxBl7Jd8ECxgF8XGi5OepRU2Kq1VPDE2qkNPqIIVkucjB+6LAVzLHsYy+UB/oLjPz/a3dLIj7unTxo+akCV1kvkU1Vlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5CwBdCi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729872217; x=1761408217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HKIq9hY09BFUFtD+j2pgeoxjWnH5WfKCnBFvl6IdW5o=;
  b=N5CwBdCi+ZxcF14JBPl+/GS3D05N0/EKm7xfJN2pGZQsP8IzPpIPRB+v
   wmnfXKVwCVtbKylF9OCyM4n4okGcA4OBiPHTQo+wCRxMOZp1mDlxUQus8
   8xTpLIkWRK/NL4HGY7s9uOlh0XsTqY/LvZQ8ckipAazQ6VSxRpJJK6rff
   yV+fxQIEjAi5Ls3lCQ8QOY0NmWzzZ3cYqwkHh5rOPiDRTAQq3MaLqIqPG
   nyyzA38bWg/9mW8Q+I0O4vzNguV80oXpc1eIyXE63HPtLLO0+jNJhpGpw
   xy998VLuCHwq+7834+UAiEsnwaS5TWySlwHr+J3XREqYDlI2J/shk343w
   g==;
X-CSE-ConnectionGUID: uqqIX571QXmFvl3N4fO7AA==
X-CSE-MsgGUID: 1AkYx1VKTGGCDDPUc2OGgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29677780"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29677780"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:03:36 -0700
X-CSE-ConnectionGUID: vJWqYolwRAW+N4d8vgbNhw==
X-CSE-MsgGUID: LOvuvOzeQ2qva/5i3GfskA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="118403184"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.197.87]) ([10.245.197.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:03:32 -0700
Message-ID: <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
Date: Fri, 25 Oct 2024 18:03:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: Jani Nikula <jani.nikula@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <87bjz9sbqs.fsf@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <87bjz9sbqs.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/24/2024 6:32 PM, Jani Nikula wrote:
> On Thu, 24 Oct 2024, Nirmoy Das <nirmoy.das@intel.com> wrote:
>> Flush xe ordered_wq in case of ufence timeout which is observed
>> on LNL and that points to the recent scheduling issue with E-cores.
>>
>> This is similar to the recent fix:
>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>> response timeout") and should be removed once there is E core
>> scheduling fix.
>>
>> v2: Add platform check(Himal)
>>     s/__flush_workqueue/flush_workqueue(Jani)
>>
>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> ---
>>  drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> index f5deb81eba01..78a0ad3c78fe 100644
>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> @@ -13,6 +13,7 @@
>>  #include "xe_device.h"
>>  #include "xe_gt.h"
>>  #include "xe_macros.h"
>> +#include "compat-i915-headers/i915_drv.h"
> Sorry, you just can't use this in xe core. At all. Not even a little
> bit. It's purely for i915 display compat code.
>
> If you need it for the LNL platform check, you need to use:
>
> 	xe->info.platform == XE_LUNARLAKE


Will do that. That macro looked odd but I didn't know a better way.

>
> Although platform checks in xe code are generally discouraged.


This issue unfortunately depending on platform instead of graphics IP.


Thanks,

Nirmoy

>
> BR,
> Jani.
>
>
>
>>  #include "xe_exec_queue.h"
>>  
>>  static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
>> @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>>  		}
>>  
>>  		if (!timeout) {
>> +			if (IS_LUNARLAKE(xe)) {
>> +				/*
>> +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
>> +				 * worker in case of g2h response timeout")
>> +				 *
>> +				 * TODO: Drop this change once workqueue scheduling delay issue is
>> +				 * fixed on LNL Hybrid CPU.
>> +				 */
>> +				flush_workqueue(xe->ordered_wq);
>> +				err = do_compare(addr, args->value, args->mask, args->op);
>> +				if (err <= 0)
>> +					break;
>> +			}
>>  			err = -ETIME;
>>  			break;
>>  		}

