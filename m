Return-Path: <stable+bounces-210283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4CD3A193
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E506B3015149
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231D33D51B;
	Mon, 19 Jan 2026 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naRYZJa2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF733D50B
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811176; cv=none; b=X/XtGgmSNWmRzT/PGrVtpxO4GbRyaD3M4vtjypj5hnt0iL1OkEBkTOq5cG8AeUB3WwG805poP9RyBxwY5IMcD5KH4KrCbu9rmbEcuFmvoo/JjVKVwIKDeMpJqaLuJgmHGRazJ4aS/tfwZYwt+HgFZ6EPraR2PAtosVJr9IoObBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811176; c=relaxed/simple;
	bh=FDragOxsAkoXm09TI3NdTH/HdW3OX83nwP68tiK4R/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZ+Pbw6X/HtcDMXXftrj8l1It7Fn6Zz0fltQMQMW4Pd1TRrp6j5OqjMpiA3vc99ht1O/4OlwAL/5Mv4dWabd+DiEgFzaYoMkgh+Bg1GlDlB9/ZiJQ4w0c5mKoWz5ykP8OeFgOd4qrIdfgOWAIkaSO8iJwnMAeC20sgJjNs+jWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naRYZJa2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0834769f0so27625715ad.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768811173; x=1769415973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbmEw0xI5GEkCsxaHsMMe7LmACI8y/oSXqbnzXdllII=;
        b=naRYZJa2t5bGzLnaHZDTOAmNmnGy7NaK25fvjOTFzA3knSSfVXYmiMDAYucwfEZZG+
         vF7ioV5pE9BavUEUTHJFGHQd74iEMgjupsWrTCrC5IYYXkVjba9bdOSig5oWqZPQfBIw
         zZe9FgeNP4nkG818UrOraEODKQr3Q9r1VfzKEeOq4FQ72Q8KITf5ijPXEDvwxb6Hn7jk
         NZNb2OOX1T1ZZAyj+Us03Kwl7EAkzoz1FIGKzNXcIy/KvISKjBzH9kvAx/3jfWg9kMT/
         ItN/ROjgB4fo8Vup+m+WKetKkyLD0TYA6MRKVSDG+dnfJOfbC+39jnbfDuNs3yBpCHJz
         HUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811173; x=1769415973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbmEw0xI5GEkCsxaHsMMe7LmACI8y/oSXqbnzXdllII=;
        b=VIZxII5QottGqxs0IqT6NAks28z+JGTGVMxQFWXr1ESnCb/giqJqPj6mpYGcv6m55P
         e42/1lzFM6dMh3ObftMrDFElJEoQEXuho4p/95hfkIw2Or8E/G51V/EPZtKXNn+50LMf
         6r86/ZBuDGsyFBUb/ppuLXgXZYE8ZVPaLcy19ncRh2IF6LK8apyF93uYeOtHYGtRjp0+
         +29QYU7VHjtdjNsYD2YSzzb6OtBd9v4jXvSUgekEjyH7PWQom8psBj3RxFImt97pAtpq
         jNwlgSXMoNi9RaFQcOObgSOoVgF139JhRWQXfNDNYNGljrCL2dkXyoCnXoOo64LT7hwV
         ZnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEVfD+En+4SdwScEwQ2kLJAp9vJuoq2cuPswhZQURCoKug/aylgmRUvDc9UhByZ0FppLZgNRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwmbZ10zfNPtoDv0iR1EW6QbbmE1ldTt5VXKFo9sbKtDdkP9d
	XO6/MOl263xYNGNbUiIXPee4Tjl8w63dhde1z5DpKrGWZk42XdLR2/Oj
X-Gm-Gg: AZuq6aIE65tHT4/dL/2ysTfdjjKOtrHAUUdt1mcrfcDGmF7HvXjSCx9mffdhS1sIl8Y
	diwGzg9VqkRhiTe6qGhQv3qb2O9LSNGxmBSD1wKYv+9xWo1MV3suvztIkYUW9I6f0rryFMMG7Mu
	O60mraJJ2UfSpWsJyyyCfxLrqepWEkRZlSML+VrZ5CV+3stoq6mZ9w9L6E7AMg1lNduQuMba+Rm
	cJNzYj6kmAj3JH+0H5OEH/ErIUTlf45vJDkgNrSJqiTny0zcPid/RVpwCIrgoLjzm7craGIA/7E
	f53Bhd6ypGdpkume/lkbJkHpF+Ermkak9QEeaSHuUzIXH72pOnP70TpJb/KM/erUYzrY1S4Yw7W
	u7Ub2SbvM+fpzP5SeK4GWtjO+e6KZCXPR946YCHxgm9PvdunMXQu2w4YcXNeIsW7DTqJs9cggqA
	FSXGJ/0SwLo90BkQZbJ0V7fyBAkGMpK/UUSDZ/Ug==
