Return-Path: <stable+bounces-177527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF176B40BBB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6CB3B90D3
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12718310654;
	Tue,  2 Sep 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imLd0ZkY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C62E11B8
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833119; cv=none; b=XI5bQqy7uznTyHBJgNzrxitX/lX4SgfxczqJE89wm1mFyvSC87MALgzlTr7VJFAzJYQ/bI/U8cDp49oC6w1Vfz1awG1aHNlwXFlfVkeeKsTgh/VNR18HW9Z/iG+6XoyoOaUir4eUfczGGZ02D1me/tidr9k1vImKAQ5LXqSpK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833119; c=relaxed/simple;
	bh=dHyMC6l+GcyGaedbR+h3iDfvGqOP6hG4+EWLny3uhco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM007eaEO9xarr/qaDzRF3k349dRj3rnG5xIC1FUOXQP6XF3hKycGIqM5XrZMsUcn2CEbDAE/hMNXJxbgk043eTM1p+dnxPkV0P+DxXQEEV5t2pKAyuv0k9mnEmcip3fDzqdtlMXJ0nLBWFobUgp1ka/ZfeUs7NfxLSd9liYUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imLd0ZkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE6C4CEF5;
	Tue,  2 Sep 2025 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756833119;
	bh=dHyMC6l+GcyGaedbR+h3iDfvGqOP6hG4+EWLny3uhco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imLd0ZkY1GMu9c2X/ANHFTWc28E/jf1eXO+5mtP1sV9teSWUvEv5xIG4UXsoGgG1K
	 egK4nPhZ45GqMY5CFLGPsGf8w8Cb95//klBYEU+iBgVrNK39o7AoTCEJCf9ErX1kQ6
	 pdfhlr/fZnmmUZwcKLxe/FvD+yb2abYjgJSQoaJDLBybQhQNMY1bUXSOD4uwEna0yd
	 2InjemU/x6SV6XvmFPnNYTLiJaYfWJyQalVYVjHGyl1HTvITUmDLvhuCU2Ls3o2E7Z
	 VGAl59gLqP1a8bKtJzS/HEp9Ga+87E6sPk3/SJ62kSUrNreeKXHtE/KCVrjbE/IfzL
	 wVnbbY3Oh7EaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv
Date: Tue,  2 Sep 2025 13:11:54 -0400
Message-ID: <20250902171154.1493908-3-sashal@kernel.org>
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

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit 1f403699c40f0806a707a9a6eed3b8904224021a ]

Using device_find_child() and of_find_device_by_node() to locate
devices could cause an imbalance in the device's reference count.
device_find_child() and of_find_device_by_node() both call
get_device() to increment the reference count of the found device
before returning the pointer. In mtk_drm_get_all_drm_priv(), these
references are never released through put_device(), resulting in
permanent reference count increments. Additionally, the
for_each_child_of_node() iterator fails to release node references in
all code paths. This leaks device node references when loop
termination occurs before reaching MAX_CRTC. These reference count
leaks may prevent device/node resources from being properly released
during driver unbind operations.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Cc: stable@vger.kernel.org
Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250812071932.471730-1-make24@iscas.ac.cn/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 68a4c77951891..bfa1070a5f08e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -365,19 +365,19 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
 		if (!of_id)
-			continue;
+			goto next_put_node;
 
 		pdev = of_find_device_by_node(node);
 		if (!pdev)
-			continue;
+			goto next_put_node;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
 		if (!drm_dev)
-			continue;
+			goto next_put_device_pdev_dev;
 
 		temp_drm_priv = dev_get_drvdata(drm_dev);
 		if (!temp_drm_priv)
-			continue;
+			goto next_put_device_drm_dev;
 
 		if (temp_drm_priv->data->main_len)
 			all_drm_priv[CRTC_MAIN] = temp_drm_priv;
@@ -389,10 +389,17 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC) {
-			of_node_put(node);
+next_put_device_drm_dev:
+		put_device(drm_dev);
+
+next_put_device_pdev_dev:
+		put_device(&pdev->dev);
+
+next_put_node:
+		of_node_put(node);
+
+		if (cnt == MAX_CRTC)
 			break;
-		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {
-- 
2.50.1


