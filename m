Return-Path: <stable+bounces-100445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D69EB58B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC8D1641E8
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61620232789;
	Tue, 10 Dec 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROSraWmT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A03231C8C
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846378; cv=none; b=VWQX+sb06sQVYVrjAECib16Gx+ZlHDf/wS1hkiOQkA9Pfz+VP1AtOlUSojJeNf1ggY8ku9c/wtsUIEstSmcbKHVx6j/ptak+TlweYXimwodDebPJarA20h+9r+IBV1py7Fra4MYVRw1Xzu0SCGXbBpdr2Ks6MDlQa8scaykuSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846378; c=relaxed/simple;
	bh=5pjft/W20eUX8JrsDVRJH6EKsIldtGO+hAWKlGzM3pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9ukgSf2ww76XF3zKds80ptDpMcQ4uGsEzLwfDvORl9g0nx24L07PJ12Vg/XQdQG2nSGzT8Yf2cn1K6HLAgAHuTu8GjWeMub9YW345vShSM2Ti0VlAbhKS1FkbcXrmXv7gY6qBlH+gdNUzNsQnqQP5h4/ECuzPVwkN6UPFewgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROSraWmT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733846376; x=1765382376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5pjft/W20eUX8JrsDVRJH6EKsIldtGO+hAWKlGzM3pY=;
  b=ROSraWmTlm7XotSr3uQW5CyL+8WSj1ZG92p8HiAwb2XdjXBGGRvO7yUd
   /rDc/ZxNaQ61q7QMhVvlr6y6Ha7aurbAcW5ZbhHWo5V8Ae544cYL4PMOv
   YUqWyQhJbzaD29cSR9u/d+Lk7IMyF/4B5M86AcQRBveXZXR7sukrOrB+z
   w6TQ4QHH54Lp+SSR1jz+SyQcSjdHC06+HcTT4raEw8yrt+86Jv9J57aui
   ALmVN3hOoSQG2+67kN3YxGPsZlNho6c2TKOe+/kb1FA9OcHoqyx6K1zFl
   AOL6xY9gkMwmlx+G+OnZqxejasQnW4n081rwLUBUN378QB1hfq7jTmiro
   Q==;
X-CSE-ConnectionGUID: x4X+C6H+QmG6jF7PSEUCTg==
X-CSE-MsgGUID: crCgG4c5TMCNnCRec9BuAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51723025"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="51723025"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:59:35 -0800
X-CSE-ConnectionGUID: phBmM0BcQ3OPLrqhoHTywQ==
X-CSE-MsgGUID: DxftFuYYTbKvD2AFdM8+HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="100408566"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.192.15]) ([10.245.192.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:59:33 -0800
Message-ID: <e9d7a359-2c38-4dab-a56e-b406198cf033@linux.intel.com>
Date: Tue, 10 Dec 2024 16:59:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/xe: Wait for migration job before unmapping
 pages
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
 intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20241205120253.2015537-1-nirmoy.das@intel.com>
 <20241205120253.2015537-2-nirmoy.das@intel.com>
 <5eb91aa3-6d84-47a9-9f07-1742fe723c41@intel.com>
 <695c408b-c077-44c1-9861-0af54148cc86@linux.intel.com>
 <6vthulgckq2jpfwn2amux5ssijwhxbjp44g2xwp44r626ttrkh@ofwboiylc7eh>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <6vthulgckq2jpfwn2amux5ssijwhxbjp44g2xwp44r626ttrkh@ofwboiylc7eh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/10/2024 4:38 PM, Lucas De Marchi wrote:
> On Thu, Dec 05, 2024 at 03:33:46PM +0100, Nirmoy Das wrote:
>>
>> On 12/5/2024 1:40 PM, Matthew Auld wrote:
>>> On 05/12/2024 12:02, Nirmoy Das wrote:
>>>> There could be still migration job going on while doing
>>>> xe_tt_unmap_sg() which could trigger GPU page faults. Fix this by
>>>> waiting for the migration job to finish.
>>>>
>>>> v2: Use intr=false(Matt A)
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
>>>> Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>> Cc: <stable@vger.kernel.org> # v6.11+
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>>>
>>> Ok, so this is something like ttm_bo_move_to_ghost() doing a pipeline move for tt -> system, but we then do xe_tt_unmap_sg() too early which tears down the IOMMU (if enabled) mappings whilst the job is in progress?
>> Yes, this exactly what is happening for this issue.
>>>
>>> Maybe add some more info to the commit message?
>>
>> I will add more details.
>
> Are you going to send a new version?

Was waiting for more reviews. Sent  out v3 with updated commit message.


> Once this is fixed, please also
> send a revert MR to the kconfig workaround
> 3940181b1bad @ gitlab.freedesktop.org/drm/xe/ci.git

I will do that.


Thanks,

Nirmoy

>
> Lucas De Marchi
>
>>
>>
>>> I think this for sure fixes it. Just wondering if it's somehow possible to keep the mapping until the job is done, since all tt -> sys moves are now synced here?
>>>
>>> Unless Thomas has a better idea here,
>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>
>>
>> Thanks,
>>
>> Nirmoy
>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
>>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>>> index b2aa368a23f8..c906a5529db0 100644
>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>> @@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>>>>     out:
>>>>       if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
>>>> -        ttm_bo->ttm)
>>>> +        ttm_bo->ttm) {
>>>> +        long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
>>>> +                             DMA_RESV_USAGE_BOOKKEEP,
>>>> +                             false,
>>>> +                             MAX_SCHEDULE_TIMEOUT);
>>>> +        if (timeout < 0)
>>>> +            ret = timeout;
>>>> +
>>>>           xe_tt_unmap_sg(ttm_bo->ttm);
>>>> +    }
>>>>         return ret;
>>>>   }
>>>

