Return-Path: <stable+bounces-181524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60398B96922
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84012480CA5
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155326A0DD;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6yt8Dd0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875326563B;
	Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641173; cv=none; b=kZxxpnE+/NbXpg26ewOpuINoMKU7MvCZtX7Z4VLsjtcHAZyXoTym44hu4jNoQlAK8chFBYGcWCptSo8qM66l2iBWinZ2EHXHH+Go/mM20mq3YMqAElcsI9uWvT8BKwYxGX0yiz8bx9BBTPJzeRAZG3OfE1fJkg5mk1Mx7H+Emag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641173; c=relaxed/simple;
	bh=CX4657yA0nVtCwJ99HeYU2TEyd1VwUMZkfyJlumA3Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI2Qr2L2rLdL20wwLkYCHZJS9gOCXNOZC77oNIogLKwhQeadOGcUEhImZofJeqCL7nQJLxgp1axvpmOtMnUDek3h6z8yVjUDfJ+Uy8oGIcH1KDF8LRvnlCj8n8gY6bVw8DiRHo5OmfByL9mzOBlfELotmkpprBGamsFWr/mXmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6yt8Dd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEFFC19421;
	Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641172;
	bh=CX4657yA0nVtCwJ99HeYU2TEyd1VwUMZkfyJlumA3Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6yt8Dd01hQYW7tFm79LRMPeF/k8WJfQrQ6DVn9XeoMSORQUvMUWKMVYjfp+9NK3P
	 aIO8luiitVPFhEwFFLo+5I9JRBV7pDAvnqQ+8G4YENa2T3LPaejd+WeQud+A7mphpn
	 NVRjF/8MxbKvINvHJ94CuPM6d2liKLZp2SXm4L7/1tfmBTU1alO/fRO4l1JjB4CP6Y
	 PNBq7/dDQVlugxp5DnejPAzsIL3h51y+ZSA9pC7pDcgJ68UOCQkLNRDWa51hiSgC6U
	 AnGaaSkoRnrRFVo9etYvwoG6s9EGY3m9HVfCEbEBMt4ugU6z9+ji528EC/N9HsB6BM
	 M2/2IchSh+InA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v14u7-000000004ms-0HWq;
	Tue, 23 Sep 2025 17:26:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] drm/mediatek: fix probe device leaks
Date: Tue, 23 Sep 2025 17:23:38 +0200
Message-ID: <20250923152340.18234-4-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250923152340.18234-1-johan@kernel.org>
References: <20250923152340.18234-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to each component device during
probe on probe failure (e.g. probe deferral) and on driver unbind.

Fixes: 6ea6f8276725 ("drm/mediatek: Use correct device pointer to get CMDQ client register")
Cc: stable@vger.kernel.org	# 5.12
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 31d67a131c50..9672ea1f91a2 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -621,6 +621,13 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 	return ret;
 }
 
+static void mtk_ddp_comp_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static void mtk_ddp_comp_clk_put(void *_clk)
 {
 	struct clk *clk = _clk;
@@ -656,6 +663,10 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	}
 	comp->dev = &comp_pdev->dev;
 
+	ret = devm_add_action_or_reset(dev, mtk_ddp_comp_put_device, comp->dev);
+	if (ret)
+		return ret;
+
 	if (type == MTK_DISP_AAL ||
 	    type == MTK_DISP_BLS ||
 	    type == MTK_DISP_CCORR ||
-- 
2.49.1


