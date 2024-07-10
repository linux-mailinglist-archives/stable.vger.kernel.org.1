Return-Path: <stable+bounces-59030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7892D6EE
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 18:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997FF283FAA
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D1194A5E;
	Wed, 10 Jul 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Dj0RUbkE"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BEBE4E
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630426; cv=none; b=a9zN3XBjX7BdJ7c/rHFtzJz4R3sMUIuTNCgh4ZeOFXJRv+J5eRF/ht08QTwxmuPLcXCuzm+kcGPOFUfq0LpZdbSBnz7u4SPgYZZUHznIz2GAIwNcRL+bH6x0XmCkkq+2j0Wsjzus9+MsfUYaCDOZt6HYnrKDgtQNggSscWFcfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630426; c=relaxed/simple;
	bh=momHgnrWLtzVAden7OXBe7qbaQ0SqS6tjMatziBenaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVY73z08dWUmUxdqVvXUXAtmYoI2GucTRKvCApT0tGmnSOTy5y1tYhvOLK38K9762tlIiK9w+vIwtWP05dnbSMtqC0AiTnG8wIZD+bDonbwhNPBSeA7O7JcI/yiYBTpXRuHWAZWK57GJ+yxzGH7y9IeMCRraR0HqD7yoLSvykJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Dj0RUbkE; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Rw3XxamDj1d5KGwjJD35pbWSeV7+7+JsM/RTHX08vsQ=; b=Dj0RUbkEWLAXx7c8PGyusCVOJY
	2yNHVGlrC0Hty7ePIAsKZnaEFMivXAh+00s/I0xerKlO2tRnTLIUZDHSAE6mm8fMUK7gMSJlVtTzB
	3RG+80Cx9fr1RFWit6cGX7F6B8J6gAQ/7jV/KEXQ/ojm6pdVjDqEgCkEH4xmQ44lPChIrQVSvUT3y
	aCkiQDZ2LVXaQ7kLKZAVqftgByz8L4qY96hldbx/WuCqexyQHUD7XecXZ21hKLL/BtVedl3vbkK4X
	xz0cebzdg5eXW9u3VVH3DKTrRTQ2qNOdkezWUVTe8q8d6zhZL7ZKiMhhbn9hM3R5Va7at5FcBQZqO
	aDXpvcGw==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRaZX-00DL0a-H3; Wed, 10 Jul 2024 18:53:39 +0200
Message-ID: <ec14d6f6-f774-4795-8aff-bae344e0a982@igalia.com>
Date: Wed, 10 Jul 2024 13:53:35 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] drm/v3d: Fix potential memory leak in the timestamp
 extension
To: Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>, stable@vger.kernel.org
References: <20240710134130.17292-1-tursulin@igalia.com>
 <20240710134130.17292-3-tursulin@igalia.com>
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
In-Reply-To: <20240710134130.17292-3-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/24 10:41, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> If fetching of userspace memory fails during the main loop, all drm sync
> objs looked up until that point will be leaked because of the missing
> drm_syncobj_put.
> 
> Fix it by exporting and using a common cleanup helper.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

This patch looks fine to me apart from two nits and a compilation issue.

> Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/v3d/v3d_drv.h    |  2 ++
>   drivers/gpu/drm/v3d/v3d_sched.c  | 22 +++++++++++++------
>   drivers/gpu/drm/v3d/v3d_submit.c | 36 ++++++++++++++++++++++----------
>   3 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 099b962bdfde..95651c3c926f 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -563,6 +563,8 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo);
>   void v3d_mmu_remove_ptes(struct v3d_bo *bo);
>   
>   /* v3d_sched.c */
> +void __v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *qinfo,
> +				     unsigned int count);

My two nits:

I believe we never used this `__` pattern in V3D and I'm not sure how
comfortable I am to introduce it now. I know it is pretty common in
drivers like i915, but I wonder how much semantics we would miss to
remove it.

Also, any chance we could use `query_info` instead of `qinfo`? This
suggestion applies to all patches in the series that uses `qinfo`.

