Return-Path: <stable+bounces-183677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A22BC8606
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16FC3E6C7A
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF502D77ED;
	Thu,  9 Oct 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxlowe+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40389273FD;
	Thu,  9 Oct 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003501; cv=none; b=dOrY5+OA9CsGGq/MbUim19sMXcwPU0wJqTQWnElHiUzDM4V5OPUiokNy5bBgEF7ONqNJ/C0UUjcFkzR6tsIN0whsMvDkX8Fuc48ZyyM2MYVYoE5yl06Rl5buqliEW2DIe2IvwBSM8Bq8WlKPMsRaCi2Jgd8v5qSMvFemLBXTHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003501; c=relaxed/simple;
	bh=GijdTCamNQ82KE4Uz6SV7HvRXp4xVcT6Z1OWSeBQXxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvS9GfNpTZ0j/rNoFRN4NUQwu70U6G8ULVPAmjlZVHD9yVCkz0OhhT8jpTQfW8rCr6AYEpnqp5MIEa2+i554GVxBVgTopy5JX1tvfgHoYuTIhYWq1wO+DR9X6fgbcoA2aeCT1sE3UpqnY1hzKvC3khZAxinRGv+wCM2/QULOQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxlowe+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EE1C4CEE7;
	Thu,  9 Oct 2025 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760003500;
	bh=GijdTCamNQ82KE4Uz6SV7HvRXp4xVcT6Z1OWSeBQXxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxlowe+CbNsCH/XpnQKxXqwojpEdXJQvfGkWQOYSX+fX5n2k0pqxDg19ukJZFmFHm
	 /LV6YTHAVB5DmM6JmOafsZUnWFNVAA8Q2aP0xWoet4nuJ/2LQo+H5F2lZZvPXUp/Xh
	 caGuGm/111pVLrcbNCGM4vzGU0yf5uHqL6tF+dKw=
Date: Thu, 9 Oct 2025 11:51:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: harry.wentland@amd.com, christian.koenig@amd.com, sunpeng.li@amd.com,
	airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
Message-ID: <2025100931-retorted-mystified-bd52@gregkh>
References: <20251009092301.13212-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009092301.13212-1-matthew.schwartz@linux.dev>

On Thu, Oct 09, 2025 at 11:23:01AM +0200, Matthew Schwartz wrote:
> This fix regressed the original issue that commit d83c747a1225
> ("drm/amd/display: Fix brightness level not retained over reboot") solved,
> so revert it until a different approach to solve the regression that
> it caused with AMD_PRIVATE_COLOR is found.
> 
> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
>  2 files changed, 4 insertions(+), 15 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

