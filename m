Return-Path: <stable+bounces-89480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A329B8DB9
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 10:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94F71F246EE
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6C158558;
	Fri,  1 Nov 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UbN1DXSM"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A615852F;
	Fri,  1 Nov 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452867; cv=none; b=sV37pW9zduoWOhflRRLuCfD1SoDW5aA86qq1A+6ntccVPKX5PWgrQz1kP/1jKIk1X/fRSzpAAhSfoXeADWHNEQdKT6lxmHo2a23Dn1IzxooJT0/D/bguhIyOFMJXjtsWwMkb232KyU5aHWcA8xbm0Tl++v1z1Jf+MMUhN85k0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452867; c=relaxed/simple;
	bh=DvGdTgJ/Dg9JlFjF6NE7OmksllUnclX4NbH7Ot6PLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5OOF1eL6G4FP5NBwHLtnJlfbrKqmX5kkCeOLQyd2OxH7A73yybcpCd1SrSBhjATqa/AIpCtl32/4yyfRzAtCBLCaxW20/wKmdmqsKjCS5870HbeCIAfOfEPAtRPovP21T70EGlJtnUGMVXzlXBZ8Y6POpm5S5ag9V31w/5uc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UbN1DXSM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3436D3D4;
	Fri,  1 Nov 2024 10:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730452851;
	bh=DvGdTgJ/Dg9JlFjF6NE7OmksllUnclX4NbH7Ot6PLFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbN1DXSMfqjA+beJQ+tmf2QAG3lWzfRixBwST78dyzID5Q9CUZjnxJr7nuL+mHKC7
	 9KqXtwICmXxJwrrlbewhGPeNmpBXER55mMZ/MwEtL0UfmLVe1AB9gHssb/XY3xk12l
	 8eD7F2OUFpTlJ/USFuTALVxl1et5E3n1FS5/5Iuc=
Date: Fri, 1 Nov 2024 11:20:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Johan Hovold <johan@kernel.org>, neil.armstrong@linaro.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
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
Message-ID: <20241101092049.GJ2473@pendragon.ideasonboard.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30fefafc-d19a-40cb-bcb1-3c586ba8e67e@linux.dev>

On Fri, Nov 01, 2024 at 11:49:07AM +0800, Sui Jingfeng wrote:
> 
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

Brainstorming a bit, I wonder if we could create a swnode for the
auxiliary device, instead of reusing the parent's OF node. This would
require switching the DRM OF-based APIs to fwnode, but that's easy and
mostly a mechanical change.

-- 
Regards,

Laurent Pinchart

