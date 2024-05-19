Return-Path: <stable+bounces-45421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8D8C93C7
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28151C20AC4
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834CF11CB8;
	Sun, 19 May 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MiSyS1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BF1BC20;
	Sun, 19 May 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105591; cv=none; b=hNJIf316OskoxSVa0xNKDg/fC7G6w5E/vNv0iaT9yWvhEUYUB6fTtm27xbsdbYwhX1A5AjRakGu1tMZOqjxs2y2k1x4D8C2PURHIF+unvkGAKi3NYfQklljkvDa/ZgbdFXscWbSkU97bqUOiNZQJ1WhlYLBRxSXG4Be9OtiIsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105591; c=relaxed/simple;
	bh=Js533fXv07i00ZGY091MEl3ChJe/lib4LdV6Kq4wzIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGeXwtp1xpWp4lraDI0Di0Hifd97dUKSa/awElc2qKr5fpotlDYpJBBvqKkMPkvgSqeBHHjh9H3TZO/xEXV4bF7fRheJnr/czi7PewMSQUyHj/S2RYrqPRyOZzeVsU7+LeGFkAOhZU18iKlukwjhrBOWGdv/6bdc8sEpaExQ1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MiSyS1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ABBC32782;
	Sun, 19 May 2024 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716105590;
	bh=Js533fXv07i00ZGY091MEl3ChJe/lib4LdV6Kq4wzIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2MiSyS1OlozoQwxwtUwkCDqKXeCND4CH0dDYQqbT7fJjK9ZxDKBMY48MPbW/6vxpn
	 ygZInnvC/+G/4ZA+IgCXOjN7J2ygMwgEPCNmjB+XuAAcpwvRpTRiKebKSupn00Qf8H
	 uExc4kDcBAuzTOxuMi94XAcCZ+E+w+nc3kdm+Q7c=
Date: Sun, 19 May 2024 09:59:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/rockchip: vop: clear DMA stop bit on flush on
 RK3066
Message-ID: <2024051936-cosmetics-seismic-9fea@gregkh>
References: <20240519074019.10424-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519074019.10424-1-val@packett.cool>

On Sun, May 19, 2024 at 04:31:31AM -0300, Val Packett wrote:
> On the RK3066, there is a bit that must be cleared on flush, otherwise
> we do not get display output (at least for RGB).
> 
> Signed-off-by: Val Packett <val@packett.cool>
> Cc: stable@vger.kernel.org
> ---
> Hi! This was required to get display working on an old RK3066 tablet,
> along with the next tiny patch in the series enabling the RGB output.
> 
> I have spent quite a lot of time banging my head against the wall debugging
> that display (especially since at the same time a scaler chip is used for
> LVDS encoding), but finally adding debug prints showed that RK3066_SYS_CTRL0
> ended up being reset to all-zero after being written correctly upon init.
> Looking at the register definitions in the vendor driver revealed that the
> reason was pretty self-explanatory: "dma_stop".

What commit id does this fix?

thanks,

greg k-h

