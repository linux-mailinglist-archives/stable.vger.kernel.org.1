Return-Path: <stable+bounces-151623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF3AD050A
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3B1889D4C
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D340D1991CD;
	Fri,  6 Jun 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPIza6dL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2291A38F9
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223150; cv=none; b=OL0MA1H+OpNxE9JRSMshoHl6K+zsojACU4ORbLt6lYGSgNwDkqRV+pNTVNltyCyJsrXqRNcByYucasqMr0cFbzaQRuhL5mL6ndO7ovBbCTPEAoADOmv7Rc2HZEcii2Ogw10owAcfYjz+gMMGgDNZYocQW83k7+VwzOkzJmGV/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223150; c=relaxed/simple;
	bh=HGVGnAi0B7LJ0pZobzS+bnJFwUkPfXV+b8qyKxRXktA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1iotyl9jBRF2sg0/9/epmVcJUeYTzBUTC/+cElzV1IaEqAPuO6B7d/BcpokWaFbLJfXIy96pUDurMjRfoPYQ41t+0XTpyIkrENr0cnChpR8O2eLYRVd6aV1NUTptdM1QK6kYUs+txcgnR1sBav6v/nc6ybKpaZbXsIOaD1LOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPIza6dL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749223149; x=1780759149;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=HGVGnAi0B7LJ0pZobzS+bnJFwUkPfXV+b8qyKxRXktA=;
  b=jPIza6dLlLYB0zLtxAVjiFntpp4fpMEmfc3hfnjNu+boHhzW4pNkwv4t
   dBOj+D8lfXyYDja1QTokrR/u9lChpnom45GGmXUvayPPEDmJt/Ve6edUg
   Phh0yWwzljO441tDC45IPLJn0WnCiVzZfZzWyVgdVEyyTtsN1p9yqUzzq
   zhC9y67KZyMydXVJY2iqJdtH+0EzXS1TaMSBWtz6NfYLNHZUeAKn4wzC1
   Ll/abDi2bLDJh2gy1e0E7wZ5NuSzJpFOZ4Zab3R1HuRdFThbWJJea25SH
   BULSUxj/v92E2dPDfsUJh6xNBE3eNUrVfRTaENr07Vdy51M9jgxhT3Ei2
   w==;
X-CSE-ConnectionGUID: YACcSwYySiOmnaga0IZabg==
X-CSE-MsgGUID: U4C7YB6yRPqVno45mxa5+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="50605809"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="50605809"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:19:08 -0700
X-CSE-ConnectionGUID: 7KQDcNuXTHuqp8DsJZKenw==
X-CSE-MsgGUID: NjME5DUTSW22oE1l4PzNgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="150862704"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.52]) ([10.245.245.52])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:19:07 -0700
Message-ID: <097aa0d8-6bc1-4616-8f8f-805b7fc5e886@intel.com>
Date: Fri, 6 Jun 2025 16:19:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/xe: Move DSB l2 flush to a more sensible place
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 stable@vger.kernel.org
References: <20250606104546.1996818-3-matthew.auld@intel.com>
Content-Language: en-GB
In-Reply-To: <20250606104546.1996818-3-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2025 11:45, Matthew Auld wrote:
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

Tested this locally and noticed a pretty big improvement just playing 
around in the desktop environment, where stuff feels way smoother.

> ---
>   drivers/gpu/drm/xe/display/xe_dsb_buffer.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
> index f95375451e2f..9f941fc2e36b 100644
> --- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
> +++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
> @@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
>   
>   void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
>   {
> -	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
> -
>   	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
> -	xe_device_l2_flush(xe);
>   }
>   
>   u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
> @@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
>   
>   void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
>   {
> -	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
> -
>   	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
>   
>   	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
> -	xe_device_l2_flush(xe);
>   }
>   
>   bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
> @@ -74,9 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
>   
>   void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)
>   {
> +	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
> +
>   	/*
>   	 * The memory barrier here is to ensure coherency of DSB vs MMIO,
>   	 * both for weak ordering archs and discrete cards.
>   	 */
> -	xe_device_wmb(dsb_buf->vma->bo->tile->xe);
> +	xe_device_wmb(xe);
> +	xe_device_l2_flush(xe);
>   }


