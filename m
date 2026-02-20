Return-Path: <stable+bounces-217530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJyCK9bWl2k99QIAu9opvQ
	(envelope-from <stable+bounces-217530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:36:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6CF1646BE
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50C5D304E0E8
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2762DBF40;
	Fri, 20 Feb 2026 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnq+F5yo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADFC2DB78E
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558561; cv=none; b=jw4cl7DyN50BRuRz5GSYELkHFgabNOkV6GUM8HzQtPMuiDYdQWwltqXm68kpxyliVbCbXMHa5/G3myG5Jn+jZm+EjIp+6jfKCOyDmXhJxHt72mzx3Jy+YxhwYNWlIK0FFSKY8BUyBHrX+XoLQS4r/a/+/QI3On1bsXGeHhBN+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558561; c=relaxed/simple;
	bh=QzO8lKBkDOc2XZfOK961CgRLNkgKWjz8O0lEWEyHBzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6Uo7RkucSHTRsG/0XOaVf2gjIiyvBgFPqlBkM7s3ewQDgXU5O+ShTt7Wxp8nM5WS/+vHbKIk+BLG5Q9Ke9t0xbUJAVDRrxWKXJwibE5+2+HVfzUjxrjV9ebMv2JnhscfIPWXe0fOtgGfLnaZ2ln7XIQ5u881Hh7fBveXDcs6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fnq+F5yo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6f306faaffso647866a12.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 19:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771558559; x=1772163359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt6vgi/ugK6ilulMXdoJ0iyfQKJZUeMQJfjUYZUE7BU=;
        b=Fnq+F5yoMOgLQloS4rRYni9ja+4w3cxeD+hUBRXQwKWHXVCyz1bvbLVXHJ8D/04vbo
         fP0KB8ImOGs9O1UUR1sRjPeHm1CHMHdcrnPHUBIvJ2fIsxyZdHQMlo4+zhtDzeySktrU
         pCUS1e0oI+RLPlDNmNX8Rfw7zmB8fc8amhAeTFxU5SR+t1Zb27N3UQZugonFPXNiBFsP
         uKiRYouL2QgPGoDYV9uzS9e+fDeZmKjYZOt5OsVh3iVRu/RS3qQTe+cal8DZd6hcLa+2
         B4XlU+gYMLwLrglM08ZbCDyWnGmXB56Peo01kumU/RevmsUPjiYRcU5fW3sbB6WWlcHa
         uo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558559; x=1772163359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nt6vgi/ugK6ilulMXdoJ0iyfQKJZUeMQJfjUYZUE7BU=;
        b=roG8pRJEfe9nlgg8M4+Qz4ZJBxTuriiOOCS8R4zSKZ9WsAAPNUjsPV40gmQHO5uigp
         50VaHWDn5+1XT/t0+Tz/faim/3vzga+0Hr03DXRHPv4RARdIwZNr3YWJe2XCOHt9r9nL
         pwOAidwkmlp+ECPdg6A0Iz9entCgpEoWC3BXLPwn9paP4pDuORbppTHO/2VvR59M2B5V
         S9lFeYm9wEMQ/+yKrgI2ZpXIK+r1gt3rYLMSagvwB39KXNRcTVAOBp3xV1J4WU2QTIF0
         pS3pR7t1s5sgDzJP1YLrHoDR0o5nUqTa4T63ANCuAuqGhO8kh7Oyp7ozB1VFgJj24oF+
         jFeg==
X-Gm-Message-State: AOJu0Yx+/taggMynS2iy6r9qWJDzk32uHJTuvu3ibQOm6kiOrIhD9AOF
	HouZFqgiK/7IrWLiblqZ26xdE32ovuGPqh9mBCjfg++7tjESYh5HNd1YM/9RZxWL
X-Gm-Gg: AZuq6aImlW6V5mXytf8BNz5qNjPH9QOR4fdBr76BPO9emW7jEhfZYbwauwE7+GemzlG
	1sbi8wv14cahZTuRUMzjfWa9qxRf9+YaqXQhVft8mz9EJeZMGALL/lvTCUQLWsOL6KviY4W6B3K
	sRqKuF2Sd+O2igdY/S2ekGCuUkPota+Er7vVxKIWyiXnJOyqocb9MP4z2kMr+oc3OV7Y3c2pOis
	HHjPiigxSCtXiQhjO3ypjsAcjRK4m1niaoTjBUI63HR4BiKwAVTSYi8oXVqqUMtMVNORNL4aWT7
	NM4aiDlvAqKTQQ+IJ6BAeRRSn5oQnYhtBTrE2SmbBipngbpiNKYNTUdgIkPICM8FS3JwBkti6W1
	0CkgGjOm4X/ohc6Hr1opAnc8BRTSjxom4sGHS5xWyOdzTbpEyN81YD3EJ+tGPhyUBOdEHK2BvSa
	hHvAncHd2t4YQIew1smt2mKXBzZjrMFL81Yur/k/wRXwxCAEWO3Q==
X-Received: by 2002:a17:903:1aa7:b0:2aa:e23c:2697 with SMTP id d9443c01a7336-2ad175b1491mr182585685ad.57.1771558558897;
        Thu, 19 Feb 2026 19:35:58 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5cf8sm177143675ad.52.2026.02.19.19.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:35:58 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.19.y 6.18.y 1/2] drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
