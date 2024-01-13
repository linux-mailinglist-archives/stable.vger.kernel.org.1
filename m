Return-Path: <stable+bounces-10830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E1E82CECE
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 22:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0601C20E4F
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376F15AF9;
	Sat, 13 Jan 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Kn2kWVIr"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC43107A6
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oBo01r8/iJ8Rli/yC2n2geNRwwiTY1yFXJ0m+9s1Kbs=; b=Kn2kWVIracFMDNrUMhMnyoDiUR
	2ibCuN4I7pjRUItaT0IFJlJQ96lHwz/dfiWZJgEcXXg61x3g7nNTEv3IuXCskmvPD0OOfZSOw3b3t
	i3kDiUMKK0Y8LaAhlyTqJeSm2ZlPbqPYrK3vqLRsMHsSjpkTZjanlYRphWHqQbBFnhcKM46tpT/OU
	0ebp1xIOsMOvCeVn9F4KHaYBq1SU4pcFpKOjm2do83HGC4WTYzt3Qr8XFYbtlgeJb5OG0YzYbiwao
	N+8puiLPF+K8CtNt9TRGoiHjEcdsGPpGqQnS4pSjic4Xz2ST6/mOARe2G95j9AwNOa6if19sOIhDS
	0gSdrPCg==;
Received: from [177.45.63.147] (helo=[192.168.1.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rOlfL-006EEJ-EG; Sat, 13 Jan 2024 22:35:43 +0100
Message-ID: <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
Date: Sat, 13 Jan 2024 18:35:35 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: Joshua Ashton <joshua@froggi.es>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20240113140206.2383133-2-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joshua,

Em 13/01/2024 11:02, Joshua Ashton escreveu:
> We need to bump the karma of the drm_sched job in order for the context
> that we just recovered to get correct feedback that it is guilty of
> hanging.
> 
> Without this feedback, the application may keep pushing through the soft
> recoveries, continually hanging the system with jobs that timeout.
> 
> There is an accompanying Mesa/RADV patch here
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
> to properly handle device loss state when VRAM is not lost.
> 
> With these, I was able to run Counter-Strike 2 and launch an application
> which can fault the GPU in a variety of ways, and still have Steam +
> Counter-Strike 2 + Gamescope (compositor) stay up and continue
> functioning on Steam Deck.
> 

I sent a similar patch in the past, maybe you find the discussion 
interesting:

https://lore.kernel.org/lkml/20230424014324.218531-1-andrealmeid@igalia.com/

> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: André Almeida <andrealmeid@igalia.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 25209ce54552..e87cafb5b1c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job)
>   		dma_fence_set_error(fence, -ENODATA);
>   	spin_unlock_irqrestore(fence->lock, flags);
>   
> +	if (job->vm)
> +		drm_sched_increase_karma(&job->base);
>   	atomic_inc(&ring->adev->gpu_reset_counter);
>   	while (!dma_fence_is_signaled(fence) &&
>   	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)

