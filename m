Return-Path: <stable+bounces-219833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJuYJPWBoGn/kQQAu9opvQ
	(envelope-from <stable+bounces-219833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:25:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F71AC577
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98C0A335FFF4
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CE744CF4D;
	Thu, 26 Feb 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vWjKSWbG"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3D426D22
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122678; cv=none; b=C7u6nAsRZ24wU7sbOv51/LguNarQuccMIS/ihN/IdyGkFVHtbvT2KJNK6GMhdG8ybKn9/oGvJ843eITgfTWTDD8boGFcG1nPHfwSAuquzBSRaFvgH0RKdzjx1cjRosfniih31NxoTMwdp56gAc9cl5AUAnU4HfeKMZoZ1giVTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122678; c=relaxed/simple;
	bh=d+mBtfaENeIFoLUn/a2Cq0yMb0XxlFe7Pa/fBOqtdCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pK4xcd3nF2BCPmrAz899CvZv9XX71FT8/5ibbtIlIJbYM5yGWxMeaQGVGmDU/TV+varH0yaDEuh6DlRDA24MCLaRuOqa1GmkGRR87krXM6zKwSEaN3QgAmGupBlG9j3L8rfrUlIgXzjZ3EvJHDu9oRhZwg33TqRWzo02+T8m+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vWjKSWbG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B19584E41230;
	Thu, 26 Feb 2026 16:17:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 870F25FDE9;
	Thu, 26 Feb 2026 16:17:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B12F103693EF;
	Thu, 26 Feb 2026 17:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772122673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J7rzqyCwEJE4QXCmYRXeLF0zeRFmIwZ7a/ILMFOO6lk=;
	b=vWjKSWbGaHRLu3pK8EgSpxFFj8Twa/amgqR7pjMNa/N4VH+zHuLyp0fNwGyGZuuQMFJE/M
	AU165sADWJr6Q2JYK4bkmYXs++Q3vyPe0zx2SS6LgDsqvzVNnJjGODa705WpLPN5HeIfgR
	3FHdedKuzs0tL4PpbiJ/WMBaaVSbDvZEno9caipVzsmTWLpp/F4NmOMI8OqNDq5e3+hPBQ
	Kiydg2dcv0cz8aiEZoYkBZDmNxSsjkF0C8Ng+E0llsheA6zXiAgTl9XTF4635QOFWtwSPf
	+741P1lxczB9Wr8cVbZ3W3f/TDG3y4sUSA0ls0qtwGmypQ2MTZBhTFsg2Va6qA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 26 Feb 2026 17:16:45 +0100
Subject: [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for
 dual LVDS output
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219833-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 423F71AC577
X-Rspamd-Action: no action

Dual LVDS output (available on the SN65DSI84) requires HSYNC_PULSE_WIDTH
and HORIZONTAL_BACK_PORCH to be divided by two with respect to the values
used for single LVDS output.

While not clearly stated in the datasheet, this is needed according to the
DSI Tuner [0] output. It also makes sense intuitively because in dual LVDS
output two pixels at a time are output and so the output clock is half of
the pixel clock.

Some dual-LVDS panels refuse to show any picture without this fix.

Divide by two HORIZONTAL_FRONT_PORCH too, even though this register is used
only for test pattern generation which is not currently implemented by this
driver.

[0] https://www.ti.com/tool/DSI-TUNER

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index d2a81175d279..17a885244e1e 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -517,6 +517,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 					struct drm_atomic_state *state)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	const unsigned int dual_factor = ctx->lvds_dual_link ? 2 : 1;
 	const struct drm_bridge_state *bridge_state;
 	const struct drm_crtc_state *crtc_state;
 	const struct drm_display_mode *mode;
@@ -653,18 +654,18 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	/* 32 + 1 pixel clock to ensure proper operation */
 	le16val = cpu_to_le16(32 + 1);
 	regmap_bulk_write(ctx->regmap, REG_VID_CHA_SYNC_DELAY_LOW, &le16val, 2);
-	le16val = cpu_to_le16(mode->hsync_end - mode->hsync_start);
+	le16val = cpu_to_le16((mode->hsync_end - mode->hsync_start) / dual_factor);
 	regmap_bulk_write(ctx->regmap, REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW,
 			  &le16val, 2);
 	le16val = cpu_to_le16(mode->vsync_end - mode->vsync_start);
 	regmap_bulk_write(ctx->regmap, REG_VID_CHA_VSYNC_PULSE_WIDTH_LOW,
 			  &le16val, 2);
 	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
-		     mode->htotal - mode->hsync_end);
+		     (mode->htotal - mode->hsync_end) / dual_factor);
 	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_BACK_PORCH,
 		     mode->vtotal - mode->vsync_end);
 	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_FRONT_PORCH,
-		     mode->hsync_start - mode->hdisplay);
+		     (mode->hsync_start - mode->hdisplay) / dual_factor);
 	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
 		     mode->vsync_start - mode->vdisplay);
 	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);

-- 
2.53.0


