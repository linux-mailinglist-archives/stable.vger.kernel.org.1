Return-Path: <stable+bounces-76940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B448983A4E
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 01:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BF1282E4C
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB8126BE5;
	Mon, 23 Sep 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJK/PUQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DE23DE;
	Mon, 23 Sep 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133427; cv=none; b=BsNlzA0tcnAOrdkisIQe+0Hj/G80BWW9DX/M0j9xiZGjVZHLlyDZUjTanHcprjI0JanvLuczZGA/yRmui7h3kTZm4RKuV17wXQ0ra9j6E3A9Zukuq1H7+u2e8/nQrhcrNDq4uacr2Wsai08wCFqKy2j1rR1kf3OYbVzCe2eysoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133427; c=relaxed/simple;
	bh=UG4UGsKvX+wo2WitQPf+2gQC75xr/D3jMlaQj0ZBjE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhkEtZl84bF3PcvRkLpwHF1p41PCgo3873NTbUWwaXeRHG1pjEPCi/HR2c8OujvrxpbIPeGxFIBsgKj1n3WAfetAmHn87w/vQfQowlglJzOICDTyZHtZ4ygCEIZFrYQ3MoD0JQS5jmHDJYPTXOeHJWTfsqR1DsZgnq20ErtfOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJK/PUQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2D6C4CEC4;
	Mon, 23 Sep 2024 23:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727133426;
	bh=UG4UGsKvX+wo2WitQPf+2gQC75xr/D3jMlaQj0ZBjE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJK/PUQcr11Ke/mGT5Csom2T1JI2blUSICf8algmmr8FoU/le19MjhPgrj5WwGGVq
	 juI9bs5nAjIia4RBEv2noI0AdLx3I7zIsezLIGcYX2mb8nXZtG8E6HfN6Y2xdgUpBK
	 8Iphs1PMwNHVs6j7OFgjlIAdwPF+rfEcLtT79/ujx1Ms7vUNSRLXfvWA0Z5D1MuyMW
	 /6QUswAdwf2Bit3Yi1Fr8PhpsNvTPB2v9dbOysL/nuVnX5P3Xbr6XcdESFs8LkpGr0
	 GeQ6cSyiZoME+9fzVqQwpg/PyV42WLA/F0cdSBdYJ3BR0/hPLQwiw0GbIQbOslNHsg
	 mhcXAJgmUuIGA==
Date: Tue, 24 Sep 2024 01:17:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Asahi Lina <lina@asahilina.net>, stable@vger.kernel.org,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/sched: Fix dynamic job-flow control race
Message-ID: <ZvH27TgYcJbHeiZn@pollux.localdomain>
References: <20240913202301.16772-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913202301.16772-1-robdclark@gmail.com>

On Fri, Sep 13, 2024 at 01:23:01PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609
> 
> The whole premise of lockless access to a single-producer-single-
> consumer queue is that there is just a single producer and single
> consumer.  That means we can't call drm_sched_can_queue() (which is
> about queueing more work to the hw, not to the spsc queue) from
> anywhere other than the consumer (wq).
> 
> This call in the producer is just an optimization to avoid scheduling
> the consuming worker if it cannot yet queue more work to the hw.  It
> is safe to drop this optimization to avoid the race condition.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
> Closes: https://github.com/AsahiLinux/linux/issues/309
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Applied to drm-misc-fixes, thanks!

> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
>  drivers/gpu/drm/scheduler/sched_main.c   | 7 ++-----
>  include/drm/gpu_scheduler.h              | 2 +-
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 58c8161289fe..567e5ace6d0c 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -380,7 +380,7 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
>  		container_of(cb, struct drm_sched_entity, cb);
>  
>  	drm_sched_entity_clear_dep(f, cb);
> -	drm_sched_wakeup(entity->rq->sched, entity);
> +	drm_sched_wakeup(entity->rq->sched);
>  }
>  
>  /**
> @@ -612,7 +612,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>  			drm_sched_rq_update_fifo(entity, submit_ts);
>  
> -		drm_sched_wakeup(entity->rq->sched, entity);
> +		drm_sched_wakeup(entity->rq->sched);
>  	}
>  }
>  EXPORT_SYMBOL(drm_sched_entity_push_job);
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index ab53ab486fe6..6f27cab0b76d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1013,15 +1013,12 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
>  /**
>   * drm_sched_wakeup - Wake up the scheduler if it is ready to queue
>   * @sched: scheduler instance
> - * @entity: the scheduler entity
>   *
>   * Wake up the scheduler if we can queue jobs.
>   */
> -void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
> -		      struct drm_sched_entity *entity)
> +void drm_sched_wakeup(struct drm_gpu_scheduler *sched)
>  {
> -	if (drm_sched_can_queue(sched, entity))
> -		drm_sched_run_job_queue(sched);
> +	drm_sched_run_job_queue(sched);
>  }
>  
>  /**
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index fe8edb917360..9c437a057e5d 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -574,7 +574,7 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
>  
>  void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched);
>  void drm_sched_job_cleanup(struct drm_sched_job *job);
> -void drm_sched_wakeup(struct drm_gpu_scheduler *sched, struct drm_sched_entity *entity);
> +void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>  bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched);
>  void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched);
>  void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
> -- 
> 2.46.0
> 

