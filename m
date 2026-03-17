Return-Path: <stable+bounces-226788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O9SGsCOuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FB2AF8B4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D41B303DA15
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7833624B3;
	Tue, 17 Mar 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F6ynPNPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF822F362B;
	Tue, 17 Mar 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768199; cv=none; b=d7aP61xWnQOUJFVR5dZJMfff1qkUvk+7+hSK/XnePMDP7QAllGeVWxctKtYEKPsU969XIJKVFhrABcpWNxkmsIpEFMxY/+rXAs5sGSafzMErXb/TFJ0ukfpMpFH7PKxFSH1kHD3LSK5Lsyv4+VCqCXZXgNS1iZLXRSy4ghj14Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768199; c=relaxed/simple;
	bh=ungHzVpcs12NyM9sWoC4UOCJX24gnATKzZqw+b8d3NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZxgD2LMIOhA8cHc/vy5tq8yN44pyM3Av7K07yn5mNr0Xx3uFJuzWZHkREpcc6JnJa8SZ6EmVySGup8ulTOcLLWFHMdgrTmr5wXEgwDfL1f9GK7o1en/jeXbxfscU/+Uw7A0PIWDD7Qbp7zP8ry4gPcez7w5/H7ss/c7lknVX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6ynPNPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6748C19424;
	Tue, 17 Mar 2026 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768199;
	bh=ungHzVpcs12NyM9sWoC4UOCJX24gnATKzZqw+b8d3NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6ynPNPiLdvgQmJ3VOJuETxKnW7/iYVg4ovuqvD9iRysCjm9CvjufY2Dfdkrt5Yjn
	 VrtkhAkRgAng+c9Dve8RGipbbA2pviDsy5GFMKMnhCU5dHaQCUEOKAP4a8JoubD4Zm
	 lhDZ7Z1vZkZtwvcn451NsCpVhXbBbEi+U74b5UlY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut@mailbox.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 6.18 255/333] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
Date: Tue, 17 Mar 2026 17:34:44 +0100
Message-ID: <20260317163008.824481426@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226788-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,mailbox.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:url]
X-Rspamd-Queue-Id: 118FB2AF8B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

commit d0d727746944096a6681dc6adb5f123fc5aa018d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -474,6 +474,7 @@ static void sn65dsi83_atomic_pre_enable(
 					struct drm_atomic_state *state)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	const unsigned int dual_factor = ctx->lvds_dual_link ? 2 : 1;
 	const struct drm_bridge_state *bridge_state;
 	const struct drm_crtc_state *crtc_state;
 	const struct drm_display_mode *mode;
@@ -606,18 +607,18 @@ static void sn65dsi83_atomic_pre_enable(
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



