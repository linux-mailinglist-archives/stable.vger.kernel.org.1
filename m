Return-Path: <stable+bounces-78557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62BA98C3BB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 18:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665351F21996
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154F1CB523;
	Tue,  1 Oct 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TkeMFdoh"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F71CB519
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801099; cv=none; b=ioTcf6NiuUu2viAvgWfQcNiijle/GUJCc4jdNV9n3y2afi5CWjmSMbHBX2+LEoFG3oOnhfR5zgWXRspUkOiCi1ls2vBNHrbJrzYd1gdfFdkmtJBdqdPTQE9W6ThjZHAYvBCK0PgQCXcxygxCfrcQcm+oivuoadfvdMjQtIR55fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801099; c=relaxed/simple;
	bh=O1xxf+LgFXqyD3WL+3jhBGJgRN9DMhnh7oMTmo6XrBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DePsBDyI5EM/5uRSb/fyVr42Euxn+4Vlwn2+skEYm4GgxTpa1d+ouY07642LHsM+72d/NYtXMDJ/qYSy7LLxnKrbXzTKf/PGYD+AYYWbvj1e3caaO17KEwR0iKd7WKfKUSnxJaqn24Y2BtO0U97hiXT2bxtgoyGm2i62p0gZ3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TkeMFdoh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727801096;
	bh=O1xxf+LgFXqyD3WL+3jhBGJgRN9DMhnh7oMTmo6XrBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TkeMFdohgevVYm+5xCd4Y62PP2XXOnd0d+tkcMH/Ob3czfDgKXLfVHy/KeJNrRRm8
	 OYlvfNwMITDiOG+7JeGQ7VerbuEJ1rzd6Gia5gx9CQ6Bt8HezAc64WqSxL0kDfy7mU
	 aBY2NtrVfKSZgnIwHgE68B6vnuITsePJxWjXGp+lW2/PnbiEJBZumkabFpq+CYccmu
	 haIifhI17bzANKDVhxtWP+TOU6rgIvFFdRqqFngChcHvuMHmukn/ZUrUEEpbM/reTL
	 supISV7P1/BKq0rxYvCV4kpHT1ycXOIC93pGlF98etQ4tGGqhAJ4O8kRYhqCXPRyzP
	 qUc6QHkUls7zA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D046417E1060;
	Tue,  1 Oct 2024 18:44:55 +0200 (CEST)
Date: Tue, 1 Oct 2024 18:44:51 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@inria.fr>,
 kernel@collabora.com, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v2] drm/panthor: Fix access to uninitialized variable in
 tick_ctx_cleanup()
Message-ID: <20241001184451.041cf02f@collabora.com>
In-Reply-To: <20240930163742.87036-1-boris.brezillon@collabora.com>
References: <20240930163742.87036-1-boris.brezillon@collabora.com>
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

On Mon, 30 Sep 2024 18:37:42 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

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

Queued to drm-misc-fixes.

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


