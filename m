Return-Path: <stable+bounces-244336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJAcAI71+mk1UwMAu9opvQ
	(envelope-from <stable+bounces-244336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:02:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B74D792A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 793E8305BF07
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728723E314C;
	Wed,  6 May 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FOeXm3NT"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42F25F98B;
	Wed,  6 May 2026 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054505; cv=none; b=EzWM2S2OJq574Du5DOkfIQECG5QiZaJ0UgvhaEw8zUull2r3E4UOWFDd/eVKDxNgF7P3lyUy/ZRoBJUdKwO7DM0FcI9TmIOmPfuvnQaYNmgBL5UhNgGS3RRGMj544PoUiEF7VW+qqhDyUkJrr/rBbyysO5KKfvVqyuGo+ndhIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054505; c=relaxed/simple;
	bh=sBiF8tqyySOo/DmrZC8WqhP3evQV2sfTKn6yuUj/Qko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u34zLLcDtD40cn1P4FZe1oVZy8k+NQC7VS8zLqeG6C5l69hOQTQPZWifXxZRgjUDJDcVkwgj4f7TIBjCYm7VgBjmPNQ+f1Xdi+J5P0GHayK6CaJi1eEVa5wWturoISaDMj+BXFZI1vHX5SMTMkKfR57KLTOBm62+G7HvqWu7aG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FOeXm3NT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D446F55;
	Wed,  6 May 2026 10:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1778054497;
	bh=sBiF8tqyySOo/DmrZC8WqhP3evQV2sfTKn6yuUj/Qko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FOeXm3NTkbxnKYWblklYWP1FOnQ4yLHGJJd3bgtBiNbu89/FzD/UYn9ZKoL/IuF71
	 YoxCHWoKif6jp8hPE6TbDxEj8O0YV9TRxCRmKC0otWumWoPKiVbeYLeXUVIcVGZdaN
	 c747oAAstiTWLpYU8L9tuHbRqZDGXSTStRg+hIiU=
Message-ID: <d9c5fd5f-f910-45c9-82cc-9284bcedc162@ideasonboard.com>
Date: Wed, 6 May 2026 11:01:37 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
To: Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 stable@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260505134705.188661-2-ivitro@gmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260505134705.188661-2-ivitro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 445B74D792A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[ideasonboard.com:server fail,toradex.com:server fail];
	FREEMAIL_CC(0.00)[toradex.com,lists.freedesktop.org,vger.kernel.org,bootlin.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-244336-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[ideasonboard.com:server fail,toradex.com:server fail];
	FROM_NEQ_ENVFROM(0.00)[tomi.valkeinen@ideasonboard.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toradex.com:email,ideasonboard.com:email,ideasonboard.com:dkim,ideasonboard.com:mid]

Hi,

On 05/05/2026 16:47, Vitor Soares wrote:
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
> RUNTIME_PM_OPS(). Bridge and panel drivers should only deal with runtime
> PM, as the DRM framework manages system-wide power transitions through
> the bridge enable() and disable() hooks.
> 
> Link: https://lore.kernel.org/all/fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com/
> Cc: stable@vger.kernel.org # 6.1.x
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Thanks, pushed to drm-misc.

  Tomi


