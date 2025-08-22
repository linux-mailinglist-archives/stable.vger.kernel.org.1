Return-Path: <stable+bounces-172336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F180B31273
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9610F17B092
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2C2EBDFF;
	Fri, 22 Aug 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="EmCJm+cq"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714A27B33D;
	Fri, 22 Aug 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853247; cv=none; b=enM7dyl1mvXCso8Jjo77xuDh3+mNq3nH4tXJfU68xHEzjybMe2yQm7rbhDn0SFsgyDxpbPInrG8/VbdOFLbUiTZMmDflWw6PsYwFlGzegg5TFXtavpJIrwsUrwKJn431sYHWRico0TkCMO6/FctteO5wY6PhM1RQHbjWaDRlXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853247; c=relaxed/simple;
	bh=sXRl84of7PDm6LrG1eFLh/2cNF4SjtxGeuRctS+KdVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEWyRIWEG19MQfGMXjWIMRVbSonXxzWEkTJed0a7XN6HblkVWkwgOKkFPOusEsUa8tjcmjcxCbLU0V8aGrCxwaAO0ncG2yl3pk4jNXuQFu+HJnrP0HSvDah4FINlQxK6ktF/TpVTTRWXs8PtKwWKzIaMDAog5ZzptKPs2iDhMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=EmCJm+cq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 006B71F928;
	Fri, 22 Aug 2025 11:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1755853242;
	bh=yqVIjOf4gmTgf8/ajdU+DxSBG+h+a3DoeajU5rdLano=; h=From:To:Subject;
	b=EmCJm+cqqX20mZNOxneRB73/50mbe4rqrqKN35H0gGp9tHmpWsItfctfc+6EAWeEj
	 R6a+PgIqbV9gSNpS4eQ9DVwV8H778fbKMNpY5Xjjrze2ZGhfL9THJbYtiYDbqhY5XS
	 8+GVIqr3TZ4+34zBmGDK2A8+QFQ+HLX4ZgtCTqhc8xp/gaua9PgzdFO3UTG/Q7nu/u
	 1B7NvhbTLYhCE9prHbY/voXKeSVuE/wloLIjzwvK+KWDyrrM++ySTzmRyl7GaT8f9y
	 Z58J6MWmMH+6/KRm+/eiNz/ppl43oNWzqbJkl4JkWU9nrh43fQrShZ+Wpz3RneODIF
	 YcvUgrbZe9qbQ==
Date: Fri, 22 Aug 2025 11:00:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Vitor Soares <ivitro@gmail.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vitor Soares <vitor.soares@toradex.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Message-ID: <20250822090038.GA28190@francesco-nb>
References: <20250512083215.436149-1-ivitro@gmail.com>
 <546ef388-299b-4d97-8633-9508fab4475a@ideasonboard.com>
 <20250822070401.GA15925@francesco-nb>
 <09441f4b-bdd1-46c9-876e-2ff503dd1160@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09441f4b-bdd1-46c9-876e-2ff503dd1160@ideasonboard.com>

On Fri, Aug 22, 2025 at 11:46:40AM +0300, Tomi Valkeinen wrote:
> On 22/08/2025 10:04, Francesco Dolcini wrote:
> > On Thu, May 22, 2025 at 12:09:08PM +0300, Tomi Valkeinen wrote:
> >> On 12/05/2025 11:32, Vitor Soares wrote:
> >>> From: Vitor Soares <vitor.soares@toradex.com>
> >>>
> >>> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> >>> for both runtime PM and system sleep. This causes the DSI clocks to be
> >>> disabled twice: once during runtime suspend and again during system
> >>> suspend, resulting in a WARN message from the clock framework when
> >>> attempting to disable already-disabled clocks.
> >>>
> >>> [   84.384540] clk:231:5 already disabled
> >>> [   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
> >>> ...
> >>> [   84.579183] Call trace:
> >>> [   84.581624]  clk_core_disable+0xa4/0xac
> >>> [   84.585457]  clk_disable+0x30/0x4c
> >>> [   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> >>> [   84.593651]  pm_generic_suspend+0x2c/0x44
> >>> [   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
> >>> [   84.601670]  dpm_run_callback+0x8c/0x14c
> >>> [   84.605588]  __device_suspend+0x1a0/0x56c
> >>> [   84.609594]  dpm_suspend+0x17c/0x21c
> >>> [   84.613165]  dpm_suspend_start+0xa0/0xa8
> >>> [   84.617083]  suspend_devices_and_enter+0x12c/0x634
> >>> [   84.621872]  pm_suspend+0x1fc/0x368
> >>>
> >>> To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> >>> SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
> >>> _enable()/_disable() hooks managed by the DRM framework for both
> >>> runtime and system-wide PM.
> >>>
> >>> Cc: <stable@vger.kernel.org> # 6.1.x
> >>> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> >>> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > 
> > ping on this, Tomi, maybe you can pick this one or is there any
> > concern ?
> 
> No concern from my side, but I'm not a bridge or cdns-dsi maintainer, so
> I don't pick any of these to drm-misc by default.
> 
> Aaand now as I wrote that, I realized I just some time ago pushed the
> cdns-dsi series ("drm/bridge: cdns-dsi: Make it work a bit better") to

Yep, that's the reason I assumed you could also pick this one. Any
DRM bridge maintainer can help here?

Thanks,
Francesco




