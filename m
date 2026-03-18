Return-Path: <stable+bounces-227115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OQeIqvUummfcAIAu9opvQ
	(envelope-from <stable+bounces-227115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:36:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29A2BF608
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43B993068A23
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BEC3F54D1;
	Wed, 18 Mar 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcShw5px"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6A3ECBEE
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850237; cv=none; b=Bl6QhXy8w12kEjhalT93zThFM3ZJyum8BNQ/omf6ZMpncHxET6ObtAdV+nJt46rLnRHCy443DfFKDAm7KLjvgfxz1rvZEZomTcYzKF8KkCTglsVzbSYnrDIWykiNyk8cUKWVeIzigk/CCA4OrUKwHc2YmaZcrsdnCi57tysyeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850237; c=relaxed/simple;
	bh=vGEk9TcLCY1iWYayPlA6QptXQQKglYIrDJf3WpdbcZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag1ys5TE16kx6HVrXYJcQMpU3WS+SjqA3jmprY5FXlBqwAaddU2/P4jIv3P0laUY+xhdkr4Saz3UK79INpZ3L5zLlzFmiYzMlr3sfcF+zlr0HX2fqO7iTDkCCOUOMd+/N6oZH0fcwDrl38doyEHlWd+fAFwoqzjwJqBpWUUHipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcShw5px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47083C2BC87;
	Wed, 18 Mar 2026 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773850236;
	bh=vGEk9TcLCY1iWYayPlA6QptXQQKglYIrDJf3WpdbcZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcShw5px6ChhPMphOqV1cJb2GVoMZMJ5YLmda87WqvtkliVQFWKJI/z5fXGztwPeZ
	 LgEEpcSyg8GvW06VmIu5heiyDIFDn2jGSetZ6OTKL5fr4g7gf4jarUOh1oSbQSxPmG
	 NEEkgHxHWLxJRD1mtcaYcmtp8zLVanw9wMQGDTfGrNRk4x24DjKFEr5rJrf1ExG8+p
	 QFT4+gkMO+iKN3bGmTUBWVId64zqPNsQQZSF0qoSS1cQ6L3v4B9DmbsehHfAOCrO+j
	 3sLt9lm55cKqxQznX8E6lFn8sv9yWSiJE8SqxqFsY2ejdvnk4mPj7943eYN+UvL94L
	 r++K9uPkCR97w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
Date: Wed, 18 Mar 2026 12:10:34 -0400
Message-ID: <20260318161034.907691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031722-ablaze-chloride-2f82@gregkh>
References: <2026031722-ablaze-chloride-2f82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227115-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,ti.com:url,mailbox.org:email]
X-Rspamd-Queue-Id: 0A29A2BF608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit d0d727746944096a6681dc6adb5f123fc5aa018d ]

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
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Link: https://patch.msgid.link/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
[ adapted variable declaration placement ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 8a23116346a8a..29946de5e2ba3 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -325,6 +325,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 					struct drm_bridge_state *old_bridge_state)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	const unsigned int dual_factor = ctx->lvds_dual_link ? 2 : 1;
 	struct drm_atomic_state *state = old_bridge_state->base.state;
 	const struct drm_bridge_state *bridge_state;
 	const struct drm_crtc_state *crtc_state;
@@ -452,18 +453,18 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
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
2.51.0


