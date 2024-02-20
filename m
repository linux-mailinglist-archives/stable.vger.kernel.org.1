Return-Path: <stable+bounces-20829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A585BF17
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA914283F14
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E66BB50;
	Tue, 20 Feb 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7JmXccd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5516BB38
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440517; cv=none; b=Wbuqc75+lWEdACqt63ymREjrBdpIrBAm5JqwRrWOAly/fKEFLMzIHl/B2Rs/iO4NMRiBSkU5ju7GhV10g3HxL5KbdvAfChfTmsocL/+W2E7ENPhc5ViE6+JKHcQ7HeYLHhyWB57b+NfXlGkVAoTXukt7ijSiJs2uwWF3moftsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440517; c=relaxed/simple;
	bh=meXKs4nthnLwRqIeR9ozUCdxnOa2stibML1LIR1Xa/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URC9yUxmEY0wftjIq5suK/ty9GxWFIKjpbbqjzLGHWHZWHF7U+J9YhCbrYU6vy6NHrDCPAwkzDuvyukeiNrgNghqmYhElnuZndppm5oaaHnperMCnpUWrjpGL2XYb3/jhyHdeA+qtmx9MKGBhjgvveAgdDqmjbVJl3kZGOI/fxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7JmXccd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708440516; x=1739976516;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=meXKs4nthnLwRqIeR9ozUCdxnOa2stibML1LIR1Xa/w=;
  b=e7JmXccdIjItq3uo0p8woG4FL8IIQsgB5QyjNWcm4uEnL/8UiG+w6CXQ
   SUQDOS0jTFlNPVxmLa2XXON27jvNG2Fcg+sU27bRByekJSBvVQWSrl1Up
   RySPjL4bOVx+geIQBYgC2P65VhAtsIptSysWAjl03gITFzUo1hB7eUhWA
   K2GmKWSugdXoaXIXlhQ2ZwB1wDyiu+gDwGZRlno40H9PjlVkTgbVS8STN
   rAiB33ty8vY4t3+0VDqp2GgUTebia2aMr3diO6qgAei203FbPTTIFuZad
   V+Vpg7Yb7niCytOScCIHxnPw+S3U0aPYdkw3YOBoWwt4M4aZNvSRTko+G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13252908"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13252908"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9369243"
Received: from dunnejor-mobl2.ger.corp.intel.com (HELO [10.213.231.185]) ([10.213.231.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:48:33 -0800
Message-ID: <af007641-9705-4259-b29c-3cb78f67fc64@linux.intel.com>
Date: Tue, 20 Feb 2024 14:48:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/i915/gt: Enable only one CCS for compute
 workload
Content-Language: en-US
To: Andi Shyti <andi.shyti@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>, stable@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>
References: <20240220143526.259109-1-andi.shyti@linux.intel.com>
 <20240220143526.259109-3-andi.shyti@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20240220143526.259109-3-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/02/2024 14:35, Andi Shyti wrote:
> Enable only one CCS engine by default with all the compute sices

slices

> allocated to it.
> 
> While generating the list of UABI engines to be exposed to the
> user, exclude any additional CCS engines beyond the first
> instance.
> 
> This change can be tested with igt i915_query.
> 
> Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>   drivers/gpu/drm/i915/gt/intel_engine_user.c |  9 +++++++++
>   drivers/gpu/drm/i915/gt/intel_gt.c          | 11 +++++++++++
>   drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  2 ++
>   drivers/gpu/drm/i915/i915_query.c           |  1 +
>   4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> index 833987015b8b..7041acc77810 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> @@ -243,6 +243,15 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
>   		if (engine->uabi_class == I915_NO_UABI_CLASS)
>   			continue;
>   
> +		/*
> +		 * Do not list and do not count CCS engines other than the first
> +		 */
> +		if (engine->uabi_class == I915_ENGINE_CLASS_COMPUTE &&
> +		    engine->uabi_instance > 0) {
> +			i915->engine_uabi_class_count[engine->uabi_class]--;
> +			continue;
> +		}

It's a bit ugly to decrement after increment, instead of somehow 
restructuring the loop to satisfy both cases more elegantly. And I 
wonder if internally (in dmesg when engine name is logged) we don't end 
up with ccs0 ccs0 ccs0 ccs0.. for all instances.

> +
>   		rb_link_node(&engine->uabi_node, prev, p);
>   		rb_insert_color(&engine->uabi_node, &i915->uabi_engines);
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
> diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> index 3baa2f54a86e..d5a5143971f5 100644
> --- a/drivers/gpu/drm/i915/i915_query.c
> +++ b/drivers/gpu/drm/i915/i915_query.c
> @@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
>   	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
>   }
>   
> +

Zap please.

>   static int
>   query_engine_info(struct drm_i915_private *i915,
>   		  struct drm_i915_query_item *query_item)

Regards,

Tvrtko

