Return-Path: <stable+bounces-244542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN5vLIhl/GmGPgAAu9opvQ
	(envelope-from <stable+bounces-244542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:12:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 168BE4E6881
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AE7302D5C5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6153D34A8;
	Thu,  7 May 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb2VjgOw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA53D3CF0
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148527; cv=none; b=I9otnj+ZLDkMyGsXk4VG742YOVeGI9rAZu4fi3mlTcWq6XcLc9Qj6OOoMsWG79nZoq7nCGMxGUIjYs7SYLqSr7YKgUqTUP9MGBAtt/wsYM4K7k1eupG8Y9ygaTPJlE/d9Y0QTBkCnXIFYJ3WZHQKInZfpcdTsh6IkapPSk/yJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148527; c=relaxed/simple;
	bh=sW1pkhQalveqOxhHkFt5QmsQqGRnLmYPsxwediic4l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNSeBGjmXm7FU/VDtrOqCKFgDM8G+UtWbqgaiHYgxDCCIfx99JPTPwRcTx+hSPGY0BPPZ7jt6LLU42F/xI4mKhri0wDnlfoT4ZWUmVbDhiCX2BaTK9xF1qOtHVs2VhxM5fVtWFjyfXb2xLVS7Y+14ZLrQbcUMawXhKClAUd59cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb2VjgOw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so232708b3a.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778148526; x=1778753326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lca9GgtebxHSmlkPkYgy6Y8kn+w8BgkxfJ8muffjImk=;
        b=fb2VjgOwXINI7XE5ku4vS4fFqxzOkJ1Jn7MGe/Kv2kVVIiw6/OFD4hjj8Qbh/VN+Id
         TvgOl185mUGnm4U3xpHJ1SdPcTD24mPzAhOoQO4CJDEdfXv/pGY8LK0yj9NqjZPRIgN7
         0iWYCwoT7lJ5TbE3XxHcEdGjMQQu4s2gqGfufhMTUtXfTpiRNWbARK2u7MM/RkKnHM6J
         sCx+cr9+reH5VflvZkksU3n3uKYa/H0NkCvPAJcpprtfbowprkXX4nqEEyn6hwkCL8q+
         /aXbokQkaEvPR3K1jnJvAC9xXhQ5ApQrCKDu4s4GIWyNJQLUrJ9l1DaA7ehYdu/9evfY
         jbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148526; x=1778753326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lca9GgtebxHSmlkPkYgy6Y8kn+w8BgkxfJ8muffjImk=;
        b=fhrF8P+YgZ5NB8q0yTrAUqQCodRttQidzPrHSII6YlE6dG5QNKMnhCAoblEmPyE5Ax
         Adrsx4D8GqUAu4E9hEA95EPskwryJX6c2iL9yUFQ4KA2y1SqGa5S21e3MTvsExKVzrll
         ee6Fmy5AtGV7boIEuaN5uS4L1KVFRcQ8av3VzJnTE09PqlX/qaOoZ+A51weN+Et6TctT
         ueQ1BFO00Dn6kqnY9F71svSksi0IdWbryBWA4ec/yroBA4SzNd/y2IE/WuoF25DlM1x5
         lY4qYQluyj2/x/Exg8NKgfsYOHTaS5WxH/Lt1CIyXj+F3XUjQMttbFeMAb3g+lDt50+v
         RhFw==
X-Forwarded-Encrypted: i=1; AFNElJ8fEp0ef6uWQJrfhmGK2At1AE/AlEqatolgYP2RbfgGQlf4qz6z1iobzSroNghl9G4pBZ3jjJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRU9AeS/JtFF8ZmIKYoYgKPTvH089On8bxe3mbWJDm7SQRqAw
	tz9fb8K2eAwlaKyz0/K+QT7RqMhj9/JdKb/VXTI+ty4njsrPV2BFvjQt
X-Gm-Gg: AeBDievZvZaOKs838wu7xqGT27oAH2h9UQUDYJiWUClf1YXmD6lEeMxYnwtswMLgUKQ
	jJgc/bmrB/VtGgw7Qy833gzFeuON4PeyH5W6UodBuz8I6/oM7DZYPv94I62DourgNDSN5PPysV7
	NA/oiGIrOKCyMPBrhGxysUiyLtDik4yeW3L/ZlL5DiG8E/Kt0lGOEh83/6LWs692Zp8gm7EITfh
	70nNxHWKz98+kxCs1y7UpYOLsRB1S/LCCCuMEInBaHd4KFcx1ZrmYPeJkTwso1/rVWvwcJ4sBI7
	AQ4ZJRLlT1K/HPV1IGRwqoKqqNO+gpux3mCkymjz0iQq+Zfmqy2YIfkoiU6zcwGV92V7GlYLweS
	u4MX0hsq+avJN32HRMEeTa4XTNQW4VE5JKnjfH0blpwEaprT1XRuEEsRzo/A7ePAeE+99AgrKaA
	Tiu51Pzrn9bIoulxKS
X-Received: by 2002:a05:6a00:22d5:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-83a5d387595mr7014546b3a.32.1778148525580;
        Thu, 07 May 2026 03:08:45 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d38ab5sm10162541b3a.26.2026.05.07.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:08:45 -0700 (PDT)
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
Subject: [PATCH v7] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup
Date: Thu,  7 May 2026 18:06:03 +0800
Message-ID: <20260507100604.667731-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 168BE4E6881
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244542-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
value in a __free(device_node) variable before checking IS_ERR().
When the function returns on the error path, the cleanup action calls
of_node_put() on the ERR_PTR() value.

Do not let a device_node cleanup variable hold error pointers. Change
imx8qxp_pxl2dpi_get_available_ep_from_port() to return an int and pass
the endpoint node through an output argument. Initialize the output
argument to NULL so callers hold either NULL on error paths or a valid
device_node pointer on successful path.

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v7:
  - Rephrase the commit message sentence about output argument
    initialization as suggested by Liu Ying.
  - Drop the unnecessary sentence about keeping explicit of_node_put()
    usage.
  - Add Liu Ying's Reviewed-by tag.
  - No code changes.

v6:
  - Change imx8qxp_pxl2dpi_get_available_ep_from_port() to return int
    and pass the endpoint through an output argument.
  - Keep using __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().
  - Keep ep initialized to NULL in imx8qxp_pxl2dpi_find_next_bridge()
    to satisfy the __free pointer initialization requirement.
  - Do not add cleanup action usage in
    imx8qxp_pxl2dpi_get_available_ep_from_port() or
    imx8qxp_pxl2dpi_set_pixel_link_sel().

v5:
  - Make the fix minimal for stable by avoiding __free(device_node)
    for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge().
  - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.
  - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().
  - Drop Frank's Reviewed-by tag due to the implementation change.

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

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 40 +++++++++++---------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..d64e328bf542 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -222,52 +222,58 @@ static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs = {
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
+	struct device_node *port;
+	int ret = 0;
 	int ep_cnt;
 
+	*ep = NULL;
+
 	port = of_graph_get_port_by_id(p2d->dev->of_node, port_id);
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
+		ret = -ENODEV;
 		goto out;
 	} else if (ep_cnt > 1) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "invalid available endpoints of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-EINVAL);
+		ret = -EINVAL;
 		goto out;
 	}
 
-	ep = of_get_next_available_child(port, NULL);
-	if (!ep) {
+	*ep = of_get_next_available_child(port, NULL);
+	if (!*ep) {
 		DRM_DEV_ERROR(p2d->dev,
 			      "failed to get available endpoint of port@%u\n",
 			      port_id);
-		ep = ERR_PTR(-ENODEV);
+		ret = -ENODEV;
 		goto out;
 	}
 out:
 	of_node_put(port);
-	return ep;
+	return ret;
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
@@ -291,9 +297,9 @@ static int imx8qxp_pxl2dpi_set_pixel_link_sel(struct imx8qxp_pxl2dpi *p2d)
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
-- 
2.43.0


