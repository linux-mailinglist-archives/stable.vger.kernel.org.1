Return-Path: <stable+bounces-244012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HpMMi+q+Wky+wIAu9opvQ
	(envelope-from <stable+bounces-244012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:28:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5304C8A90
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428AC3012270
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE23D9041;
	Tue,  5 May 2026 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMFhXYW3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B75362120
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969333; cv=none; b=QwE76dlkjUHKE7KIhmsNZFiKVXIouUWNPLrxRVnN3xfmUIGYmYgwt7fpFpnnTJZdvyytbun4zNK3LZMT0nZJJNec7SSZ1nj8qspeIhsFmGqL7NUPrJrWiFwimiDOtEfjyGdJg05befnSHdbJ+vPM2SHJK/zcnCIKqpLbAkHdglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969333; c=relaxed/simple;
	bh=nK0j9juRgg0ZsV/8NnbWOopdIAYdgSZX1Hdc5+iIKv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmSg04VAT+5ahLU4pi8eHeOuXGPoySHnzUkpS62MUKFzaWDjkZudWsQ0c9JFWuAR7frDz1lMHi12LG6IbTX9f/T06ey6jJyfz/LWTbLtqmefN9vsxPqeX3Tx2gs5Id6PaXBxpCTl3ztqlHwGLaVIAyorr3XGuVgEyzSglkfXM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMFhXYW3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36520a83186so1795733a91.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777969331; x=1778574131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoyB8695OKHFJLVaXhyFdUBCqi4FGLL4BEcb0wuk4uw=;
        b=UMFhXYW3y4u+5Dq8e06YMmJuX+yiW15+IJNj66jpctXwvGjGZISCjyN4feDoKr1S5o
         QRxlTzM+MNFwpsXID9pUwbVbJDSLKa2KNBC3BSshCOOxO++W3WOYkR0b36suRjNWSXqa
         n4YnzW6j7CF/lrxyI62NP1fvuuV9DD0xmXKBu34t0LgVlVje2f6/SaTsD4gnDG1JnM0u
         QoT3iycV4L8NT14f/vTabGrAqMg1/DWTmBKY4rGuzkdvy6SyE5CaHvSZdYBGn/rdTk8D
         u+c7knmpBzI83H2aUj/NxEuTkZLsNg+xGkCZYh1TKwqZr408nkBMQ5p74d4E2gZw4x+D
         QM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777969331; x=1778574131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoyB8695OKHFJLVaXhyFdUBCqi4FGLL4BEcb0wuk4uw=;
        b=o6kr9pnOW/KB2C82qrlk+TWJiLJbY7z2Fi3TekI3U76TI+MUvsiBYwueVRIeG3SDVv
         luxad4BzceM66dzEV75wmiXWvahDPvu1E2imKaB7gvYcvy1UoijPVsz130JPPDg0IRX3
         X1Bvb3ILefVT1HH8NKLwMMR4tZxNp7LtDOqRdLPcxCkG/SPbMGcbsQFw3gMosOfNC/OH
         rp5iu9U2nXv4BKpgLfACbVdy6TDwfyh3Q2Fw2b2hZoKDnG0VkNfSKHMsHS75fRJA6qYA
         LNRvr5NvjY74WtpwcNYToWso/mInhqWC30IYRJnnZRJnPhqh2pbIeiL6yTC4LUebYLfC
         oJow==
X-Forwarded-Encrypted: i=1; AFNElJ900TgJn4xXtpuYSBqO7scMd66NtjOayWn6JKCtG7YfQyap43PDRitW3rVyw/NbgPCKurd7oWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaokzwGgHx+3IVN4SFGk+MGQjZCkS/6vwX0jvWQA54/0VyuYO
	0tATnXEJpNtCFVTSWmVENOQLOz3t8okkpP3QltewifeGXxUvNuh7gjQM
X-Gm-Gg: AeBDietumQ0s0zs/7yyHMJFIT8QL4/1Fkk7ErbVHBcR3bPVfagieSYkseGE9tUO+Jk2
	cbB2ib9MjLXm7wyT6Pwp0Pdko3/Uk+Dxe49k45x/GLpkCg+VQO0SSHLSucqmBtMQNJEs0LRA7tp
	NO7bY+6/JtZFRm6e74ZxfF60hoJ/V0yqGeA6QQ8Wvv9gUiTm1I1X8YJkaJTciRtpqvecIcT1Z7S
	qNlwOPtGTmmoTWEjYFEJMWsE6Kqb4wzaH7V4PJ954c6e+UR71e/cO7MqrCkWZNXw4A7xG/pTpz1
	QlB4KtZCoVUTCYDWJvDeXNTyY9ilyPXmlFE5dJSTq9qa3uL23bkVzNT1XCv5j0QIGm4IpjaVhAN
	HMdTLvdcc+xtJ8EdIHxFqYY4KYFQmOohUjyPGoYnZyk9sRIlliBDwxY5nUrcjnrqB49nIYvJ/xZ
	91Rj6Bcjar02rdc18SvhkYJoxN
X-Received: by 2002:a17:90b:3807:b0:35d:95eb:879a with SMTP id 98e67ed59e1d1-36577487bccmr2309864a91.13.1777969331396;
        Tue, 05 May 2026 01:22:11 -0700 (PDT)
Received: from lgs.. ([152.32.133.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3650e94126dsm11439814a91.5.2026.05.05.01.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 01:22:10 -0700 (PDT)
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
Subject: [PATCH v4] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup
Date: Tue,  5 May 2026 16:21:45 +0800
Message-ID: <20260505082145.603262-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A5304C8A90
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
	TAGGED_FROM(0.00)[bounces-244012-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FREEMAIL_TO(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.953];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v4:
  - Drop the sentence mentioning the custom static analysis tool.
  - Add Frank's Reviewed-by tag.
  - No functional code changes.

v3:
  - Do not change DEFINE_FREE(device_node, ...).
  - Fix the driver pattern by making
    imx8qxp_pxl2dpi_get_available_ep_from_port() return an int and
    pass the endpoint via an output argument.
  - Update both callers so __free(device_node) never holds ERR_PTR().

v2:
  - Fix DEFINE_FREE(device_node, ...) directly.

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 54 ++++++++++----------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..881ebb811eb3 100644
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
@@ -287,26 +287,24 @@ static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 
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
 
-	return ret;
+	return 0;
 }
 
 static int imx8qxp_pxl2dpi_parse_dt_companion(struct imx8qxp_pxl2dpi *p2d)
-- 
2.43.0


