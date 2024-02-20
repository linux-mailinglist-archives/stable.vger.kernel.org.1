Return-Path: <stable+bounces-20819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9A85BEBB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C4FB21777
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DD6A034;
	Tue, 20 Feb 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k49ylnjI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223733D2
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439233; cv=none; b=Ip+Fwrl65seOVWT+CpMiDqXn/PsuKr2pqluPI13VR3AoxMmnlIQ1cfJR1AHrcAYleDvxWX8wHXbuhVe88f+geSwMu0ECrk0e/PSUQYmojGvXKc3B9JRr6rXHE/DINtORlNspY/dGGkv7dYMyY8T0eMtWxpSq3MgtGOWp6HHQiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439233; c=relaxed/simple;
	bh=RzMtD+rjxpsDc6i2kJwBC+kNlexG8JeWwnefmJVGRdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3qBOYSqYGgYnmbBuD3i1BAwXjf9ipBjzpm/SrK3gOA6NnnfesOojthLpjDulmdsd2rjzX475uP3RZX8NdtN7Q0ghD9KgTk2srWFlhaaXHVb/zqyuoVAcB2N0T+GmYMeEJU1iaPYHCWPzwKKHZ4aJlec7irtCMQphTUlQ7q3RUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k49ylnjI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439231; x=1739975231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RzMtD+rjxpsDc6i2kJwBC+kNlexG8JeWwnefmJVGRdY=;
  b=k49ylnjIlfSlaOJ4kAszmS9Ph1BwQWQoF3Tg6kIXulUPP/QWV9SB1/Ko
   1lz1VpzQE+4QBCswgpeERHnBq9RHj1qzxkEDTxM3hiD7ABSWRJOkLEH+Z
   eQ2ZmKPnzdGT48pqPpCEFl8GPNIEHLR3UYDDSNPCoEMWHRlY0LPFVUJlT
   LGOoO4TBy7d8J9noMglWr0zk8B4VF8uXMaVAdxEuPkI1tlH5C21mehG8L
   PBAup6envOeDcS4gop8Uny9oWKN79l570m1dJb2ol1Ae3/rrRea4wUAek
   94Dr6kf6BMhVr+XBXEKT8nwOuXDb3EIbFQoiZd5kWa4ER9CqupsjBhsn2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="5499826"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5499826"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913084677"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913084677"
Received: from dunnejor-mobl2.ger.corp.intel.com (HELO [10.213.231.185]) ([10.213.231.185])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:27:09 -0800
Message-ID: <62a1a0d1-0972-41fb-b14f-0513f6691baf@linux.intel.com>
Date: Tue, 20 Feb 2024 14:27:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/i915/gt: Set default CCS mode '1'
Content-Language: en-US
To: Andi Shyti <andi.shyti@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>, stable@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>
References: <20240220142034.257370-1-andi.shyti@linux.intel.com>
 <20240220142034.257370-3-andi.shyti@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20240220142034.257370-3-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/02/2024 14:20, Andi Shyti wrote:
> Since CCS automatic load balancing is disabled, we will impose a
> fixed balancing policy that involves setting all the CCS engines
> to work together on the same load.

Erm *all* CSS engines work together..

> Simultaneously, the user will see only 1 CCS rather than the
> actual number. As of now, this change affects only DG2.

... *one* CCS engine.

