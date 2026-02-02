Return-Path: <stable+bounces-213061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OANsK7yMgGkl+wIAu9opvQ
	(envelope-from <stable+bounces-213061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:38:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33547CBCD9
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DFE9305C2A3
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E343624DD;
	Mon,  2 Feb 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPStKWyw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A78363C5E
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031965; cv=none; b=XPhHAghU3j5VXHJx+ttoJtyTXLgvuTgnrfgNjaO7sqUQNopif57VAXizNKsv+z0ct2FLYJos4kXCY5pN8p8viVyS7PeGCPVuD/uxnkqpcxicnjkYbEXp6AD7NnehAzxu0eXkgRglcjW0YGRF/QouGVji/NDPZOCyFw7jIRrCmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031965; c=relaxed/simple;
	bh=mXXZ/E8iu1icugw56rUDGM02NHGVORn+CKASFjCuOLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REsxkLPbvsg83x/HGJvjKZqBswMick6mo0AlVZL5xX1fHMo4BQgOGggaeRkd4CKmRrDH8fMeynX1l1ItgAtm0cMBRrTn95nerkK4G2qYqI1x38AG4gb1vs0gWkt+l5Y/VRFR8t07XwNlzyQaw54GvKetTqaraNlN2Det1r+uC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPStKWyw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso3402675b3a.2
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 03:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770031963; x=1770636763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+souS7YaNTH8HrRQ+fNkEhlVU7efydlW/fF0+nylSc=;
        b=IPStKWywAd6GT7botAZvDrXyxJCBVghn0tlVaWymWaC635+BE6dDjH23Xbedw9QZS1
         Dh71ebqcBQ7FypNOvHyUqWsXK88qRcoR58U6uy04Gj+VXDApviCTnK1tj2tAOJNYpSLn
         Y4aWinaL5TXxc16XGeS+MOixpdH4J/TOakjFYYfNRaiOwfebjEwFkSct9m8J+FhgnGsK
         TeTFljB7FpqMA2MLuZK1kR5DsUv/Sxrmzhp/mV95EYt8Cprv3wIcIxERhlEyu3KGC5wU
         V+Dctyr+w349wsX5KUGJQyj2XZlZjpb0wM+oopwIAdB/NO+59IozAh3OHvsRvSD9u7yZ
         R0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031963; x=1770636763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+souS7YaNTH8HrRQ+fNkEhlVU7efydlW/fF0+nylSc=;
        b=QBfe7t2HS/TWndq4IzmXJL4g8yPRsb8ctujOefWcRdOQ8gTDsTd/mEoFTIKzLBZECC
         MPccozHFYfsA0s57EnfGaoDwmsaF2g023QoN28NQxsHKOnqF2gRy+MLNyUcsVivf7YuE
         PU8E2ICvw0hsutQuBkLDBm0ZXk01oy4WhLRyonvXGHQO0DCVIgkXHPhDv+9qiYD+S+RP
         iy6/GPNS4Cj/dG+77IxRQwVlEcpMqwcIXJ4P5Gb1sXaMHNzVK25yhJYVqZ88BqgDFWag
         LfJC4rhYJ73v9ws+L6fgFr/6vhevM7zNCBHqFejmxG12uhOwJPNRZTmo+HrlmjVicxrh
         mKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbGwqtqc78N1t7mbL4keNdMfKNsiJHR8qzDKkDGmRCUC+mGaO/pl4YhwkVPxf2u9ybGCNmY08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1/+aCv3wNHGJg6/CmYfs09nyjuhbP3raUtF0EYhOTnLKhcpn
	7Wev4Ai8XQl32FKyVRF0R1BqOf1cVCfrlJd21VkrTGU7KU+nD/qo9+zn
X-Gm-Gg: AZuq6aL3kiIgs50Xzn046JKtdkzZKld6BOpJqiufLn+lCyETHjemMc7K+WwGcyUbvGf
	MA0NodjzhebH1snLw2jEsex+7biyfRd8awIqrBFLcqSFlXZubU95n0diyXjJK+mK86ZvrISPpnO
	U6qPs5JmvAt6Ye2BjK64QhFdRS+Thiz0zzhwh8/l0J3fw7yYki3cdyuxhCznC0hN6L3qJ43eyvM
	v5useY4D/UnoeR4kzIRoV3wEwPimrWPs5JFI7VK6L0j838iDQ5cDY1vyC/VNQ49omeEcTSuy24f
	zbPAYeXap0yoHfnBDV64DeC3p45CkU2AoXmzOn4QHIGrzDZdwqrHNahsKfrXAmAusQG5rnTNVN3
	CWzMjCGtq+4QIlYJWL1t4xZhxbjfQTJAajbtEiP5eFlpIBqk+vOX37urfinaYcqk/T9thv/J8Nq
	8jqX9ectlkMbToLS9Ku8NVCmfOPNscBPkRoZdoug==
X-Received: by 2002:a05:6a21:7804:b0:393:8fc:5284 with SMTP id adf61e73a8af0-39308fc8453mr4806502637.70.1770031963552;
        Mon, 02 Feb 2026 03:32:43 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm13743190a12.26.2026.02.02.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:32:43 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 1/3 v2] drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
Date: Mon,  2 Feb 2026 20:32:32 +0900
Message-Id: <20260202113234.183393-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202113234.183393-1-aha310510@gmail.com>
References: <20260202113234.183393-1-aha310510@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,kernel.org,samsung.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-213061-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33547CBCD9
X-Rspamd-Action: no action

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
Fixes: cf67cc9a29ac ("drm/exynos: remove struct exynos_drm_display")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
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

