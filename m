Return-Path: <stable+bounces-83490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94399AC92
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 21:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A11F2273B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D91CF5DF;
	Fri, 11 Oct 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpj8wYsV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5C1C9DFD;
	Fri, 11 Oct 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674547; cv=none; b=rDJRqIz21b3l7PxkDC1n6fOu7Dt223J2QOZxLYDtEiuKyqoix2NShNHHM/6+sSkSO/PL+/c5o49PaJVLxEcnRyuBHVjTUKlne7tXZRcxOfTViBUtsS6tSTPAQ+3rt6PosfNkBufxSx0JtGPe9jRt9/PwDsk/QfMn+jQjcZlSdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674547; c=relaxed/simple;
	bh=GACFWz+z5+whIxiIEf5wTm2vjO+WqH2Y46iheppGzXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmnlTHmyWhQd4H0Ar+SeHM/uUrZ/2QmEJs/+KuJTwzlbCTkWOZBSxa++7uC1mvSCrNy1I0m7MTyWKQw6vWB2MaLh/uk2Raa1bYa6ZlliikM5ElS0RCbtNge9X6BVzxZH5l4uDQTj1k5WoZl3cnE0Fq8JwcHLjW5kjKKiaCxzaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpj8wYsV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d47eff9acso1287926f8f.3;
        Fri, 11 Oct 2024 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674544; x=1729279344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kBIYBhNJLveBi0X8buyeW3/XiOUmPsQpigk1+cdvIw=;
        b=fpj8wYsVg47kVtOutIzHhdZvmxMC++6OfaQ61RmkIukqh4nY8Rvl+lihNsO9Mg2dK5
         cC1OxXE/aJ1rSgFCxQX2D2CNrntKOQodaRAkUI5PkzEO2S8WttbAGNQHx7I26YhRWYwp
         FVqFuSVmWGO6W02iRph0ck4oT1CzvrJBIK/ghB0lAKQFK72JT33Ym/040GdPxgu4JbB1
         xgBs1y24DJf64BlvwZJeSRdcCAWVKrxhOVNcmfD9SjyuxbKN2ZhiaeVAd82c2oo4jJx+
         /B2Hwi9OCS7V0Ycwih8Es7EsHPnnlBTvj16yYCMoa/LNhpJ2gAYEkIJJlvNnyC4wywjm
         hqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674544; x=1729279344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kBIYBhNJLveBi0X8buyeW3/XiOUmPsQpigk1+cdvIw=;
        b=RdX82BUqGzW9OscYOt1A2lWuyvGGaUJYju2zlOI7mZS/VOSYBUmojFSt7AcTS4QIKQ
         0sbnV4Xi+TZn/0mLygrTt/pTiNcVAnP5DAwZrmjFCZGOvhqM1quFuslu5tqJ7vA8cQVq
         h9Ckoqbtz00VRvL8qm4hNOM+ME4ypN4jkSS5spwYVRwPoILlmg7l+JtZTS1SphZ25n6w
         qhb9TNkSAKItIRzq8m7k4Nd7T/t1jBjgP0Y7ylbGkv0btMEzi6C8hw2pv+ih/JDW9yGa
         mycFqPRxj4mUL2ZD+ktFJPW/CHI4C5/GPmb44Z9J2bar/BabJjZIoGPjt2dd1ob7Nn1y
         /HWg==
X-Forwarded-Encrypted: i=1; AJvYcCUBjh+dzUR6w0ohofyy4qsO2vT/vi20JS9jHRsHh0dkj92pK0MGvpYXPHbVdNsqg/KzbR4V5++B@vger.kernel.org, AJvYcCVxtMCwHL5sLihnBODaWMwdZAw5Q69PFg3UhE+wB5C07RnBl0QM2EyGsVMZx/KhYBq1kH1vJYMew4sDa3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywak91vgBVGvFJvagHWLPgvhzisgKEB6fo5J8j1bW+qHtwadjDR
	JG73X0iwr1hOWNzbkva6pgfjgimszf1aDThZdfAn20MR4AttCzCM
X-Google-Smtp-Source: AGHT+IEPObY61TTZUljSGVbxJ83DtlRp1vP8GuFprN167lb4Pr6rcaZZVUv+UkSSbZYzG56rZDvzaA==
X-Received: by 2002:adf:cc8f:0:b0:37d:4937:c9eb with SMTP id ffacd0b85a97d-37d5feb13acmr443072f8f.21.1728674544198;
        Fri, 11 Oct 2024 12:22:24 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee49bsm4581663f8f.100.2024.10.11.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:22:23 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 21:21:51 +0200
Subject: [PATCH 1/2] drm/mediatek: Fix child node refcount handling in
 early exit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728674541; l=1023;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GACFWz+z5+whIxiIEf5wTm2vjO+WqH2Y46iheppGzXc=;
 b=ctsLXzl8itXZ6YjbYlz1K50LW7nQRM1QFq2Ygrbx/fh9qsjr38w6zeU3uGz61wTvN3/n+WyDJ
 l0VO+LnC28wBFlo1TkzxIJ42L0f2a0eNe3vsDXXc4rOBCnHRlQ/or2M
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Early exits (goto, break, return) from for_each_child_of_node() required
an explicit call to of_node_put(), which was not introduced with the
break if cnt == MAX_CRTC.

Add the missing of_node_put() before the break.

Cc: stable@vger.kernel.org
Fixes: d761b9450e31 ("drm/mediatek: Add cnt checking for coverity issue")

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a4594f8873d5..0878df832859 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -406,8 +406,10 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC)
+		if (cnt == MAX_CRTC) {
+			of_node_put(node);
 			break;
+		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {

-- 
2.43.0


