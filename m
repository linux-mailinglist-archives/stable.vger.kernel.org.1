Return-Path: <stable+bounces-241513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGRqLHN78GnMTwEAu9opvQ
	(envelope-from <stable+bounces-241513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:18:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17040481335
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317D830B5BBD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1343E9F8C;
	Tue, 28 Apr 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GRSO+vhO"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67C3D75B6
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367117; cv=none; b=hM47YRHivaK/994Z1Sy/fnQcMmXAR21eDkHeiJA/U+W+5ZSRvn1OVUuvD604HlmvYj0mnpXHJNXq6x41OYOIL3AmVtxmCuBZ4o6YcVp6cHIv9u3nHl8jY2CjNSnk0HLm947WEeXlWBoDlT19XwXnDR7CN4JAtw9lfFeacbGFVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367117; c=relaxed/simple;
	bh=nvFAaw9D+G/TgBTpEZf0cSS3I2VcMUf+GVUDncHtMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZNmTFp+X+4YuVXO/77J0WqUGJgXaLMlwQssXRgOfAFPD/eWireUbAELlps5w71M0ggbW5HbRuQSCeOzvhAdir9mxEL4TcBRrXI/9XJ/BXov3kalBxeMMgBF0JuWoQC8xeR61+IqGym4ND07RCDhV19XnOYx2zQ3XRT/CELo6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GRSO+vhO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7E2BF4E42B61;
	Tue, 28 Apr 2026 09:05:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3841F601D0;
	Tue, 28 Apr 2026 09:05:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FDD3107285DA;
	Tue, 28 Apr 2026 11:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777367111; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=p1EUV+7JqOJA6Mt015DMFL7T8iYybFOyWHpjGpeH4TQ=;
	b=GRSO+vhObFNOumMrxBJsyWAYCLh4I1FeO7jD0Gv1slaTl18QmGh6eA2Lyg/fjECGJpXTP1
	c/C/dSBBbXXPSh1wO/kHUN0OncYt3elltbFDswXm1NQX315886PpbYXN7zQFLTvZmXXRnP
	XQBpuysoqnApXKqO6tp5ngDaIB4vny8HIE/gexbupVMKpECN7th8jJ9xV4enpXK4m+L7dJ
	WxQirP/4aUauaHD7sQpc3bBrxUbgiTGhcBBPmkdRIfpO9r7EE9xafeVo261eLKAHtSC3ro
	Jg697rCx16eJ29OCdNtm8eJmG7k6/zmkan9DW+em/IRUkDpi0+D5qosHIPDRGA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jyri Sarha <jsarha@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Bajjuri Praneeth <praneeth@ti.com>,
	"Kory Maincent (TI)" <kory.maincent@bootlin.com>,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Russell King <linux@armlinux.org.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/bridge: tda998x: Use __be32 for audio port OF property pointer
Date: Tue, 28 Apr 2026 11:04:56 +0200
Message-ID: <20260428090457.121894-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 17040481335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,bootlin.com,vger.kernel.org,armlinux.org.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241513-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]

From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>

of_get_property() returns a pointer to big-endian (__be32) data, but
port_data in tda998x_get_audio_ports() was declared as const u32 *,
causing a sparse endianness type mismatch warning. Fix the declaration
to use const __be32 *.

Fixes: 7e567624dc5a4 ("drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding")
Cc: stable@vger.kernel.org
Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 367a46c057e41..6c427bc75896b 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1762,7 +1762,7 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 				   struct device_node *np)
 {
-	const u32 *port_data;
+	const __be32 *port_data;
 	u32 size;
 	int i;
 
-- 
2.43.0


