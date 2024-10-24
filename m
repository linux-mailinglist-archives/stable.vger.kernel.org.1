Return-Path: <stable+bounces-88023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD939AE156
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D54B21142
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186531AC8B9;
	Thu, 24 Oct 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jcQDXOb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69A79C4;
	Thu, 24 Oct 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763249; cv=none; b=ZObZ8oVf2xf7EDHaLUIOZCGsl3duxWk5yDAhJ/yutuNtNc6EeL3Ju+CHc6/OgiSFlFzYfLpqNj7mOmA8ZD4VkeDI86Jlf8Aa4mCbvIeSDz81BeAhyKWVIvGQWWpAWq7UfHqWGqEkvUv+OJfKzmWGN4nFkX22hbVcpaGrEx8DmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763249; c=relaxed/simple;
	bh=4Xd9flZBNjg4ZFP11yWd6ull8gJEasRSLCN7/xDE1T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqu2r3kbMkcuBQJ+KUEKwWo/3dJMqgbrGhV9fY/ADL6vkBk8mLXyKi1jCeSf//IyDpO2NP7HNNYWQmlz0BsV86Zym2lejFx6wLWNJcwXITf+oEtFqi1U0kXzabP79P+uv9tr2hD5aIRCOGJT6DfsZ2HnZtb4LJSR4bE9sCPImuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jcQDXOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E67C4CECD;
	Thu, 24 Oct 2024 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729763249;
	bh=4Xd9flZBNjg4ZFP11yWd6ull8gJEasRSLCN7/xDE1T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1jcQDXObT2VzXlLw2uVdZCr+y2DuY4ywLdsP92gDkq215zkAzzYt9/zDcKB7jO1pc
	 BxitZahtp0qaQrdEaSvddSdN+nL6nDpxzdvb1goOVfEQ9XQBoUjgQVahxuZMSCNA9d
	 DAnXd9BsV5Wk6ifI73XieB9AUHmMWsarL1ISWDGw=
Date: Thu, 24 Oct 2024 11:47:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jason-jh.lin@mediatek.com
Cc: Saravana Kannan <saravanak@google.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Message-ID: <2024102406-shore-refurbish-767a@gregkh>
References: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>

On Thu, Oct 24, 2024 at 05:37:13PM +0800, Jason-JH.Lin via B4 Relay wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.
> 
> Reason for revert:
> 1. The commit [1] does not land on linux-5.15, so this patch does not
> fix anything.
> 
> 2. Since the fw_device improvements series [2] does not land on
> linux-5.15, using device_set_fwnode() causes the panel to flash during
> bootup.
> 
> Incorrect link management may lead to incorrect device initialization,
> affecting firmware node links and consumer relationships.
> The fwnode setting of panel to the DSI device would cause a DSI
> initialization error without series[2], so this patch was reverted to
> avoid using the incomplete fw_devlink functionality.
> 
> [1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
> [2] Link: https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@google.com
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 24606b632009..468a3a7cb6a5 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>  		return dsi;
>  	}
>  
> -	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
> +	dsi->dev.of_node = info->node;
>  	dsi->channel = info->channel;
>  	strlcpy(dsi->name, info->type, sizeof(dsi->name));
>  
> 
> ---
> base-commit: 74cdd62cb4706515b454ce5bacb73b566c1d1bcf
> change-id: 20241024-fixup-5-15-5fdd68dae707
> 
> Best regards,
> -- 
> Jason-JH.Lin <jason-jh.lin@mediatek.com>
> 
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

