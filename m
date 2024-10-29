Return-Path: <stable+bounces-89184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD409B47C6
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F357E284D3D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A6205AD3;
	Tue, 29 Oct 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtwQJA6w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722E205ACA
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199555; cv=none; b=YYxFnTCMt4eKiobNgsmmU2jVp7HG/yjmutdSgh0CzR7tIKbx20J21g9ftQnY5BnUGttYAh+zVroRhQWxvfGbmRAfOD0HuhzPjvMunRB59GwcEoUJIgmEhwOKhnkJjQ7Bb/7xWSdF9aJ++Hh+V80qTptbWwoSAUAbOvDCWhf8/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199555; c=relaxed/simple;
	bh=D4x0LW2X773aTtiklWD6zcs30iEW3uOTvFhsGYQ/xTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYZDw5dVk0MX5H3G8qqDjGfL+qaS7Ta/rD2C7GN4j2inNjVHfSRovtmqTUsfTPGks3wYlDSBxVGkxBlDzz/tAalC4dedis6CBKWXHWr9b5KnEAjsOGXl1Pl85j7xnh3W4cbH2hUgeckqqETsUVhBGQU8zH8dMRd6Ho+fvRNgbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtwQJA6w; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730199553; x=1761735553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D4x0LW2X773aTtiklWD6zcs30iEW3uOTvFhsGYQ/xTM=;
  b=PtwQJA6w5NesH+1m/e44QMaMND+68CQ5BJFU1NuluOU0PjooKpegmG9w
   00ibLxbdiZmiUdd9kqZn1Ug3Rl2sH2fQKfqTzPtdYZC1Vjcvp1xnaiEWA
   rCG/hi3npL55spPXR4H2udA2q6BsD9dSVrb8NrkNuAsC4bdRsSVULVbvj
   2WRpllxzn5DP1nGjUqo17OyJ1+xiYgTU/LJ1fvMSceQyZUPVBcAod8u92
   +bC8K/LWKCfky+mO/HIOf99cXNJgCqFH8IpICTkV9AXiOINtDixANSGtg
   DTlusOuqCQZBfUhhXsgMwMtS8Ko4m8IF+wI0yKKcR2e1TmvuCY8KMyn9F
   Q==;
X-CSE-ConnectionGUID: EUrLpQiWTfKXLoFHjVn30A==
X-CSE-MsgGUID: 99RnpfdzR+uZxVpLJdnRow==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="17466066"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="17466066"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:59:12 -0700
X-CSE-ConnectionGUID: mXaZVkVTR7+sEWVgmdKucg==
X-CSE-MsgGUID: gG0dogHoQFWFIXyYOzXJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86535921"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.244.40]) ([10.245.244.40])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:59:10 -0700
Message-ID: <b50daa2b-45b7-434b-88e9-d5f40bcc6542@intel.com>
Date: Tue, 29 Oct 2024 10:59:08 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb
 timeout
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org
References: <20241029095416.3919218-1-nirmoy.das@intel.com>
 <20241029095416.3919218-3-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241029095416.3919218-3-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 09:54, Nirmoy Das wrote:
> Flush the g2h worker explicitly if TLB timeout happens which is
> observed on LNL and that points to the recent scheduling issue with
> E-cores on LNL.
> 
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is E core
> scheduling fix.
> 
> v2: Add platform check(Himal)
> v3: Remove gfx platform check as the issue related to cpu
>      platform(John)
>      Use the common WA macro(John) and print when the flush
>      resolves timeout(Matt B)
> 
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> index 773de1f08db9..0bdb3ba5220a 100644
> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> @@ -81,6 +81,15 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
>   		if (msecs_to_jiffies(since_inval_ms) < tlb_timeout_jiffies(gt))
>   			break;
>   
> +		LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);

I think here we are holding the pending lock, and g2h worker also wants 
to grab that same lock so this smells like potential deadlock. Also 
flush_work can sleep so I don't think is allowed under spinlock.

> +		since_inval_ms = ktime_ms_delta(ktime_get(),
> +						fence->invalidation_time);

I think invalidation_time is rather when we sent off the invalidation 
req, and we already check that above so if we get here then we know the 
timeout has expired for this fence, so checking again after the flush 
doesn't really help AFAICT.

I think we can just move the flush to before the loop and outside the 
lock, and then if the fence(s) gets signalled they will be removed from 
the list and then also won't be considered for timeout?

> +		if (msecs_to_jiffies(since_inval_ms) < tlb_timeout_jiffies(gt)) {
> +			xe_gt_dbg(gt, "LNL_FLUSH_WORK resolved TLB invalidation fence timeout, seqno=%d recv=%d",
> +				  fence->seqno, gt->tlb_invalidation.seqno_recv);
> +			break;
> +		}
> +
>   		trace_xe_gt_tlb_invalidation_fence_timeout(xe, fence);
>   		xe_gt_err(gt, "TLB invalidation fence timeout, seqno=%d recv=%d",
>   			  fence->seqno, gt->tlb_invalidation.seqno_recv);

