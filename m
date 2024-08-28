Return-Path: <stable+bounces-71442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8571963186
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46821C21C6F
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249E1A7ADD;
	Wed, 28 Aug 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RT+MZl00"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12B13775E
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876101; cv=none; b=k6ed+hS4L9UOLezSma9jzXoZgV3M3n56RMkjRSIussFesauXBAb4NtDl6AfFJEOoB89SRlq1kVUv5Tz/SDuUXbCoZCkblg+z62NLvf9+JpNtXk2X0evx4iRrkJ77m5M+ju8jfG6IYAkbfZpi2D2qnBJsGN2JwMe7k5MeHPBtuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876101; c=relaxed/simple;
	bh=uGNu+Eo9CuHR3MZkPv67aRfcAVKI9IMCofFtdR1O1Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abu6ex4rKAVORQXLMGmyKiXZDdhiBKV5Af6Nx50Mzp2265ciqKOaxQp5o4UusrN6urXYG9jcnWalMxDn97mlJooIDEp0tIzC45LRpOufQkqJDDadQtRUGxhS6NyiHmqS4fKO/LG6KE6wwhY5Q6n4PHh/2pQgDL0USdHotWPX1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RT+MZl00; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Le/8/9cCn/eBCEJoZiUW3LnjHOH19SUZ2uOTXQy+Hfs=; b=RT+MZl00NdFzdm2HkYCZfStfw1
	LNPeWuX8Qsx2AEQcmDXcp8TqjcU/KLVdXSa45vhCkEShAlvC7wpxl8OK7qThmgNeRULrosjEkOtuW
	w5WrHc/YXAudam8dns1EsMIOxOslSudzad2ew6k2rW+wOJ7TdSSbGe/6a2xfzkj/UbGFpohjzSuaV
	7aKIMprxjKGGK5qgBU7hIqTfdsJqvYm4xE+q/6j9l1HnBY6D+5d62LT2VjVlRh87lVIDZIMWVfYno
	/jw1+rH58aTwJNP4eFKGngk5/FPn0FC2E78UHg0c1WIA50lQaBOu6O0RvxSG3PlIIm6mCE+R9ZOW3
	H5DEMhWA==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sjP49-006SsX-ET; Wed, 28 Aug 2024 22:14:53 +0200
Message-ID: <22831c77-d144-4dbc-b155-6ecb1b3704d1@igalia.com>
Date: Wed, 28 Aug 2024 17:14:46 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/v3d: Disable preemption while updating GPU stats
To: Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 stable@vger.kernel.org
References: <20240813102505.80512-1-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240813102505.80512-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tvrtko,

On 8/13/24 07:25, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> We forgot to disable preemption around the write_seqcount_begin/end() pair
> while updating GPU stats:
> 
>    [ ] WARNING: CPU: 2 PID: 12 at include/linux/seqlock.h:221 __seqprop_assert.isra.0+0x128/0x150 [v3d]
>    [ ] Workqueue: v3d_bin drm_sched_run_job_work [gpu_sched]
>   <...snip...>
>    [ ] Call trace:
>    [ ]  __seqprop_assert.isra.0+0x128/0x150 [v3d]
>    [ ]  v3d_job_start_stats.isra.0+0x90/0x218 [v3d]
>    [ ]  v3d_bin_job_run+0x23c/0x388 [v3d]
>    [ ]  drm_sched_run_job_work+0x520/0x6d0 [gpu_sched]
>    [ ]  process_one_work+0x62c/0xb48
>    [ ]  worker_thread+0x468/0x5b0
>    [ ]  kthread+0x1c4/0x1e0
>    [ ]  ret_from_fork+0x10/0x20
> 
> Fix it.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 6abe93b621ab ("drm/v3d: Fix race-condition between sysfs/fdinfo and interrupt handler")
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Acked-by: Maíra Canal <mcanal@igalia.com>

I just applied this patch to drm-misc-fixes. I'll wait for drm-misc-
fixes to be backported to drm-misc-next before applying the second patch
to drm-misc-next.

Thanks for your contribution!

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/v3d/v3d_sched.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 42d4f4a2dba2..cc2e5a89467b 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -136,6 +136,8 @@ v3d_job_start_stats(struct v3d_job *job, enum v3d_queue queue)
>   	struct v3d_stats *local_stats = &file->stats[queue];
>   	u64 now = local_clock();
>   
> +	preempt_disable();
> +
>   	write_seqcount_begin(&local_stats->lock);
>   	local_stats->start_ns = now;
>   	write_seqcount_end(&local_stats->lock);
> @@ -143,6 +145,8 @@ v3d_job_start_stats(struct v3d_job *job, enum v3d_queue queue)
>   	write_seqcount_begin(&global_stats->lock);
>   	global_stats->start_ns = now;
>   	write_seqcount_end(&global_stats->lock);
> +
> +	preempt_enable();
>   }
>   
>   static void
> @@ -164,8 +168,10 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
>   	struct v3d_stats *local_stats = &file->stats[queue];
>   	u64 now = local_clock();
>   
> +	preempt_disable();
>   	v3d_stats_update(local_stats, now);
>   	v3d_stats_update(global_stats, now);
> +	preempt_enable();
>   }
>   
>   static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)

