Return-Path: <stable+bounces-118938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4ADA422B6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D331668C0
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4EB1624FC;
	Mon, 24 Feb 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xqiOONr5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DB13CA81
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405879; cv=none; b=f8tOxExaUqA6auYUI9Ff7vThcto9yJAUdmj9aeSLVVo2r8M0eokW7dQm8/hBm31URUkeePG+FtFt9ld9L8NikcdJgDbcxgKf2VA+FJ4JuLCZ3rySeHtS2Y4yR6NaGWzs8jo5d2J1An9d2fWsD4UUvJiJqGEOObYBAFSFOTzbW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405879; c=relaxed/simple;
	bh=I8uue7ddv2AOEoV+/3T+CqGrVne4UNa0HCr2CmsPHyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8Ap31Cy9E0CdwStsjq2dHceaRX7o/H0KPm4n9X9X2a9Ow4ujZykNZuYTl5v+IMi2Jr9J31XwoYXCdvF6tCMOxgoqF7UkFaNqLUf1dLXZo2fyb/Z9LHey8XUefp/SB0wSRPLQ62QCGgYppwSbBUu4TdMAIqIF+jdqPEK5OzTTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xqiOONr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1587CC4CED6;
	Mon, 24 Feb 2025 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740405878;
	bh=I8uue7ddv2AOEoV+/3T+CqGrVne4UNa0HCr2CmsPHyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xqiOONr5xEzBWXxcnYoeW5xNE5/AvO1pDIvBSuocVdofrpdBl6JrJjDVd+EymQK4w
	 VsuGK9JtHNcJ99NmeCEYt+dStpQLxXvTDAMuyRNzUW4+uv907vr2qjfaTGllFDphs6
	 ZOWjqIDn55CYHND5zLHkbXMwNkjW/FhvKy5CKpvI=
Date: Mon, 24 Feb 2025 15:04:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lancelot SIX <lancelot.six@amd.com>
Cc: stable@vger.kernel.org, Jay Cornwall <jay.cornwall@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in
 gfx12 trap handler
Message-ID: <2025022419-urchin-preplan-e999@gregkh>
References: <2025021802-scrimmage-oppressor-8e61@gregkh>
 <20250221180928.466632-1-lancelot.six@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180928.466632-1-lancelot.six@amd.com>

On Fri, Feb 21, 2025 at 06:09:28PM +0000, Lancelot SIX wrote:
> It is possible for some waves in a workgroup to finish their save
> sequence before the group leader has had time to capture the workgroup
> barrier state.  When this happens, having those waves exit do impact the
> barrier state.  As a consequence, the state captured by the group leader
> is invalid, and is eventually incorrectly restored.
> 
> This patch proposes to have all waves in a workgroup wait for each other
> at the end of their save sequence (just before calling s_endpgm_saved).
> 
> This is a cherry-pick.  The cwsr_trap_handler.h part of the original
> part was valid and applied cleanly.  The part of the patch that applied
> to cwsr_trap_handler_gfx12.asm did not apply cleanly since
> 80ae55e6115ef "drm/amdkfd: Move gfx12 trap handler to separate file" is
> not part of this branch.  Instead, I ported the change to
> cwsr_trap_handler_gfx10.asm, and guarded it with "ASIC_FAMILY >=
> CHIP_GFX12".
> 
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.12.x
> (cherry picked from commit d584198a6fe4c51f4aa88ad72f258f8961a0f11c)
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

You sent this twice, right?  What branch is this for?

confused,

greg k-h

