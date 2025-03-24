Return-Path: <stable+bounces-125871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E3A6D78D
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEE0189457E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7FD25D8F4;
	Mon, 24 Mar 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huNX8NvZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4213C81B
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808870; cv=none; b=FK9uI2O3qau8/kfUHBRNiChzvx3HlyvetuzYsdI0+t/vubSFHYRfJDA17yObU3iktgU70hf2xvbevKucIQOD5UCkL5/to772SXNgRVjsg0yxb1GipgJf6Gcg4URjIlEfdXAtsoHLvNgAYWC+sHq3+xtVMmFV//4aXI+F3v/mXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808870; c=relaxed/simple;
	bh=r1dQEktHFkwsHLZgPuYKuaEXWfGQeaDIxWwGvGdmQco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9CU6ZqrQHVjbLNZadM0VwZzbmwWuE9EvMSAY0xQ9rXbXJlCP+VnXIbAgeB974+TCFAylwU/AK+W71rMaAHGZzwRH1X9rmfBWGc5HBDnZWrfRqYxRIc5N0yr+84LRYFWdM9S7cBXoj5AJNq4FD+VXV+aKUw7VPnTc085NOO56VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huNX8NvZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742808869; x=1774344869;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=r1dQEktHFkwsHLZgPuYKuaEXWfGQeaDIxWwGvGdmQco=;
  b=huNX8NvZitAUg3uk8AYN/GPhWR/6+l/AASX+TS7fibuNVoFJ5OeMIkW6
   BlWesm2ZWmxpEERpNWdB/r7mhbdOiFTOStoB9LWqxEN2/0LzxXVz4EI98
   B1PNQ+3Vfm1u9C14tjHZGKiDgCePjPlSOdJK/xxFKTZtxePzCGk/t/pzi
   BLt9IM8T8TqJCuvBfE080ERGuSO53+gOWt+Ski6DJ1lok+aSMO3PmQoJW
   hvi/ek43UIqJMG8tXVNIR6Kmj08pVff251KmSa+9UdkWwZ7suvM3s5IxV
   0xh2EDC7uzIv7Dkq+F6sgRrjaxCta9tj++wjwipugcIGQx97ZCByWMA3Q
   g==;
X-CSE-ConnectionGUID: 468fNiy1TX60Lngs0Qkl6A==
X-CSE-MsgGUID: plnv81ddRB6ISsDi4NB30Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="55002547"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="55002547"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:34:28 -0700
X-CSE-ConnectionGUID: okwWYH7EQAy7N3jMonWbgw==
X-CSE-MsgGUID: /24OaiqRQNiTHJ0ws0yTKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="129070606"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:34:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Chauvet <kwizart@gmail.com>, Zhenyu Wang
 <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Nicolas Chauvet <kwizart@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] [RFC] drm/i915/gvt: Fix opregion_header->signature
 size
In-Reply-To: <87pli6bwxi.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250324083755.12489-1-kwizart@gmail.com>
 <20250324083755.12489-3-kwizart@gmail.com> <87pli6bwxi.fsf@intel.com>
Date: Mon, 24 Mar 2025 11:34:21 +0200
Message-ID: <87h63ibwma.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 24 Mar 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
>> Enlarge the signature field to accept the string termination.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
>> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
>
> Nope, can't do that. The packed struct is used for parsing data in
> memory.

Okay, so I mixed this up with display/intel_opregion.c. So it's not used
for parsing here... but it's used for generating the data in memory, and
we can't change the layout or contents.

Regardless, we can't do either patch 2 or patch 3.

BR,
Jani.


>
> BR,
> Jani.
>
>
>> ---
>>  drivers/gpu/drm/i915/gvt/opregion.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
>> index 9a8ead6039e2..0f11cd6ba383 100644
>> --- a/drivers/gpu/drm/i915/gvt/opregion.c
>> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
>> @@ -43,7 +43,7 @@
>>  #define DEVICE_TYPE_EFP4   0x10
>>  
>>  struct opregion_header {
>> -	u8 signature[16];
>> +	u8 signature[32];
>>  	u32 size;
>>  	u32 opregion_ver;
>>  	u8 bios_ver[32];

-- 
Jani Nikula, Intel

