Return-Path: <stable+bounces-78559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE798C3CE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED9B2847FA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D01C5782;
	Tue,  1 Oct 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UcA6G7i2"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6F1C9EB4
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801177; cv=none; b=j7tzGy7q/DiqwPJH6ooyonXa90GhFSguT7sst9OX4G/XfD8tP3F3YwdVM+3IhVTJHEmNXrV6OAeESDxjdBslt7x9emNU1BvV0YWFQH1apQKg40WptKm5sHUODpdsKjLn3NYs2xwuW7QNtCyj58q/O/JlQu7cTE+B17TpX3j8GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801177; c=relaxed/simple;
	bh=xE6NJpQ74aBGmAv3SpGgn5T8OT7VuUeAiPRDBOsfvYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulh+s840uMHwxDqdwQFoSIJxQG6iI9LBLpAouMEGwj2hJzzFgz4Rh5VFEQSBj+jG2dekA2IjmddGp5A660mNrGtcktZSn9FV2di3sj8Izoq/H/ADJ31BvUQiYEozls+xK5+KB/7Mw+7mkX2jII86+2N9m/0I5Yn9TomNLxwsz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UcA6G7i2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727801174;
	bh=xE6NJpQ74aBGmAv3SpGgn5T8OT7VuUeAiPRDBOsfvYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UcA6G7i2/9hmSh/XmFgPhFCvgPnDvT8dz2CYiCQlYgEHhF9h93ZO6DnZTLiygAHVp
	 fQeB56Jr0uC0+tzg2/CGVjc/1dDvp7+1u4rLLn494qrYNht+moGwxUOJoxTJN7ZfLU
	 rEVLRedZtpI7XjVEE6nh+UgPTButa7C/C8X/hlfeaS1NesYk7mTZ35l3x3ex1zCrCp
	 7ZfmGUJpuuhlwI+4v1hLElv2pCY9XDg3S5FS6JrvPz7etg4aF0G8uMh33GnCI5CZ9i
	 mtyyh4qvCaS/NkpMonbRKLbJwftacAN7PrKsrTrRl4bRamf/p6u29BGr8bsEYqbpQH
	 o8//CQM8FPShw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C584D17E1060;
	Tue,  1 Oct 2024 18:46:13 +0200 (CEST)
Date: Tue, 1 Oct 2024 18:46:10 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, Matthew Brost
 <matthew.brost@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Don't add write fences to the shared BOs
Message-ID: <20241001184610.43d4ae2a@collabora.com>
In-Reply-To: <20240905070155.3254011-1-boris.brezillon@collabora.com>
References: <20240905070155.3254011-1-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 09:01:54 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

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

Queued to drm-misc-fixes.

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


