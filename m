Return-Path: <stable+bounces-228637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB3eEIRNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A682F4769
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C398303A443
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D03A9D9D;
	Mon, 23 Mar 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWBSqjCi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847F3AE6E1;
	Mon, 23 Mar 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275678; cv=none; b=coYi/GRAzVwdXBxy+o2dAo+jUYxDsgPT51bjVubD9jHW7G8sBBIaa3WH/hqN4iWMwdPWLknucfzvp26wZcSqj7I88wl0DB4D0YWH/g9S4pyzhKlNbzRpj8wNKyUFyQk8oo5Iuku/UetC2HeKcPZA1Oh7v3Oejj2H3SRoQHzU8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275678; c=relaxed/simple;
	bh=LkEa7slegrk/wAQezVnv0xHhtooTfvwqJcjz8M2CxEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyryNxsGwwbSts9nuMXNeeWIKPn9JRci1XN/3PEUobMakUpZzuLnI+aG+Z/F3Ylemi5jhbL7m21M+6fYZVyaZfjKQqYA82lgYO8VPzrIUAHI4s11r32PzDW/JHslR2A3UvpjLoTqOP/EsTTnqOpVGPZkFXbpUvWqQH6AJz2R13U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWBSqjCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58055C2BC9E;
	Mon, 23 Mar 2026 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275677;
	bh=LkEa7slegrk/wAQezVnv0xHhtooTfvwqJcjz8M2CxEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWBSqjCiF6B4rMmY18KW20ZlOGIf49qf/C+GCsmRuzIeV0ijQq9uUaUlIUEHSWueI
	 Jqk7RRssSI4WLWdGT7D+99iuCoW1Xkt8/q9LvEG50/r6m9gOKOgT2V/3r+VP75qG0M
	 u+n1jynIJcz1HG2OvzjXa3PDEayDyqAD9Dr4Evog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut@mailbox.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 6.12 180/460] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
Date: Mon, 23 Mar 2026 14:42:56 +0100
Message-ID: <20260323134530.963988066@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 56A682F4769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

commit 2f22702dc0fee06a240404e0f7ead5b789b253d8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -303,9 +303,9 @@ static u8 sn65dsi83_get_dsi_range(struct
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



