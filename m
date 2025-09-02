Return-Path: <stable+bounces-176995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFEB3FDB5
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE51A2C4F6F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85DE2E92C5;
	Tue,  2 Sep 2025 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNEe5W6v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90252F83D0;
	Tue,  2 Sep 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812117; cv=none; b=hnGzJAl3WnSBZHREXjlR4B+BLaZKR36E0DHmQK8ENvRLFrAgmImjyXwQq0bDeBWwvZW+XmdSAB/hWLjH8NyQpjKtZEU0XxxqCe3ImeDy88F0NgOiObAMzySNhc5aIOBcq++2pgGGdBiyWamKxhmV3xDAvlXc7MozsA+dQBhGuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812117; c=relaxed/simple;
	bh=3hh7/4HKJe6OeXFl1JCaf+f5VfZb6PdHargCvfMgQao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAjgmGoH+HqSVBqWw0sDEAuTOPPt2TRetJU2AOjx3jBAmow9bNp1XhN/V7Od09VURfmOygc5yWhF7zYTaeu+ji7UQS0my8AexwLRTemLNrzQxpTkBa0BlOtLLx8GF3ygLiJUCeDbZ7EC0YHURFtArY93hiy1abCYj+YRD4KP+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNEe5W6v; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771fa8e4190so3441771b3a.1;
        Tue, 02 Sep 2025 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756812115; x=1757416915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmBFxHhYRsHxUFb6yKl311GgplCtiII3+UFgBt4dL+A=;
        b=GNEe5W6vnXrO6WrQX/WRMFNRGtRv8JeRFTYryJz9l+JP6S0f6uQpyfiioTR4JHpZdi
         j0TUwRVrbD1duCizPi7TBMgpLB2dG+kvt++R/XXm7/AR5e3PwWsmPYuhVip9PT9Pj6S0
         r1sqAxs63/VC1I6svQQJu+xl2xwb9mkZhvs0vLqlN2iHcnOO5zyonMHUCTUqYWJ3huk5
         0iN4dTAh41XWcdjb6DWBRWTSFwQwo9RR5oGS0l3QXYDzKQYFEqqutoVMcB2L9EBdYcZW
         7pIyX5fJxWHratbMaquB8seYNwIEaZlsh5awLGBHLIXzjnaFSpTco+FUkC9qUWhtjw/h
         vRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756812115; x=1757416915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmBFxHhYRsHxUFb6yKl311GgplCtiII3+UFgBt4dL+A=;
        b=hdVAUh3lT39DrX6zw9R3NHSWsy6LgbjfUDxksX0uHfJFwfN9axB1R1mvh/93837vD/
         2+SPqOnv+ymTf8BDcMWtJ+G2lYHK7SkE/qXJLHxHXNFWxQznvdW83Ys9pnahdj1AiKE5
         +N/zcbKFQDFStfvweFuSfP+aTWHDk+rvrbcvdWJc2ps9qUy2d+tF8bSqnQ0WUY6QukLu
         Saq023dZUCLx3hLUqrwGg9AQfVgIVfuz20gEppe26Njpia9j2usvD+MNC0gOyJMgRyJi
         CO1fZiDAkIAYlFEVAgyOwC5Dxiq+waKEIEjaqtsP1H5RADY5iCSfBUcZfygzxMGnQ+0X
         q8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXXXd9DjNX8QgHeBKi2y+9X+fWVGOJw0KMKBzs4Rb4AhxswALmukgs9NNq/cC0kzMLh2E39KkVLD/L/tBmTRnzqI=@vger.kernel.org, AJvYcCUu598c6ejGeF1/V+Lp5p+jCOSVWPDi3RS03RmnTkAiSlFp+n0U3qWHcJTZlRSylA2MdUeyI1n5@vger.kernel.org, AJvYcCXP5z4UXd2Hiend0YnjNRm3vBEM7/Kdgp2/dzjT1hMu04AamCh1pHo+BFmGFh14itFwb+5afJ9APf9b4ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPnLas2Bf2QaywWv0bfSVv85yaTTNGoVgrrh/V2cEolqtbAkg
	ICzrcDhsnBjbcfM85HoNrQE+HAnIQE7KoziDqQ4osH2o4hW1ZtFjPBxq
X-Gm-Gg: ASbGnctyPfKHrJ+mmSPf3yvdlfSa94Z5AoXD3f21R6t1mZNdidWowSAWTd2KfunAwpX
	yQKqfW+mjHKtVouO0irdl44SV+G7TJwrhtF/IxGgKGx+R9s+toxK0szhXtcdAKV08n++2rrV5TD
	U3XOq2JNMSq9RzB3UhYZANpXHWtTBedfZGYWcGn8s7S07t69WDz5/j+wpp4CL0X5ew+3MjjY06G
	dUAJ9rPgoSpH+GVnxP5XX6aiAQ7Sud8RW6qcDNEqR1m0zDKgg9D+LNoylAUiA94JgYhjHCeOwHo
	bbttt0Wxpv+DaRJ6X4DYGv3763nYm67JUwBdgekdMrtGbxXvRFX2iY1xwFoC4EzuMdeABfAjdDx
	Gv2/lAYCTb2aLoOSOsWnxtacg8bsDLNU0bKxZKRFQ1Z7Bi3ZkfjsbPoAXcR/h
X-Google-Smtp-Source: AGHT+IHagalNzYPov+qToIRn5726tUcNigXXQLmuwNeQCyxqjqgOyE8ZJPIjKB/R2FuzA1JH42ZaHA==
X-Received: by 2002:a05:6a20:42a3:b0:243:c38c:7b3d with SMTP id adf61e73a8af0-243d6e10746mr16673032637.24.1756812115058;
        Tue, 02 Sep 2025 04:21:55 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e27d1sm13140645b3a.81.2025.09.02.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:21:54 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: krzk@kernel.org,
	alim.akhtar@samsung.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	aha310510@gmail.com
Subject: [PATCH 3/3] drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free
Date: Tue,  2 Sep 2025 20:20:43 +0900
Message-Id: <20250902112043.3525123-4-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902112043.3525123-1-aha310510@gmail.com>
References: <20250902112043.3525123-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos Virtual Display driver performs memory allocation/free operations
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

