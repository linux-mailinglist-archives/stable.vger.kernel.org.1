Return-Path: <stable+bounces-70314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C796049D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB5C1C20B9A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C254197A83;
	Tue, 27 Aug 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhgDCZgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DB14A90;
	Tue, 27 Aug 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747990; cv=none; b=BKJdlmdl071W3oofZ822NJUhRJ+Lwmb0kAPOKVaB3kHIr4zevdhDWznZ2DIsGQHMRwTY3ZPnDKFfQJb5iKC7+eSZoJ0lNIr1y/JWAyO+qMs1r+pukBpkeN3kUgWNeaz4Truou1svcdkSTC2986tlYIYiLfEHqbQ5hQT14giwaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747990; c=relaxed/simple;
	bh=rZ2wpB0Y+VWnhoCHWKOo5llJYLwaTLq/4hYvgehNZ2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8MPTn0xImFGZdzyccFRYUAgT+KjNEoD3Y4ccgtG8GpvhchhGCVjrWvS4dE5vTLkkwIO99Pp4+Nqhb7ZXfpQmNcWmByjpz/Z+lwENqGn9aab60QC5YUP5LrMRzTiibu/RE67wD/8pyF0i/Xv5fJY4vZbR8HI7yXD0+imR+VTq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhgDCZgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5901BC8B7AA;
	Tue, 27 Aug 2024 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724747989;
	bh=rZ2wpB0Y+VWnhoCHWKOo5llJYLwaTLq/4hYvgehNZ2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZhgDCZgs3GArgGQylJXU0u72MWPZYCKfCElYIRFJKfpZSkL2EdPV8Cmq5TuOEns37
	 v0D701DXavUQ0RTJkI2zfZU34C0KeldFJzYBb+d2P7K2FjrlDgvhbORUGJqXjIKVzL
	 MLaKpMDL29pEaGZwgAHHAY1e2XPrAF/QIG7rUCK/xU9NkIxqP2zX7rbWwwy2KzUo4e
	 qwraGfKm51CRYpaPuHQyGWMSKFzJiZvhFslQSVCT7KuZj8jcCxvUDrCbTID/dP3W73
	 j/GZ3MNJPh2xEWhErNl1KCyxX+5g7/bBLqLQGoVPA0NM6shSpXWT+IguWtloYWvv0k
	 Ujk6ilIZtj/fg==
Message-ID: <c443e90d-6907-4a02-bab4-c1943f021a8c@kernel.org>
Date: Tue, 27 Aug 2024 10:39:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Fix UB pointer dereference
To: Philipp Stanner <pstanner@redhat.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240827074521.12828-2-pstanner@redhat.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20240827074521.12828-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 9:45 AM, Philipp Stanner wrote:
> In drm_sched_job_init(), commit 56e449603f0a ("drm/sched: Convert the
> GPU scheduler to variable number of run-queues") implemented a call to
> drm_err(), which uses the job's scheduler pointer as a parameter.
> job->sched, however, is not yet valid as it gets set by
> drm_sched_job_arm(), which is always called after drm_sched_job_init().
> 
> Since the scheduler code has no control over how the API-User has
> allocated or set 'job', the pointer's dereference is undefined behavior.
> 
> Fix the UB by replacing drm_err() with pr_err().
> 
> Cc: <stable@vger.kernel.org>	# 6.7+
> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
> Reported-by: Danilo Krummrich <dakr@redhat.com>
> Closes: https://lore.kernel.org/lkml/20231108022716.15250-1-dakr@redhat.com/
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 7e90c9f95611..356c30fa24a8 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -797,7 +797,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>   		 * or worse--a blank screen--leave a trail in the
>   		 * logs, so this can be debugged easier.
>   		 */
> -		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
> +		pr_err("*ERROR* %s: entity has no rq!\n", __func__);

I don't think the "*ERROR*" string is necessary, it's pr_err() already.

Otherwise,

Acked-by: Danilo Krummrich <dakr@kernel.org>

>   		return -ENOENT;
>   	}
>   

