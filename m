Return-Path: <stable+bounces-127561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EBDA7A5CE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BAA3AA07E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF72459EE;
	Thu,  3 Apr 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUwhJ+Oj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712524EF61
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692204; cv=none; b=ppEz+ksbaxbAJb1KlKlJFobsy/CtMV0jtqUH8Qo3U4NSdnHh1zTngZay8TywWoit2h7DGkLTaluD64AyOqq2pCEHPNcchuO6TMwOoVCWmHcaknQdHEjXOZt0AbUBUFfburpwby+jQWJBAap3ANKwC/SEB7+bBJFeC47hhKP9FNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692204; c=relaxed/simple;
	bh=vSjhxIDGC8qGcKyS4/5ajqX0GNNYbBAato0hHnP6DDI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HSswmBmVFh7eJ3K/q+DcFkpurQ0cS/wKi7YCUlsZRip6IAHJ/5zgyBWpN5zFknJAkxXBwhTb15Hmrdb1QKxojOJCGcC5JpnpalEeHUZkgjn52H2i39vvfBxf5FtdNFMyOOq5wg9zPg5c9xHGfd6crUf2+Zy5m+rwYuxsuVeHlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUwhJ+Oj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743692203; x=1775228203;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vSjhxIDGC8qGcKyS4/5ajqX0GNNYbBAato0hHnP6DDI=;
  b=WUwhJ+OjRepTAEHGdGig3cO3hBB2nR3n+kYc4L2h/bbiz5QjsKoW9JEd
   VopsX1JbVyIKlj3MmU/OxOtLqRMjnAk6NDzzP8I1ONNlovA2E5BxxCOrv
   B7qcySOxKLPncceqFP43MpP/3rME79AR//5FEpissyxRji7pYFbvX7C9x
   fTYDZYniQzg5kjTdvPhcchVMsUaimcRPIYNLEFLAfcA7JPf3hICEx40n9
   iN7LjJH4OqTGNlnVyWrpddYL1cWuRiKOGDlSurYkDoulGndwLNSP1fAmV
   WpFzqtzmw3BIdMa7+kRkHUdjqMzPWNBvT/9vT5at4DyMp7A5j6AvJJJO9
   A==;
X-CSE-ConnectionGUID: GFLrtKduR3iw8ZSrLgEEyA==
X-CSE-MsgGUID: D0Ffpj8MSO23HX1DyMQBVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48764910"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48764910"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 07:56:43 -0700
X-CSE-ConnectionGUID: JJBU5hHNQkakhTZPW0MpNg==
X-CSE-MsgGUID: hgqy/mDKRW+xbsQm9LIHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127965681"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.142]) ([10.245.244.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 07:56:41 -0700
Message-ID: <c60972cc-0927-44d1-b9a6-5c8c73ffbdaf@intel.com>
Date: Thu, 3 Apr 2025 15:56:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/dma_buf: stop relying on placement in unmap
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20250403140735.304928-2-matthew.auld@intel.com>
Content-Language: en-GB
In-Reply-To: <20250403140735.304928-2-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/04/2025 15:07, Matthew Auld wrote:
> The is_vram() is checking the current placement, however if we consider
> exported VRAM with dynamic dma-buf, it looks possible for the xe driver
> to async evict the memory, notifying the importer, however importer does
> not have to call unmap_attachment() immediately, but rather just as
> "soon as possible", like when the dma-resv idles. Following from this we
> would then pipeline the move, attaching the fence to the manager, and
> then update the current placement. But when the unmap_attachment() runs
> at some later point we might see that is_vram() is now false, and take
> the complete wrong path when dma-unmapping the sg, leading to
> explosions.
> 
> To fix this rather make a note in the attachment if the sg was
> originally mapping vram or tt pages.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4563
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index f67803e15a0e..b71058e26820 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -22,6 +22,22 @@
>   
>   MODULE_IMPORT_NS("DMA_BUF");
>   
> +/**
> + * struct xe_sg_info - Track the exported sg info
> + */
> +struct xe_sg_info {
> +	/** @is_vram: True if this sg is mapping VRAM. */
> +	bool is_vram;
> +};
> +
> +static struct xe_sg_info tt_sg_info = {
> +	.is_vram = false,
> +};
> +
> +static struct xe_sg_info vram_sg_info = {
> +	.is_vram = true,
> +};
> +
>   static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>   			     struct dma_buf_attachment *attach)
>   {
> @@ -118,6 +134,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (dma_map_sgtable(attach->dev, sgt, dir,
>   				    DMA_ATTR_SKIP_CPU_SYNC))
>   			goto error_free;
> +		attach->priv = &tt_sg_info;
>   		break;
>   
>   	case XE_PL_VRAM0:
> @@ -128,6 +145,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>   					      dir, &sgt);
>   		if (r)
>   			return ERR_PTR(r);
> +		attach->priv = &vram_sg_info;

Maybe we need to subclass the sg itself? It looks possible to call map 
again, before the unmap, and you might get different memory if you had 
mixed placement bo...

>   		break;
>   	default:
>   		return ERR_PTR(-EINVAL);
> @@ -145,10 +163,9 @@ static void xe_dma_buf_unmap(struct dma_buf_attachment *attach,
>   			     struct sg_table *sgt,
>   			     enum dma_data_direction dir)
>   {
> -	struct dma_buf *dma_buf = attach->dmabuf;
> -	struct xe_bo *bo = gem_to_xe_bo(dma_buf->priv);
> +	struct xe_sg_info *sg_info = attach->priv;
>   
> -	if (!xe_bo_is_vram(bo)) {
> +	if (!sg_info->is_vram) {
>   		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>   		sg_free_table(sgt);
>   		kfree(sgt);


