Return-Path: <stable+bounces-45424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCF38C941F
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 10:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9298F1F213BA
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A79C17C9B;
	Sun, 19 May 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZr0+0uH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B3E554;
	Sun, 19 May 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716108880; cv=none; b=mVJPg26fO1/NSUc5J2f38jeIxR8R0xLi/qXzAJjlgNviaIdCRlJ/chHaNMvFHlkFul3+BDs7kYX9w21ag7uYRM7ustSLQAdz4zbxpIG7ojL0GToEAcRsYdGFl9DtR9IuHuW72vq5nrpTCjt/BIBXHs7XCL8eADk85WoHRodBO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716108880; c=relaxed/simple;
	bh=avtQ0tx1UdGxRsX9qlthvVsjKBAmRdw8FRebf2A40AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzRDRzFRWya34iLbSq6dzI4Dy4BgZiJmCVjoh3Dy5ZclvMXU5FOK9zsSePwclIxNplbLeCk7d8yvGu56gXt6OmAhYXJMNw66dazVFp5fR9mdKVGMjVUEI6Od2u7PK5D+XIgW5K1piz3Q161J91f65sjUz6RXwPhSvC9YweSUWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZr0+0uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF3EC32781;
	Sun, 19 May 2024 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716108879;
	bh=avtQ0tx1UdGxRsX9qlthvVsjKBAmRdw8FRebf2A40AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZr0+0uH7hovHNTAPMinTSPdETzLlI5O+iBMGKaXSs8Dn6tjYThYVZzpuuB3q89k7
	 8ivAraMr8BuZNiDzkNjR/dw/01BJItU3zMnON0g2J5TM9Tz5uw5dZXEBMbSE45LRbU
	 njK9ujwV0dIekKzEFZV4X3qw2RHWZ5KQYPCMhgUQ=
Date: Sun, 19 May 2024 10:54:36 +0200
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
Message-ID: <2024051930-canteen-produce-1ba7@gregkh>
References: <20240519074019.10424-1-val@packett.cool>
 <2024051936-cosmetics-seismic-9fea@gregkh>
 <0C5QDS.UDESKUXHKPET1@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C5QDS.UDESKUXHKPET1@packett.cool>

On Sun, May 19, 2024 at 05:38:24AM -0300, Val Packett wrote:
> 
> 
> On Sun, May 19 2024 at 09:59:47 +02:00:00, Greg KH
> <gregkh@linuxfoundation.org> wrote:
> > On Sun, May 19, 2024 at 04:31:31AM -0300, Val Packett wrote:
> > >  On the RK3066, there is a bit that must be cleared on flush,
> > > otherwise
> > >  we do not get display output (at least for RGB).
> > 
> > What commit id does this fix?
> 
> I guess: f4a6de855e "drm: rockchip: vop: add rk3066 vop definitions" ?

Great, can you add a Fixes: tag when you resend these?

> But similar changes like:
> 742203cd "drm: rockchip: add missing registers for RK3066"
> 8d544233 "drm/rockchip: vop: Add directly output rgb feature for px30"
> did not have any "Fixes" reference.

Just because people didn't properly tag things in the past, doesn't mean
you should perpetuate that problem :)

thanks,

greg k-h

