Return-Path: <stable+bounces-242596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AtsBVTm9WlNQQIAu9opvQ
	(envelope-from <stable+bounces-242596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 13:56:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D14B1DA9
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B53300AB1C
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEEF13D51E;
	Sat,  2 May 2026 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxIrZqMe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADD32571D
	for <stable@vger.kernel.org>; Sat,  2 May 2026 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777722957; cv=none; b=RAfRChWYBT7yaDletNE/nf0acd4SfShIoOcUobVvTp95/v3pBE3wFQ8N7MFcubCs6E8xSOqDIWXZ5V4b2m9l+nnGro+63jqI3zkbEn2O3S4keoirMfeKEaTDErH+Q4vx0aGYUl6b+VGTxyYH5eTJHgsPwomfrqLiK+2Uo+QdE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777722957; c=relaxed/simple;
	bh=ukA8Li2hr5tYPQA6gEHOkrrU1Q0/VLBNSU8rcMwrk4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZbFhISY0YlY+RsZAcZi6OBXqXsxDMFx/hoHwFE0+z4KAMkLmfyk58gshlARUC1wvJUSYl9GEVq6ryRh7rDhVnhcDlXvYbXU2fU0szvVZGZj72AlTXNVj9lwGWjsR2cu3fEz6N/QWQHt0bm9Z/PY1cEWnNaCXoUCytPLKQzBRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxIrZqMe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so1127218b3a.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777722956; x=1778327756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xG+dopoE7tyttQuw5xxPLAnkXqhbsfbklISoHSefbCs=;
        b=oxIrZqMetV0Fgovvw6u2z22RjZ879JLPZWx1fWDINZ2NX4YTp0pYCr4wDNJpl3q44X
         ANHUkXikK4OTBzkpQjYbqfU3V2ZxL4rQFh1IOsvZ00ic2s0TRfDoBDszQXLHjPzvJIaW
         o36Mb7UWOIzkdTdI8Mxzcdhvzf+3giTDfbG1lwfiOe9KdadvF07dzdgzHYsGDuibmJW2
         0ACsfFFEOxcnp6deLXfGezb5Vq8yST1PqCk3E60C4Du/E3UT9eBwPqOUVHx+c77ESp4z
         447l78sm/CiRH+f0V36N38zD6CijVZjqHJa56ooAQQURiCdj8ARhS34+l7ctUYeP/keb
         oA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777722956; x=1778327756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG+dopoE7tyttQuw5xxPLAnkXqhbsfbklISoHSefbCs=;
        b=Iturbrokpui/bhBQk+5OJAwO0QVxWrTK2ZBQr0g5qevZzrzKa+DakVw5dtlbbypHlx
         pDyGXyNPMQNwNbfkktUQVSVDHyK2mSswFvO65GM0vF3m2MusqjjFuzvKLBMH8qAp5guh
         lF4AYIrK7PaDxjxsp4amZObnw7nfeldKFFk40jtH+T0hgVJkzdWG6Tz26imWLH6N0KFQ
         zRWAfeWj7tNuvF+X5IX46A6kyl/bHXFMSoXDOxSQjbayw++qa50FxlwZcQxHH1R2fixq
         +0x4Mf5EIKouWhwZDv8RM4rmGC0U0nntFZGBbWGUS/nnddwwfcGFrXtMQ7vwdH1KmEcx
         l2qw==
X-Forwarded-Encrypted: i=1; AFNElJ8hVYWkdrcRY0n8Fyh/tL5/CO65Jf/nGQa9AnCwRO4wsyJrMhKss16AdblmQ43YRb5xSr3tlVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7Dg6vFzEaFrHgNF1TiSvdfBbylywaJJ1G0DwqFW6HNHkyV1d
	Y1B99j8QGzrNedwdxZcb2LXNL+Uz8+yw8d4Vfz+ifoBbsmkmR9hEP2EZ
X-Gm-Gg: AeBDietgW/NyZO6nREX1xCC6TNwa1HeOFRi3b4wIj3qWDz1PriU9c6DWHX9zRiLmupV
	jpr4aQHasQuCQSN5c/JPWEXU6RpxVnX+6pfrTQIqObJrU1AQ9/vL/aJU64x7vmgPsAvxqA9HzCD
	bqWCmUrLqv45jlMT6NtQTJ9m0z6SSXOjMK4nmx+YYl2LhcwGkEHsbgg4ijzltKDlaStGTbKDVeA
	ZFDnGKWJ3yldRRGUuSX0GbCbfOh0YU9OSV/Yn81sie5G4qjf3TtBQGEAe7voxDT8jsCEzOtDs+l
	z1PWdpyIsTNv+t+dJX7MTe0eGj6HG5g4TIdsrQq+cxAgiCYxlis4SNHAKgkM1R5rMzWMLSCR+Sf
	3oJaMK+JdQqwVttPq8/PSHSUWb92oA9GYkRuJhggLqmLaTyqIJiTPRKgVtnCMONjkL+thr0GCOI
	XIc/QuusWkXB/TEzOq2vqRkhWF
X-Received: by 2002:a05:6a00:2d10:b0:82f:96ab:e011 with SMTP id d2e1a72fcca58-8352d2f802emr2803655b3a.37.1777722955971;
        Sat, 02 May 2026 04:55:55 -0700 (PDT)
Received: from lgs.. ([101.36.109.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b01a4asm5307663b3a.43.2026.05.02.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 04:55:55 -0700 (PDT)
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
Subject: [PATCH v3] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup
Date: Sat,  2 May 2026 19:55:28 +0800
Message-ID: <20260502115528.530401-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 692D14B1DA9
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242596-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FREEMAIL_TO(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.893];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Spam: Yes

imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
value in a __free(device_node) variable before checking IS_ERR().
When the function returns on the error path, the cleanup action calls
of_node_put() on the ERR_PTR() value.

Do not let a device_node cleanup variable hold error pointers. Return
the error code from imx8qxp_pxl2dpi_get_available_ep_from_port()
directly and pass the endpoint node through an output argument. This
keeps the cleanup action operating only on NULL or a valid device_node,
while preserving the existing error codes.

This issue was found by a custom static analysis tool.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Do not change DEFINE_FREE(device_node, ...).
  - Fix the driver pattern by making
    imx8qxp_pxl2dpi_get_available_ep_from_port() return an int and
    pass the endpoint via an output argument.
  - Update both callers so __free(device_node) never holds ERR_PTR().

v2:
  - Fix DEFINE_FREE(device_node, ...) directly.

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 55 +++++++++-----------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..a82f10218707 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -222,52 +222,52 @@ static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs = {
 			imx8qxp_pxl2dpi_bridge_atomic_get_output_bus_fmts,
 };
 
-static struct device_node *
+static int
 imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
-					   u32 port_id)
+					   u32 port_id,
+					   struct device_node **ep)
 {
-	struct device_node *port, *ep;
+	struct device_node *port __free(device_node) =
+		of_graph_get_port_by_id(p2d->dev->of_node, port_id);
 	int ep_cnt;
 
-	port = of_graph_get_port_by_id(p2d->dev->of_node, port_id);
+	*ep = NULL;
 	if (!port) {
 		DRM_DEV_ERROR(p2d->dev, "failed to get port@%u\n", port_id);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
 	ep_cnt = of_get_available_child_count(port);
 	if (ep_cnt == 0) {
 		DRM_DEV_ERROR(p2d->dev, "no available endpoints of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-ENODEV);
-		goto out;
+		return -ENODEV;
 	} else if (ep_cnt > 1) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "invalid available endpoints of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-EINVAL);
-		goto out;
+		return -EINVAL;
 	}
 
-	ep = of_get_next_available_child(port, NULL);
-	if (!ep) {
+	*ep = of_get_next_available_child(port, NULL);
+	if (!*ep) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "failed to get available endpoint of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-ENODEV);
-		goto out;
+		return -ENODEV;
 	}
-out:
-	of_node_put(port);
-	return ep;
+
+	return 0;
 }
 
 static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep __free(device_node) =
-		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
+	struct device_node *ep __free(device_node) = NULL;
+	int ret;
+
+	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1, &ep);
+	if (ret)
+		return ret;
 
 	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
 	if (!remote || !of_device_is_available(remote)) {
@@ -287,26 +287,23 @@ static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 
 static int imx8qxp_pxl2dpi_set_pixel_link_sel(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep;
+	struct device_node *ep __free(device_node) = NULL;
 	struct of_endpoint endpoint;
 	int ret;
 
-	ep = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 0);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
+	ret = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 0, &ep);
+	if (ret)
+		return ret;
 
 	ret = of_graph_parse_endpoint(ep, &endpoint);
 	if (ret) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "failed to parse endpoint of port@0: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	p2d->pl_sel = endpoint.id;
-out:
-	of_node_put(ep);
-
-	return ret;
+	return 0;
 }
 
 static int imx8qxp_pxl2dpi_parse_dt_companion(struct imx8qxp_pxl2dpi *p2d)
-- 
2.43.0


