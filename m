Return-Path: <stable+bounces-73601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC896D9F7
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F19B24263
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD519CD1B;
	Thu,  5 Sep 2024 13:16:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE2189518
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542167; cv=none; b=It8eirmng5Y071kKcH8EmvOg0/G6FJXjFd3am1ifO569NiqFiC1Jl5MlpXNID7jP92GdFEAaGSRcIEGXvkgE+56ttyoCVPn3daT1MEb9n7ODnR7+p7F8Mc5tpCXzechhR844K9EvPRx0QWG5kYDW3OXvamsCDcVRZdYsM0vUscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542167; c=relaxed/simple;
	bh=FsAbyGHLsv+dXDx4RS6frlW87Ore9ysiVjYAEXQWwYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsZ0AF/5KcYTPHtE3cCmX9jfDB5xHEVqVc1ap+Cww4r0t1sW4yboCoC8PquXklS2JoBvFb8SbH8Db/0dFbIxEOA3EMhR/3o5AR9hSQhtxN8IFL7xs4SXAZCOO0m1H4tMcDgMBm6LKJ488T84gEIH3P/n8WDjVFO7p+RIwdcIAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6CAFFEC
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 06:16:31 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD71B3F73F
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 06:16:04 -0700 (PDT)
Date: Thu, 5 Sep 2024 14:15:59 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	=?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org, kernel@collabora.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Don't declare a queue blocked if deferred
 operations are pending
Message-ID: <ZtmvDxsW8NFKrGKR@e110455-lin.cambridge.arm.com>
References: <20240905071914.3278599-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240905071914.3278599-1-boris.brezillon@collabora.com>

On Thu, Sep 05, 2024 at 09:19:14AM +0200, Boris Brezillon wrote:
> If deferred operations are pending, we want to wait for those to
> land before declaring the queue blocked on a SYNC_WAIT. We need
> this to deal with the case where the sync object is signalled through
> a deferred SYNC_{ADD,SET} from the same queue. If we don't do that
> and the group gets scheduled out before the deferred SYNC_{SET,ADD}
> is executed, we'll end up with a timeout, because no external
> SYNC_{SET,ADD} will make the scheduler reconsider the group for
> execution.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 41260cf4beb8..201d5e7a921e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1103,7 +1103,13 @@ cs_slot_sync_queue_state_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs
>  			list_move_tail(&group->wait_node,
>  				       &group->ptdev->scheduler->groups.waiting);
>  		}
> -		group->blocked_queues |= BIT(cs_id);
> +
> +		/* The queue is only blocked if there's no deferred operation
> +		 * pending, which can be checked through the scoreboard status.
> +		 */
> +		if (!cs_iface->output->status_scoreboards)
> +			group->blocked_queues |= BIT(cs_id);
> +
>  		queue->syncwait.gpu_va = cs_iface->output->status_wait_sync_ptr;
>  		queue->syncwait.ref = cs_iface->output->status_wait_sync_value;
>  		status_wait_cond = cs_iface->output->status_wait & CS_STATUS_WAIT_SYNC_COND_MASK;
> -- 
> 2.46.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

