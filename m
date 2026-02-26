Return-Path: <stable+bounces-219835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7hb0CqmBoGn/kQQAu9opvQ
	(envelope-from <stable+bounces-219835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:23:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53D1AC4BF
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 169FA31F2CD4
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C45433CE80;
	Thu, 26 Feb 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Th4jixQk"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC235FF50
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122679; cv=none; b=cO340JH56ONQZVuFyZNHDmKPmPinjXIHtM2D1ek1B7Sf0eOLxfFStLkOF7RUIQER1jrsUD81eEg9vshmtaMJ6LOe9P7DNN6W/XS3bAIuQWIGjH7SDMA+hx8ygdRnnNF8//FOlSPBF2ksjVV7B8Ggj9/VuWgLDyvAjtiQ4+2ILLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122679; c=relaxed/simple;
	bh=QjDfBOjj+v9+tm8usbQFDuQsLWjBDEFBxE2wtwecyhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyOYqV86od7eCSnLK8vBmCxgPX4XgAQXRyhDRBgbs6HM8lOQe0zjn29UWS10i55hZ29DPIr1Y2if1uX3MR6xMT20duLhVW1eyG/YD2WLL0v7g8KW33vczBKPeJ51nqdlTswlYsTv2WbcsbKFbtQ+YxbmTZM45W3GptNlq43Ixow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Th4jixQk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 594801A156C;
	Thu, 26 Feb 2026 16:17:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F0D45FDE9;
	Thu, 26 Feb 2026 16:17:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3694F103693C1;
	Thu, 26 Feb 2026 17:17:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772122670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8XkrbW1hnirnZLGMwEegjlBI4fLIXypAXffpHsh+X60=;
	b=Th4jixQkyCmPeaFtAecWi2A1PmjmPfSM0/peoVmRNauB/hxMWa35AID7i4yYTPH0KYkW5r
	Wd8p3MN0TZEPQvnXHN59vEeMDXm+UI3cYTmT92WA4TNLw9oRdeepM1VeHKAnv1PJr0Gd6N
	T9GlU8wkQY+sBYZcrAGO3geU06L11B7dDTZ+iBILinZ4uV5syAGPvjS9U4vEA9h4M00DWX
	dsonptG6TrQu2O5QuVcCtn5gLVV7HcrAdPaqdhuRl8k6gjTQJG67CctyrmxcE/QTkHyo11
	mslwaDbfPHVY7Wu+G1Pzpl9M/klUA5MrjNj/+co8lWM2xagL1ak19s+zWdRQqQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 26 Feb 2026 17:16:44 +0100
Subject: [PATCH 1/3] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE
 rounding
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com>
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219835-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D53D1AC4BF
X-Rspamd-Action: no action

The DSI frequency must be in the range:

  (CHA_DSI_CLK_RANGE * 5 MHz) <= DSI freq < ((CHA_DSI_CLK_RANGE + 1) * 5 MHz)

So the register value shouldpoint to the lower range value, but
DIV_ROUND_UP() rounds the division to the higher range value, resulting in
an excess of 1 (unless the frequency is an exact multiple of 5 MHz).

For example for a 437100000 MHz clock CHA_DSI_CLK_RANGE should be 87 (0x57):

  (87 * 5 = 435) <= 437.1 < (88 * 5 = 440)

but current code returns 88 (0x58).

Fix the computation by removing the DIV_ROUND_UP().

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index f6736b4457bb..d2a81175d279 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -351,9 +351,9 @@ static u8 sn65dsi83_get_dsi_range(struct sn65dsi83 *ctx,
 	 *  DSI_CLK = mode clock * bpp / dsi_data_lanes / 2
 	 * the 2 is there because the bus is DDR.
 	 */
-	return DIV_ROUND_UP(clamp((unsigned int)mode->clock *
-			    mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
-			    ctx->dsi->lanes / 2, 40000U, 500000U), 5000U);
+	return clamp((unsigned int)mode->clock *
+		     mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
+		     ctx->dsi->lanes / 2, 40000U, 500000U) / 5000U;
 }
 
 static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)

-- 
2.53.0


