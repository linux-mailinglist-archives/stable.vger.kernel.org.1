Return-Path: <stable+bounces-89406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FF9B7C57
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A9F1C2150F
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8319C54C;
	Thu, 31 Oct 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTD3lW8f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1777483;
	Thu, 31 Oct 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383555; cv=none; b=XlLOKYOvJcz6u68zbJRv59f0Hw2TOJbsGIO+WFVjvukpvEYOJBjHPVWWDwGZ0U1dWaRy0goFDEsn7Zk0Dk6Jju0K/IxaXD+ANrupwntjWwJw8CYnHgBu/Hkav3eUXmg8Qp4p2pKkSJ02zpcjn9gkk5LGbPkr7YHWauvzCpr3/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383555; c=relaxed/simple;
	bh=tqhdXipXaApdyzH7wbucKGPUec8wdzKCSf8PtkJTxso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+Yu/v1ZE2nnzFB2f9H1kTX0EK8EjAB0nCz9Vkqby/sd8/tzJwLenwK7XaGZOFCr0KgLMB1vdh/AWrV3kaKUjxwn6XCBxpYpDmMzJrECWPVuCGfR2rjDpB3Y8nVdKQ+tQGLPdoPvfEzxNjNzE5SBtwhOatK/94YrthQbDbce2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTD3lW8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129CBC4FF0D;
	Thu, 31 Oct 2024 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383555;
	bh=tqhdXipXaApdyzH7wbucKGPUec8wdzKCSf8PtkJTxso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTD3lW8fWB74a1NtwyhYLGCCzQo3c0W2TfXSAtMh9Bnh4z9Oj1I8vdc28lu9B6MRS
	 MQR7yy1N7WVEz+rmypsGxHSSDIlevHnq7EeTDlzHTvovlPGAK8l3dEVkgIuz5HJGgp
	 46835ueeXuOZlqP2uEDIDGtrdUqplEEvmrQl3lng5yEZsTXGiDwFBQ8IMaxOrO/DfJ
	 seH4cP++XQK4QU83l7G+uPD+J10Lecd3P6+BslCMw1+4sSXhHzn1FphODY4lEe90Xb
	 edVruSFjliiI877b5B6BvS0mL84DHhLfJ1tsrgAxJAjppK4smpL6K9WMKuV+8voGO2
	 ircghHwu0/29g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6Vo8-000000004NO-3f8I;
	Thu, 31 Oct 2024 15:05:52 +0100
Date: Thu, 31 Oct 2024 15:05:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ZyOOwEPB9NLNtL4N@hovoldconsulting.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYBa11Ig_HHQngV@hovoldconsulting.com>

On Mon, Oct 21, 2024 at 09:23:24AM +0200, Johan Hovold wrote:
> On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> > The assignment of the of_node to the aux bridge needs to mark the
> > of_node as reused as well, otherwise resource providers like pinctrl will
> > report a gpio as already requested by a different device when both pinconf
> > and gpios property are present.
> 
> I don't think you need a gpio property for that to happen, right? And
> this causes probe to fail IIRC?
> 
> > Fix that by using the device_set_of_node_from_dev() helper instead.
> > 
> > Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> 
> This is not the commit that introduced the issue.
> 
> > Cc: stable@vger.kernel.org      # 6.8
> 
> I assume there are no existing devicetrees that need this since then we
> would have heard about it sooner. Do we still need to backport it?
> 
> When exactly are you hitting this?

Abel, even if Neil decided to give me the finger here, please answer the
above so that it's recorded in the archives at least.

Johan

