Return-Path: <stable+bounces-16059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3EE83E8F0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167DFB23724
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29D79CD;
	Sat, 27 Jan 2024 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V7Q3V4YG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0146138
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318732; cv=none; b=bmEUjqEPA4mlNJMW+aU3PSPNKFkO2pAUAHehxB/Adknu7vaVOw/rMMvYqXj4jJhClgbkw0Z/wXkAPpqzN56zPL21/9HjtBPRWwGpx2LE9Ak8pMf9M/mMu6M8PWwRLumdclo10XZYkGDKFV4RqaFxhgQwQXYQav9G9nWd5GNUIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318732; c=relaxed/simple;
	bh=P+hOUtOpAmxNKt+YyfroPoaZ7cjc44+WBPb50ba85tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma/nfFonZZv54CpAaUrNd3tmwlFrH1hkx0Xg9MwIWlKJuqryYFvuz+PZ8/DwEVtPgx0CizCquUE7D7jsG42asUjz45aSdOB9tj7Z2yFJOWa3GJXUFjLBG1UesrF/VnCAtzTLsoVQDLL+AZtvVOSKax8ZcHeVkbpB+TVqZajGfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V7Q3V4YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FABEC433F1;
	Sat, 27 Jan 2024 01:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318731;
	bh=P+hOUtOpAmxNKt+YyfroPoaZ7cjc44+WBPb50ba85tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7Q3V4YGux/ffyt8//qjZwXhIT+mwWwRhxJalMsmYrlAqgYaLlWqLzjjR6840hxnB
	 XP+3eJ/y257RzqMuG6Hi2b/PUu1Sif11GckSrLZXZ2S/nqHKPU8Aqfm7z568uRaSZN
	 jMeqcPryekz0bHZv2R1r68nwdsN90+QzqmThww1U=
Date: Fri, 26 Jan 2024 17:25:30 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Wade Wang <wade.wang@hp.com>
Subject: Re: [PATCH] drm/amd/display: pbn_div need be updated for hotplug
 event
Message-ID: <2024012623-snuff-veneering-db1b@gregkh>
References: <20240123204106.3602399-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123204106.3602399-1-alexander.deucher@amd.com>

On Tue, Jan 23, 2024 at 03:41:06PM -0500, Alex Deucher wrote:
> From: Wayne Lin <wayne.lin@amd.com>
> 
> link_rate sometime will be changed when DP MST connector hotplug, so
> pbn_div also need be updated; otherwise, it will mismatch with
> link_rate, causes no output in external monitor.
> 
> This is a backport of
> commit 9cdef4f72037 ("drm/amd/display: pbn_div need be updated for hotplug event")
> to 6.1.  This fixes a display light up failure on some docking stations.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
> Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Wade Wang <wade.wang@hp.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 9cdef4f720376ef0fb0febce1ed2377c19e531f9)
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Now queued up, thanks.

greg k-h

