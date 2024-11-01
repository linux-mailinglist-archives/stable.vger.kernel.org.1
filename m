Return-Path: <stable+bounces-89477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DEE9B8C08
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 08:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193E61C21588
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497401537CB;
	Fri,  1 Nov 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDmhzBQi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047841547C9;
	Fri,  1 Nov 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446026; cv=none; b=j+WyuGiidL5yN16f9BIR7Bz0D8GZf75yRrgJ+bmAQ0vkyEYD6L8e/6gyxF4JHxZAuYhleUz5K9FiuP9yjx1T7zF+o8TVdKjJpq/5IQrxITChXp/57A/TuJbZhXCw9rfbYg9X3l+wM7KEoIcyUj50jcwrwR4qoUHHj+C0z2lnFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446026; c=relaxed/simple;
	bh=eB/YxladbY67Z1rGM/yK1zVVfqWKD65iIbhTpOy341Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc9Fl2fzuZ43fA0Lcp70h4+wNEnTS6m4kW5xxBErbIi6fwn69MnbnLXUA5Qfk1WxLlihmVEIi6Vr4otWuByzPnXxW35wRkwMiLjqyQmHXYG3NeSAjrsqje0MM9Mm6xpnX9KM1uW822GI3SDgm1PDL6aHCENZj435miU2alIgGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDmhzBQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3057C4CECD;
	Fri,  1 Nov 2024 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730446025;
	bh=eB/YxladbY67Z1rGM/yK1zVVfqWKD65iIbhTpOy341Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDmhzBQi4YTa0N5Msh41yVsVAP1dMN4CQB/M2DhBeySbNoCTF+ZMGFUGGpBtj8lSt
	 FLDsDJhRWVRMVEBzJi4UpIdl6ZqccdXfbQwYUR87Rx1s21LSs/0whgmcBCrpY1ySGN
	 8p1WnGjgOHGB7Xkf+WEhRnpdwh1UNOdcdo3WZ4ftF6FXNt3MXg4g6waUvRM0XjmY/x
	 5PNrhX3qSy/UV3DHjUOnUQyv70vt//Zr/uI9NZYmZZvdIhgBUKzpTIW7FH+xjl8X6e
	 UJ0c7XDunu/N5V1V1YQxj7W0kCqo9ypOqklz67LTPKJrMtwLbnFoYXqhGQFdhQLpKN
	 pa2oCz/HXMyBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6m3j-000000004kI-0lrJ;
	Fri, 01 Nov 2024 08:27:03 +0100
Date: Fri, 1 Nov 2024 08:27:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Abel Vesa <abel.vesa@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ZySCx9mvjRjo0Xfp@hovoldconsulting.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
 <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
 <751a4ab5-acbf-4e57-8cf4-51ab10206cc9@linux.dev>
 <ZyOvAqnuxbNnGWli@hovoldconsulting.com>
 <30fefafc-d19a-40cb-bcb1-3c586ba8e67e@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fefafc-d19a-40cb-bcb1-3c586ba8e67e@linux.dev>

On Fri, Nov 01, 2024 at 11:49:07AM +0800, Sui Jingfeng wrote:
> On 2024/11/1 00:23, Johan Hovold wrote:
> > On Thu, Oct 31, 2024 at 11:06:38PM +0800, Sui Jingfeng wrote:
> >
> >> But I think Johan do need more times to understand what exactly
> >> the real problem is. We do need times to investigate new method.

> > No, I know perfectly well what the (immediate) problem is here (I was
> > the one adding support for the of_node_reused flag some years back).
> >
> > I just wanted to make sure that the commit message was correct and
> > complete before merging (and also to figure out whether this particular
> > patch needed to be backported).
> 
> Well under such a design, having the child device sharing the 'OF' device
> node with it parent device means that one parent device can *only*
> create one AUX bridge child device.
> 
> Since If you create two or more child AUX bridge, *all* of them will
> call devm_drm_of_get_bridge(&auxdev->dev, auxdev->dev.of_node, 0, 0),
> then we will *contend* the same next bridge resource.
> 
> Because of the 'auxdev->dev.of_node' is same for all its instance.
> While other display bridges seems don't has such limitations.

Oh, I'm not saying that there cannot be further issues with the design
or implementation here. And perhaps fixing those would make the
immediate issue Abel was trying to address go away.

Johan

