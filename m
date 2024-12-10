Return-Path: <stable+bounces-100441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506DF9EB533
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86ED168005
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF51BBBC0;
	Tue, 10 Dec 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqk/9bn7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59251BB6A0
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845143; cv=none; b=ZcFfiOBNAwhF2wq6HfogbsivJMdchXajvexL6HB1JbSwQQuza87XHErLNocXWO8dG5l3rm1zOca8qo0XhAi+QcE2cTfrE5xbDz7kLxNVPqfiVi4sbKkkusPQArkKf4vdm9BR/nm0X8B5SGwYTUPgOq9rMxxxGzkyzm/SK9Dkd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845143; c=relaxed/simple;
	bh=Yrb3yG6TmtINv89SjNBJPEwRb5ueiDKtKnTOmw8qKvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOwylNcqZZGtB52hDGglUvz3OLvXa8Xfvn1AYQmpC7IChLAaU0r4jTcDudYTY4TS/cvaCNxE+Kd1UtyNlt9EaC+FQRwTTSCLCMHzVk7giIE9OMqQCJThGxQIFkJ7WGQLoc7LcIVriLkZI0OYZhaoO87gT01yZaLE8KQc1hCl/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qqk/9bn7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733845141; x=1765381141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Yrb3yG6TmtINv89SjNBJPEwRb5ueiDKtKnTOmw8qKvo=;
  b=Qqk/9bn7u2uhjS34gh3UOu6VxcyYtEsPaHwBPB9qXiPzgvLKBQ9jnnHc
   o6hXZOhqLDN+O/qxmTzwaBlUwh9I3iyYMw0TfdByoNrdi4rK9cSBOftzQ
   OnUwnEr7e5zXS4S6wufklTtvMRFPS1Y+iV0/gpHyakM5em4Gv9AguTL2/
   fvnh9WLbpTKHtRt/zVSQrE1LDsbeNs5fjDYx++OFnf5C+4L7Igh3Ry8DQ
   Nn/tKnVeLEZMrgnEyb6X3JRh1y5XNzlcJTumkb2jrkM98rpI4vHB/E4/X
   wVWNyGf9I3Z3M+CLC6gxybouNNGNPLpdZ9ubsgFB3jGn2Hl3Hn6bNwz9G
   A==;
X-CSE-ConnectionGUID: uFb9drkwTCSWWc4ZG576DQ==
X-CSE-MsgGUID: 6b1HILiQRPuJ3u2m5nHuOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34077866"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34077866"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:39:00 -0800
X-CSE-ConnectionGUID: 4/3v7p/ISJKcnZeyTDYSQA==
X-CSE-MsgGUID: +HjiT3xqRLe14PY8Gp1m+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100506727"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.109.171])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:38:59 -0800
Date: Tue, 10 Dec 2024 07:38:54 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Nirmoy Das <nirmoy.das@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>, 
	Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/xe: Wait for migration job before unmapping
 pages
Message-ID: <6vthulgckq2jpfwn2amux5ssijwhxbjp44g2xwp44r626ttrkh@ofwboiylc7eh>
References: <20241205120253.2015537-1-nirmoy.das@intel.com>
 <20241205120253.2015537-2-nirmoy.das@intel.com>
 <5eb91aa3-6d84-47a9-9f07-1742fe723c41@intel.com>
 <695c408b-c077-44c1-9861-0af54148cc86@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <695c408b-c077-44c1-9861-0af54148cc86@linux.intel.com>

On Thu, Dec 05, 2024 at 03:33:46PM +0100, Nirmoy Das wrote:
>
>On 12/5/2024 1:40 PM, Matthew Auld wrote:
>> On 05/12/2024 12:02, Nirmoy Das wrote:
>>> There could be still migration job going on while doing
>>> xe_tt_unmap_sg() which could trigger GPU page faults. Fix this by
>>> waiting for the migration job to finish.
>>>
>>> v2: Use intr=false(Matt A)
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
>>> Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.11+
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>>
>> Ok, so this is something like ttm_bo_move_to_ghost() doing a pipeline move for tt -> system, but we then do xe_tt_unmap_sg() too early which tears down the IOMMU (if enabled) mappings whilst the job is in progress?
>Yes, this exactly what is happening for this issue.
>>
>> Maybe add some more info to the commit message?
>
>I will add more details.

Are you going to send a new version? Once this is fixed, please also
send a revert MR to the kconfig workaround
3940181b1bad @ gitlab.freedesktop.org/drm/xe/ci.git

Lucas De Marchi

>
>
>> I think this for sure fixes it. Just wondering if it's somehow possible to keep the mapping until the job is done, since all tt -> sys moves are now synced here?
>>
>> Unless Thomas has a better idea here,
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
>
>Thanks,
>
>Nirmoy
>
>>
>>> ---
>>>   drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>> index b2aa368a23f8..c906a5529db0 100644
>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>> @@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>>>     out:
>>>       if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
>>> -        ttm_bo->ttm)
>>> +        ttm_bo->ttm) {
>>> +        long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
>>> +                             DMA_RESV_USAGE_BOOKKEEP,
>>> +                             false,
>>> +                             MAX_SCHEDULE_TIMEOUT);
>>> +        if (timeout < 0)
>>> +            ret = timeout;
>>> +
>>>           xe_tt_unmap_sg(ttm_bo->ttm);
>>> +    }
>>>         return ret;
>>>   }
>>

