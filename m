Return-Path: <stable+bounces-233932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCJVMWJ11mlQFggAu9opvQ
	(envelope-from <stable+bounces-233932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:33:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C53BE424
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26DC5300E27F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA422E4247;
	Wed,  8 Apr 2026 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nMmNdY+D"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7827603A;
	Wed,  8 Apr 2026 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662333; cv=none; b=aqIILl7WyY2itRY/HAXICR7cQcGj2+qgIRIf/vTfwEdTnbVoDCIOE2CRXRBNAV3JV5fVzzBJ7bruY+U8SNL1YbCWmxdGvuTPBk5oGIP3Ga93xaF5VzonhdGP628SqY/S7Q4LVa8lPMuVTCjM6zQZ9vDyBKeJtMfEq/ofAA/uPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662333; c=relaxed/simple;
	bh=VKiZmvl4WWXk91aIkSO31dlwVeVOz8l+FYli2wi0K4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzQ/NGnOIA4qKs7BzF60ATPekdeITzrr6ZbpABYif6CtSzn9+THEQc+4zouQc/GM1glhd9xCGdoSGNN2x0ndiRZZbtRQyrSFK64/K6eY/cnqugwTGnrF4aGs/Sanv3xEIgBcqMxUhJ4D1fzQ7D/8Nl2mNJTKC4Fdprpz/nFtNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nMmNdY+D; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE4C2C5AA98;
	Wed,  8 Apr 2026 15:32:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A275603CB;
	Wed,  8 Apr 2026 15:32:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEF0B104500FE;
	Wed,  8 Apr 2026 17:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775662327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=D6wwHgL4qxNF79DvLc8v4w9tKYZJfLiounJZIjveOxw=;
	b=nMmNdY+D3FB5AotrSzWu5hFDk78Cvx19H94Y4pPl1dMf9s4HovskEJENJpWKX662jX+z8o
	ie29LisVRCb5D4mDW1sedWF4B/HVAaQeptSxY2uVyYU4lRcauYdmaQ19COi2Alq4NKKr0r
	Ci7pWzkDrIPeYqlUvrBfSoU0Svn5+t2iP6gjSJYhhr1ElW6LP05xLv90FiFj5aJt5R/f7d
	OtEZ/akpIHNwzsxcZGOqa7+5cfKyNWYVaps3oBHAl0kCreC1gC6Jk+6/NAYLyKZR/UfwVI
	TmoE6hVsjzgbVXC9+SHJLKuQfw28wBvwYCEksmQCu653nDQ2PvqRp1i4E7EIlw==
Message-ID: <161bd1c9-4015-4d56-95ad-7e5c4d57d7aa@bootlin.com>
Date: Wed, 8 Apr 2026 17:32:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE
 rounding
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 Linus Walleij <linusw@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233932-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.chauvet@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 695C53BE424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2/26/26 17:16, Luca Ceresoli wrote:
> The DSI frequency must be in the range:
> 
>    (CHA_DSI_CLK_RANGE * 5 MHz) <= DSI freq < ((CHA_DSI_CLK_RANGE + 1) * 5 MHz)
> 
> So the register value shouldpoint to the lower range value, but
> DIV_ROUND_UP() rounds the division to the higher range value, resulting in
> an excess of 1 (unless the frequency is an exact multiple of 5 MHz).
> 
> For example for a 437100000 MHz clock CHA_DSI_CLK_RANGE should be 87 (0x57):
> 
>    (87 * 5 = 435) <= 437.1 < (88 * 5 = 440)
> 
> but current code returns 88 (0x58).
> 
> Fix the computation by removing the DIV_ROUND_UP().
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index f6736b4457bb..d2a81175d279 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -351,9 +351,9 @@ static u8 sn65dsi83_get_dsi_range(struct sn65dsi83 *ctx,
>   	 *  DSI_CLK = mode clock * bpp / dsi_data_lanes / 2
>   	 * the 2 is there because the bus is DDR.
>   	 */
> -	return DIV_ROUND_UP(clamp((unsigned int)mode->clock *
> -			    mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
> -			    ctx->dsi->lanes / 2, 40000U, 500000U), 5000U);
> +	return clamp((unsigned int)mode->clock *
> +		     mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
> +		     ctx->dsi->lanes / 2, 40000U, 500000U) / 5000U;

If you need to do a v2, I think it could be nice to introduce one or two 
intermediate variable to allow a human to read this line:

required_bitrate = pixel_clock * bpp;
lane_rate = required_bitrate / lanes / 2;
return clamp(lane_rate) / 5000;

With or without this:

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

>   }
>   
>   static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)
> 


