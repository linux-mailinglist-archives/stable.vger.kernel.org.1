Return-Path: <stable+bounces-133196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD9A91F61
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DACE8A1EEF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99291238171;
	Thu, 17 Apr 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6sDauiw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AED1ACECB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899623; cv=none; b=bGbmteEYKMGAnc6BQ3oRw3HKx7rLoAS2pxJqOMvae+//ligGVaTtWZRlvTNmLQuC1pf1j5M7cXEwpJKy+DByREXRrOofwUck9UpkDSEACgGYxAEXFRncdZy/oCmllfqGamv9qQB3N60pip5VmDrhQv8jLsmcvKAtcTurt0cyusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899623; c=relaxed/simple;
	bh=TyrqC9MSRl6ghuiGG5BlOtNbd6QVDx3d2h2zXMyq8X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg5z/j+7fca2xY/uh6QTUXE8AnfbDDIBdgKvVyRn8njVVmPo59ofnKcbteTHRcPmKgNaWoEDsRL4/JSXYHqIdAqpsMh7wJ+sANNflYSLNB0WaD4yT+V5N+9fmo4g1g/2Uy+IzrpB2WzW5OhIYpl8h6WKLknOBvde/LHahU7YxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6sDauiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4426AC4CEEA;
	Thu, 17 Apr 2025 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744899622;
	bh=TyrqC9MSRl6ghuiGG5BlOtNbd6QVDx3d2h2zXMyq8X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6sDauiwXQb5UPtkydtSqWzFdb3mxsAN2Ysxjt+leusoxYTUjqs8+tsCRRSvmKMur
	 ZbsWdg3VlRYdkAfhXwjco8f/a2ZR+eW7JVMHWI3JYX4/tx8HrXzPiEXVs63GuWGXxh
	 F5th02SGiL+lp+ThnC9EwVLPBFMVswMqmoUPvhWw=
Date: Thu, 17 Apr 2025 16:20:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: stable@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 6.13.y] drm/panthor: Replace sleep locks with spinlocks
 in fdinfo path
Message-ID: <2025041703-endearing-zestfully-e20f@gregkh>
References: <2025040916-appraiser-chute-b24d@gregkh>
 <20250411230808.3648376-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411230808.3648376-1-adrian.larumbe@collabora.com>

On Sat, Apr 12, 2025 at 12:08:03AM +0100, Adrián Larumbe wrote:
> Commit 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo
> group samples") introduced an xarray lock to deal with potential
> use-after-free errors when accessing groups fdinfo figures. However, this
> toggles the kernel's atomic context status, so the next nested mutex lock
> will raise a warning when the kernel is compiled with mutex debug options:
> 
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_MUTEXES=y
> 
> Replace Panthor's group fdinfo data mutex with a guarded spinlock.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo group samples")
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20250303190923.1639985-1-adrian.larumbe@collabora.com
> (cherry picked from commit e379856b428acafb8ed689f31d65814da6447b2e)
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 28 ++++++++++++-------------
>  1 file changed, 13 insertions(+), 15 deletions(-)

Does not apply at all, did something get corrupted?

