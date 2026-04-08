Return-Path: <stable+bounces-233933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLrtCmJ11mlQFggAu9opvQ
	(envelope-from <stable+bounces-233933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:33:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E383BE41D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E0603008D3E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29753A75A5;
	Wed,  8 Apr 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WY9slsKs"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10B272E56
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662414; cv=none; b=nZBXhVjA+BOAqG+qlYbfl7Yv61OQmoHI3Dp0+hKbKg7+GCsnDzm2/HYy1RF9tEm9HZkFqOhK/7tTzMFdnXeirRhWGlOGO6sEf1kMSnIbI39EkhRJKMRacH8Jmts26CP1UB5b4Sq1C3hb0I3q+V46d1GF8yb4xQ2XfVb7D3+802Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662414; c=relaxed/simple;
	bh=fzPHjuoLLAoXykNO9a5pGBrGsdhieGJVDBN8nz/9ZHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbagB0mCbZrGFXefxvYxlHabblEdHR78VdP8S9HAdFyxe0+QDBSNTBfAjdmY+P0leZBYllKqfd/+fZvVZGA9xNu/JWmIPrJr7RdQkL/njjCSlf9+TehiJAnlbSa4WnPiFDNWKCTxMIlV8JMwZ+ZFtzdnTdAs0W5X0UgmZdtzHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WY9slsKs; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15088C5AA98;
	Wed,  8 Apr 2026 15:34:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C495B603CB;
	Wed,  8 Apr 2026 15:33:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E28D410450144;
	Wed,  8 Apr 2026 17:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775662404; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XgrwB8oAIVjlAggKnPwuRCiDlzO+uSlP6BW+9wxQCpc=;
	b=WY9slsKseQQdifjXci9ktSbh7pjFpsw9qvaCaeKt9l2Qw1dQGh/M8O/T45Lcy7VMHrGHjP
	WKNzHgNiImEYcsIyQmAPs7Ld0TGiU4e58N4yEVjLt6midnPPcc8nkY/oqh+WtKkhF4iMmy
	VI2ODUpsBrks5tqNuSsiXm0lSS1y8p6tKzQuAcsYw1i1vwmGGjkx4Oy1Fy+sYGJIvr7G5Y
	xGQa4ODa4z0WsAMnsiIaJBseS3OkQo/RqLbA6ymFF312Q+ma1RPM2cJ+uUdJBAleZFSAWb
	H4iaywFrc9JmeixBgAfKEItw+4pnxXrYZsRESdljzVG41kL43dpOxnDZLIM59g==
Message-ID: <fdfc2321-bc31-4ff8-831e-adefcf6689a8@bootlin.com>
Date: Wed, 8 Apr 2026 17:34:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for
 dual LVDS output
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
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233933-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,ti.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34E383BE41D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2/26/26 17:16, Luca Ceresoli wrote:
> Dual LVDS output (available on the SN65DSI84) requires HSYNC_PULSE_WIDTH
> and HORIZONTAL_BACK_PORCH to be divided by two with respect to the values
> used for single LVDS output.
> 
> While not clearly stated in the datasheet, this is needed according to the
> DSI Tuner [0] output. It also makes sense intuitively because in dual LVDS
> output two pixels at a time are output and so the output clock is half of
> the pixel clock.
> 
> Some dual-LVDS panels refuse to show any picture without this fix.
> 
> Divide by two HORIZONTAL_FRONT_PORCH too, even though this register is used
> only for test pattern generation which is not currently implemented by this
> driver.
> 
> [0] https://www.ti.com/tool/DSI-TUNER
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index d2a81175d279..17a885244e1e 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -517,6 +517,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   					struct drm_atomic_state *state)
>   {
>   	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
> +	const unsigned int dual_factor = ctx->lvds_dual_link ? 2 : 1;
>   	const struct drm_bridge_state *bridge_state;
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *mode;
> @@ -653,18 +654,18 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   	/* 32 + 1 pixel clock to ensure proper operation */
>   	le16val = cpu_to_le16(32 + 1);
>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_SYNC_DELAY_LOW, &le16val, 2);
> -	le16val = cpu_to_le16(mode->hsync_end - mode->hsync_start);
> +	le16val = cpu_to_le16((mode->hsync_end - mode->hsync_start) / dual_factor);
>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW,
>   			  &le16val, 2);
>   	le16val = cpu_to_le16(mode->vsync_end - mode->vsync_start);
>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_VSYNC_PULSE_WIDTH_LOW,
>   			  &le16val, 2);
>   	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
> -		     mode->htotal - mode->hsync_end);
> +		     (mode->htotal - mode->hsync_end) / dual_factor);
>   	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_BACK_PORCH,
>   		     mode->vtotal - mode->vsync_end);
>   	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_FRONT_PORCH,
> -		     mode->hsync_start - mode->hdisplay);
> +		     (mode->hsync_start - mode->hdisplay) / dual_factor);
>   	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
>   		     mode->vsync_start - mode->vdisplay);
>   	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
> 


