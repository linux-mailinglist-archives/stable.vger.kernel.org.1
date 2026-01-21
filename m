Return-Path: <stable+bounces-210799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BUJMdkzcWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:15:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F845CF49
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC0707831C6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09D44CF2C;
	Wed, 21 Jan 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFjM6pEb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0C334C02
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016011; cv=none; b=BZfs1Qi2J0BxbX9re/mHW4ScYEz1Uy8b7xIwaQeLbZOGzxWBlPRJISlq8ume0Xj9e0Ynx+fpM0xxjw1zrGP0e2sAnDLYDMTFvEfvgQVM7LUHLELFXSYsjFPX4f/o/659ZiIlXBZtZgOUxHOg37l6eVjnEUemALngNK8IhZdanVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016011; c=relaxed/simple;
	bh=RT+nH3hDNGsYT1UnSKOcCfuQw0yC7WxJ2GBu/Q7kfIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJsCWEfu0/o1i614Kqjw7BEDuQQfpoO+uGqq8Hi/K4tl74iRq6pQoLca+i6l5Oj7mdlCdAQbFraRMOgOi4GgHlnsoima5QTPSMYwOodwd7yROJyPjetiLn7XbsQqWLS1ds87eTBuvMTLTfUkh+qjw8ujLBdZ+DVFtsdBr/lwuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFjM6pEb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769016008; x=1800552008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RT+nH3hDNGsYT1UnSKOcCfuQw0yC7WxJ2GBu/Q7kfIQ=;
  b=hFjM6pEb1jO7P9B3bu3RBRuLyDWTWKSuCYK6Pky79tYqMAS0yp1f/RRJ
   /dNixPG75LyRLgME2VEwguLGvFpZO8stmqHTUMLEHCURIhZsDm5/PmGNZ
   FM8cJgnlsUEZXdYonWJj4ypW9S7HipwaWxy9/tVlyTIbFtfN9FXj7+j5k
   +NeXW9W5fAG7FNaymN0etyk4myq2MEHn2IbXK2Hrt6fM0QkhB6E5RTuZy
   +CmghJQ+VnTFfup8Ldoh5r3VrLBZYPEyCOQRZcjMRv/YIfqlZqHD1iztJ
   VLSvXwSIz5Q1i5PSQzh/raXejRc8mSbkShchoIWu/LZncrWbVnve9X0mZ
   A==;
X-CSE-ConnectionGUID: +UH91SjPSfehk+GwHgPEUg==
X-CSE-MsgGUID: m35Y09QsRJuufadCa7IXAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70299112"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70299112"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 09:20:03 -0800
X-CSE-ConnectionGUID: ulsi36SFTT+R+bfSrWKahw==
X-CSE-MsgGUID: stBHJcLBQUqI6PHpAXWiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211340559"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.122]) ([10.245.245.122])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 09:20:01 -0800
Message-ID: <ad0efbfc-b7b3-4dc8-9499-8a7accd6c5e4@intel.com>
Date: Wed, 21 Jan 2026 17:19:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm, drm/xe: Fix xe userptr in the absence of
 CONFIG_DEVICE_PRIVATE
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260121091048.41371-1-thomas.hellstrom@linux.intel.com>
 <20260121091048.41371-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260121091048.41371-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210799-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 56F845CF49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 09:10, Thomas Hellström wrote:
