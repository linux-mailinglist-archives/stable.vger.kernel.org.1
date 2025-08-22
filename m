Return-Path: <stable+bounces-172331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E56B31238
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1901D01D57
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635E2EACE0;
	Fri, 22 Aug 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UTqjg2u9"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B2221577;
	Fri, 22 Aug 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852409; cv=none; b=Tttd47+miuXq24IBAwl8VnAQ8FZFxpIEwHfs3DI/AJ3sL0ZOWghjwfDjK2Knq7hP/Ut2IMS0xgo3lhLwYj+F6ur0Fri8hrbpCt8lyRW223g+KQr1w7X0wa4a+60KCkq9UQdNzs4gPUs7E3nB+nFTJ/3+6t1Q0QC1NjWdoZKCdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852409; c=relaxed/simple;
	bh=sMZ/sVgshi7/W76au4urNnyFfZBACrPxwav0Rr+oR3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmaV235CVEgKyR9nJ8ysbqjHJwIta+FNMXG/M7bwEk+hv+Y3kZIximNT6WHr1clp8tkhIGr/zuD92MMHe2uxxW3D6PbZuA45is1gKoDI0XqLw+3XSg/XSayBzlirfnVPsCOEPNn+vPZimUQDa/o/xlxwHp16EI/gr3kzLjSoVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UTqjg2u9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A28C078E;
	Fri, 22 Aug 2025 10:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1755852344;
	bh=sMZ/sVgshi7/W76au4urNnyFfZBACrPxwav0Rr+oR3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UTqjg2u9Qun0pkqantzMaJDn76iWz8k4ZcnvyWrDtZhLjeocTxGGSUKJV06+yf2Zg
	 kgJoclIMppgSdFcAm5zwO9NiR85IarVrjIfKsbI7J+brIs5VnF2CyM7brFj/KO6Fx6
	 VVS/1M0i7kP4TDiRPkvkA3hnaFmjN1q1O427h9Mc=
Message-ID: <09441f4b-bdd1-46c9-876e-2ff503dd1160@ideasonboard.com>
Date: Fri, 22 Aug 2025 11:46:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Vitor Soares <ivitro@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Jayesh Choudhary <j-choudhary@ti.com>, stable@vger.kernel.org
References: <20250512083215.436149-1-ivitro@gmail.com>
 <546ef388-299b-4d97-8633-9508fab4475a@ideasonboard.com>
 <20250822070401.GA15925@francesco-nb>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20250822070401.GA15925@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22/08/2025 10:04, Francesco Dolcini wrote:
> Hello,
> 
> On Thu, May 22, 2025 at 12:09:08PM +0300, Tomi Valkeinen wrote:
>> On 12/05/2025 11:32, Vitor Soares wrote:
>>> From: Vitor Soares <vitor.soares@toradex.com>
>>>
>>> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
>>> for both runtime PM and system sleep. This causes the DSI clocks to be
>>> disabled twice: once during runtime suspend and again during system
>>> suspend, resulting in a WARN message from the clock framework when
>>> attempting to disable already-disabled clocks.
>>>
>>> [   84.384540] clk:231:5 already disabled
>>> [   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
>>> ...
>>> [   84.579183] Call trace:
>>> [   84.581624]  clk_core_disable+0xa4/0xac
>>> [   84.585457]  clk_disable+0x30/0x4c
>>> [   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
>>> [   84.593651]  pm_generic_suspend+0x2c/0x44
>>> [   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
>>> [   84.601670]  dpm_run_callback+0x8c/0x14c
>>> [   84.605588]  __device_suspend+0x1a0/0x56c
>>> [   84.609594]  dpm_suspend+0x17c/0x21c
>>> [   84.613165]  dpm_suspend_start+0xa0/0xa8
>>> [   84.617083]  suspend_devices_and_enter+0x12c/0x634
>>> [   84.621872]  pm_suspend+0x1fc/0x368
>>>
>>> To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
>>> SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
>>> _enable()/_disable() hooks managed by the DRM framework for both
>>> runtime and system-wide PM.
>>>
>>> Cc: <stable@vger.kernel.org> # 6.1.x
>>> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
>>> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> 
> ping on this, Tomi, maybe you can pick this one or is there any
> concern ?

No concern from my side, but I'm not a bridge or cdns-dsi maintainer, so
I don't pick any of these to drm-misc by default.

Aaand now as I wrote that, I realized I just some time ago pushed the
cdns-dsi series ("drm/bridge: cdns-dsi: Make it work a bit better") to
drm-misc without bridge maintainer's ack... So that didn't go according
to the rules, sorry.

 Tomi