X-Received: by 2002:a17:903:138a:b0:2a1:3769:1cf8 with SMTP id d9443c01a7336-2a7188fd789mr97024985ad.33.1768811173364;
        Mon, 19 Jan 2026 00:26:13 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm85699645ad.27.2026.01.19.00.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:26:12 -0800 (PST)
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
Subject: [PATCH 3/3 RESEND] drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free
Date: Mon, 19 Jan 2026 17:25:53 +0900
Message-Id: <20260119082553.195181-4-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119082553.195181-1-aha310510@gmail.com>
References: <20260119082553.195181-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos Virtual Display driver performs memory alloc/free operations
without lock protection, which easily causes concurrency problem.

For example, use-after-free can occur in race scenario like this:
```
	CPU0				CPU1				CPU2
	----				----				----
  vidi_connection_ioctl()
    if (vidi->connection) // true
      drm_edid = drm_edid_alloc(); // alloc drm_edid
      ...
      ctx->raw_edid = drm_edid;
      ...
								drm_mode_getconnector()
								  drm_helper_probe_single_connector_modes()
								    vidi_get_modes()
								      if (ctx->raw_edid) // true
								        drm_edid_dup(ctx->raw_edid);
								          if (!drm_edid) // false
								          ...
				vidi_connection_ioctl()
				  if (vidi->connection) // false
				    drm_edid_free(ctx->raw_edid); // free drm_edid
				    ...
								          drm_edid_alloc(drm_edid->edid)
								            kmemdup(edid); // UAF!!
								            ...
```

To prevent these vulns, at least in vidi_context, member variables related
to memory alloc/free should be protected with ctx->lock.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 38 ++++++++++++++++++++----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 601406b640c7..37733f2ac0e7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -186,29 +186,37 @@ static ssize_t vidi_store_connection(struct device *dev,
 				const char *buf, size_t len)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
-	int ret;
+	int ret, new_connected;
 
-	ret = kstrtoint(buf, 0, &ctx->connected);
+	ret = kstrtoint(buf, 0, &new_connected);
 	if (ret)
 		return ret;
-
-	if (ctx->connected > 1)
+	if (new_connected > 1)
 		return -EINVAL;
 
+	mutex_lock(&ctx->lock);
+
 	/*
 	 * Use fake edid data for test. If raw_edid is set then it can't be
 	 * tested.
 	 */
 	if (ctx->raw_edid) {
 		DRM_DEV_DEBUG_KMS(dev, "edid data is not fake data.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
+	ctx->connected = new_connected;
+	mutex_unlock(&ctx->lock);
+
 	DRM_DEV_DEBUG_KMS(dev, "requested connection.\n");
 
 	drm_helper_hpd_irq_event(ctx->drm_dev);
 
 	return len;
+fail:
+	mutex_unlock(&ctx->lock);
+	return ret;
 }
 
 static DEVICE_ATTR(connection, 0644, vidi_show_connection,
@@ -243,11 +251,14 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 		return -EINVAL;
 	}
 
+	mutex_lock(&ctx->lock);
 	if (ctx->connected == vidi->connection) {
+		mutex_unlock(&ctx->lock);
 		DRM_DEV_DEBUG_KMS(ctx->dev,
 				  "same connection request.\n");
 		return -EINVAL;
 	}
+	mutex_unlock(&ctx->lock);
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
@@ -281,14 +292,21 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
+		mutex_lock(&ctx->lock);
 		ctx->raw_edid = drm_edid;
+		mutex_unlock(&ctx->lock);
 	} else {
 		/* with connection = 0, free raw_edid */
+		mutex_lock(&ctx->lock);
 		drm_edid_free(ctx->raw_edid);
 		ctx->raw_edid = NULL;
+		mutex_unlock(&ctx->lock);
 	}
 
+	mutex_lock(&ctx->lock);
 	ctx->connected = vidi->connection;
+	mutex_unlock(&ctx->lock);
+
 	drm_helper_hpd_irq_event(ctx->drm_dev);
 
 	return 0;
@@ -303,7 +321,7 @@ static enum drm_connector_status vidi_detect(struct drm_connector *connector,
 	 * connection request would come from user side
 	 * to do hotplug through specific ioctl.
 	 */
-	return ctx->connected ? connector_status_connected :
+	return READ_ONCE(ctx->connected) ? connector_status_connected :
 			connector_status_disconnected;
 }
 
@@ -326,11 +344,15 @@ static int vidi_get_modes(struct drm_connector *connector)
 	const struct drm_edid *drm_edid;
 	int count;
 
+	mutex_lock(&ctx->lock);
+
 	if (ctx->raw_edid)
 		drm_edid = drm_edid_dup(ctx->raw_edid);
 	else
 		drm_edid = drm_edid_alloc(fake_edid_info, sizeof(fake_edid_info));
 
+	mutex_unlock(&ctx->lock);
+
 	drm_edid_connector_update(connector, drm_edid);
 
 	count = drm_edid_connector_add_modes(connector);
@@ -482,9 +504,13 @@ static void vidi_remove(struct platform_device *pdev)
 {
 	struct vidi_context *ctx = platform_get_drvdata(pdev);
 
+	mutex_lock(&ctx->lock);
+
 	drm_edid_free(ctx->raw_edid);
 	ctx->raw_edid = NULL;
 
+	mutex_unlock(&ctx->lock);
+
 	component_del(&pdev->dev, &vidi_component_ops);
 }
 
--

