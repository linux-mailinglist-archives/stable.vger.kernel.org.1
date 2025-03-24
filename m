Return-Path: <stable+bounces-125873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04862A6D7A0
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6E47A5398
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2225D8F4;
	Mon, 24 Mar 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2WyUrUX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CA143895
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809090; cv=none; b=oNvxz2IxS62n1jLYIdEtGBAuMLaTu3URo7AHir7jPrz/tyDVEnaFvraTZpO0htjBPOH54tx2J6xzDT5Zfr0SCaq1gzQqkLWUaOQ2p6mwhiDGlf9v5Fkd8sQyFJRQufnJBbvQnlSI5Tpv3Z61qwQ9okVzIG1dBFPUPmp1H70Mx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809090; c=relaxed/simple;
	bh=xum1MmTp1CXfeSxTSdmDj7gdVqmKq5X9Q1ojm4hMPXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Af9sCeQCvPxapBA+4531DZT0UOf1yCQad43/SUtLLohsqToTDy+A3vow+WILY6tNAz+i5LgQGHFJJqdmOXJUiYimADzJAFUhGUeyl+yUCIxA4oQul9DDWBOi5yxyuwByEjLu3VIDwUZMTnlna2ZRn5j9Ala23ejTvZP8HVmrEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2WyUrUX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742809089; x=1774345089;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xum1MmTp1CXfeSxTSdmDj7gdVqmKq5X9Q1ojm4hMPXM=;
  b=W2WyUrUXGBb6/MEv5uQQg54RjUOg8vxbvOclK9q+nVP/jPy/Ku0WnkSl
   ndJRoaXWs4wiN3DvbsGyqqrBuR5D8actGCa+Bcfq0t9ZvK9RWu++ZOUwh
   frV8KMb3UaKJW74TI5dsQ6GtBILLWH+FkazbJYmjxmn8ywKdA4jUwKuUG
   iOTKvfsHng+vFFs/ysi8h8EF/0+ECflaTXxdNCiErwoN+KIr35//u9Z8n
   D7YrdFQOTT82Tr9RocoSvN80tE9plFEPtnXyqVMeHh5OWlbzO64K9ZxUo
   PJHMgH1+rEEc3MTfwVB3QJuU4KUoB+QVKb0Vcd+MwaaQFFn+OUp33eNr4
   A==;
X-CSE-ConnectionGUID: ZCoa8nFWRdqG0hFxlpSAVw==
X-CSE-MsgGUID: cBIXOj+cRLO3zPSVUBVwDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="69360146"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="69360146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:38:08 -0700
X-CSE-ConnectionGUID: zhEpJ0HcRAGBIp/woNBoCQ==
X-CSE-MsgGUID: XMMtvz8JRlWLvchGy9tF/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="161232106"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 02:38:04 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Chauvet <kwizart@gmail.com>, Zhenyu Wang
 <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Nicolas Chauvet <kwizart@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "drm/i915/gvt: Fix out-of-bounds buffer
 write into opregion->signature[]"
In-Reply-To: <20250324083755.12489-2-kwizart@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250324083755.12489-1-kwizart@gmail.com>
 <20250324083755.12489-2-kwizart@gmail.com>
Date: Mon, 24 Mar 2025 11:38:01 +0200
Message-ID: <87ecymbwg6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
> This reverts commit ea26c96d59b27e878fe61e8ef0fed840d2281a2f.
>
> This fix truncates the OPREGION_SIGNATURE to fit into 16 chars instead of
> enlarging the target field, hence only moving the size missmatch to later.
>
> As shown with gcc-15:
> drivers/gpu/drm/i915/gvt/opregion.c: In function intel_vgpu_init_opregion:
> drivers/gpu/drm/i915/gvt/opregion.c:35:28: error: initializer-string for array of char is too long [-Werror=unterminated-string-initialization]
>    35 | #define OPREGION_SIGNATURE "IntelGraphicsMem"
>       |                            ^~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gvt/opregion.c:225:45: note: in expansion of macro OPREGION_SIGNATURE
>   225 |         const char opregion_signature[16] = OPREGION_SIGNATURE;
>       |                                             ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Cc: stable@vger.kernel.org
> Reported-by: Nicolas Chauvet <kwizart@gmail.com>
> Fixes: ea26c96d59 ("drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>

This introduces a buffer overflow.

sizeof(OPREGION_SIGNATURE) == 17.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/gvt/opregion.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index 509f9ccae3a9..9a8ead6039e2 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>  	u8 *buf;
>  	struct opregion_header *header;
>  	struct vbt v;
> -	const char opregion_signature[16] = OPREGION_SIGNATURE;
>  
>  	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
>  	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
> @@ -236,8 +235,8 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>  	/* emulated opregion with VBT mailbox only */
>  	buf = (u8 *)vgpu_opregion(vgpu)->va;
>  	header = (struct opregion_header *)buf;
> -	memcpy(header->signature, opregion_signature,
> -	       sizeof(opregion_signature));
> +	memcpy(header->signature, OPREGION_SIGNATURE,
> +			sizeof(OPREGION_SIGNATURE));
>  	header->size = 0x8;
>  	header->opregion_ver = 0x02000000;
>  	header->mboxes = MBOX_VBT;

-- 
Jani Nikula, Intel

