Return-Path: <stable+bounces-211209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM5JBWDicWk+MgAAu9opvQ
	(envelope-from <stable+bounces-211209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 09:40:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4A634E1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BF5AB471
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EB3A89CC;
	Thu, 22 Jan 2026 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4CHitSd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D73A9628
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070659; cv=none; b=hq3CAMQowxkmIQsYowAlAvZNal06JVn6uV6UWM8DsMC6ktsIP/fbJMIz2VdTWTDAMRnBasOVNWz5Q1cQnJoqlPuJVeDDb5mLxVhjnQkVfgu89a5p2QY2F7koCahXWPmsRfBLUp+oaQWVtmPWl+40C4kkr3tuSkf2x2zwaA5jcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070659; c=relaxed/simple;
	bh=bPCCZqVDSzUqSGD0wi9CuxOEWw/A6N1hpTgCoEUXb7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9CzKPz8ETAe6/GFlUQPfE97wS6zPknOJD4dCJ6ehKP3Sgv40f/dsHnF7ryosZjYF41H9I9FUXbdHIBGv/K9LUTTP1iLk4oVqGIdhQEaPvW35Pjy3VwZe0Uas6gLbkwriiGA8AIB8RjtjEZmwa/CJieMhTkk33JKi0QxxkK4tDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4CHitSd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769070658; x=1800606658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bPCCZqVDSzUqSGD0wi9CuxOEWw/A6N1hpTgCoEUXb7A=;
  b=W4CHitSdRGhTuT5Z6zm0eITYvRBFJHqFqP7F/Rh2EiP2+DLPKdG/H9bh
   KbSUIByZmmGWG5LCmdv2H4KjOM8KI/K/DJhEeDctldymbEzTcf+QULvp0
   dQMbHFy07vlcSo+tJOwgDGCda1k0QI4qq45B9gyPrXU9O7uvCzCXWxy8T
   0enVgQxe42vkKLix/vEjfVjWn1WyPULi3tNAnY4nnqkv29zF8Ih1xWEu6
   VqKlIOxIIvMf5C3J4DZ4n28iIECwLH5aGHF6DUym9rx5V9yh0wx1xEKGw
   QM/HuMJ0c5MtpyCMskwjBQJL2gZaK2RXDXTuQB3pfCwrNAyyBt4+kc4k5
   A==;
X-CSE-ConnectionGUID: +SNBE1W2TuCSoIkIdKqtig==
X-CSE-MsgGUID: /7V6m59CSju7ErOeCLKucA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70278759"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="70278759"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:30:57 -0800
X-CSE-ConnectionGUID: NE4+lB/2TkmcSZH0ZRcOqw==
X-CSE-MsgGUID: mPGhGBBBRXGKKwUZ1j8Zig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206488386"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.245.248]) ([10.245.245.248])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:30:54 -0800
Message-ID: <7d2b26f8-f4ec-4139-8056-efb0cb40226e@intel.com>
Date: Thu, 22 Jan 2026 09:30:52 +0100
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
Cc: Matthew Auld <matthew.auld@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260121091048.41371-1-thomas.hellstrom@linux.intel.com>
 <20260121091048.41371-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@intel.com>
In-Reply-To: <20260121091048.41371-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-211209-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 91D4A634E1
X-Rspamd-Action: no action

Hey,

Den 2026-01-21 kl. 10:10, skrev Thomas Hellström:
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
> ---
For merging through drm-xe-fixes:

Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

>  drivers/gpu/drm/Kconfig    |  2 +-
>  drivers/gpu/drm/Makefile   |  4 +++-
>  drivers/gpu/drm/xe/Kconfig |  2 +-
>  include/drm/drm_pagemap.h  | 18 ++++++++++++++----
>  4 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index a33b90251530..d3d52310c9cc 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -210,7 +210,7 @@ config DRM_GPUVM
>  
>  config DRM_GPUSVM
>  	tristate
> -	depends on DRM && DEVICE_PRIVATE
> +	depends on DRM
>  	select HMM_MIRROR
>  	select MMU_NOTIFIER
>  	help
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 0deee72ef935..0c21029c446f 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -108,9 +108,11 @@ obj-$(CONFIG_DRM_EXEC) += drm_exec.o
>  obj-$(CONFIG_DRM_GPUVM) += drm_gpuvm.o
>  
>  drm_gpusvm_helper-y := \
> -	drm_gpusvm.o\
> +	drm_gpusvm.o
> +drm_gpusvm_helper-$(CONFIG_ZONE_DEVICE) += \
>  	drm_pagemap.o\
>  	drm_pagemap_util.o
> +
>  obj-$(CONFIG_DRM_GPUSVM) += drm_gpusvm_helper.o
>  
>  obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4b288eb3f5b0..c34be1be155b 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -39,7 +39,7 @@ config DRM_XE
>  	select DRM_TTM
>  	select DRM_TTM_HELPER
>  	select DRM_EXEC
> -	select DRM_GPUSVM if !UML && DEVICE_PRIVATE
> +	select DRM_GPUSVM if !UML
>  	select DRM_GPUVM
>  	select DRM_SCHED
>  	select MMU_NOTIFIER
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 46e9c58f09e0..2baf0861f78f 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -243,6 +243,8 @@ struct drm_pagemap_devmem_ops {
>  			   struct dma_fence *pre_migrate_fence);
>  };
>  
> +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> +
>  int drm_pagemap_init(struct drm_pagemap *dpagemap,
>  		     struct dev_pagemap *pagemap,
>  		     struct drm_device *drm,
> @@ -252,17 +254,22 @@ struct drm_pagemap *drm_pagemap_create(struct drm_device *drm,
>  				       struct dev_pagemap *pagemap,
>  				       const struct drm_pagemap_ops *ops);
>  
> -#if IS_ENABLED(CONFIG_DRM_GPUSVM)
> +struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
>  
>  void drm_pagemap_put(struct drm_pagemap *dpagemap);
>  
>  #else
>  
> +static inline struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page)
> +{
> +	return NULL;
> +}
> +
>  static inline void drm_pagemap_put(struct drm_pagemap *dpagemap)
>  {
>  }
>  
> -#endif /* IS_ENABLED(CONFIG_DRM_GPUSVM) */
> +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
>  
>  /**
>   * drm_pagemap_get() - Obtain a reference on a struct drm_pagemap
> @@ -334,6 +341,8 @@ struct drm_pagemap_migrate_details {
>  	u32 source_peer_migrates : 1;
>  };
>  
> +#if IS_ENABLED(CONFIG_ZONE_DEVICE)
> +
>  int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  				  struct mm_struct *mm,
>  				  unsigned long start, unsigned long end,
> @@ -343,8 +352,6 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation);
>  
>  const struct dev_pagemap_ops *drm_pagemap_pagemap_ops_get(void);
>  
> -struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
> -
>  void drm_pagemap_devmem_init(struct drm_pagemap_devmem *devmem_allocation,
>  			     struct device *dev, struct mm_struct *mm,
>  			     const struct drm_pagemap_devmem_ops *ops,
> @@ -359,4 +366,7 @@ int drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>  void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool is_atomic_or_reclaim);
>  
>  int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
> +
> +#endif /* IS_ENABLED(CONFIG_ZONE_DEVICE) */
> +
>  #endif