> CONFIG_DEVICE_PRIVATE is not selected by default by some distros,
> for example Fedora, and that leads to a regression in the xe driver
> since userptr support gets compiled out.
> 
> It turns out that DRM_GPUSVM, which is needed for xe userptr support
> compiles also without CONFIG_DEVICE_PRIVATE, but doesn't compile
> without CONFIG_ZONE_DEVICE.
> Exclude the drm_pagemap files from compilation with !CONFIG_ZONE_DEVICE,
> and remove the CONFIG_DEVICE_PRIVATE dependency from CONFIG_DRM_GPUSVM and
> the xe driver's selection of it, re-enabling xe userptr for those configs.
> 
> v2:
> - Don't compile the drm_pagemap files unless CONFIG_ZONE_DEVICE is set.
> - Adjust the drm_pagemap.h header accordingly.
> 
> Fixes: 9e9787414882 ("drm/xe/userptr: replace xe_hmm with gpusvm")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Let me double check that while it does at least build it is also 
functional without DRM_XE_GPUSVM. I think it takes a different init path 
and maybe some other differences. Unless you already did?

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/Kconfig    |  2 +-
>   drivers/gpu/drm/Makefile   |  4 +++-
>   drivers/gpu/drm/xe/Kconfig |  2 +-
>   include/drm/drm_pagemap.h  | 18 ++++++++++++++----
>   4 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index a33b90251530..d3d52310c9cc 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -210,7 +210,7 @@ config DRM_GPUVM
>   
>   config DRM_GPUSVM
>   	tristate
> -	depends on DRM && DEVICE_PRIVATE
> +	depends on DRM
>   	select HMM_MIRROR
>   	select MMU_NOTIFIER
>   	help
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 0deee72ef935..0c21029c446f 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -108,9 +108,11 @@ obj-$(CONFIG_DRM_EXEC) += drm_exec.o
>   obj-$(CONFIG_DRM_GPUVM) += drm_gpuvm.o
>   
>   drm_gpusvm_helper-y := \
> -	drm_gpusvm.o\
> +	drm_gpusvm.o
> +drm_gpusvm_helper-$(CONFIG_ZONE_DEVICE) += \
>   	drm_pagemap.o\
>   	drm_pagemap_util.o
> +
>   obj-$(CONFIG_DRM_GPUSVM) += drm_gpusvm_helper.o
>   
>   obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4b288eb3f5b0..c34be1be155b 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -39,7 +39,7 @@ config DRM_XE
>   	select DRM_TTM
>   	select DRM_TTM_HELPER
>   	select DRM_EXEC
> -	select DRM_GPUSVM if !UML && DEVICE_PRIVATE
> +	select DRM_GPUSVM if !UML
>   	select DRM_GPUVM
>   	select DRM_SCHED
>   	select MMU_NOTIFIER
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 46e9c58f09e0..2baf0861f78f 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -243,6 +243,8 @@ struct drm_pagemap_devmem_ops {
>   			   struct dma_fence *pre_migrate_fence);
>   };
>   
> +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> +
>   int drm_pagemap_init(struct drm_pagemap *dpagemap,
>   		     struct dev_pagemap *pagemap,
>   		     struct drm_device *drm,
> @@ -252,17 +254,22 @@ struct drm_pagemap *drm_pagemap_create(struct drm_device *drm,
>   				       struct dev_pagemap *pagemap,
>   				       const struct drm_pagemap_ops *ops);
>   
> -#if IS_ENABLED(CONFIG_DRM_GPUSVM)
> +struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
>   
>   void drm_pagemap_put(struct drm_pagemap *dpagemap);
>   
>   #else
>   
> +static inline struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page)
> +{
> +	return NULL;
> +}
> +
>   static inline void drm_pagemap_put(struct drm_pagemap *dpagemap)
>   {
>   }
>   
> -#endif /* IS_ENABLED(CONFIG_DRM_GPUSVM) */
> +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
>   
>   /**
>    * drm_pagemap_get() - Obtain a reference on a struct drm_pagemap
> @@ -334,6 +341,8 @@ struct drm_pagemap_migrate_details {
>   	u32 source_peer_migrates : 1;
>   };
>   
> +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> +
>   int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>   				  struct mm_struct *mm,
>   				  unsigned long start, unsigned long end,
> @@ -343,8 +352,6 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation);
>   
>   const struct dev_pagemap_ops *drm_pagemap_pagemap_ops_get(void);
>   
> -struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
> -
>   void drm_pagemap_devmem_init(struct drm_pagemap_devmem *devmem_allocation,
>   			     struct device *dev, struct mm_struct *mm,
>   			     const struct drm_pagemap_devmem_ops *ops,
> @@ -359,4 +366,7 @@ int drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>   void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool is_atomic_or_reclaim);
>   
>   int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
> +
> +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
> +
>   #endif


