Return-Path: <stable+bounces-28175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741CB87C0EF
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 17:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BFA282F2F
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A766FE3D;
	Thu, 14 Mar 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWUTNu1+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02973180
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432390; cv=none; b=NbibyiUvT1Us4LXrWvKOIWeiYuFNl1XCHlSfAICMqhgQm9mhhuy5vKIQu1VzW9Dl4KSvZNxXW4uk7BOM3dB+g1JOdQz8xmI+wc4gEVx6uWOzXzlFSwPuwrTVglED9Nc7zfPCcgvI+1/L3DWzagHF8E1pgesUmIddKCqA0s2+bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432390; c=relaxed/simple;
	bh=xAnI8MPiFBJ2niClHFiZeOk8l5r7cL4JtmHSlGbzMXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO/h/a8p7TuR1HtNit+agHZRB3r6+1L2zAt0TYdlLYejuAIUsWE9M+mJ7xRG//8EMyuvoCRtA7Ik2uYy6+vJ3D/0K9GSE7C+r/DVDqCKWNvrzjV/4zXjZ+KP3fNGbu5lMtF7xu23PcoUDNjg86LOMk7igosbRChJKVoX6ZuE8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWUTNu1+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710432389; x=1741968389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xAnI8MPiFBJ2niClHFiZeOk8l5r7cL4JtmHSlGbzMXk=;
  b=AWUTNu1+prHC7k6tSI1E1cNS9yAQOKB3wyN61y1zDR778tA7ll1OWGUA
   4qadOxNAdjrWEer5VWc5ywJJ1sfAZ5KTuaQzITc1yo3A6EwGntm82jmUa
   SXoaquISeyHI/g+o4ywQ2ZExYd6EWuD3D6yd396KyA49e7lC4yLpQFZ0d
   /o7naw2cWMKfX6K5OZWDDfeJ1bfVCIu1ezzfpyYd2dyx7tLxCJbdTPrXs
   EgTgjQZ8pvJ3Pp7pcm4D74nD1AkK5iV0grmW+pSFhaqyOfW20TOqSBfj/
   hHebW04aoOgz8OkaZtr4m34bYzr7B0+qSWHkdMf+MxiJWsfJu4xrfhBgk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16417455"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="16417455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="43259502"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.246.35.115]) ([10.246.35.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:05:11 -0700
Message-ID: <35df0767-384f-49f2-806a-f83765ca7c4c@linux.intel.com>
Date: Thu, 14 Mar 2024 17:05:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Report full vm address range
Content-Language: en-US
To: Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Chris Wilson <chris.p.wilson@linux.intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
 stable@vger.kernel.org
References: <20240313193907.95205-1-andi.shyti@linux.intel.com>
 <46ab1d25-5d16-4610-8b8f-2ee07064ec2e@intel.com>
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <46ab1d25-5d16-4610-8b8f-2ee07064ec2e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/14/2024 3:04 PM, Lionel Landwerlin wrote:
> Hi Andi,
>
> In Mesa we've been relying on I915_CONTEXT_PARAM_GTT_SIZE so as long 
> as that is adjusted by the kernel

What do you mean by adjusted by, should it be a aligned size?

I915_CONTEXT_PARAM_GTT_SIZE ioctl is returning vm->total which is 
adjusted(reduced by a page).

This patch might cause silent error as it is not removing WABB which is 
using the reserved page to add dummy blt and if userspace is using that

page then it will be overwritten.


Regards,

Nirmoy

> , we should be able to continue working without issues.
>
> Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
>
> Thanks,
>
> -Lionel
>
> On 13/03/2024 21:39, Andi Shyti wrote:
>> Commit 9bb66c179f50 ("drm/i915: Reserve some kernel space per
>> vm") has reserved an object for kernel space usage.
>>
>> Userspace, though, needs to know the full address range.
>>
>> Fixes: 9bb66c179f50 ("drm/i915: Reserve some kernel space per vm")
>> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
>> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
>> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
>> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
>> Cc: Michal Mrozek <michal.mrozek@intel.com>
>> Cc: Nirmoy Das <nirmoy.das@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.2+
>> ---
>>   drivers/gpu/drm/i915/gt/gen8_ppgtt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c 
>> b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
>> index fa46d2308b0e..d76831f50106 100644
>> --- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
>> +++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
>> @@ -982,8 +982,9 @@ static int gen8_init_rsvd(struct 
>> i915_address_space *vm)
>>         vm->rsvd.vma = i915_vma_make_unshrinkable(vma);
>>       vm->rsvd.obj = obj;
>> -    vm->total -= vma->node.size;
>> +
>>       return 0;
>> +
>>   unref:
>>       i915_gem_object_put(obj);
>>       return ret;
>
>

