Return-Path: <stable+bounces-210481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGadDC/Jb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:27:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4A49724
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D412C5E06FB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C163ED115;
	Tue, 20 Jan 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdC+YUaa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB13F23D6
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905724; cv=none; b=JXtC3rwIxZDoBVwFzZlW42+DKt+yYMuyM/oAIOdHiSTSY7GzUG/Bb7+0zjvog30y20OV4ZVm6CYAkHoXqIC8qzq+polg0LoLg9ob3kAvDGlD74kMkk0APs8DRBSqYNwhZqa5uKCh26b1pBhpP/Si7wa8wy/ALjlnOmE7ex/fomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905724; c=relaxed/simple;
	bh=0l3VHXyDJw0+QakH6PJ+JROapppkV5FjgLHShJX5VKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0DHwFQ4qpKX3Eb29ZbbGCNl7HDGBMbBiP8NnKqinPX/UgdO0dkcVwUc8gLPGdl7rKBMAhHJnQMwuyVAxHdMb7P9UaXRaMjd0Uo7bWHCylziQqbfy5aYIqByVYOj1JxlaLxh3pfUPULZgOWKgAVkMlMdDuylGq3q5JpfvzLZhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdC+YUaa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768905723; x=1800441723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0l3VHXyDJw0+QakH6PJ+JROapppkV5FjgLHShJX5VKo=;
  b=KdC+YUaa5N8k392IA+lE+ZykUsiP/2ZG3Flfeyu6cMr6Cea8FAsZ3uJd
   E85Zq1JRkXWZFQYRTqSYH9JB69tvGMyHDBg1mIdWTFl5jzqheX5VB56iS
   4oRgSUNv3hnriZt1c+Q8gG2bhlabzT2NLO3k8eNJM8ozTNOhmU5gwXlM0
   fMZ/mVQFIQHNNbmFmt4nqp+s+FKmqkfhcOJ9DOsWZmvRMFk/EywaYuF94
   J/IC/dB3o2nDXFtpTHXbl9oMMlERL/kjC3Vw6x3ElILDeDebbNUbppgMh
   /seqCPEfinBpxILa2Sohbk822VLnd0vAZN75K+dIZtZ63BCOofmgiQrkz
   Q==;
X-CSE-ConnectionGUID: PiZQSA08TI6hzx2s7mIT5Q==
X-CSE-MsgGUID: HVEdWeMtSE+MCJac/DqhbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70164498"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70164498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:42:02 -0800
X-CSE-ConnectionGUID: AwXlz7FdQYO8TgQAfjhtbQ==
X-CSE-MsgGUID: I1f4jfO7Rj+/ZaHDgmWDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205889692"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.235]) ([10.245.244.235])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:42:01 -0800
Message-ID: <654f40ab-8402-4bb1-88ff-742572a1b251@intel.com>
Date: Tue, 20 Jan 2026 10:41:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/buddy: Prevent BUG_ON by validating rounded
 allocation
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
References: <20260108113227.2101872-4-sanjay.kumar.yadav@intel.com>
 <20260108113227.2101872-5-sanjay.kumar.yadav@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260108113227.2101872-5-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210481-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: CDA4A49724
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 08/01/2026 11:32, Sanjay Yadav wrote:
> When DRM_BUDDY_CONTIGUOUS_ALLOCATION is set, the requested size is
> rounded up to the next power-of-two via roundup_pow_of_two().
> Similarly, for non-contiguous allocations with large min_block_size,
> the size is aligned up via round_up(). Both operations can produce a
> rounded size that exceeds mm->size, which later triggers
> BUG_ON(order > mm->max_order).
> 
> Example scenarios:
> - 9G CONTIGUOUS allocation on 10G VRAM memory:
>    roundup_pow_of_two(9G) = 16G > 10G
> - 9G allocation with 8G min_block_size on 10G VRAM memory:
>    round_up(9G, 8G) = 16G > 10G
> 
> Fix this by checking the rounded size against mm->size. For
> non-contiguous or range allocations where size > mm->size is invalid,
> return -EINVAL immediately. For contiguous allocations without range
> restrictions, allow the request to fall through to the existing
> __alloc_contig_try_harder() fallback.
> 
> This ensures invalid user input returns an error or uses the fallback
> path instead of hitting BUG_ON.
> 
> v2: (Matt A)
> - Add Fixes, Cc stable, and Closes tags for context
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6712
> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> Cc: <stable@vger.kernel.org> # v6.7+
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Arun/Christian, when you get a chance could you also merge these two please?

> ---
>   drivers/gpu/drm/drm_buddy.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index 2f279b46bd2c..5141348fc6c9 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -1155,6 +1155,15 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
>   	order = fls(pages) - 1;
>   	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>   
> +	if (order > mm->max_order || size > mm->size) {
> +		if ((flags & DRM_BUDDY_CONTIGUOUS_ALLOCATION) &&
> +		    !(flags & DRM_BUDDY_RANGE_ALLOCATION))
> +			return __alloc_contig_try_harder(mm, original_size,
> +							 original_min_size, blocks);
> +
> +		return -EINVAL;
> +	}
> +
>   	do {
>   		order = min(order, (unsigned int)fls(pages) - 1);
>   		BUG_ON(order > mm->max_order);


