Return-Path: <stable+bounces-214513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMWqJ5fGhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:34:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDC4F54A5
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9EA304D97B
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D1438FFD;
	Thu,  5 Feb 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nkj9vK9G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E7438FF8
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309044; cv=none; b=GNGY80LV23FywbmCfqXsB0tg6Cise9LozUyy1eIjXPN5BiCOYI6pfoC0AC/DbKacmXJz8tUx0ug4r12EnY0xlLpnRAGGvSiD8LeCZy4o0Dz7D82w1vMZTBPrDn6N4hU0lUVgn29fld1iExT44Ul4kgJ7bO/lO2uUryPGcyxYG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309044; c=relaxed/simple;
	bh=vufy4dgLTMftlQVlBW3PAYdOu7jlYglucCx5MOrxHKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZYM9voLBSOEUI7HQreSJIdhjLZbyAu8Gk2kt6ntG0G4ekvt1RU8NdetOcFJdtraCIUz59e548ZEbkicQauMDxyoBxGgNVffGdbtiXFVrDANY1cmSuLX2CyybUGJt/NahuVc1pJK834shAKUVbiz95QfNYVOgXPuINLFS9Mx5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nkj9vK9G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770309044; x=1801845044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vufy4dgLTMftlQVlBW3PAYdOu7jlYglucCx5MOrxHKg=;
  b=Nkj9vK9GidLobgs77briUlpJo6i2ajLKPXxJIJu2KEqB2xB78o4VQoYo
   0BzulvpqcbyiZWhxgS6HWEgZHBDDt97gAkGoGZiAQfulYT3YYEwpngrZD
   uEmy51HkW7BHrYFiuhEAvLnTMkBnAUwJQvrTEEGABgN/FBjIrR5lBmn/z
   ys4t7JlxDVwNJpNHE8EzJ0p1kb/GXSOR03mtaC0R7BmYv6vThPxJpJiMz
   Zm6KwgTN1UZcQqIP/+AyGad8WH4atFIJKmeIVl3KdxiCon4AngY38RhHy
   VrD8qvqG3M0mGIIlRwx4Y32FnNh+YD64cG/dOTKRpUDbZoFuqyIlto/V4
   g==;
X-CSE-ConnectionGUID: 6UQk7/g0SQC6g1UThWPgTg==
X-CSE-MsgGUID: xQLc0okISI6WEgMYKIV1DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82144762"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82144762"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:30:43 -0800
X-CSE-ConnectionGUID: xtBIMBlVR3e8QXAmXdpaDw==
X-CSE-MsgGUID: nirSzZFvRYq+O5TPMCYmeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210385117"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.124]) ([10.245.244.124])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:30:41 -0800
Message-ID: <2c1d5a59-9f1b-4263-b9cf-89b4c7eb59e5@intel.com>
Date: Thu, 5 Feb 2026 16:30:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/xe: Add bounds check on pat_index to prevent OOB
 kernel read in madvise
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260203172045.1154546-1-jia.yao@intel.com>
 <20260205161529.1819276-1-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260205161529.1819276-1-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214513-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFDC4F54A5
X-Rspamd-Action: no action

On 05/02/2026 16:15, Jia Yao wrote:
> When user provides a bogus pat_index value through the madvise IOCTL, the
> xe_pat_index_get_coh_mode() function performs an array access without
> validating bounds. This allows a malicious user to trigger an out-of-bounds
> kernel read from the xe->pat.table array.
> 
> The vulnerability exists because the validation in madvise_args_are_sane()
> directly calls xe_pat_index_get_coh_mode(xe, args->pat_index.val) without
> first checking if pat_index is within [0, xe->pat.n_entries).
> 
> Although xe_pat_index_get_coh_mode() has a WARN_ON to catch this in debug
> builds, it still performs the unsafe array access in production kernels.
> 
> v2(Matthew Auld)
> - Using array_index_nospec() to mitigate spectre attacks when the value
> is used
> 
> v3(Matthew Auld)
> - Put the declarations at the start of the block
> 
> Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.18+
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_vm_madvise.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
> index add9a6ca2390..091e450b781c 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
> @@ -246,6 +246,10 @@ static int xe_vm_invalidate_madvise_range(struct xe_vm *vm, u64 start, u64 end)
>   
>   static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madvise *args)
>   {
> +	s32 fd;
> +	u16 pat_index;
> +	u16 coh_mode;
> +
>   	if (XE_IOCTL_DBG(xe, !args))
>   		return false;
>   
> @@ -261,7 +265,7 @@ static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madv
>   	switch (args->type) {
>   	case DRM_XE_MEM_RANGE_ATTR_PREFERRED_LOC:
>   	{
> -		s32 fd = (s32)args->preferred_mem_loc.devmem_fd;

Nit: This was fine. The {} is also a block.

> +		fd = (s32)args->preferred_mem_loc.devmem_fd;
>   
>   		if (XE_IOCTL_DBG(xe, fd < DRM_XE_PREFERRED_LOC_DEFAULT_SYSTEM))
>   			return false;
> @@ -291,8 +295,11 @@ static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madv
>   		break;
>   	case DRM_XE_MEM_RANGE_ATTR_PAT:
>   	{
> -		u16 coh_mode = xe_pat_index_get_coh_mode(xe, args->pat_index.val);

Same here, we could just add pat_index here. Anyway, this can be fixed 
up when merging, no need to resend.

> +		if (XE_IOCTL_DBG(xe, args->pat_index.val >= xe->pat.n_entries))
> +			return false;
>   
> +		pat_index = array_index_nospec(args->pat_index.val, xe->pat.n_entries);
> +		coh_mode = xe_pat_index_get_coh_mode(xe, pat_index);
>   		if (XE_IOCTL_DBG(xe, !coh_mode))
>   			return false;
>   


