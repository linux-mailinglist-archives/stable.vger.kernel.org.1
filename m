Return-Path: <stable+bounces-89361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDC9B6CF0
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 20:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3161C20FDE
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3F1CC88D;
	Wed, 30 Oct 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BaG/8wNw"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59631C3F06;
	Wed, 30 Oct 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317180; cv=none; b=rmqGhSYg9cf4OmodJcT9tbcQAxvQZKc1Jo0v8mxO3yByTmf9WM12iQf/XcB+iYV9h/6RF1DdnlzMAl7dBIeEHQ1Xj9sm7ugOfD6yOM15GhAhQqy2lUnDHEqP3eDrsSiPzNCQtnZhJijVfqvlMlfa3cGVVO+nNhCDA7Tov6fN8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317180; c=relaxed/simple;
	bh=0hN4Dxbc88JoFnTjDC6D8vcsDV41vBFTbn2UWygs4+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3PlErCUcFaBykgxA1Bt0NJg38Qc3hxotSO/1yo6vnslIFRpsnoXHE7Pjn9AMSFH5rfFPqA5uHO5Lc96N16WFdgkt87YA5k5qok0SJ5lxo5KKsbc21Ac8SWOir1ui/MDVYO5ZGM6tBb0rm5pgc6hZzCdjn9mIit2hZsTl7IbVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BaG/8wNw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 307FBA8F;
	Wed, 30 Oct 2024 20:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730317172;
	bh=0hN4Dxbc88JoFnTjDC6D8vcsDV41vBFTbn2UWygs4+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaG/8wNwxN5d0Z4/fRu0OKDMasM9ukvWucJhfwfasHvt3WCt9fQRc3mShkBSBVMmR
	 uPFy+wL8R+2tpswHO2hn6kzkuF1g9/P80W3doG654t+RgUTHm6mPjQhWfoTVyXH54x
	 qXvEJQrBg7UEVjsL5FbcbUVQQiXapjxsAr+iDdcQ=
Date: Wed, 30 Oct 2024 21:39:28 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <20241030193928.GC920@pendragon.ideasonboard.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
 <f2119a4d-7ba3-4f11-91d7-54aac51ef950@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2119a4d-7ba3-4f11-91d7-54aac51ef950@linux.dev>

On Thu, Oct 31, 2024 at 12:45:24AM +0800, Sui Jingfeng wrote:
> Hi,
> 
> On 2024/10/18 23:43, Dmitry Baryshkov wrote:
> > On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> >> The assignment of the of_node to the aux bridge needs to mark the
> >> of_node as reused as well, otherwise resource providers like pinctrl will
> >> report a gpio as already requested by a different device when both pinconf
> >> and gpios property are present.
> >> Fix that by using the device_set_of_node_from_dev() helper instead.
> >>
> >> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> >> Cc: stable@vger.kernel.org      # 6.8
> >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >> ---
> >> Changes in v2:
> >> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
> >> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
> >> - Added Fixes tag and cc'ed stable
> >> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
> >> ---
> >>   drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Technically speaking, your driver just move the burden to its caller.
> Because this driver requires its user call drm_aux_bridge_register()
> to create an AUX child device manually, you need it call ida_alloc()
> to generate a unique id.

There's a relevant discussion for a ti-sn65dsi86 patch, see
https://lore.kernel.org/r/20241030102846.GB14276@pendragon.ideasonboard.com

I agree it shouldn't be the responsibility of each caller to generate
unique IDs.

> Functions symbols still have to leak to other subsystems, which is
> not really preserve coding sharing.
> 
> What's worse, the action that allocating unique device id traditionally
> is the duty of driver core. Why breaks (so called) perfect device driver
> model by moving that out of core. Especially in the DT world that the
> core knows very well how to populate device instance and manage the
> reference counter.
> 
> HPD handling is traditionally belongs to connector, create standalone
> driver like this one *abuse* to both Maxime's simple bridge driver and
> Laurent's display-connector bridge driver or drm_bridge_connector or
> whatever. Why those work can't satisfy you? At least, their drivers
> are able to passing the mode setting states to the next bridge.
> 
> Basically those AUX drivers implementation abusing the definition of
> bridge, abusing the definition of connector and abusing the DT.
> Its just manually populate instances across drivers.

-- 
Regards,

Laurent Pinchart

