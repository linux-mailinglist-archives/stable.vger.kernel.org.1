Return-Path: <stable+bounces-70374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C5960D7A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37EAB24FC9
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949A1C4EDD;
	Tue, 27 Aug 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O93Beyjh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786391C4638
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768472; cv=none; b=UWOpSKmPTicA1O3xgPlsWqjPDvQXtOW+bTHL6+KvikTgsoEXqEam+ky8MSlgbv9k0viPSkNq1eRj/Os0TQt9q1q/kDXFYBWByOMpK1EvjPy9VGQVcnP9ixmUC98R0WQj5Vx6HT18SBWPnioF3g9QJ14LlyGgwkn5RvoCtEAK/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768472; c=relaxed/simple;
	bh=CA+Fto/TIZtWhL5Q63P1zxd+OrmQhGFycs0zEiFZztM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2t8MTNZfG7Aymsau5/bMvYKF2v8UKxcgWrIdbWDpRw3t56+Szs/A/nqLdxFIIRq45Nbb0fueYMFYhUdi4mpUMaw0hMHWOi0Gzi3lWzYwqb3Xt5AV0sHa+IHsJmrRAJ1gixzGszKo4pvxwHjcPxFxHsP2wLi+9fdLfAAWnRB8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O93Beyjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19AEC6107E;
	Tue, 27 Aug 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724768472;
	bh=CA+Fto/TIZtWhL5Q63P1zxd+OrmQhGFycs0zEiFZztM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O93BeyjhOkDVzaoCSR7X8lCtkwYkaHcNOgQCx8WXtpR9OkzW71tjcMswlXT1YIlUh
	 DZZI2Wv/em23pTLf/z97qIn/733Bl8smzL1kOj2btTLjDwGw4tV7M2QBB/zl6WXAmA
	 3kg2kBVJ4uinU3uUB47aW+maxszrr70s0EIODcQQ=
Date: Tue, 27 Aug 2024 16:21:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Jack Xiao <Jack.Xiao@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Message-ID: <2024082746-amendment-unread-593d@gregkh>
References: <20240827141025.1329567-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827141025.1329567-1-alexander.deucher@amd.com>

On Tue, Aug 27, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> From: Jack Xiao <Jack.Xiao@amd.com>
> 
> wait memory room until enough before writing mes packets
> to avoid ring buffer overflow.
> 
> v2: squash in sched_hw_submission fix
> 
> Backport from 6.11.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3571
> Fixes: de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
> Fixes: fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")

These commits are in 6.11-rc1.

> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 34e087e8920e635c62e2ed6a758b0cd27f836d13)
> Cc: stable@vger.kernel.org # 6.10.x

So why does this need to go to 6.10.y?

confused,

greg k-h

