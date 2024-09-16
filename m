Return-Path: <stable+bounces-76199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFC979E43
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E413A1F21F5E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B314A4E0;
	Mon, 16 Sep 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCiRhUN3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D776144304;
	Mon, 16 Sep 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478313; cv=none; b=fU3uirwBFggUqpOAZazCQOxBYXgwTito7zNLZNJJkucDqPGy2DBhU7pGNNWD5kilW9wTaZ8XsC3dbmvIf4mcwIuiB3r0ujnVEd/65qT+eVjMFFEYuQUgg8Rgn0p6Djw5Juo7gtuycU0CPwmkQcUt7Xjix6rlmWwPEejetZyYb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478313; c=relaxed/simple;
	bh=zEWR3VljhiLlA5posYMPNrB0uVTCKJ5HXlA8NqGoA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVr94vD1t0ChBQSuPZx0TxEJll+UvM7YhwVDa4kElLZqRCssxcU4nODydw7D0JIXNBRu4m40TZZmmvSiNPdk9frdpQlTneunRFGS6xkPiz8zrXr2LoNqHJ2fY3yi0OX9UhfFbKvcIJ0HDCYcFx9uSMNJYNokECe/UkqjKSX/9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCiRhUN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5E0C4CEC4;
	Mon, 16 Sep 2024 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478310;
	bh=zEWR3VljhiLlA5posYMPNrB0uVTCKJ5HXlA8NqGoA7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCiRhUN3XFWuXYljppL4ITBsTf5UvGs+TQtpjtRovnqMUhkAHvoUNH8auk2Ed9j/M
	 rxorIWz/CLx4SeqJf15J1DM7/HAl4pQ+XlPMkfuwK0v+UYd99zPWAEne4425tg0dYC
	 LsJkmZK8PhX+soEAyl3F5fiKjDrhQNX/4NExaVWe2vsb4aiQ12lKL1ZGC6qRAc2rXc
	 mnEl8h14fysCWezqzR9qLkpXJdeWKl0XzP0iC6mJhcfng9gtdGLAoZGe41ylAm60EK
	 ayXtTfO+UsePSvLcaSg6UDqvuZj8C2llhJREHdmyWiXqVzt2rUXa9U+yQK9Gk2vMia
	 L/1d/qWiPR2hw==
Date: Mon, 16 Sep 2024 11:18:24 +0200
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
Message-ID: <Zuf34Bg2B78FlKyh@pollux>
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

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

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

