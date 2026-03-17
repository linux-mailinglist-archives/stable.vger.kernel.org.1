Return-Path: <stable+bounces-225905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGpAAhZOuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:50:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDE12AA1DF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1950C3050ECF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88213C456B;
	Tue, 17 Mar 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PewEXuKY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5363C196B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751826; cv=none; b=tf8XS0Hhhjv5ARJ87kFpJNIy+8+vHnXqUt5gPzHiMqmFmeHlCkkhlVqdk85WpsDmqrg4nU1djXdqN3LUb9tLZe+IMMZFpI9nLAeztaJLsYtcybCDOdB6pJoGgzEQ7T666rFp2ERQcTZnR1ViZjFsmjmMdWS9oDbu0d8hl//X1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751826; c=relaxed/simple;
	bh=/2jAndraE7cbqbz6gFE8Taz0bgsiAUuZsQ49SczI9+8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FX5t0ULpmpjn6LsrGpOi5msuGWm3qqYBd1AYBeIJ/aoi30loXXcQCXpiJTe5d30rIJVTZk46qbt367dt7cB8ry7hHIcRe3fKUlPseA5SsHkovqzL6aBveGxmGWS/g/T63CJJulsCtfXr5mFzwpWt6YYXIlyFjylAC5r9CcrdmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PewEXuKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAFFC4CEF7;
	Tue, 17 Mar 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751826;
	bh=/2jAndraE7cbqbz6gFE8Taz0bgsiAUuZsQ49SczI9+8=;
	h=Subject:To:Cc:From:Date:From;
	b=PewEXuKYDuRRbnjSKips3QpngjRHeNoi+q2EB/TdpiUdmsQLq7HMtaYRmzl1rTCk2
	 f5RyFld7kJbtvoliVKGl2JBAZ0tsoNMmIS7W2nqswT3a/sjzGj760QOohWUzkNMlO5
	 CMgvChVmfogedWdF8W147rC6oShAKQQ80fwuZpPg=
Subject: FAILED: patch "[PATCH] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual" failed to apply to 6.12-stable tree
To: luca.ceresoli@bootlin.com,marek.vasut@mailbox.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:50:21 +0100
Message-ID: <2026031721-jujitsu-bobcat-0c47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225905-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,ti.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,mailbox.org:email]
X-Rspamd-Queue-Id: 2CDE12AA1DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d0d727746944096a6681dc6adb5f123fc5aa018d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031721-jujitsu-bobcat-0c47@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0d727746944096a6681dc6adb5f123fc5aa018d Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 26 Feb 2026 17:16:45 +0100
Subject: [PATCH] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual
 LVDS output

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


