Return-Path: <stable+bounces-98756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B549E4FFB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766CC284463
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A561D45E2;
	Thu,  5 Dec 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLW9mgeP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2B1D433C
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388053; cv=none; b=sH5Og1SaIzQaBFRUmJVgCk3U3iMUzR9HLshLuzOiO/GW3VwweWRo/fJeqigs78NwHN0p2STiPBjG/QlezOvUPkNhMj6kRGzdSE2E+4xTH6a1D9PE98tNJCr1/h7b2eRXdy8GcXa/2Noq//RlXGnImrZyJ1AJlX/iriBAxh/UusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388053; c=relaxed/simple;
	bh=5laH2nNsUPd2VcKyVNXteUE32esDqgL+doC5R58Imvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcRj+kr2kaW38ii4myRG8/rNEnA7mhWHa3J7/BAXX6M7nV815ru1J44dspB8xiAJZ9hir3m5+havWcz5Wyk/fAtCOtbjeFPRBcGUieN0VdA9zxg1muw9211I8icpRlQBuEsXa7uMFDtehLwzVeaHDgNgBqUn/CO5heR1L1LGEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLW9mgeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A3DC4CED1;
	Thu,  5 Dec 2024 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733388052;
	bh=5laH2nNsUPd2VcKyVNXteUE32esDqgL+doC5R58Imvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLW9mgePWONvZEmK+T7y0+jhlvlnBkJPY/pENNLTsDl+31o5U/el3J1npaGwcq+g/
	 cP044Ykb/dfwiCpib4Flh8onv9FeV+2EQ/l8uDRrHtFEx9kZusiejtGoJiHjxeI+Wr
	 ++nOoqftE8/UwnPzKccLOMLsT433wdvcocwDt1gA=
Date: Thu, 5 Dec 2024 09:40:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: n.zhandarovich@fintech.ru, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc
 in amdgpu_dm_fini()
Message-ID: <2024120543-extrude-ranking-96ab@gregkh>
References: <20241205084329.1748881-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205084329.1748881-1-jianqi.ren.cn@windriver.com>

On Thu, Dec 05, 2024 at 04:43:29PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> 
> Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
> before the call to dc_enable_dmub_notifications(), check
> beforehand to ensure there will not be a possible NULL-ptr-deref
> there.
> 
> Also, since commit 1e88eb1b2c25 ("drm/amd/display: Drop
> CONFIG_DRM_AMD_DC_HDCP") there are two separate checks for NULL in
> 'adev->dm.dc' before dc_deinit_callbacks() and dc_dmub_srv_destroy().
> Clean up by combining them all under one 'if'.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

No upstream git id :(

