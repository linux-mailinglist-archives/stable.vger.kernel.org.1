Return-Path: <stable+bounces-73589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC196D5B0
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B27B284775
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1E198827;
	Thu,  5 Sep 2024 10:19:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C37191F7E
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531576; cv=none; b=uKP3wPREsa2XC2Ib7q7d3/cs/Y6pk8QeKApMnh2s31H8bNWZLKZ+97inBypAyjdrScnBGjB+plMVZOLjqs8IDgB9jYMMDPJRNX224A+Y0bkGHrCiPkcgNhaPPd12eyeIl/+mBsC1d9ZQnkdC3DsrKeZ+1Qm6d2IleXz+7Fxv2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531576; c=relaxed/simple;
	bh=Td6g4nELzgmet9YirghDsSit/1MQ4dV3k8w8v8efOnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFg72mc1ftJnWIpndcAyGVigIQcDRu5q4IJOFclH9tWh/Lv15KV9HYYOaIUFo72va8zcSJ6WA794lMlENmiQ2q0Fga6UYRTDQ6r6FGBuqohlr7Vi0UBpLINwJI+uc7oGEJ1iYZfAidkb0WH2wPDe3LJLfFCEoX8MadB0y7z5jJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218D3FEC;
	Thu,  5 Sep 2024 03:20:00 -0700 (PDT)
Received: from [10.1.29.28] (e122027.cambridge.arm.com [10.1.29.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541133F73F;
	Thu,  5 Sep 2024 03:19:32 -0700 (PDT)
Message-ID: <21f335cd-145f-42b0-929a-f0ee11efa8db@arm.com>
Date: Thu, 5 Sep 2024 11:19:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Don't add write fences to the shared BOs
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
References: <20240905070155.3254011-1-boris.brezillon@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240905070155.3254011-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 08:01, Boris Brezillon wrote:
> The only user (the mesa gallium driver) is already assuming explicit
> synchronization and doing the export/import dance on shared BOs. The
> only reason we were registering ourselves as writers on external BOs
> is because Xe, which was the reference back when we developed Panthor,
> was doing so. Turns out Xe was wrong, and we really want bookkeep on
> all registered fences, so userspace can explicitly upgrade those to
> read/write when needed.
> 
> Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 9a0ff48f7061..41260cf4beb8 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3423,13 +3423,8 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
>  {
>  	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
>  
> -	/* Still not sure why we want USAGE_WRITE for external objects, since I
> -	 * was assuming this would be handled through explicit syncs being imported
> -	 * to external BOs with DMA_BUF_IOCTL_IMPORT_SYNC_FILE, but other drivers
> -	 * seem to pass DMA_RESV_USAGE_WRITE, so there must be a good reason.
> -	 */
>  	panthor_vm_update_resvs(job->group->vm, exec, &sched_job->s_fence->finished,
> -				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_WRITE);
> +				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
>  }
>  
>  void panthor_sched_unplug(struct panthor_device *ptdev)


