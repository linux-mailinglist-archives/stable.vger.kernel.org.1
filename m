Return-Path: <stable+bounces-55066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4971915494
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDF41F24AEA
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7419E7F7;
	Mon, 24 Jun 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrPJ3p5X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBD19E813;
	Mon, 24 Jun 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247449; cv=none; b=TZ553iU3l6er8Xau2r+T5F6ZtCwXD0iDkitDf3ebHL5nKbxRfX3OJ2mDICuVWaPfwv3dUbnUNzvWzevom6SzGYRDJLhqxAHWu4wxQSUg9dG07pWqsYUr8ixJ9aOhgpjJj3a7i0H7QiPeVCM2wttsu+QTTE/Nl1IA7esY+ZL7dKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247449; c=relaxed/simple;
	bh=Y2BB2weXpa+LoCNHgaMdua1IE8aKDXJvx8s/YfYa6MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dV4o33kPq/DFLIqQ7Wk77a+g/X5bh+l0y9j1V3yhQpwvc4FdsSiiv2GNqbSmJLMbWuwzjY6btfIZye2ATDx/1yiG9VqBAsNJ1zYJqf0YJJtf+oF6XthfNsIIRCKODx7l6CT1v7waWdAjdZjc3o3iM7YXnUnlE5SnpKZw2WFS2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrPJ3p5X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4248ea53493so11085795e9.3;
        Mon, 24 Jun 2024 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719247446; x=1719852246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uw74zf66DQORFJn85kqFB7s36On7KUi5ywYxV+PBn+Q=;
        b=LrPJ3p5Xgck3I8V55ZhMo9joe/r6VXI1n5qREcE9CKfW11fwACTNVwpWo8qTiFL9t+
         l+kysnxc4EMuSeeDAI5L5OvRDI9CV+NgAyUoMK2LF/JQpPVSkjSnGjJMzIwtji5m16VW
         b6p+RtkqmLomHg4S7A8WusAFrVNalE0qs86mQeS6lkcnJc/7NKxTXvZVyh88+c2RXQXH
         qrPmLZG6JOLfSokGafovBfCdvx9LSCPKRfEj0T1tGJrO3E8Hkwu/pUjiP2kcVStocoox
         rHusZvl6PvwPqHVrAsW++Az3WZUZ3oC7lg5yoIwzbwwav1S9oqSXAA/5PY8/Y4Annk55
         BjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247446; x=1719852246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw74zf66DQORFJn85kqFB7s36On7KUi5ywYxV+PBn+Q=;
        b=W310B0drnN8gyo9hQ36+Wo1s4zhhYHHJ+PxmFxe/tt8ZNkv72CjZpR/U4FjSdHyb+7
         zpXdgJWqeOGryQ8J376mvffOn222v4HQA0n5AXnpH6NxnpYfvN7eyxpW6ktpqov/YRDZ
         3DI1np3pfr+IsMXXWDImbXka04Vf7hC4r/xRFWjvmMNQWs+nloks4d+f5pY8H0mUFdQn
         9uFcXIgy6DbTILzNfgYa8LFP7qx897hgU9BQK9rZnde1ZSUwlLsmOOWryz86Ei3l8mxb
         DIlR+6f3YgZsEVGUVakC+0ncgHj0LjaWKOdKYBVQUA4eEiQUearHO/2wKy1c1iWBabA3
         KEdA==
X-Forwarded-Encrypted: i=1; AJvYcCUMVVLLPVOlyb60BxW5E2uZzZ8B1uu8c7nNVq8DUVo166UY/CMHVsiNfUZlj7DVigH+jbX+KNEEg3dxbcPfwRZJP0miAM7zbI9NP5LtmGLc/m11MFVnL1P+Rt4fEJQHLjgBKXeO
X-Gm-Message-State: AOJu0YzJNGjAyXkrS8ls2f456kAeErnz3LH56a3/vkoQ0yr+DbnQwv05
	zV5Gp37aJvtXkwhZWBfceKcmb8iHyYktoRYsnmrKplLbO3zD4g6O
X-Google-Smtp-Source: AGHT+IFJgazm2qcBXOO1WWxGq23AutwedIYScGjsNMAPrLSl9grCFKoRB3d22V6hGWsVj6fq6F18nQ==
X-Received: by 2002:a05:600c:6ca:b0:424:8dc4:ee43 with SMTP id 5b1f17b1804b1-4248dc4ef8cmr40224005e9.6.1719247446267;
        Mon, 24 Jun 2024 09:44:06 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42484fc0aecsm126090365e9.12.2024.06.24.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:44:05 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 24 Jun 2024 18:43:47 +0200
Subject: [PATCH 2/3] drm/mediatek: ovl_adaptor: add missing of_node_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-mtk_disp_ovl_adaptor_scoped-v1-2-9fa1e074d881@gmail.com>
References: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
In-Reply-To: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719247441; l=1042;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Y2BB2weXpa+LoCNHgaMdua1IE8aKDXJvx8s/YfYa6MI=;
 b=RAqXlU9Qx0xyXFz5ElRIdZf5wbyhqD1m5J/GrWFrXfBbUzgeeyRE+ciEsRkz6rmFpz1gue41A
 vrubTA59EmVC63CZJ8zl+7GhwXzFo2s4l6d2Ty9wnfS3yvCWNVBinoH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Error paths that exit for_each_child_of_node() need to call
of_node_put() to decerement the child refcount and avoid memory leaks.

Add the missing of_node_put().

Cc: stable@vger.kernel.org
Fixes: 453c3364632a ("drm/mediatek: Add ovl_adaptor support for MT8195")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 1418992311c4..3faf26a55e77 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -522,8 +522,10 @@ static int ovl_adaptor_comp_init(struct device *dev, struct component_match **ma
 		}
 
 		comp_pdev = of_find_device_by_node(node);
-		if (!comp_pdev)
+		if (!comp_pdev) {
+			of_node_put(node);
 			return -EPROBE_DEFER;
+		}
 
 		priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
 

-- 
2.40.1


