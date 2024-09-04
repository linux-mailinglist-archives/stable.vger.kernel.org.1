Return-Path: <stable+bounces-72963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572F96B174
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 08:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD57282F84
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696512FF7B;
	Wed,  4 Sep 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kVDDzh6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CA823DE;
	Wed,  4 Sep 2024 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430888; cv=none; b=QtG4m2BOnzpd6TsVOV/PaiNwMMUQRJaDFYcFXZ099qQUJwZQrD4/rO4LwgW3kHHnv0slEUVQ5IjsbT7eswN4OmWbBnLQdzH4HKvspAwC33qix4VY8Vcbtec/DN/G46zDsgxa+1LvVYfFJz/SFCnWz2fIA/W+1mRylS9Ew/8Iewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430888; c=relaxed/simple;
	bh=45T0UdM4XULpq6I/wvSmgNZL5OfJfMSSqZmgV1iBb8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwSMTONvUeFijIirvW82rvS/Kq5Y66zs3nqCBJR1rHxIYBcOF7qxp3pgCmzz1QfityfhCp+AnV7blxVwnm4UE20isBHY1Rdd5pku8ySgT3rWRdrwWmFdZOOQGGF6mswq+OOKUyUExdaW7Ujf42lvTvyVJZ+C7oxUhWv8fzq34Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kVDDzh6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D618C4CEC2;
	Wed,  4 Sep 2024 06:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725430888;
	bh=45T0UdM4XULpq6I/wvSmgNZL5OfJfMSSqZmgV1iBb8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVDDzh6QVMrQmWm/Ayy6BLEtPbpWxLD7Dmok9kpi96Xv/j0ze8gum1MQweUGRZbqZ
	 31M1w8Yh3WWSQU6f7wOP33I8H5JvRqJZUjUc19FCXDNw81VsJpVLEVOi+xUaEzIhOj
	 SWymqg1X2y7EYjHRJXXnn0znfNviyj2J1jFaQMw8=
Date: Wed, 4 Sep 2024 08:21:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Pu <hui.pu@gehealthcare.com>
Cc: p.zabel@pengutronix.de,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Sasha Levin <sashal@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, HuanWang@gehealthcare.com,
	taowang@gehealthcare.com, sebastian.reichel@collabora.com,
	ian.ray@gehealthcare.com, stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: imx: ipuv3-plane: fix HDMI cannot work for odd
 screen resolutions
Message-ID: <2024090452-canola-unwoven-1c6c@gregkh>
References: <20240904024315.120-1-hui.pu@gehealthcare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904024315.120-1-hui.pu@gehealthcare.com>

On Wed, Sep 04, 2024 at 05:43:15AM +0300, Paul Pu wrote:
> This changes the judgement of if needing to round up the width or not,
> from using the `dp_flow` to the plane's type.
> 
> The `dp_flow` can be -22(-EINVAL) even the plane is a PRIMARY one.
> See `client_reg[]` in `ipu-common.c`.
> 
> [    0.605141] [drm:ipu_plane_init] channel 28, dp flow -22, possible_crtcs=0x0
> 
> Per the commit message in commit: 71f9fd5bcf09, using the plane type for
> judging if rounding up is needed is correct.
> 
> Fixes: 71f9fd5bcf09 ("drm/imx: ipuv3-plane: Fix overlay plane width")

That id is not in Linus's tree :(

> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Paul Pu <hui.pu@gehealthcare.com>

No need for the blank line before this.

thanks,

greg k-h

