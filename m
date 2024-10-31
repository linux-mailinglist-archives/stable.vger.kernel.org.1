Return-Path: <stable+bounces-89429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B512B9B8003
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BB91C21B7D
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2811BBBEA;
	Thu, 31 Oct 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPI0Jaw3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA541BBBD8;
	Thu, 31 Oct 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392002; cv=none; b=Fzv7m0qT2pY5qQqiykKoloRN6tZJ2/Vl96xn36638/r4or5RFyaEWoCHvzepgYAkQdA08jDNF+f9ZO+aJhe/eNIIO58u1oOx0OUtd5vCHEyF7gRzi8caIkKeNtCpKiXEvpE8+44QLoFKty/NI/vCTg6WkfkS4vZgySJt7pYg7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392002; c=relaxed/simple;
	bh=MeYpjmAvsTooc9kfh8p42uuv2Bag5WtM3PIxxAl8Flw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDv1rCh7rJKxk4iQcE7xisMBrHnrlUJj+HgRKb6PnWWfBNHRZW+H2xFIluw+7+t1K5mlF1jLP1KfpfP/cfj1fsDeugJ4bFE48UXMLYPqGcLkHl3dQFmGo1BqiYIdPvNMQQpyjqBQdIhyb9i5DfH0/++vtXk1cMgINS/BAsz0ugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPI0Jaw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF22C58106;
	Thu, 31 Oct 2024 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730392002;
	bh=MeYpjmAvsTooc9kfh8p42uuv2Bag5WtM3PIxxAl8Flw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPI0Jaw3PrGIL3Gqfkq8ZESXsc99FWmta6Mxd4nyD7C/q2ojqtwLAp3wLbZNUGmyL
	 abdRCI126UQDv1zLIxFZ0fQoQYu+w7BLlKfEhNE5xFad4s51JMA3Liw809RSjX+d1F
	 +MjeQemmA4fRQW3uQ3Xlo8gD+NWbm38goXztCTxhc/abc1jpfLlQ3zsTSLZMzGdu1f
	 p+6x1+7a+oeAnjJR8W8w4Ly8Ir1T6MwSfRDRIDY/tH/eptMu90NZA28xm0QJg6lcdP
	 cV5i4dhfO7c6KHZn2mA1atIY720O710on2fzNDV2YiAU+nRYODNJ8XD/S2IvJDzKkL
	 B/+oPXlVP0LPg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6Y0N-000000007Ab-3Yq2;
	Thu, 31 Oct 2024 17:26:39 +0100
Date: Thu, 31 Oct 2024 17:26:39 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ZyOvvxUQjUdfSX25@hovoldconsulting.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
 <CAA8EJpopyzeVXMzZAiakEmJ9S=29FKt43AHypSYyOuo_NbSJbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpopyzeVXMzZAiakEmJ9S=29FKt43AHypSYyOuo_NbSJbw@mail.gmail.com>

On Thu, Oct 31, 2024 at 05:48:24PM +0200, Dmitry Baryshkov wrote:
> On Mon, 21 Oct 2024 at 10:23, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> > > The assignment of the of_node to the aux bridge needs to mark the
> > > of_node as reused as well, otherwise resource providers like pinctrl will
> > > report a gpio as already requested by a different device when both pinconf
> > > and gpios property are present.
> >
> > I don't think you need a gpio property for that to happen, right? And
> > this causes probe to fail IIRC?
> 
> No, just having a pinctrl property in the bridge device is enough.
> Without this fix when the aux subdevice is being bound to the driver,
> the pinctrl_bind_pins() will attempt to bind pins, which are already
> in use by the actual bridge device.

Right, and IIRC it then fails to probe as well. This is information that
should have been in the commit message.

Johan