Date: Fri, 20 Feb 2026 12:35:49 +0900
Message-Id: <20260220033550.124346-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220033550.124346-1-aha310510@gmail.com>
References: <20260220033550.124346-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217530-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 1C6CF1646BE
X-Rspamd-Action: no action

[ Upstream commit d3968a0d85b211e197f2f4f06268a7031079e0d0 ]

vidi_connection_ioctl() retrieves the driver_data from drm_dev->dev to
obtain a struct vidi_context pointer. However, drm_dev->dev is the
exynos-drm master device, and the driver_data contained therein is not
the vidi component device, but a completely different device.

This can lead to various bugs, ranging from null pointer dereferences and
garbage value accesses to, in unlucky cases, out-of-bounds errors,
use-after-free errors, and more.

To resolve this issue, we need to store/delete the vidi device pointer in
exynos_drm_private->vidi_dev during bind/unbind, and then read this
exynos_drm_private->vidi_dev within ioctl() to obtain the correct
struct vidi_context pointer.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 23646e55f142..06c29ff2aac0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -199,6 +199,7 @@ struct drm_exynos_file_private {
 struct exynos_drm_private {
 	struct device *g2d_dev;
 	struct device *dma_dev;
+	struct device *vidi_dev;
 	void *mapping;
 
 	/* for atomic commit */
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e094b8bbc0f1..1fe297d512e7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -223,9 +223,14 @@ ATTRIBUTE_GROUPS(vidi);
 int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 				struct drm_file *file_priv)
 {
-	struct vidi_context *ctx = dev_get_drvdata(drm_dev->dev);
+	struct exynos_drm_private *priv = drm_dev->dev_private;
+	struct device *dev = priv ? priv->vidi_dev : NULL;
+	struct vidi_context *ctx = dev ? dev_get_drvdata(dev) : NULL;
 	struct drm_exynos_vidi_connection *vidi = data;
 
+	if (!ctx)
+		return -ENODEV;
+
 	if (!vidi) {
 		DRM_DEV_DEBUG_KMS(ctx->dev,
 				  "user data for vidi is null.\n");
@@ -371,6 +376,7 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
 	struct drm_device *drm_dev = data;
+	struct exynos_drm_private *priv = drm_dev->dev_private;
 	struct drm_encoder *encoder = &ctx->encoder;
 	struct exynos_drm_plane *exynos_plane;
 	struct exynos_drm_plane_config plane_config = { 0 };
@@ -378,6 +384,8 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 	int ret;
 
 	ctx->drm_dev = drm_dev;
+	if (priv)
+		priv->vidi_dev = dev;
 
 	plane_config.pixel_formats = formats;
 	plane_config.num_pixel_formats = ARRAY_SIZE(formats);
@@ -423,8 +431,12 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 static void vidi_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
+	struct drm_device *drm_dev = data;
+	struct exynos_drm_private *priv = drm_dev->dev_private;
 
 	timer_delete_sync(&ctx->timer);
+	if (priv)
+		priv->vidi_dev = NULL;
 }
 
 static const struct component_ops vidi_component_ops = {
--

