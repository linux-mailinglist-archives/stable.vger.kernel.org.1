Return-Path: <stable+bounces-238637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZaNoAu3I5GkNZgEAu9opvQ
	(envelope-from <stable+bounces-238637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 14:22:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85628423EF5
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FCC730058F4
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759E355F5C;
	Sun, 19 Apr 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5+I2G8o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C84281525
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776601318; cv=none; b=Jtq7xEX9ufS+qOnPQq7zOa5nNpr9AM4J1ODVdNYAF7dr+EcS43X3qg6kReYQ9ricTSv4HP6y1DOTBOVvrr5k6NJXu9OZneMgTf+YsWevyx6W9NS9vqVQZ24ne5XbxMEjA7i0r2oW1zWXmfAg9/PQHjaUcaOQ2i5ZCeb5VrRlY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776601318; c=relaxed/simple;
	bh=nmgKREmCWZiDkKASZtmRc2MVHkFKpfUbB1epmq3XSBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jas3SLD3Hd9lSTRML3UgTbmD2I3XnytwJrJxlT3S0QUy5r6vWOKxfMlBOZDQdzZh5rWZsrTCfkPO5UiHdwNk8YKLBdZV8gxnvN9fGQra82xOGot2uYFbVPyGic1Ej1ExslvnI8wDhVMrf0OoIhuyGfyebosqwoL9RwG/bIze4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5+I2G8o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f8892d4d6so897798b3a.0
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776601316; x=1777206116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmWG7OM2EB7RxxwskQ0/zeTI1Kmre4JByGl1ksiUCqU=;
        b=X5+I2G8oz/+yG4hTU2ZhYBfWqwlcvhdhVmhH6aYXUZ2hR2A5XWKz5yZ3xi5EUv3aTH
         Kash6Y2MHbNjZQ68b9tRHYtyujsDMq1i8jAzBctzdi01dbBrDeWcJIXH1SBu4w/MMlRV
         bP08/jkfoKrTNacumiWVEl7Ie3Zbf+ILGe8VTfdIXXaWU6Mr5oI1Xzc9tsYbeqzOnEkM
         kITO58pPTbHh/pcwEdsjxT7wGFmBQL2yM+phGXdwdbJEGCHTgmZ1vJ4OP5oqQTXd01QF
         QDV7qKEo8JWu6GZYwe1+fnB88j+oQAtrDNNz7P6TfKVrzD2ZMkq8+V5W1LsDwLEk3xR8
         2iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776601316; x=1777206116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmWG7OM2EB7RxxwskQ0/zeTI1Kmre4JByGl1ksiUCqU=;
        b=YH6VX3rcZRUOAEBTl1yknzCD1zz4y5pPzgk6Vptcs/5DeCEc9WdO4rjSr6HECcTmoU
         m40UUrmMOCM3RephAiZrmyuIUT08t6HLaD4AnKP5UghRUQts6htlmsOAq7hNuIjYzWS8
         lqY0SQ9V/2gcMpN4mCrNUQL59FjF354BIHOTcGPHledNn8e6X6EKTvAnCaI7HoqjKBUb
         fI9pWx+IEQk0BJXUkO0O5QuBJN9ormKE7iUejLlw3v9gAUc7ITlFn8DfV/VniuraJjkp
         oHOE6rlrox1oHUSLBTrh1fKFXjtmy5rSjATnJdE0zKS+8LjLKu12i+ka9qDmglRDEiXi
         6hGg==
X-Forwarded-Encrypted: i=1; AFNElJ+v9b10NRf9pX//q7SDuPXtCOgTuCBGDV9HNXGLkWdg2sfCRDoWrNq2D663XjWjIDAt5rV0+SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdNRF3MIVZh5J5cn7adYF5B2tH6O2sTNuaM6foCSm7CzmhOO6
	9iyZ+fG+yvbQ1H0sNs/5HmrtuSP8aGGfx9TnkNed3mc4xqO+EPUFuCVy
X-Gm-Gg: AeBDiesmYInyuN1HAz7Nz6/SK3yNLqOsnKS7LlT5X2+Iuvz5mgrWbN2w6hr32zaAnI4
	11PaN45+xv+gHaD9OmMKyOAxRcmSrBi831GHpajAbzAsMBx4cBIYk1+iLhrKDom5Yv+JZy0oAUq
	HJuGCKRpqvpGgXPCDYtHtAEQVrSIORXfBAzvARFBCvRkCMP/MXyH88xwDNa/zIzLuv1btvQo7A3
	bg1E6/XSxi7p8FxG17KQmzdRa3b9dqqm/QVVy8jOIUH815G4fyGPWnZ6ks8wUmo7TPJYSiW9M0G
	OuvFKfIkaFOICWXLs9lkxZqfqjZiKiKIjKu8DuAdH2VM5C59r1hrVbECURrrFgn9f5fyts8Tycp
	zLBEodDb7u9jkt8flhah8eSeR8SXxF1/deJkrLXAXcRr6JRuVAm7eNeawTMDyD3qmTXT+Uu48eb
	labQN7dKP4TyeVramNS/Xx+1YNP9qr9aPc
X-Received: by 2002:a05:6a00:2d8d:b0:82f:1d38:f68f with SMTP id d2e1a72fcca58-82f8c8bee86mr10893475b3a.31.1776601315542;
        Sun, 19 Apr 2026 05:21:55 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:fc0:88de:ed15:556b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2fa9sm7700034b3a.16.2026.04.19.05.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 05:21:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liu Ying <victor.liu@nxp.com>,
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
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on ERR_PTR()
Date: Sun, 19 Apr 2026 20:21:34 +0800
Message-ID: <20260419122134.97529-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85628423EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

imx8qxp_pxl2dpi_get_available_ep_from_port() may return ERR_PTR(-ENODEV)
or ERR_PTR(-EINVAL). imx8qxp_pxl2dpi_find_next_bridge() stores that
value in a __free(device_node) variable and then immediately checks
IS_ERR(ep).

On the error path, returning from the function triggers the cleanup
handler for __free(device_node). Since the device_node cleanup helper
only checks for NULL before calling of_node_put(), this results in
of_node_put(ERR_PTR(...)), which may lead to an invalid kobject_put()
dereference and crash the kernel.

Fix it by avoiding __free(device_node) for the endpoint pointer and
releasing it explicitly after obtaining the remote port parent.

This issue was found by a custom static analysis tool.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..3610ca94a8e6 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -264,12 +264,15 @@ imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
 
 static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep __free(device_node) =
-		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
+	struct device_node *ep;
+
+	ep = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
 	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 
 	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
+	of_node_put(ep);
+
 	if (!remote || !of_device_is_available(remote)) {
 		DRM_DEV_ERROR(p2d->dev, "no available remote\n");
 		return -ENODEV;
-- 
2.43.0


