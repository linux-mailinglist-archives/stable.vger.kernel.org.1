Return-Path: <stable+bounces-208060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E8AD117D7
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9611230021D5
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5B347FF4;
	Mon, 12 Jan 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="S8HteJDN"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5F322C6D;
	Mon, 12 Jan 2026 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210111; cv=none; b=ZfyuVmIje62GsAuSjxtXk6MosaUDIOfC3DmtqNG5rpiT/BKLziYfQs8Fg3k+V2qgl3TxFbuE/h/JwXzguXUING7S6CgSsxU7SFZcqrNUtSbEDOple2cGBepXGuU5YOlq5u4nXqFZTXeudnFzGcBAPd/s1+6nyWM296z+9BM59+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210111; c=relaxed/simple;
	bh=ns1rC+gvdyqz34RkYw0ksEhRFptDkIHcHxwKF4cxtVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmvHV1WDXOeqrc/fq6wMlRoYGQyieu1SEc/5Dc3FsKRNUnkS2PZ84zoZVgZqvRbdAriysNwKLPoUvAdqAxrOEUff12XS45Pv+kwMGoSruKTAyYAJyYj+YNXoMTF16Xp0iwGwFwyrJVh88YUI+7Wj7Nsfpew9bzpyZ59ByMuAmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=S8HteJDN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 325C31FB2D;
	Mon, 12 Jan 2026 10:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1768210107;
	bh=IUGM7tUYpJzm3kIg7W7yUdT2FccbaCQQyhc9oICILzk=; h=From:To:Subject;
	b=S8HteJDNdUpKPGR2payHmpuG99yQXEUxklnIefkRqVoYk8CvZpkSKTc9slVFksE8q
	 8lJv0Pd+wNqtUxsHK+Vp7RLuWxAC6L28EK+g3i5KC6cQDi693xMpO4I2CoavcLI1J7
	 SGRRi8Bh4o1kEdDNQhtxd980j6NhGyJGSOJORAR0jLLnlQclDvzIBmmEOfkjurGOwG
	 EhIAtjuWYSrEqLYXSBHmIIYykyYTn5g4U+nYkLvB/WQhrTbq4qZwTrKvROJheOa3kF
	 OpLBh4OgoH7sGCxbE+JwttpBdiXn7n8I1umdKrTYQIpS4wxvX2ztt4Wm4aMYmdkgyD
	 VtzmsjiriAoRg==
Date: Mon, 12 Jan 2026 10:27:38 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Message-ID: <20260112092738.GA120199@francesco-nb>
References: <20250512083215.436149-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512083215.436149-1-ivitro@gmail.com>

Hello Maarten, Maxime, Thomas, Simona, David,

On Mon, May 12, 2025 at 09:32:15AM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> for both runtime PM and system sleep. This causes the DSI clocks to be
> disabled twice: once during runtime suspend and again during system
> suspend, resulting in a WARN message from the clock framework when
> attempting to disable already-disabled clocks.
> 
> [   84.384540] clk:231:5 already disabled
> [   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
> ...
> [   84.579183] Call trace:
> [   84.581624]  clk_core_disable+0xa4/0xac
> [   84.585457]  clk_disable+0x30/0x4c
> [   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> [   84.593651]  pm_generic_suspend+0x2c/0x44
> [   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
> [   84.601670]  dpm_run_callback+0x8c/0x14c
> [   84.605588]  __device_suspend+0x1a0/0x56c
> [   84.609594]  dpm_suspend+0x17c/0x21c
> [   84.613165]  dpm_suspend_start+0xa0/0xa8
> [   84.617083]  suspend_devices_and_enter+0x12c/0x634
> [   84.621872]  pm_suspend+0x1fc/0x368
> 
> To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
> _enable()/_disable() hooks managed by the DRM framework for both
> runtime and system-wide PM.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

I am a little bit stuck on what is the best way to have this patch
moving forward.

Who can help on this?
Can any of you guide me a little bit?

Francesco



