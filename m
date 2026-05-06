Return-Path: <stable+bounces-244352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGr5OcsI+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:24:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2D64D8900
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF213004C64
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04003DCDBE;
	Wed,  6 May 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0SznP2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC153939A4
	for <stable@vger.kernel.org>; Wed,  6 May 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059431; cv=none; b=Xm9Ey0fF+2cdFf55iyuqTrT6fh+jZuV2caSkI9moFuN8t52g+o2vH5fdcHSSothZdoofA4jJMqEDnF8ct1iLNVAMxfkgd/rUzpF9cA7fOdvfXdjmdo5YMoQELHABzwpkd/NU0b/9hGjZXcH1qlO5mSY64++vJaBQaf+Cy21iSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059431; c=relaxed/simple;
	bh=/JlcOXBa4uakAjtW7+ZH++g1+Oe2RazEmev44gZjRLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2BFVzy69jAjIQE08SSbL6UteQPwp9FAkM00UJ+jkfK1bN5FKpm7yFQalRYWXjO1zCID6AdiaD0XqmG4W+Gr11G4MDuFhfLadMwhLIpzRxkVTrgY/UYaeQ+TvWWSjvviQJKSXwjI6zLn44ghBtS6QRsiz+p7h5DjZ7+LaXCjIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0SznP2p; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so4829467a91.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059429; x=1778664229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//nou2Qb1FnpkEvM0SdcsiAXuxlLxSwwu1Tjy8/lIKE=;
        b=L0SznP2pyf+XQqe9WoF4IPyxSvjsYVAVXqo6lPUWxsmSDcz11nuzYqTNk+I/9fHI3x
         0feOF0WXGPFGI9uZVZnSa6l9/fm0yzd05p7C4a4eJq0sSZtBHVOdE24/yPYiP0WU3Amz
         4s5U14sDESIrwZ+5oshZgioV64nGGvi84vaPn/+3D+Xj1H7nnyxJRkImOY/EHv/5+UBa
         eZHLMzkdwkGHLbTN1ELSm2cIQHV36/hfQ6LT+lbQzPx1zxGsBTCgo5s4u8GCzVVhVpO2
         50Gf2MZwQpuR2TZBH0omrz3s9okCFs4Bce+po1ZprfxHuqSTzg1hsT9Rc98fII3eVahM
         fwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059429; x=1778664229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//nou2Qb1FnpkEvM0SdcsiAXuxlLxSwwu1Tjy8/lIKE=;
        b=KQRyLnXler0uS6sjIW/ea/UnUyIoHF43JKhz8wNXhu0J3baHexlnWLuzdFJdwIuTD9
         8a8YnTDwKcPs54CXWCvv8mF4suH6HAZFTqFckgWZJsDU+o37xqiFbA6ZHLDj0Z5B85kO
         DY/CdRBHFtHMZkU2HesMUKmZsh9ymSIfFQDZMm1UhTZ8JsXKyva7nWkyVZNtUAeD0npA
         JLIEe5B00SIde0JzgcxWW2PzYuoqDf1HSPMKsw3UubX4xjOVQj2oaQZp/s4427KBRd2c
         y+0BO2NUJFpFHeVRuRqQK9gs6tADhihQbvnLqkQJyZTRW+MTLroImyfwJHIhaO6ypPuZ
         98NQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BhwSJCXJcuRVHh1lohyUoB1HIgyPvnrctQTVQw4bgtroeX2nblmkEZO7WbJ+2ZTAR5Xo0h9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEWdVe+pd+uWI7gjHUC2BPOtZeYKGH9zVxR4o0XM7TBUxdbx4
	Y/O4bPuyClu6TkVs7OhN/Yq5ipMWHqUkUDVJWPSolDfUVsDVEkTcKSSe
X-Gm-Gg: AeBDieuscPuVpoNPCiEobwZndm/uRuutgPgsXv2TcsCDrsPcpKT7RyXxhkSKhC8M/lV
	m2Q6p7O2ZapGCIvMBY0xQxw33pRsLwRrdZFBdGIosDKM6NNlQvXbu1wJFa9dla/BGgg6O6Q9Qyn
	qoCahXWN9jzrsPSXPL7p+TDDxGioTYVBRjom/sHvqbhQ/w74tqQEDEdmv2hnS6PTqNNw78tPfwE
	cF9IODnXKYfZ+MOWmxPY+CLWiQqPX/KAKkG0TAPEP/mA68jqzY4StgVyMyjRM+Q/AQfud6WpgZ7
	3+sjti2q2aV8dpwm7N4Pp7p5gTPEqEpdcNRuLWQFjHUsmRBjkWdstfHRSIJBBa97n9lWB4DGDne
	PC2a2v4qgwgzSb1H2RS8FS20fFjRiT4Ba3piWidaCMp1DOPPAEp6IfvyS1k/kqOts/BEsbA1OUJ
	ytRAUXkwNsjUC9kz5yGu/DNHdcwhBkRrlRnw==
X-Received: by 2002:a17:90b:1c84:b0:35d:a3b4:2ef6 with SMTP id 98e67ed59e1d1-365ac47f086mr2457412a91.21.1778059429387;
        Wed, 06 May 2026 02:23:49 -0700 (PDT)
Received: from lgs.. ([118.193.33.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b06adc51sm716818a91.4.2026.05.06.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:23:48 -0700 (PDT)
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
Subject: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup
Date: Wed,  6 May 2026 17:23:24 +0800
Message-ID: <20260506092324.635014-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C2D64D8900
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244352-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
value in a __free(device_node) variable before checking IS_ERR().
When the function returns on the error path, the cleanup action calls
of_node_put() on the ERR_PTR() value.

Do not store the endpoint node in a cleanup variable before checking
whether it is an error pointer. Use a regular device_node pointer for
the endpoint node, check it with IS_ERR() first, and release it
explicitly with of_node_put() after getting the remote port parent.

This keeps the fix minimal and avoids changing
imx8qxp_pxl2dpi_get_available_ep_from_port().

Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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

 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 441fd32dc91c..f64f57a33c62 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -264,12 +264,13 @@ imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
 
 static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
 {
-	struct device_node *ep __free(device_node) =
+	struct device_node *ep =
 		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
 	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 
 	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
+	of_node_put(ep);
 	if (!remote || !of_device_is_available(remote)) {
 		DRM_DEV_ERROR(p2d->dev, "no available remote\n");
 		return -ENODEV;
-- 
2.43.0


