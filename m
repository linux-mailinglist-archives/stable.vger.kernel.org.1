Return-Path: <stable+bounces-89496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFE99B9383
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923221C20A6E
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547441A7274;
	Fri,  1 Nov 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MWSY2wEu"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542D49620;
	Fri,  1 Nov 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472207; cv=none; b=T5m3vmvWPqFytHLQxopfTCsN1mKNyhyS+K79sLGbf1crmEfqlciieTMAgvDW6M7kAFZKoZGgRwYXiRYa5dkr1mCUHH30CIl/+Xjol4+iHG65vo3LZI+TxUW+TPdExPkEXoRlikqgO24BR2grfKgvgtfdBICfmNL/8kIeIVYWC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472207; c=relaxed/simple;
	bh=DZWLfHW2eJhePPE3Q0nswhlD0ECMPDjCzq0Ko2Z40oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ijy2d5q+FWkA7CBzXk8k8P6Q0SDBIx1F+7XbKOJZ9aQXS6DeocDqGN6Y4sKW1m/UDZnHteJm3yjVdR02YsPpyKE/6W6W+6YKsMWNLLMRUxJvKcwW/fkGcILtEfBs04/BCK7O1RTJB9DRPj7MCKL8J/nRXLgH5HGu59QsUJq6mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MWSY2wEu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7B5A3A2;
	Fri,  1 Nov 2024 15:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730472198;
	bh=DZWLfHW2eJhePPE3Q0nswhlD0ECMPDjCzq0Ko2Z40oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWSY2wEuc6Qj4FjBO1cBCoPs8MjJsah9QmCwk1mYCY9KoN9I2sQ1ACQPh9nnYAIF4
	 XZI7POtpBEFYQMIMKaRhw6/NII7D3A0NpY0kmHqscG5E/j11ZbdJhvWZsMTs0qX+Jg
	 U0kWOWPi7wXFI6a3uSYYB8XQ01MXInSjzYigHdP0=
Date: Fri, 1 Nov 2024 16:43:15 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, Johan Hovold <johan@kernel.org>,
	neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Abel Vesa <abel.vesa@linaro.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <20241101144315.GK2473@pendragon.ideasonboard.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
 <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
 <751a4ab5-acbf-4e57-8cf4-51ab10206cc9@linux.dev>
 <ZyOvAqnuxbNnGWli@hovoldconsulting.com>
 <30fefafc-d19a-40cb-bcb1-3c586ba8e67e@linux.dev>
 <20241101092049.GJ2473@pendragon.ideasonboard.com>
 <CAA8EJprEDV2JViB9kQS2H1p=NgF+PcataEejC97DBo=aU5g5kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA8EJprEDV2JViB9kQS2H1p=NgF+PcataEejC97DBo=aU5g5kw@mail.gmail.com>

On Fri, Nov 01, 2024 at 12:27:15PM +0200, Dmitry Baryshkov wrote:
> On Fri, 1 Nov 2024 at 11:20, Laurent Pinchart wrote:
> > On Fri, Nov 01, 2024 at 11:49:07AM +0800, Sui Jingfeng wrote:
> > > On 2024/11/1 00:23, Johan Hovold wrote:
> > > > On Thu, Oct 31, 2024 at 11:06:38PM +0800, Sui Jingfeng wrote:
> > > >
> > > >> But I think Johan do need more times to understand what exactly
> > > >> the real problem is. We do need times to investigate new method.
> > > > No, I know perfectly well what the (immediate) problem is here (I was
> > > > the one adding support for the of_node_reused flag some years back).
> > > >
> > > > I just wanted to make sure that the commit message was correct and
> > > > complete before merging (and also to figure out whether this particular
> > > > patch needed to be backported).
> > >
> > > Well under such a design, having the child device sharing the 'OF' device
> > > node with it parent device means that one parent device can *only*
> > > create one AUX bridge child device.
> > >
> > > Since If you create two or more child AUX bridge, *all* of them will
> > > call devm_drm_of_get_bridge(&auxdev->dev, auxdev->dev.of_node, 0, 0),
> > > then we will *contend* the same next bridge resource.
> > >
> > > Because of the 'auxdev->dev.of_node' is same for all its instance.
> > > While other display bridges seems don't has such limitations.
> >
> > Brainstorming a bit, I wonder if we could create a swnode for the
> > auxiliary device, instead of reusing the parent's OF node.
> 
> This will break bridge lookup which is performed by following the OF
> graph links. So the aux bridges should use corresponding of_node or
> fwnode.

We can also expand the lookup infrastructure and handle more platform
integration and driver architecture options. I'm not sure how it would
look like, but all these are in-kernel APIs, so they can be extended and
modified if needed.

> > This would
> > require switching the DRM OF-based APIs to fwnode, but that's easy and
> > mostly a mechanical change.

-- 
Regards,

Laurent Pinchart

