Return-Path: <stable+bounces-225904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FpjETBOuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:50:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13E2AA1FB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC9B306CC1A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891943C456B;
	Tue, 17 Mar 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2vw2FCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B73C196B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751811; cv=none; b=g0vY6ymJ5vURNNfQ+Vm29s+D59oLOty6+f+FLN98IHGZ1RQWo8OBr8zTEBriLOZZ6Rq4VpGI4SFimwjKyovENb9u7ZXLMq788CuBASHFvEyE50ofoYLUZWhFJ4Bzqgb6NYvhyrBxS83lThtL18T1g+/xDQuzZ0WbUKdGhnWpdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751811; c=relaxed/simple;
	bh=zDee8HSdI7t8xOcOVQFpyNEi094dYR+TQlwCM1XLghA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E06f+rMKiBG9klEamk6wAT0cesEiywPYodBD+5EHIDf4bj9Lv7qg/v8Laf1JVX5g2nBhWPtXxTUhuaoUeWXKNGN5Bcg2HeEeteIyS8LZXyHcGeVjiyK0c7KP9h2Q5UtCOv7nVupHn9o/qGmqfPfGp3yhLpKxzWxII18t3niOAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2vw2FCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56284C4CEF7;
	Tue, 17 Mar 2026 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751810;
	bh=zDee8HSdI7t8xOcOVQFpyNEi094dYR+TQlwCM1XLghA=;
	h=Subject:To:Cc:From:Date:From;
	b=b2vw2FCxAADhHttwD0uEAWKIqOTO8j1hIg3N53VrS6dY85+CF6apILX+8lZ0SfelI
	 W7iFc8Neg/gCCo0L76U/gv4O9JGroj27AclJlwVg3wJB8hsiG310/XMWkN3XAIRSb0
	 IRgSbGEkn3E3F4EXhDo5cjRwflSkHQhFGSgjaeb4=
Subject: FAILED: patch "[PATCH] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding" failed to apply to 5.15-stable tree
To: luca.ceresoli@bootlin.com,marek.vasut@mailbox.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:50:06 +0100
Message-ID: <2026031706-track-prevalent-493d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225904-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,bootlin.com:email,mailbox.org:email]
X-Rspamd-Queue-Id: BA13E2AA1FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2f22702dc0fee06a240404e0f7ead5b789b253d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031706-track-prevalent-493d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f22702dc0fee06a240404e0f7ead5b789b253d8 Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 26 Feb 2026 17:16:44 +0100
Subject: [PATCH] drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding

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


