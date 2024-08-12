Return-Path: <stable+bounces-66759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6C94F24D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7461F213CA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C0183CBF;
	Mon, 12 Aug 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fPs0LdW0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2541EA8D
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478604; cv=none; b=p+ShC4JkQB64yCmxJMd+RguM7vMaZSHp923ig6WaNu437iyRbfE+7POlDTeY1Rb7Ujy0Uq4avKoZTGOf6LViWYO6j6KDmThXMRc5MbefDz8VGgLPFnzRhX+T+3T8GVBsky0iw88H++YiKFX9iqULCNprDvriqvDHTI+xvglksLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478604; c=relaxed/simple;
	bh=Ql7+am2Ck0wCso6wuEU37+t+6ceNVQr+Ab5i1HGsDQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0xMdm6nZblBqVkGwCUuu/nZLWw4hQKLbqY6qwFuA0T9+nvh142LRER8EKKlI/nseebUu/EUfYZr1XDEbu8WrEzHf/S2MoFZc1YPAo8zle2BKfx9EQyFq8zb6Wm3+5eIjXKhszyU5pl8xt0+3znetWl0r3hdlF63KuV0QbBLv2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fPs0LdW0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W2tXrpivxXwyGj62CCSvbqkyUobzbnXp5Gf12/d9eXM=; b=fPs0LdW0pgBav7sxhgFjSuR9b2
	m7LGASrNE2P7Zh9BA8HDpu+82OLvLq93LjmrFzfTxKQNfhdND8KogQMdHTgujXaFEmK7jBSdA9O6n
	3LSSOUbbI5t+IWAFzKh1Odxe+XZcfPhFHH3GEnhlAMdK6wNCbFOF+pTNPkKVp9tcgnmeN0tGH+zCw
	7qkEGCzq/lupxSmeCUMnpRMb9hhMGtNiqyVzZrs/Sp39ber8NJFn3XRz/4facNeuc5uYNxymYWHE6
	GN3njGTjQUMko4HRNxPwxcKcmuuDUfCOXjIYhu5wEbgvOfnhJAqCNNnWtypEL8TIyXqRGKfOQeAnN
	E0kh2wWw==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sdWsy-00BYqe-4J; Mon, 12 Aug 2024 17:23:04 +0200
Message-ID: <b57d265e-3e46-4755-91d6-2cac86f48266@igalia.com>
Date: Mon, 12 Aug 2024 12:22:59 -0300
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
References: <20240812091218.70317-1-tursulin@igalia.com>
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
In-Reply-To: <20240812091218.70317-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tvrtko,

On 8/12/24 06:12, Tvrtko Ursulin wrote:
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

Although `v3d_stats_update()` is only used here, shouldn't we move 
`preempt_disable()` and `preempt_enable()` inside of the
`v3d_stats_update()` function? This way, we can guarantee that any
future uses will disable preemption.

With that, you can add my:

Acked-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

>   }
>   
>   static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)