> 
> Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>   drivers/gpu/drm/i915/gt/intel_gt.c      | 11 +++++++++++
>   drivers/gpu/drm/i915/gt/intel_gt_regs.h |  2 ++
>   drivers/gpu/drm/i915/i915_drv.h         | 17 +++++++++++++++++
>   drivers/gpu/drm/i915/i915_query.c       |  5 +++--
>   4 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
> index a425db5ed3a2..e19df4ef47f6 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> @@ -168,6 +168,14 @@ static void init_unused_rings(struct intel_gt *gt)
>   	}
>   }
>   
> +static void intel_gt_apply_ccs_mode(struct intel_gt *gt)
> +{
> +	if (!IS_DG2(gt->i915))
> +		return;
> +
> +	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, 0);
> +}
> +
>   int intel_gt_init_hw(struct intel_gt *gt)
>   {
>   	struct drm_i915_private *i915 = gt->i915;
> @@ -195,6 +203,9 @@ int intel_gt_init_hw(struct intel_gt *gt)
>   
>   	intel_gt_init_swizzling(gt);
>   
> +	/* Configure CCS mode */
> +	intel_gt_apply_ccs_mode(gt);
> +
>   	/*
>   	 * At least 830 can leave some of the unused rings
>   	 * "active" (ie. head != tail) after resume which
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> index cf709f6c05ae..c148113770ea 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> @@ -1605,6 +1605,8 @@
>   #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
>   #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
>   
> +#define XEHP_CCS_MODE                          _MMIO(0x14804)
> +
>   #define GEN11_GT_INTR_DW(x)			_MMIO(0x190018 + ((x) * 4))
>   #define   GEN11_CSME				(31)
>   #define   GEN12_HECI_2				(30)
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index e81b3b2858ac..0853ffd3cb8d 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -396,6 +396,23 @@ static inline struct intel_gt *to_gt(const struct drm_i915_private *i915)
>   	     (engine__); \
>   	     (engine__) = rb_to_uabi_engine(rb_next(&(engine__)->uabi_node)))
>   
> +/*
> + * Exclude unavailable engines.
> + *
> + * Only the first CCS engine is utilized due to the disabling of CCS auto load
> + * balancing. As a result, all CCS engines operate collectively, functioning
> + * essentially as a single CCS engine, hence the count of active CCS engines is
> + * considered '1'.
> + * Currently, this applies to platforms with more than one CCS engine,
> + * specifically DG2.
> + */
> +#define for_each_available_uabi_engine(engine__, i915__) \
> +	for_each_uabi_engine(engine__, i915__) \
> +		if ((IS_DG2(i915__)) && \
> +		    ((engine__)->uabi_class == I915_ENGINE_CLASS_COMPUTE) && \
> +		    ((engine__)->uabi_instance)) { } \
> +		else
> +

I thought the plan was to simply not register the engine. Like that it 
would be a simpler patch.

>   #define INTEL_INFO(i915)	((i915)->__info)
>   #define RUNTIME_INFO(i915)	(&(i915)->__runtime)
>   #define DRIVER_CAPS(i915)	(&(i915)->caps)
> diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> index fa3e937ed3f5..2d41bda626a6 100644
> --- a/drivers/gpu/drm/i915/i915_query.c
> +++ b/drivers/gpu/drm/i915/i915_query.c
> @@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
>   	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
>   }
>   
> +

!

>   static int
>   query_engine_info(struct drm_i915_private *i915,
>   		  struct drm_i915_query_item *query_item)
> @@ -140,7 +141,7 @@ query_engine_info(struct drm_i915_private *i915,
>   	if (query_item->flags)
>   		return -EINVAL;
>   
> -	for_each_uabi_engine(engine, i915)
> +	for_each_available_uabi_engine(engine, i915)
>   		num_uabi_engines++;
>   
>   	len = struct_size(query_ptr, engines, num_uabi_engines);
> @@ -155,7 +156,7 @@ query_engine_info(struct drm_i915_private *i915,
>   
>   	info_ptr = &query_ptr->engines[0];
>   
> -	for_each_uabi_engine(engine, i915) {
> +	for_each_available_uabi_engine(engine, i915) {
>   		info.engine.engine_class = engine->uabi_class;
>   		info.engine.engine_instance = engine->uabi_instance;
>   		info.flags = I915_ENGINE_INFO_HAS_LOGICAL_INSTANCE;

I thought you agreed that this still misses to hide the engine on direct 
lookup from userspace such as context map, PMU, SSEU. All of those would 
automatically be handled by not registering the engine.

Regards,

Tvrtko

