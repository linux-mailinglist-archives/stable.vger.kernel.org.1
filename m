Return-Path: <stable+bounces-78295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3598AB41
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D611C228B9
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37189193081;
	Mon, 30 Sep 2024 17:39:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43918FDC5
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717977; cv=none; b=ct8yrEnKc2POjkyCthn3IHkAzLay9ouwtD7Tm9rndfygpXPAaUDEmkJ2LCYD3tF0gfJ/3dn8BtcwCQNUKQnsGP5ioK0SR5ejn05SHTN9oDml7BvWyxb6+yJ0phaxAFhpwi0TUbia6GsvH7KN0VRoZQBt1zbS31L91cisyoPDox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717977; c=relaxed/simple;
	bh=X0UHuWgq6m7G1OdZc9OXWIY2CW/8sDNtIIiLkmO7X+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQF8Xio2JDaP7TA1X56mrkVtXlwokAIHf0kCWC/uLpdzWAUlHpmx06ZjhFWCJ5zwDNJo/hRiMYi+wtDIXr302oEeJP3L3nF2CnmegnDdBJumabuI6fhsW3xLR6vRxU1qdvUYhm/7g3qFcxLUcrFIS50yzLgJr5/xjleH1FRT320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AED1DA7
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 10:40:03 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9206F3F64C
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 10:39:33 -0700 (PDT)
Date: Mon, 30 Sep 2024 18:39:26 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	=?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	Julia Lawall <julia.lawall@inria.fr>, kernel@collabora.com,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] drm/panthor: Fix access to uninitialized variable in
 tick_ctx_cleanup()
Message-ID: <ZvriTjPDtN-UGFpf@e110455-lin.cambridge.arm.com>
References: <20240930163742.87036-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930163742.87036-1-boris.brezillon@collabora.com>

On Mon, Sep 30, 2024 at 06:37:42PM +0200, Boris Brezillon wrote:
> The group variable can't be used to retrieve ptdev in our second loop,
> because it points to the previously iterated list_head, not a valid
> group. Get the ptdev object from the scheduler instead.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: d72f049087d4 ("drm/panthor: Allow driver compilation")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202409302306.UDikqa03-lkp@intel.com/
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 201d5e7a921e..24ff91c084e4 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2052,6 +2052,7 @@ static void
>  tick_ctx_cleanup(struct panthor_scheduler *sched,
>  		 struct panthor_sched_tick_ctx *ctx)
>  {
> +	struct panthor_device *ptdev = sched->ptdev;
>  	struct panthor_group *group, *tmp;
>  	u32 i;
>  
> @@ -2060,7 +2061,7 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
>  			/* If everything went fine, we should only have groups
>  			 * to be terminated in the old_groups lists.
>  			 */
> -			drm_WARN_ON(&group->ptdev->base, !ctx->csg_upd_failed_mask &&
> +			drm_WARN_ON(&ptdev->base, !ctx->csg_upd_failed_mask &&
>  				    group_can_run(group));
>  
>  			if (!group_can_run(group)) {
> @@ -2083,7 +2084,7 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
>  		/* If everything went fine, the groups to schedule lists should
>  		 * be empty.
>  		 */
> -		drm_WARN_ON(&group->ptdev->base,
> +		drm_WARN_ON(&ptdev->base,
>  			    !ctx->csg_upd_failed_mask && !list_empty(&ctx->groups[i]));
>  
>  		list_for_each_entry_safe(group, tmp, &ctx->groups[i], run_node) {
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

