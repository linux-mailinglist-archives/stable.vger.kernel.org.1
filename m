Return-Path: <stable+bounces-200694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5BCB284A
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 10:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DEF3028F60
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517F302157;
	Wed, 10 Dec 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhjA/1Ck"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5995285C99
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358200; cv=none; b=hdJsjnMUdmuJrG15Z9X0JXL3hNGQn9vC23sMaI56Wl8iPFZwuxTSi22z02BE4HPHkLCJA96WIjeqk97Pdlc9lrTffQSp7Mvb0s6/M9as1bWUnVcGt+YyBVubkQG2JHVfN9CaK4jdMXQQL2BSiuhAr4cXYxcNjKx2lBK+SQHmVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358200; c=relaxed/simple;
	bh=VDY4U8F63J2NPwqdtQB6bVl86jPB9Pbu/bg8g4qtCKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFFXzsarmZmr7q0JOESKwGwEqxLve7Naej7DbCIrfp1LcK9LGvw+2KgSwVtBaRGDh6Wck63q2U/6lxJZyiwtUaMeRofWAldR8CayZUOMtBkh/5Q9VlU5XxEkNc1OIh8O9rgF9rNpuAwvCKRRfVfoeUBbtWX6DmFQzRfRnDMHvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhjA/1Ck; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765358198; x=1796894198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VDY4U8F63J2NPwqdtQB6bVl86jPB9Pbu/bg8g4qtCKo=;
  b=HhjA/1Ck8s2GdaCNlBURie2Q5wXOuCHFQgDz81yE+ouZ6UlwZnYhSizY
   nKiMl3xlyyN8vfHFxpr1njrnkSslCZbAtE6p6GNmGTIAtnfqmmGiQHhTg
   FT5QbmWIIcRu5M0OsTun/INg180Ft7XS71ClQSMN3l/ejYw+tOEXNLw/2
   bAAAfFtiN0qaNL7F4T/UHaOPFdkau8G9jp4vPm6IC+bFOdV4JKxdfHCrv
   1dW7dbhKrkpbkRGetEJIAFNAvA73RsQlaWF91mAa9JEVasiBl7e3tUtxy
   7/t+yt891qobA8doj4vnakUbbS+xAC+6FVP7Z0pHKfqkrpS79trNcLTO9
   Q==;
X-CSE-ConnectionGUID: /kmlr/hcTaa6IyA29JPgTA==
X-CSE-MsgGUID: uhDcxkk1R0yNigqLPQP08w==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="71173552"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="71173552"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 01:16:37 -0800
X-CSE-ConnectionGUID: GP5SwBbWTFOQ8MOPoINDbQ==
X-CSE-MsgGUID: au5j3sN7TE6yCnyjgKc9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="195533229"
Received: from unknown (HELO [10.102.88.36]) ([10.102.88.36])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 01:16:35 -0800
Message-ID: <4983e4d2-7c07-4c55-92c8-c4441af4b2f2@linux.intel.com>
Date: Wed, 10 Dec 2025 10:16:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/xe/bo: Don't include the CCS metadata in the dma-buf sg-table
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, stable@vger.kernel.org
References: <20251209204920.224374-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20251209204920.224374-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/2025 9:49 PM, Thomas Hellström wrote:
> Some Xe bos are allocated with extra backing-store for the CCS
> metadata. It's never been the intention to share the CCS metadata
> when exporting such bos as dma-buf. Don't include it in the
> dma-buf sg-table.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 54e42960daad..7c74a31d4486 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -124,7 +124,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>  	case XE_PL_TT:
>  		sgt = drm_prime_pages_to_sg(obj->dev,
>  					    bo->ttm.ttm->pages,
> -					    bo->ttm.ttm->num_pages);
> +					    obj->size >> PAGE_SHIFT);
>  		if (IS_ERR(sgt))
>  			return sgt;
>  
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

