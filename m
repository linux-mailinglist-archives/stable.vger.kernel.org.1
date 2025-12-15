Return-Path: <stable+bounces-201003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5242CBCEE6
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250913014AFA
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61228CF6F;
	Mon, 15 Dec 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sdRgY4Yy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CA31AA90
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786340; cv=none; b=qgl9QGpcArsAfedja6xR8gf9trL0+u7gc82ziqDrgi4pAXxOw0LkBw65Q7ZU19ccm/nr6+WLY4rRkvJ/pmcVhM+mmDu5KPhIm8DCjlYi44L5U3acWk1pxrKkDQ4+aaqqNq7qd2bZXDTQ/HeY+YwPx3jw8BfbZiDgJvN5HzC/w40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786340; c=relaxed/simple;
	bh=ndw59aoLe85tnOwISmtIOQssGoBfiSllzwJOyFWoKyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofi4CdjSIrtmo2L1bwj5Pkn7voGFCJy5r+K9eJAqFMke+nVQDvgHAzyVA1CWy/NI0A5TKzX4ZNNfFWrylkkhD7JOVYLkNjhbafPlPCfA43dV9l4P9mACFdoCtKAnNkeg9AxACu63iKP1ElufCuh+oJ8ysXPyt90Pl3aJV57AOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sdRgY4Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D79DC4CEF5;
	Mon, 15 Dec 2025 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765786339;
	bh=ndw59aoLe85tnOwISmtIOQssGoBfiSllzwJOyFWoKyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdRgY4YyyFyeHJOsTrTQvW5px8pu395JxHJb9eKLT1v/0AnsOK/1muuqM1YRFmKFR
	 Tu+jpopVZubIdHMCA5WcsEyLJA0O0ymw4YtrWgsbZj2EuEsv3t2ZVYgVsH0bU5CR5f
	 zxEec6+ynPbCzE9WZDIxi4EnYv9gPQRH5L5PuR4s=
Date: Mon, 15 Dec 2025 09:12:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
Message-ID: <2025121502-amenity-ragged-720c@gregkh>
References: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>

On Sun, Dec 14, 2025 at 10:53:36AM +0100, Hans de Goede wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.
> 
> SI hardware doesn't support pasids, user mode queues, or
> KIQ/MES so there is no need for this.  Doing so results in
> a segfault as these callbacks are non-existent for SI.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

What kernel tree(s) should this go to?

thanks,

greg k-jh

