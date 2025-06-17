Return-Path: <stable+bounces-153948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1DADD75B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13394A1B97
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504A2ED855;
	Tue, 17 Jun 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCwRoqi+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F56E2F9485
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177615; cv=none; b=MEW9bygW7JWnNYqm2xgMVEotV4ZNI1KObKO0IRReJmlV/aoTmqwwMhAGF2NF7tIVKhyZSJFn3M+4hheNtbNzFKByj0EPykWtc+cliNOmB7MSIqKh0XMF0321nu2jefx3K5hz5nhS/uA6QusVrejrBhOYWp/51p4Uly/oD0+xsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177615; c=relaxed/simple;
	bh=05w2d9pQn49GBKjN5vG4Maoa4OIgXqw2oKlhjzh22uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSAwJM27TJ+ETztV0v5e8gVcgfUL3GWe18ueGpVWAwKrVWXe3kKsK/vfFTh1cCKeGqoFR3BN4dzD/nEWWXbwAiDfPzqkgjnzwSTq2oywZQgbEO7GH3kR6LCLXdxJUsEpc7GO2buz9GMs8rQ9RWVct11843ZAXFXrk/zg1wzFqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCwRoqi+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750177614; x=1781713614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=05w2d9pQn49GBKjN5vG4Maoa4OIgXqw2oKlhjzh22uM=;
  b=FCwRoqi+XFS0HdM684KWF+EIB6g7Jj0RzcYE7JgRBt5i+XaG8ZyGhEKj
   sjvGsLEELoWGQGtd1K6a3+caTaptBys09XFZe82KzyO/9trqTA1g+uCCj
   MNO5HjkwKQy3u14c501qKWVeSwpCZ1H+Pj0AwJgCWbshfNYLkP3DG3jP9
   YYQMHl4BVtvMfOJFQnn4bxBHdQ+5mlo1lmpHpIPuVfm3f8MpkELRQo+Fk
   vBmK1nr/N5U/FPcGrMUsbmxuTcN6I9N9EAE/Zi8VLzTHv7lB6pNkqPBMY
   6sK7J10oNpkdzwpuMdGsKL6bJL/LJE7MsNGlBYu2XgMHQK+R+r+AVQ/yu
   w==;
X-CSE-ConnectionGUID: /vp7st5wTN6GRadwz8DJRw==
X-CSE-MsgGUID: hJXI982mRxqpYVjntGfbxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52503689"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52503689"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:26:52 -0700
X-CSE-ConnectionGUID: pLaZZmXJQDOKinGY7kfs8w==
X-CSE-MsgGUID: 22sXZ1wHS6mFvTT8VvsYGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="154124500"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO stinkbox) ([10.245.245.184])
  by orviesa005.jf.intel.com with SMTP; 17 Jun 2025 09:26:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 17 Jun 2025 19:26:48 +0300
Date: Tue, 17 Jun 2025 19:26:48 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/xe: Move DSB l2 flush to a more sensible place
Message-ID: <aFGXSPmrDiB8MNrG@intel.com>
References: <20250606104546.1996818-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250606104546.1996818-3-matthew.auld@intel.com>
X-Patchwork-Hint: comment

On Fri, Jun 06, 2025 at 11:45:47AM +0100, Matthew Auld wrote:
> From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> 
> Flushing l2 is only needed after all data has been written.
> 
> Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>

Looks reasonable.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/xe/display/xe_dsb_buffer.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
> index f95375451e2f..9f941fc2e36b 100644
> --- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
> +++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
> @@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
>  
>  void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
>  {
> -	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
> -
>  	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
> -	xe_device_l2_flush(xe);
>  }
>  
>  u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
> @@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
>  
>  void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
>  {
> -	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
> -
>  	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
>  
>  	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
> -	xe_device_l2_flush(xe);
>  }
>  
>  bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
> @@ -74,9 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
>  
>  void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)
>  {
> +	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
> +
>  	/*
>  	 * The memory barrier here is to ensure coherency of DSB vs MMIO,
>  	 * both for weak ordering archs and discrete cards.
>  	 */
> -	xe_device_wmb(dsb_buf->vma->bo->tile->xe);
> +	xe_device_wmb(xe);
> +	xe_device_l2_flush(xe);
>  }
> -- 
> 2.49.0

-- 
Ville Syrjälä
Intel

