Return-Path: <stable+bounces-214652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGtpObnghWn+HgQAu9opvQ
	(envelope-from <stable+bounces-214652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:38:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850AFDA6A
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 897C23006798
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240B03A9D8C;
	Fri,  6 Feb 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm2BoxU9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94733A0B0E
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381494; cv=none; b=KZAPVU0HIVXLKo+xuwZy+To/Cbd5pQvvDhLK/DZxyCvb8bUip8HWc8Bk3oWXmZGqdE4F1nqq149VIzGaWLfLZHOrNJviKJVchbFABT0AVe2lim8vZS0O1jh7mD3sY++4Ybjrvq2gX1s30bG69W3teRza6Kr3U3JseO4fVGDwEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381494; c=relaxed/simple;
	bh=97pdjl0bUPwA4JpV88LS+Yj1+rnWNpvemF9mpIQ6HSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQZcflrrQ3ZxBrXzjbmVaxF4HhqT+bhuMcFTeNpmYjvENUAfJ8bqRxd07wUrW48UL76nnD9iw3ImlROD1wWHXPYkHhuLYYt19cb35KqyjNmcc++HZ71vilxxEUt5HtcnGatUFZurnC8wflIGLxwumtJD6wVURQHXcT14pQdJ+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm2BoxU9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so31149045e9.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 04:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770381493; x=1770986293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ns+MXhJukhn3KEMfjhaf0vuBQwUYwZFyGUUZrRy+AsE=;
        b=hm2BoxU9SCCJwhviqUiWk56B9VOYA6UGQ++CQIZFqdFU4hzV9IM8STKJNgX7zKRijx
         I4svAuKxauQa8aEPrtSbwgz9GzpFqTCQ+d2sEiIhuN/lXkvwCyI6Bh9+MUFj6iw4KWkK
         Y4mw/PFi4rR2z5IN7hxoKE0cQbZzkh+lmyI63mJ4FZ3Yd1NhlJ900BYXpaiVoZXMhC/z
         HBpHde2xq6kaAms6Zb6/U4OYG7bZTJSLCUwe1nDh8ShGkUzIQr9vu1G4Y0lLbkniSRhb
         2Zz0b/DU0ZCfWAL4nR40MsZzXd49kKd5eh7k3KBaNCdNrcT7tAyDifGng8imIJ4J8268
         fm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770381493; x=1770986293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns+MXhJukhn3KEMfjhaf0vuBQwUYwZFyGUUZrRy+AsE=;
        b=sri4CwM3i2ck8So8PSClxNBTeouNcDGlQi8kO2dRLCVMHkqFa0RGymL3NrNJcr/xLT
         H10EWbaCGCJadJDseyVkMRsaQx7PHt+8mLymi7CfZ0ZwAjMliGdeHgUeLiR58yYZceg9
         fG/RO+0QJb3uyUXUq+S4iNRG50kzzc3neMTiWZNxGIl7+Mny95zr/8jaPUB8mSBUPF/h
         8aoTiTipvRvhEhExAV3OJSnUKpSKW/rz8uXvmgTV2fI6yb5D3p9vGZlMJ1Axn3x4aw5P
         9KG6pLWzlhQ/e9iuU+hwgKbD1YaApkPVviOGadfVTrJDKQE5hnWoOlFLdpy3FaBRliEg
         pLhw==
X-Forwarded-Encrypted: i=1; AJvYcCVspwgp7MGCl/+9XpbkMKDIbn8w+VtrWmmwLLEIgCLPjMENF6swRDY3pnj/xsAdPqxjfdhPtAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qPQLm06Idzn+Cnh5r/k0sJy/7Yr0WicC1qiK159a4xMQLvyA
	RoCaw/UI+IjetKsiGztkzqXqRuGY69csBlgJVAGf5TI6iHRGSHiXEP08
X-Gm-Gg: AZuq6aLAmzHTujIwJfZhtp/mFeMHhh7+TNjlYZqubqUQZjNd4P+1G4hvq+ElOz3Ybr9
	6eteu636fJel+8w07xNgEy2GvCKSnmKITdmHU2Wj+bkdeKyBg3a539ret2aHAhuuNfxLqz+VlMa
	l7oGtp8P9ogeQ3jmHQBZNDm8ILslgGnrWtSklInc9NuQxf927bznwIRzNU5VpSWMIrhyJCtYi4i
	CSAng7G56NHbAJp7YOYkF2gFwixuzmhNP9BvNpZPgJujYcAIemJUomhddQxvtb50Ec9MzEOhssI
	PERb8ja7CmSu5MBZXUbUENOscn+LnZIDuRa6W7V6RxmWpke5qlDt2pvOEfZlUb96YQTchO1N8Z8
	uBgaC7eqH1tJ34A6C7Itc1u/Zfu35olxFCe4kIRCJISdgf2088FHhf1QjhHzW/dQ1u5ZrRL4ZL/
	etqTjG78IeZYrDPNEvwC2Fc2MHbB3DdR+4Iq1B96m+y9EdbnPOUsZM4ymUgsHyBttLfQ7wpbm2t
	Mudc2KT4l5WtL3vm1celqlayUHK3lwzvlgyaye7tokivYO0kzbxO+BUSfrgmPP6FaKfK7lK99ey
	+K60jb2X
X-Received: by 2002:a05:600c:8b6f:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-48320236963mr35535055e9.29.1770381492800;
        Fri, 06 Feb 2026 04:38:12 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040a3cesm32168955e9.3.2026.02.06.04.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:38:12 -0800 (PST)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
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
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
Date: Fri,  6 Feb 2026 13:37:36 +0100
Message-ID: <20260206123758.374555-1-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214652-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[chromium.org,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 8850AFDA6A
X-Rspamd-Action: no action

From: Franz Schnyder <franz.schnyder@toradex.com>

Fallback to polling to detect hotplug events on systems without
interrupts.

On systems where the interrupt line of the bridge is not connected,
the bridge cannot notify hotplug events. Only add the
DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
otherwise remain in polling mode.

Fixes: 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD")
Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 276d05d25ad8..98d64ad791d0 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1415,6 +1415,7 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 {
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
 	struct device_node *np = pdata->dev->of_node;
+	const struct i2c_client *client = to_i2c_client(pdata->dev);
 	int ret;
 
 	pdata->next_bridge = devm_drm_of_get_bridge(&adev->dev, np, 1, 0);
@@ -1433,8 +1434,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 			   ? DRM_MODE_CONNECTOR_DisplayPort : DRM_MODE_CONNECTOR_eDP;
 
 	if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort) {
-		pdata->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT |
-				    DRM_BRIDGE_OP_HPD;
+		pdata->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
+		if (client->irq)
+			pdata->bridge.ops |= DRM_BRIDGE_OP_HPD;
 		/*
 		 * If comms were already enabled they would have been enabled
 		 * with the wrong value of HPD_DISABLE. Update it now. Comms
-- 
2.43.0


