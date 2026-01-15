Return-Path: <stable+bounces-208441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B5D24527
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 351BB30D404C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECCE3570AF;
	Thu, 15 Jan 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+R8uEkt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E62773CA;
	Thu, 15 Jan 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477702; cv=none; b=u98ZX1LSvTo908C8T4HCHPaJGxjCcC5PzhWUuypTNtPrTqLWrOENsYVF0a/3QaqWWQg/DKLo+Vq9qjf7+seF9+fjiSrnKLK7np+hFXBQN59FGuYlqGcts9hrwuMTQcrN3r6mrzagpOOTNGQO/LY6P2fK2ARFTjylM/a/izFS2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477702; c=relaxed/simple;
	bh=Lrw8/33E7aNVthqUIfK4Pgp3GN9Pr7qx6IqNYKilU9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EweM/iQNsUo9rVfS74l6TiHNy+2Gx9Q1bbH9wkY4FwR0J2F+2UJ8q0d3vwO4njbj+TFErWp7jpkwvn1HK61YoUaAJsPkT62c1vcNzEJBiXroK6X/8T4uBtQSHMQtHrgmU1bLaaxJtLH2eRuaoiKJ/zaUJKNLhCtzwpaC0O6+E0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+R8uEkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956E6C116D0;
	Thu, 15 Jan 2026 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768477702;
	bh=Lrw8/33E7aNVthqUIfK4Pgp3GN9Pr7qx6IqNYKilU9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+R8uEkt/Y2GF8XUqvgj3XW0jsWvxq/3mMCZDm70WnghUVjBu8OrWizDQ2xcw/XIB
	 /2FTloHGaeL6F+Z2USQwUBus8Y/s94T91eh0XsfzBRagPJAoDcryPwXGa+eN8o5mic
	 IeawYE2Eh0t4t2QrT8USV+9bOyDAKPiUUCn26AEA=
Date: Thu, 15 Jan 2026 12:48:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Sharma <black.hawk@163.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH v5.15] drm/amd/display: Check dce_hwseq before
 dereferencing it
Message-ID: <2026011507-kindling-cadet-8fbc@gregkh>
References: <20260115080057.339115-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115080057.339115-1-black.hawk@163.com>

On Thu, Jan 15, 2026 at 04:00:57PM +0800, Rahul Sharma wrote:
> From: Alex Hung <alex.hung@amd.com>
> 
> [ Upstream b669507b637eb6b1aaecf347f193efccc65d756e commit ]
> 
> [WHAT]
> 
> hws was checked for null earlier in dce110_blank_stream, indicating hws
> can be null, and should be checked whenever it is used.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 79db43611ff61280b6de58ce1305e0b2ecf675ad)
> Cc: stable@vger.kernel.org
> [ The context change is due to the commit 8e7b3f5435b3
> ("drm/amd/display: Add control flag to dc_stream_state to skip eDP BL off/link off")
> and the commit a8728dbb4ba2 ("drm/amd/display: Refactor edp power control")
> and the proper adoption is done. ]
> Signed-off-by: Rahul Sharma <black.hawk@163.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Again, need a 6.6.y version of this, thanks.

greg k-h

