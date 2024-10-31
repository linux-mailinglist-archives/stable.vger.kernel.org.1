Return-Path: <stable+bounces-89405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF789B7C47
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4881C213D0
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8614F121;
	Thu, 31 Oct 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNaRND/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F684A3F;
	Thu, 31 Oct 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383379; cv=none; b=IHFC5Dom1AhDdQcpVetAJErt/zaNGHRJHiPudI3+rZqF5emmLlj9li9QATE6dFAZ7CGhB3LLc111ltf83j0d+xvXzY2ZoBQnTZDsX8RUu39YaJ1J3cG2jv3fb7q9u4znKr/Bi45Gdde2nPcMupY9fMYxsWcGEaBaNrA4iVPhP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383379; c=relaxed/simple;
	bh=rM7JeFz9gUYAeFhBr3i1Nmo+zAAoRiN+ZzEeAmzgmoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1DRUXqncKB18Kno8JYtWBiyhq5XjcCv8rkntyFjWwDaVBbel/pjfEM0bxqOjAmW3tKabj1mbmyoN6ShpZua0KcmQMAy7oc/7Ka7s91YDW9jLN8683+RvcZRhNo+uenlDEJK9dHjls8xIwRSaUtdxppD69AjPe+xvQRN3NTFLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNaRND/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E98BC4CED0;
	Thu, 31 Oct 2024 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383378;
	bh=rM7JeFz9gUYAeFhBr3i1Nmo+zAAoRiN+ZzEeAmzgmoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNaRND/I1qBIq+wxeeLp1W8IrXNFVkeVr16EJ1tTYRm9sd/vefEzYw5RfDzGyiCqQ
	 zEbCuZ7MjZMdvzuZdShZ3v54Lk/GuDcyC35jCrNJfrgVhUbHdFXolCT/pE30UMY1+u
	 1P79uF/lp7QOOvB2E388qNQpOX0IIOggV6XO6Nb43zMwAy28B9yTP9LLX2SJ7Fgnfg
	 0pOsteXjLYtVw5LF8m+AKXiuQwdCwRJbPbICXSr13yenl7TeStlLf2IntYHnTZj2Ev
	 utVev3D1dlXbXCTSv2jc2HSeu1gFanS0O8vZVGeINOACvF4QmQxeTjeV1eEGsUyz9Q
	 riutsoBiCmDcg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6VlI-000000004Jl-0qBS;
	Thu, 31 Oct 2024 15:02:56 +0100
Date: Thu, 31 Oct 2024 15:02:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
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
Message-ID: <ZyOOEGsnjYreKQN8@hovoldconsulting.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
 <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>

On Thu, Oct 31, 2024 at 01:31:47PM +0100, Neil Armstrong wrote:
> On 30/10/2024 15:49, Sui Jingfeng wrote:
> > On 2024/10/21 21:08, Neil Armstrong wrote:
> >> On Fri, 18 Oct 2024 15:49:34 +0300, Abel Vesa wrote:
> >>> The assignment of the of_node to the aux bridge needs to mark the
> >>> of_node as reused as well, otherwise resource providers like pinctrl will
> >>> report a gpio as already requested by a different device when both pinconf
> >>> and gpios property are present.
> >>> Fix that by using the device_set_of_node_from_dev() helper instead.
> >>>
> >>>
> >>> [...]
> >> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
> > 
> > 
> > It's quite impolite to force push patches that still under reviewing,
> > this prevent us to know what exactly its solves.
> 
> It's quite explicit.

It's still disrespectful and prevents reviewers' work from being
acknowledged as I told you off-list when you picked up the patch.

You said it would not happen again, and I had better things to do so I
let this one pass, but now it seems you insist that you did nothing
wrong here.

We do development in public and we should have had that discussion in
public, if only so that no one thinks I'm ok with this.

Johan