>   void v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue);
>   int v3d_sched_init(struct v3d_dev *v3d);
>   void v3d_sched_fini(struct v3d_dev *v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 03df37a3acf5..e45d3ddc6f82 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -73,18 +73,28 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
>   	v3d_job_cleanup(job);
>   }
>   
> +void
> +__v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *qinfo,
> +				unsigned int count)
> +{
> +	if (qinfo->queries) {
> +		unsigned int i;
> +
> +		for (i = 0; i < count; i++)
> +			drm_syncobj_put(qinfo->queries[i].syncobj);
> +
> +		kvfree(qinfo->queries);
> +	}
> +}
> +
>   static void
>   v3d_cpu_job_free(struct drm_sched_job *sched_job)
>   {
>   	struct v3d_cpu_job *job = to_cpu_job(sched_job);
> -	struct v3d_timestamp_query_info *timestamp_query = &job->timestamp_query;
>   	struct v3d_performance_query_info *performance_query = &job->performance_query;
>   
> -	if (timestamp_query->queries) {
> -		for (int i = 0; i < timestamp_query->count; i++)
> -			drm_syncobj_put(timestamp_query->queries[i].syncobj);
> -		kvfree(timestamp_query->queries);
> -	}
> +	__v3d_timestamp_query_info_free(&job->timestamp_query,
> +					job->timestamp_query.count);
>   
>   	if (performance_query->queries) {
>   		for (int i = 0; i < performance_query->count; i++)
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 263fefc1d04f..2818afdd4807 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -452,6 +452,7 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   {
>   	u32 __user *offsets, *syncs;
>   	struct drm_v3d_timestamp_query timestamp;
> +	int err;
>   
>   	if (!job) {
>   		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
> @@ -484,15 +485,15 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   		u32 offset, sync;
>   
>   		if (copy_from_user(&offset, offsets++, sizeof(offset))) {
> -			kvfree(job->timestamp_query.queries);
> -			return -EFAULT;
> +			err = -EFAULT;
> +			goto error;
>   		}
>   
>   		job->timestamp_query.queries[i].offset = offset;
>   
>   		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
> -			kvfree(job->timestamp_query.queries);
> -			return -EFAULT;
> +			err = -EFAULT;
> +			goto error;
>   		}
>   
>   		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> @@ -500,6 +501,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   	job->timestamp_query.count = timestamp.count;
>   
>   	return 0;
> +
> +error:
> +	__v3d_timestamp_query_info_free(qinfo, i);

I don't see where `qinfo` is declared in this function.

> +	return err;
>   }
>   
>   static int
> @@ -509,6 +514,7 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   {
>   	u32 __user *syncs;
>   	struct drm_v3d_reset_timestamp_query reset;
> +	int err;
>   
>   	if (!job) {
>   		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
> @@ -539,8 +545,8 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   		job->timestamp_query.queries[i].offset = reset.offset + 8 * i;
>   
>   		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
> -			kvfree(job->timestamp_query.queries);
> -			return -EFAULT;
> +			err = -EFAULT;
> +			goto error;
>   		}
>   
>   		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> @@ -548,6 +554,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   	job->timestamp_query.count = reset.count;
>   
>   	return 0;
> +
> +error:
> +	__v3d_timestamp_query_info_free(qinfo, i);

Same here.

> +	return err;
>   }
>   
>   /* Get data for the copy timestamp query results job submission. */
> @@ -558,7 +568,7 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
>   {
>   	u32 __user *offsets, *syncs;
>   	struct drm_v3d_copy_timestamp_query copy;
> -	int i;
> +	int i, err;
>   
>   	if (!job) {
>   		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
> @@ -591,15 +601,15 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
>   		u32 offset, sync;
>   
>   		if (copy_from_user(&offset, offsets++, sizeof(offset))) {
> -			kvfree(job->timestamp_query.queries);
> -			return -EFAULT;
> +			err = -EFAULT;
> +			goto error;
>   		}
>   
>   		job->timestamp_query.queries[i].offset = offset;
>   
>   		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
> -			kvfree(job->timestamp_query.queries);
> -			return -EFAULT;
> +			err = -EFAULT;
> +			goto error;
>   		}
>   
>   		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> @@ -613,6 +623,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
>   	job->copy.stride = copy.stride;
>   
>   	return 0;
> +
> +error:
> +	__v3d_timestamp_query_info_free(qinfo, i);

Same here.

Best Regards,
- Maíra

> +	return err;
>   }
>   
>   static int

