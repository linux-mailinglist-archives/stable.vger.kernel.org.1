Return-Path: <stable+bounces-95560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E49D9D59
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99342B26C45
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D31DD9AB;
	Tue, 26 Nov 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbLez1S1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31041DDA17
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645562; cv=none; b=AnyD5Ykp9Z/6J0fK0Ngw+HGc/Ghq9TYXt4QP26v9wIYmFFVdAY2/C1mNnyKajjElTte6fBByE3hH5ZK/mMwjiHIayW8NtLu3xeXewNm8IH5I8lcTKlbIdHW3neOnZ31cA9MXCPvAutqxbWrMo/QxykwNAIbsCAWHucPJ0x5i+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645562; c=relaxed/simple;
	bh=RNYuaAo6IQhY4HSHKcyrhSxpNjMgrV4l6t7l0IdbgiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJP5w4uHVjNMuXU5htdeV/YnHvnHUwd/3BBg6etAmclwiXaHJxQ7OXaqLpZPvXwGtJGV0dq1yhNHVpulJCYU8AI5zjnvklB9/rZN/1Gj4FTVlpgewXlmbob7qOXzJrTAkt0GzBR9qUGMuFKKmIxi8lE1oSgiN5o+/KmoyLazMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbLez1S1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732645561; x=1764181561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RNYuaAo6IQhY4HSHKcyrhSxpNjMgrV4l6t7l0IdbgiI=;
  b=TbLez1S1hCJeM7cH9iOujWfyulsRa9gBNV4F3lQ80OXJiGLN7sP/tXDi
   W/0/vNoiltxedJnizJYVPLUnFRwx3RZ6JTzhg8Ep+1lSE0AT2imxXno/D
   +ZVr/baQdPk/nDj1rcBKUR407b+8d24Ogm9i1dJa1xxzP7Gsl0wt2iaj4
   dfHwzA6MKZaGNJ+lYiL7Pnu0iN63Y5v4UOq09wWpA/9pRM8qjCEWbINJA
   YmeQLbnSt5bg5uO85QVTu/qQwx4ZPzCxnQhPFCnTCPU2YqqWbdYA7tM7p
   jr9VB/0DyaKwaX/6M0lhuWCa7YbaZXgb6LRDp34+nQ3SeVUef6LN3pzyF
   g==;
X-CSE-ConnectionGUID: 2tMGTlJPRD65Wd19X78hkA==
X-CSE-MsgGUID: l+jgqtihRP6AlTWW/AXqWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="43892275"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="43892275"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:26:00 -0800
X-CSE-ConnectionGUID: +/aDOK3sSBOrZ2J5MRAuPg==
X-CSE-MsgGUID: T9z4cZ6ZThOh7RxG2WIwRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91312812"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.160.19]) ([10.245.160.19])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:25:58 -0800
Message-ID: <66f90d3a-17fe-4837-a8c8-a97c04d3f754@linux.intel.com>
Date: Tue, 26 Nov 2024 19:25:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/xe/migrate: fix pat index usage
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Nirmoy Das
 <nirmoy.das@intel.com>, stable@vger.kernel.org
References: <20241126181259.159713-3-matthew.auld@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20241126181259.159713-3-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/26/2024 7:13 PM, Matthew Auld wrote:
> XE_CACHE_WB must be converted into the per-platform pat index for that
> particular caching mode, otherwise we are just encoding whatever happens
> to be the value of that enum.
>
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+

Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> index cfd31ae49cc1..48e205a40fd2 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -1350,6 +1350,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
>  
>  	/* For sysmem PTE's, need to map them in our hole.. */
>  	if (!IS_DGFX(xe)) {
> +		u16 pat_index = xe->pat.idx[XE_CACHE_WB];
>  		u32 ptes, ofs;
>  
>  		ppgtt_ofs = NUM_KERNEL_PDE - 1;
> @@ -1409,7 +1410,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
>  						pt_bo->update_index = current_update;
>  
>  					addr = vm->pt_ops->pte_encode_bo(pt_bo, 0,
> -									 XE_CACHE_WB, 0);
> +									 pat_index, 0);
>  					bb->cs[bb->len++] = lower_32_bits(addr);
>  					bb->cs[bb->len++] = upper_32_bits(addr);
>  				}

