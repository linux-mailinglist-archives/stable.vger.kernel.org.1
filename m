Return-Path: <stable+bounces-226566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDr4BaWKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BAD2AF08E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 602DA304012D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D573F54CE;
	Tue, 17 Mar 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luMhOWOZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051853F54CC;
	Tue, 17 Mar 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767257; cv=none; b=fAjVR5qwPjJQag8E+yDV27gC/Ho3STEI62++2k8Y6P6tIhNDEI93yyndM658PWj/Q3WeICo3EaQgbybtwqinz+3KJ4E/fjUWtpwWsBsOEwYrEOKd5X9wp8tuGISMYh56KwjzzDKqBtLsP+qLMMIFISeiCn0tmmtaXrqCuYp1w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767257; c=relaxed/simple;
	bh=L06UK78W4Chihhu98aKPBY7sNR3egVNvrof7lSmNKxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCCeqUlAonTaE/AdVtRs6iWnPpGiKIrSYjjL+76dCGnb5ZT0K0nmCm4vpIwzpn6a5c4J5bTViuchTEJEaTPOsaBJxikkJpJ2OL5r3Bd84hRPbvVrKF3Z4ZybZzSI947MPVvl3jzxmHWGhbkU/ATT4+ZnM3ntQDy7JiatLo5YPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luMhOWOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EE0C4CEF7;
	Tue, 17 Mar 2026 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767256;
	bh=L06UK78W4Chihhu98aKPBY7sNR3egVNvrof7lSmNKxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luMhOWOZ044KpymjM8mEaCS4zDlZ37MHq+ZaobkjnvPz3d4X5dFCeqaUpFv9g2Jjw
	 JZmodd2Iqol+GG3UyYDeXsBtOD8LTaJTfzal8Z9vksqVqnHurmDCTkpgEAKsDMm5ze
	 ucI1Tb/yd39fNqnIU726c6DVlHkTqjl2caDOlikA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Lechner <dlechner@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 049/333] drm/sitronix/st7586: fix bad pixel data due to byte swap
Date: Tue, 17 Mar 2026 17:31:18 +0100
Message-ID: <20260317163001.183762430@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226566-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,suse.de:email,baylibre.com:email]
X-Rspamd-Queue-Id: D4BAD2AF08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 46d8a07b4ae262e2fec6ce2aa454e06243661265 ]

Correctly set dbi->write_memory_bpw for the ST7586 driver. This driver
is for a monochrome display that has an unusual data format, so the
default value set in mipi_dbi_spi_init() is not correct simply because
this controller is non-standard.

Previously, we were using dbi->swap_bytes to make the same sort of
workaround, but it was removed in the same commit that added
dbi->write_memory_bpw, so we need to use the latter now to have the
correct behavior.

This fixes every 3 columns of pixels being swapped on the display. There
are 3 pixels per byte, so the byte swap caused this effect.

Fixes: df3fb27a74a4 ("drm/mipi-dbi: Make bits per word configurable for pixel transfers")
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20260228-drm-mipi-dbi-fix-st7586-byte-swap-v1-1-e78f6c24cd28@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sitronix/st7586.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index a29672d84eded..055383497aae7 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -346,6 +346,12 @@ static int st7586_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/*
+	 * Override value set by mipi_dbi_spi_init(). This driver is a bit
+	 * non-standard, so best to set it explicitly here.
+	 */
+	dbi->write_memory_bpw = 8;
+
 	/* Cannot read from this controller via SPI */
 	dbi->read_commands = NULL;
 
@@ -355,15 +361,6 @@ static int st7586_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	/*
-	 * we are using 8-bit data, so we are not actually swapping anything,
-	 * but setting mipi->swap_bytes makes mipi_dbi_typec3_command() do the
-	 * right thing and not use 16-bit transfers (which results in swapped
-	 * bytes on little-endian systems and causes out of order data to be
-	 * sent to the display).
-	 */
-	dbi->swap_bytes = true;
-
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);
-- 
2.51.0




