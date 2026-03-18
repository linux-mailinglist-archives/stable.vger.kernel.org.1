Return-Path: <stable+bounces-227094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kExmCLu/umkGbgIAu9opvQ
	(envelope-from <stable+bounces-227094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:07:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E82BDDC7
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E0B4308E633
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87A36BCE7;
	Wed, 18 Mar 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyTJYUMb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CC3DB64F
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846015; cv=none; b=OHKRMlOCbo8M5HCvicG45SMBC0kBLzj5hTey3c/5RO+VDM/tV0fbVQcEzmOEOrymhVDBpDYILbMcobSlWEz7XY98yULCfZQNWP5t0wv4eEwAP8RqSDd2p+3igODhlY9L1LvqItz1EPBpSi9uyrdnl13IS8ykrQeIAAjtC+2kK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846015; c=relaxed/simple;
	bh=3sxjWS3rwmhPhZzIQUg9/BWS2FvFgKn5GPUx/l8sz9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+t00FKvu1Mw0iU5DREk4oOPFBSSZKZkbuzbly5DjLxNLQom7K8SMQjqPwuhN8l3d7ozNF9y/ZG746SGqkLhSOzvmyXc4wj2Ymfdv1AxGVLeEytGhVMTVl+bxIPwT1X58SzfVfyVmyulgNRUzuhbqqx1bS6MB1uxQBBlBJTXIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyTJYUMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E15DC19421;
	Wed, 18 Mar 2026 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773846014;
	bh=3sxjWS3rwmhPhZzIQUg9/BWS2FvFgKn5GPUx/l8sz9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyTJYUMbYaQFvLdciwXeN+fyWch1WkNByr0kyJyfxiKyaP6b6JyYBXKF78QBM6WRK
	 Smgke2diMQ2PLOqBoe+HOO9uNBRXP7j33+Zj96LwgziYUPXcmvCb3/kVfZ6GMrBtl6
	 SfDA0VokNXgd9tYO057q7uWKzZWI6tDX36jbHK9T1hT60QlcBTrJBX4jsEqIU/1dHj
	 lq+G4UtYurzKF9V9Mdvbd/80ktY2QiiYOtJjG6Iu0Snpp2T4GxmU3nwpjAISHRZ4Jv
	 XbSO/xFmOpkWQR+J8yjUEb4xki5khCsYSCPoBSHem5wzLXmnEJpP0oJJzoSzH4HUms
	 3HZVdN54dSkUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
Date: Wed, 18 Mar 2026 11:00:12 -0400
Message-ID: <20260318150012.859558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031706-track-prevalent-493d@gregkh>
References: <2026031706-track-prevalent-493d@gregkh>
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
	TAGGED_FROM(0.00)[bounces-227094-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 826E82BDDC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit 2f22702dc0fee06a240404e0f7ead5b789b253d8 ]

The DSI frequency must be in the range:

  (CHA_DSI_CLK_RANGE * 5 MHz) <= DSI freq < ((CHA_DSI_CLK_RANGE + 1) * 5 MHz)

So the register value should point to the lower range value, but
DIV_ROUND_UP() rounds the division to the higher range value, resulting in
an excess of 1 (unless the frequency is an exact multiple of 5 MHz).

For example for a 437100000 MHz clock CHA_DSI_CLK_RANGE should be 87 (0x57):

  (87 * 5 = 435) <= 437.1 < (88 * 5 = 440)

but current code returns 88 (0x58).

Fix the computation by removing the DIV_ROUND_UP().

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Cc: stable@vger.kernel.org
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Link: https://patch.msgid.link/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
[ adapted ctx->dsi->lanes access to ctx->dsi_lanes struct member ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index f96c0a89854b8..2c02326421133 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -348,9 +348,9 @@ static u8 sn65dsi83_get_dsi_range(struct sn65dsi83 *ctx,
 	 *  DSI_CLK = mode clock * bpp / dsi_data_lanes / 2
 	 * the 2 is there because the bus is DDR.
 	 */
-	return DIV_ROUND_UP(clamp((unsigned int)mode->clock *
-			    mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
-			    ctx->dsi_lanes / 2, 40000U, 500000U), 5000U);
+	return clamp((unsigned int)mode->clock *
+		     mipi_dsi_pixel_format_to_bpp(ctx->dsi->format) /
+		     ctx->dsi_lanes / 2, 40000U, 500000U) / 5000U;
 }
 
 static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)
-- 
2.51.0


