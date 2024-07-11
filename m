Return-Path: <stable+bounces-59120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7992E8C7
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039701C22864
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDA7161939;
	Thu, 11 Jul 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DF8yGEFD"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA816190B
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702891; cv=none; b=tSgAo5uUtDJQ6QQIj9ZHMkOqCkpW8Z6+d2WbkGoARBEInpol/3r18kIYsSmfQieAUCF8Cl3vZ3QZzCD5XnU70WBW/Ur1tkhpW8GECBU5NsPALadIlf7cnvR6OUeKAP4MEeuOzyaXY83jEHAJjvldRTrJpydiz7FBp0e0aCs/Kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702891; c=relaxed/simple;
	bh=nt/l1+gt+tZRngjwZ8JBBnW/Ema7pgQ3H0MuCopxy+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOU1OrryiS2xusqr1WQe4WM8bxyuHhi+cEE5JiW7wJePTt63QG2ASXQdh8iIGkUg16o7OttI/5hNbAxQn/1Tpk6lt0GgU8ab3RSP8/BsMKubGgKoNA5QXmI/YlNvrWV6yeykWWp7LAyIZrf2aedUa/fK0bom1ogywd930vRKtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DF8yGEFD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gYMrITSB5LbfwzdSbMLl5VwE3L5thh7w/W6lel4HCQk=; b=DF8yGEFDAJjy83qP8KK2ABotdu
	ZQeaEi1VZFTmkSe3Oe+D4j+nKi5oXD6vMgDFCy5L0dzF4qy4gf50dZtsoMiG0EVaHuNTm3LbsLFmR
	rUe6zM6F9a9K95rmIMK08VG9qy/7Y4oAVCuggdsrUomjv1M7FuPT7bgunK9oVNXU34ENk5HIDGlUC
	5u1i3V2w3aU/FPND+78VLss/DJOwkSAYH27U1BklePnvduX/qNYjZdd1IVdUjwzsWQHQvkPHl/U8k
	bfxOfIkv/hFbuSRPtk0MH64wdbBFPbxnvBWJcYHuInoOfYzBp0fyt4wKJS9X0EbAl908YXsyo+rUm
	vDUti1RA==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRtQK-00DhSG-Mj; Thu, 11 Jul 2024 15:01:25 +0200
Message-ID: <110e9540-5009-47e6-8e41-1ec841f3217e@igalia.com>
Date: Thu, 11 Jul 2024 10:01:19 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/v3d: Fix potential memory leak in the timestamp
 extension
To: Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>, stable@vger.kernel.org
References: <20240711091542.82083-1-tursulin@igalia.com>
 <20240711091542.82083-3-tursulin@igalia.com>
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
In-Reply-To: <20240711091542.82083-3-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/24 06:15, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> If fetching of userspace memory fails during the main loop, all drm sync
> objs looked up until that point will be leaked because of the missing
> drm_syncobj_put.
> 
> Fix it by exporting and using a common cleanup helper.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/v3d/v3d_drv.h    |  2 ++
>   drivers/gpu/drm/v3d/v3d_sched.c  | 22 +++++++++++-----
>   drivers/gpu/drm/v3d/v3d_submit.c | 43 ++++++++++++++++++++++----------
>   3 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 099b962bdfde..e208ffdfba32 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -563,6 +563,8 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo);
>   void v3d_mmu_remove_ptes(struct v3d_bo *bo);
>   
>   /* v3d_sched.c */
> +void v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
> +				   unsigned int count);
>   void v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue);
>   int v3d_sched_init(struct v3d_dev *v3d);
>   void v3d_sched_fini(struct v3d_dev *v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 03df37a3acf5..59dc0287dab9 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -73,18 +73,28 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
>   	v3d_job_cleanup(job);
>   }
>   
> +void
> +v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
> +			      unsigned int count)
> +{
> +	if (query_info->queries) {
> +		unsigned int i;
> +
> +		for (i = 0; i < count; i++)
> +			drm_syncobj_put(query_info->queries[i].syncobj);
> +
> +		kvfree(query_info->queries);
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
> +	v3d_timestamp_query_info_free(&job->timestamp_query,
> +				      job->timestamp_query.count);
>   
>   	if (performance_query->queries) {
>   		for (int i = 0; i < performance_query->count; i++)
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 263fefc1d04f..121bf1314b80 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -452,6 +452,8 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   {
>   	u32 __user *offsets, *syncs;
>   	struct drm_v3d_timestamp_query timestamp;
> +	unsigned int i;
> +	int err;
>   
>   	if (!job) {
>   		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
> @@ -480,19 +482,19 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   	offsets = u64_to_user_ptr(timestamp.offsets);
>   	syncs = u64_to_user_ptr(timestamp.syncs);
>   
> -	for (int i = 0; i < timestamp.count; i++) {
> +	for (i = 0; i < timestamp.count; i++) {
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
> @@ -500,6 +502,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   	job->timestamp_query.count = timestamp.count;
>   
>   	return 0;
> +
> +error:
> +	v3d_timestamp_query_info_free(&job->timestamp_query, i);
> +	return err;
>   }
>   
>   static int
> @@ -509,6 +515,8 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   {
>   	u32 __user *syncs;
>   	struct drm_v3d_reset_timestamp_query reset;
> +	unsigned int i;
> +	int err;
>   
>   	if (!job) {
>   		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
> @@ -533,14 +541,14 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   
>   	syncs = u64_to_user_ptr(reset.syncs);
>   
> -	for (int i = 0; i < reset.count; i++) {
> +	for (i = 0; i < reset.count; i++) {
>   		u32 sync;
>   
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
> @@ -548,6 +556,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   	job->timestamp_query.count = reset.count;
>   
>   	return 0;
> +
> +error:
> +	v3d_timestamp_query_info_free(&job->timestamp_query, i);
> +	return err;
>   }
>   
>   /* Get data for the copy timestamp query results job submission. */
> @@ -558,7 +570,8 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
>   {
>   	u32 __user *offsets, *syncs;
>   	struct drm_v3d_copy_timestamp_query copy;
> -	int i;
> +	unsigned int i;
> +	int err;
>   
>   	if (!job) {
>   		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
> @@ -591,15 +604,15 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
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
> @@ -613,6 +626,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
>   	job->copy.stride = copy.stride;
>   
>   	return 0;
> +
> +error:
> +	v3d_timestamp_query_info_free(&job->timestamp_query, i);
> +	return err;
>   }
>   
>   static int

