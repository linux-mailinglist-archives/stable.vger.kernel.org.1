Return-Path: <stable+bounces-210719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIyEHTyrcGkgZAAAu9opvQ
	(envelope-from <stable+bounces-210719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:32:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA7553ED
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 886C98E76AF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7C480334;
	Wed, 21 Jan 2026 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBhtr+iq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896F3ACA4B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989618; cv=none; b=d6QZ2B0z4nymX+b53SWEvUbdpqKMb2VOznGXDEVMQtzwOXfIYHykuswLHAhumsFK4UrAvLXi4gg8/Ul888o97+qeGylEAVxApuJU6m2CHNDf4dObBB4sSWEp5trCg9qYV/goza20f6VkJvpYdKH5JXyoD7X7MQ/wsjVL2qIDVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989618; c=relaxed/simple;
	bh=wpVhcqegH84vgpSd/7Z8b3/XFcMb+4orma0aWUeifO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv+ZHftV1dhxcHpkGdWkJL8QQ8WTnAn8S6FjipXcWv4kR+ihSqrtSHZLYoYOwXXAhNBpG5ziHS8P6eFJuRRiWyJb2IWVYp6zWV0vNnxNZkBR/vRPgUuM1ydOSo31lnpcUCsreXZBIHYHheLQwRUBR6yIgVjefjIdyxGNOrNGEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBhtr+iq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768989616; x=1800525616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wpVhcqegH84vgpSd/7Z8b3/XFcMb+4orma0aWUeifO0=;
  b=fBhtr+iqanec3ZbV9jMWFfmRHFYljSYQC2mt4UwzEFLiPJuLIIminpQ0
   XjqV97eFTynUNaQeQzozwIo+SxgRvTiVgZYmiTrxTOS9hsSHLJ1UWCK9H
   2+J3qqlt0X0B7dd9OxJCz9u+Q738arXSo1tyGHR/avEKoYginInJhRTq7
   eXBjDiEDIX8qobnt4ByuWEuRlMgfQC5ci03TETs29L8WtUpaAdaMtrXiY
   UL7J61Y3XbwlzXYJ6CPKpDCVFv2EjWdD3sdXb8JUp6FNsdN+PhMXqY8Vx
   y2yv4QBNio1H2C7jkn1glWu/3N7NSDbcWJCqnrHA5nNfzCSqP/3dzQqWz
   w==;
X-CSE-ConnectionGUID: jZU0kcemQJmd0FjuhvO8vQ==
X-CSE-MsgGUID: ykILMx7gTU6D0GDkKsC2Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74065619"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74065619"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 02:00:14 -0800
X-CSE-ConnectionGUID: +KLZcQ2GTdqI+x2MkaVhiw==
X-CSE-MsgGUID: i0xCllZLQqeoIwGwqrl1fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206466917"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.122]) ([10.245.245.122])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 02:00:13 -0800
Message-ID: <8673cd9b-7140-4209-9d44-bbf3508cc266@intel.com>
Date: Wed, 21 Jan 2026 10:00:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/buddy: Prevent BUG_ON by validating rounded
 allocation
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Sanjay Yadav <sanjay.kumar.yadav@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260108113227.2101872-4-sanjay.kumar.yadav@intel.com>
 <20260108113227.2101872-5-sanjay.kumar.yadav@intel.com>
 <654f40ab-8402-4bb1-88ff-742572a1b251@intel.com>
 <0b5fa253-1c2d-45ae-a6bd-0373e27af64c@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <0b5fa253-1c2d-45ae-a6bd-0373e27af64c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210719-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,amd.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 78AA7553ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 06:36, Arunpravin Paneer Selvam wrote:
> 
> On 20/01/26 16:11, Matthew Auld wrote:
>> On 08/01/2026 11:32, Sanjay Yadav wrote:
>>> When DRM_BUDDY_CONTIGUOUS_ALLOCATION is set, the requested size is
>>> rounded up to the next power-of-two via roundup_pow_of_two().
>>> Similarly, for non-contiguous allocations with large min_block_size,
>>> the size is aligned up via round_up(). Both operations can produce a
>>> rounded size that exceeds mm->size, which later triggers
>>> BUG_ON(order > mm->max_order).
>>>
>>> Example scenarios:
>>> - 9G CONTIGUOUS allocation on 10G VRAM memory:
>>>    roundup_pow_of_two(9G) = 16G > 10G
>>> - 9G allocation with 8G min_block_size on 10G VRAM memory:
>>>    round_up(9G, 8G) = 16G > 10G
>>>
>>> Fix this by checking the rounded size against mm->size. For
>>> non-contiguous or range allocations where size > mm->size is invalid,
>>> return -EINVAL immediately. For contiguous allocations without range
>>> restrictions, allow the request to fall through to the existing
>>> __alloc_contig_try_harder() fallback.
>>>
>>> This ensures invalid user input returns an error or uses the fallback
>>> path instead of hitting BUG_ON.
>>>
>>> v2: (Matt A)
>>> - Add Fixes, Cc stable, and Closes tags for context
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6712
>>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>>> Cc: <stable@vger.kernel.org> # v6.7+
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>> Suggested-by: Matthew Auld <matthew.auld@intel.com>
>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> Arun/Christian, when you get a chance could you also merge these two 
>> please?
> 
> I have merged these 2 patches as well.

Thanks.

> 
> Regards,
> 
> Arun.
> 
>>
>>> ---
>>>   drivers/gpu/drm/drm_buddy.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
>>> index 2f279b46bd2c..5141348fc6c9 100644
>>> --- a/drivers/gpu/drm/drm_buddy.c
>>> +++ b/drivers/gpu/drm/drm_buddy.c
>>> @@ -1155,6 +1155,15 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
>>>       order = fls(pages) - 1;
>>>       min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>>>   +    if (order > mm->max_order || size > mm->size) {
>>> +        if ((flags & DRM_BUDDY_CONTIGUOUS_ALLOCATION) &&
>>> +            !(flags & DRM_BUDDY_RANGE_ALLOCATION))
>>> +            return __alloc_contig_try_harder(mm, original_size,
>>> +                             original_min_size, blocks);
>>> +
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       do {
>>>           order = min(order, (unsigned int)fls(pages) - 1);
>>>           BUG_ON(order > mm->max_order);
>>


