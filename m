Return-Path: <stable+bounces-76071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD7978019
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D252328367A
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4012E1DA111;
	Fri, 13 Sep 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmH1P1zN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AA1DA107
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230928; cv=none; b=isUUJ3U3UPj1LSchHbU3eU66CXShlzrk4H7U51Rldq5ydz2uLr1TP541a6pOPtVxFVp1ouCliXl+4QWvdAsrNJRbeGa9RchBvbjPa0xOLKZYc1jbqBP3VhuLazZXJ3YLix1t8uNeAuKnWu4LTVx9H8TVw+LWKG2UtGCHf3r4eSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230928; c=relaxed/simple;
	bh=S7JsoSknSmdYN+Z7+B8zmBsIAtK94bUTql5EaC6fut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soNGJjTggJAK5y9ySb6UL1QbGwh61fw8HVUhUFZWAb5v0A/FKno0iukdNBmYJarC0HbvXI/yIrzSsWjC3PTdV+nmC3E7QJoODEVa17MDD/0GbbsstIYOcr8VkcIMEEOzMgSbN0soy0eTtSzMGcU81onvFAI3x1ed/QTwreXeBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmH1P1zN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81E2C4CEC0;
	Fri, 13 Sep 2024 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726230927;
	bh=S7JsoSknSmdYN+Z7+B8zmBsIAtK94bUTql5EaC6fut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmH1P1zNNxp80Oyl2ilFiB4RLP8UIm36PcJrA/mi3U9BFNgJZ28EWR+exedF/AVVn
	 cKUVkXfb0J6/SYEfoYKm8J7qAyIIcgzqrsbXnZYZ9JQM+ZYFQog41BFdNNhyE/i/7h
	 wqcnhFv+gwArSwg6brFxnb9ewyRC3g6a9gZQVjNDpcWSdSeHhYM5OoANEFw13LKuJ/
	 D34WFHBuSzYt8w0ExYPL3ZV8W8Kxb1rP+jcceHOhEfJdhdMtnSIKBXUl/s4JFrPq8f
	 mVDV8jcdAprb+mdbTDmRWAxdCYzM21SFSdsKDQykZNVZiBAjSjshjf23yIA6dkrs5s
	 8uX4JdphBJbWA==
Date: Fri, 13 Sep 2024 14:35:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Matthew Auld <matthew.auld@intel.com>
Cc: intel-xe@lists.freedesktop.org, 
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, Akshata Jahagirdar <akshata.jahagirdar@intel.com>, 
	Shuicheng Lin <shuicheng.lin@intel.com>, Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/xe/vram: fix ccs offset calculation
Message-ID: <bcgfdjrp5jvkckdgsqpr26bnvkduvxnw7eliudh47uli6jerxl@frgpwy66hsdq>
References: <20240913120023.310565-2-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913120023.310565-2-matthew.auld@intel.com>

Hi Matt,

On Fri, Sep 13, 2024 at 01:00:24PM GMT, Matthew Auld wrote:
> Spec says SW is expected to round up to the nearest 128K, if not already
> aligned for the CC unit view of CCS. We are seeing the assert sometimes
> pop on BMG to tell us that there is a hole between GSM and CCS, as well
> as popping other asserts with having a vram size with strange alignment,
> which is likely caused by misaligned offset here.
> 
> BSpec: 68023
> Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> ---

and... what is the difference between v1 and v2? :-)

Andi

>  drivers/gpu/drm/xe/xe_vram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
> index 7e765b1499b1..8e65cb4cc477 100644
> --- a/drivers/gpu/drm/xe/xe_vram.c
> +++ b/drivers/gpu/drm/xe/xe_vram.c
> @@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
>  
>  		offset = offset_hi << 32; /* HW view bits 39:32 */
>  		offset |= offset_lo << 6; /* HW view bits 31:6 */
> +		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
>  		offset *= num_enabled; /* convert to SW view */
>  
>  		/* We don't expect any holes */
> -- 
> 2.46.0
> 

