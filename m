Return-Path: <stable+bounces-177526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC332B40BBA
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E96E1B63D8C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9E341651;
	Tue,  2 Sep 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYccjX95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B43054C1
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833119; cv=none; b=M7tL41209d3PsyXHoxW4W2GUGC+d4k3dLD2RdLQ+6m9YaEd/DyHc6zQa+AIynaQpcsxHP9wyHCkhVFWCwGBDeuByaEtfPsjVwn65RPjTyth67qXt3b4h1/q3BcevmatyUrol9rZDOLj+ZiRALcO75Rer6/355F0HKZfcxZITVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833119; c=relaxed/simple;
	bh=tNDWUHJy36LIwoe/oS9EHLmkoky+7qGCbYPQZgYYasA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG/OPwG2xCS/Uth/bF2VFIUUsXbL363sFWxGncxSDDTX1+msvOlt1zi4orvqncayUr/kllkz5P4LIO79jLWFCAji6uzPCN4SGwm99v2p59TgYFeItzFXLJXLBiETyrOv4F9z5uU6ES3THoX/FkJ1Ad8modKzkbqzN0FlykqSKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYccjX95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C5C4CEF6;
	Tue,  2 Sep 2025 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756833118;
	bh=tNDWUHJy36LIwoe/oS9EHLmkoky+7qGCbYPQZgYYasA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYccjX95404kLqyjqmQ+TLnqT/P3Ms1WVuCaSGL0hM7/BIfdNIRn/SKQWJlH5FdEK
	 ztLcHq6wl29gS0kHlce7sdRITmxEVQzvdLE/dBHdwdDmEyN8J0Wjs2W2qtFdAGWXYN
	 bvMGi/RYq0W9aqK13yFA7lKdYsWnhtc9EG6/f7RD2OEo2LlLhrgpKwgFRJ0TaB9DpZ
	 V8PCvyQZ16dDasUzcMPhEYe65cQKSZ/RkFLJFCxJ9bmPWjTv5JZGFHZ8vw10fzxJmi
	 BMb3WuieBv8fqyaeXVdDKT5gs9UMD2ysSBvUBOY9x/HpSIDBClxBaxaor3gxrCZh4W
	 MubaNmYENWQtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] drm/mediatek: Fix using wrong drm private data to bind mediatek-drm
Date: Tue,  2 Sep 2025 13:11:53 -0400
Message-ID: <20250902171154.1493908-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902171154.1493908-1-sashal@kernel.org>
References: <2025090146-playback-kinsman-373c@gregkh>
 <20250902171154.1493908-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

[ Upstream commit ebba0960993045787ca00bb0932d83dad98c2e26 ]

According to mtk_drm_kms_init(), the all_drm_private array in each
drm private data stores all drm private data in display path order.

In mtk_drm_get_all_drm_priv(), each element in all_drm_priv should have one
display path private data, such as:
all_drm_priv[CRTC_MAIN] should only have main_path data
all_drm_priv[CRTC_EXT] should only have ext_path data
all_drm_priv[CRTC_THIRD] should only have third_path data

So we need to add the length checking for each display path before
assigning their drm private data into all_drm_priv array.

Then the all_drm_private array in each drm private data needs to be
assigned in their display path order.

Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Tested-by: Fei Shao <fshao@chromium.org>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20231004024013.18956-4-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Stable-dep-of: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 9ba21b36a6f69..68a4c77951891 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -352,6 +352,7 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 {
 	struct mtk_drm_private *drm_priv = dev_get_drvdata(dev);
 	struct mtk_drm_private *all_drm_priv[MAX_CRTC];
+	struct mtk_drm_private *temp_drm_priv;
 	struct device_node *phandle = dev->parent->of_node;
 	const struct of_device_id *of_id;
 	struct device_node *node;
@@ -371,11 +372,21 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 			continue;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
-		if (!drm_dev || !dev_get_drvdata(drm_dev))
+		if (!drm_dev)
 			continue;
 
-		all_drm_priv[cnt] = dev_get_drvdata(drm_dev);
-		if (all_drm_priv[cnt] && all_drm_priv[cnt]->mtk_drm_bound)
+		temp_drm_priv = dev_get_drvdata(drm_dev);
+		if (!temp_drm_priv)
+			continue;
+
+		if (temp_drm_priv->data->main_len)
+			all_drm_priv[CRTC_MAIN] = temp_drm_priv;
+		else if (temp_drm_priv->data->ext_len)
+			all_drm_priv[CRTC_EXT] = temp_drm_priv;
+		else if (temp_drm_priv->data->third_len)
+			all_drm_priv[CRTC_THIRD] = temp_drm_priv;
+
+		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
 		if (cnt == MAX_CRTC) {
-- 
2.50.1


