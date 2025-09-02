Return-Path: <stable+bounces-177525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C408B40BB9
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B733E1B63CF8
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980B2E2846;
	Tue,  2 Sep 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgWQh4Wy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC83054C1
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833118; cv=none; b=l3rDifkkQDtMj/xex5PqYztXlwloogkCM62gzcMIrWWdyZ591ICPiWSB3YzGdH9I2B85yfjo5bEWGdSssIhYi824X/ybrhB3wlB0phSlJxKBTCKbfVxfCjN36zjR+/chHjdf3CzJ3/IWLzEApgt33LeyCSt7UynftVQYcWiTMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833118; c=relaxed/simple;
	bh=YRYylXePqFU+2djFLuefolwqskkBcO1bOsZP4iI1D9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAwZXB0ULIeFr26aDROK6tUHEXDjxGKoVjS1awxlL+CiXeXeKeMvp212DsJb+vx0yaoRjzf7jYahiU1/lG5Qr/cUjfQO4i3s2O1ZTLZgPboKhZBByJoMk+ZQkOKaXAZ9Z6SPmqV8evMnTYJcwCnghgWJthBbksRYqayziWymagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgWQh4Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D237AC4CEED;
	Tue,  2 Sep 2025 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756833117;
	bh=YRYylXePqFU+2djFLuefolwqskkBcO1bOsZP4iI1D9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgWQh4Wy1LpgR76KL0e2cj22JgJzAAux7EQwZ/lCXHyNbvJUDxHGrwY26u7gxU+2P
	 g1L4UBlcyaEpzhL4vTQibf4P5oawsvOx3VxvFSNrIIslz8FzBsQydW7Lc7dHvRjxcF
	 1SVYnKM58AlbuloG6DIT+perFl+y8XgUYjBunrY9pkn+1XbPGtwVqK+N3aPHwNYD42
	 v9q3a4M4R8Q/W7gCgwNzuBRaER8mTjSoUK1g+w8UGhScmHKhmWFI9nFa8izuP6jFxE
	 RfX6jpMevo46k87zBxSbUtzUdTv+dYoJRX1Ka4SJ0+ZPD1N4rvZgNiOztIemKgI7YF
	 LeYXCjzOVwSwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/mediatek: Add crtc path enum for all_drm_priv array
Date: Tue,  2 Sep 2025 13:11:52 -0400
Message-ID: <20250902171154.1493908-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025090146-playback-kinsman-373c@gregkh>
References: <2025090146-playback-kinsman-373c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

[ Upstream commit 26c35d1d1646e593e3a82748b19d33b164871ae8 ]

Add mtk_drm_crtc_path enum for each display path.

Instead of using array index of all_drm_priv in mtk_drm_kms_init(),
mtk_drm_crtc_path enum can make code more readable.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Fei Shao <fshao@chromium.org>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20231004024013.18956-3-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Stable-dep-of: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 6 +++---
 drivers/gpu/drm/mediatek/mtk_drm_drv.h | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index ef4fa70119de1..9ba21b36a6f69 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -475,21 +475,21 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 		for (j = 0; j < private->data->mmsys_dev_num; j++) {
 			priv_n = private->all_drm_private[j];
 
-			if (i == 0 && priv_n->data->main_len) {
+			if (i == CRTC_MAIN && priv_n->data->main_len) {
 				ret = mtk_drm_crtc_create(drm, priv_n->data->main_path,
 							  priv_n->data->main_len, j);
 				if (ret)
 					goto err_component_unbind;
 
 				continue;
-			} else if (i == 1 && priv_n->data->ext_len) {
+			} else if (i == CRTC_EXT && priv_n->data->ext_len) {
 				ret = mtk_drm_crtc_create(drm, priv_n->data->ext_path,
 							  priv_n->data->ext_len, j);
 				if (ret)
 					goto err_component_unbind;
 
 				continue;
-			} else if (i == 2 && priv_n->data->third_len) {
+			} else if (i == CRTC_THIRD && priv_n->data->third_len) {
 				ret = mtk_drm_crtc_create(drm, priv_n->data->third_path,
 							  priv_n->data->third_len, j);
 				if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index eb2fd45941f09..f4de8bb276850 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -9,11 +9,17 @@
 #include <linux/io.h>
 #include "mtk_drm_ddp_comp.h"
 
-#define MAX_CRTC	3
 #define MAX_CONNECTOR	2
 #define DDP_COMPONENT_DRM_OVL_ADAPTOR (DDP_COMPONENT_ID_MAX + 1)
 #define DDP_COMPONENT_DRM_ID_MAX (DDP_COMPONENT_DRM_OVL_ADAPTOR + 1)
 
+enum mtk_drm_crtc_path {
+	CRTC_MAIN,
+	CRTC_EXT,
+	CRTC_THIRD,
+	MAX_CRTC,
+};
+
 struct device;
 struct device_node;
 struct drm_crtc;
-- 
2.50.1


