Return-Path: <stable+bounces-204490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A539ACEEEE6
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E6430380C6
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109124A049;
	Fri,  2 Jan 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5McFdDz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573E248176
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369363; cv=none; b=D+ze1QenloaORPwUQMtQNFVxfJFiXRQ5xEdLlRY2zq1YP1E+yfWdnanvI4jhTviiJzO52aCHbd5900ymroh3S7VBeJroEeLp3KbykErQZ4U/Tt4SU5HclfZaAhiJFkriID7GaFhrWqSqjpeta3L1n09WGsYrIcFmlSVyL7NS/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369363; c=relaxed/simple;
	bh=5HQ+qZEOvKLSM3M1aXgu2zDptwhry+oiv8fhyVpjSLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skiGFCOwdBUOUXOT7ryovds99SBlw2F9naeXiPU7j5PZJ7Ca7FT68BVrUPUfNx+UUhwsYEf9PNoWJp3uRxgqOQadjjq9qONQnoiFKEatUaL7YJdKmIfmVsBaerEJ2BHNkIJRJaBIm5p+WX2oK4f5ipYuExlBoob8WGvCrPTTsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5McFdDz; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b8018eba13cso1907069366b.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767369360; x=1767974160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/E4Pkle8R/umjjml+ar6gI8frpDcsvylCBgQE9LDis=;
        b=C5McFdDzH1QRc9net2dJDd2GnGdwp5kNatArENygxajziGnTXx/1z8H1MH1xXQGDep
         YetuVJb48+yVxlk5zne34ThOWcSZ7TFD0j9p1scm6QvoSaIiLGOMOaLsicb8xZNm+Y/C
         7JkU9hVPVqcJXE8MOdxjHJ6V8sbR2SUqMzCf8/VGUYxyMfpDVQPe+cMFW2TnfLBoU/E5
         zh7ChJWDJGRNO/Mf+OH6SazUijiHkBXTE64XkbMDG+rrnWn/yHOvDpQRMRFem1b8W6Pq
         thC2E/uNt4tFjlFuyRu8rolwQZ0t61t/1iWGdkoLInDxnqSAzu1/MEfEc3qCYunCzui1
         PCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767369360; x=1767974160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/E4Pkle8R/umjjml+ar6gI8frpDcsvylCBgQE9LDis=;
        b=JymAuc5FC9D1c0R1E8XFbq+cmbGfW3zmsfxMdExt6kSFSBNfHAdX1Ou11Yk3cnmyHD
         kFmSKa9yN9EcrF55yzxUUadMenqWlR40Mj00Pjftp9QAO4/BMUy0FoeTq4eiRior1YEf
         UcmPLxop4rZBxrADlzu9QBlPxhKVReDUgLSK/l+5YxG4OagTo4ownjSKfNSrhZ4cX5vl
         9xWPKmByNuwYL0aOiMlRPA/L4ezCn1xJRsz8Ze1NplVsRk+Tbuv1fMiFJuGcejsg9xg9
         XP5oPvxFBYpFSrm7szD13PD+nKYaU/QeLM4+K0ihqAaWH5nRIEVntRstE3Jzg/iLy4px
         sTiA==
X-Forwarded-Encrypted: i=1; AJvYcCWbePvlLrpMMIJ0G71YqdGGUMBbcNnjhAzL2m4q1uQ1vFl1m7PSAqZ0X8rVsFee1i4yZXqRuSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQxRZf8yConsk0nmMdaa51UhBmtYE5sPEveZ/jfKbMR56gfv8
	57gfFgwHq/kzFFse7Fk1vSOin+Qlri3LMgMXn0G7RIUWpCpyArZYfIZE
X-Gm-Gg: AY/fxX46Cbb/P/toIEYCFz/eDxSexutPOdTPuMMyb7jOka46/a48vE+vGyPpoKh14N3
	QnG29F1k+XgCwW5agK8rqFA+wgzabPXEUhawuMWdIAP9a0xvZbCcOb78Lng8jrfI/unb83iiIXR
	Hd3hX3uKXEDQDs8vYhssuETFGAcwErCgTinIbvjNf9yUlqUnVWRNiW1NvqHsjmnt3R/TNzI3yoN
	UuQZDE49FxO+rd+9IxE2vM5r0kONFaQFOv5LUapDEy50myEveHtHhLgZQFVk1DvBvT4tovX7uhv
	8bTSOeUJIvRglnvD2sfJtiJq7PfceQrsA7smv2W1yDx2ZLY/+KVItRRdhR+6cVCmTc9MIPSr7B9
	ZxV/HfXQu8odaxIZhWy5SAkFrs03WejXHsBaIqajrfKJhjTqrgmfVwiYx9ljLjcsckKn6nZ7/Wv
	mWgO7PgrjcNWGm2UhQ0ASQB+MsBw==
X-Google-Smtp-Source: AGHT+IEPvWgGFyPCVd7ePOa1jj1CQs953xedwLMhJbDS9KL168vNCZqWkuywUIt3CMvJc+d0CdFOTg==
X-Received: by 2002:a17:907:9303:b0:b83:1340:1a2c with SMTP id a640c23a62f3a-b8313401b75mr2268205166b.64.1767369359470;
        Fri, 02 Jan 2026 07:55:59 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:ac54:a680:a017:734f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f089fesm4611961066b.46.2026.01.02.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:55:58 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Andy Yan <andy.yan@rock-chips.com>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org,
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/bridge: synopsys: dw-dp: fix error paths of dw_dp_bind
Date: Fri,  2 Jan 2026 16:55:52 +0100
Message-ID: <20260102155553.13243-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several issues in dw_dp_bind() error handling:

1. Missing return after drm_bridge_attach() failure - the function
   continued execution instead of returning an error.

2. Resource leak: drm_dp_aux_register() is not a devm function, so
   drm_dp_aux_unregister() must be called on all error paths after
   aux registration succeeds. This affects errors from:
   - drm_bridge_attach()
   - phy_init()
   - devm_add_action_or_reset()
   - platform_get_irq()
   - devm_request_threaded_irq()

3. Bug fix: platform_get_irq() returns the IRQ number or a negative
   error code, but the error path was returning ERR_PTR(ret) instead
   of ERR_PTR(dp->irq).

Use a goto label for cleanup to ensure consistent error handling.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Cc: stable@vger.kernel.org

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v3:
- Add resource leak fixes for all error paths after drm_dp_aux_register()
- Fix platform_get_irq() error handling bug
- Use goto pattern for cleanup as suggested by reviewer

v2:
- use concise error message
- add Fixes and Cc tags
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 82aaf74e1bc0..432342452484 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2062,33 +2062,41 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	}
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-	if (ret)
+	if (ret) {
 		dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		goto unregister_aux;
+	}
 
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		return ERR_PTR(ret);
+		goto unregister_aux;
 	}
 
 	ret = devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
 	if (ret)
-		return ERR_PTR(ret);
+		goto unregister_aux;
 
 	dp->irq = platform_get_irq(pdev, 0);
-	if (dp->irq < 0)
-		return ERR_PTR(ret);
+	if (dp->irq < 0) {
+		ret = dp->irq;
+		goto unregister_aux;
+	}
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to request irq\n");
-		return ERR_PTR(ret);
+		goto unregister_aux;
 	}
 
 	return dp;
+
+unregister_aux:
+	drm_dp_aux_unregister(&dp->aux);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 
-- 
2.43.0


