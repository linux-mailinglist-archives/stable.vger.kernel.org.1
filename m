Return-Path: <stable+bounces-69968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0895CE91
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4846F1C2116A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36D186E24;
	Fri, 23 Aug 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEY6Lmg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03E91DA5E;
	Fri, 23 Aug 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421685; cv=none; b=m7Li9HKxFT/T/sMw1T6DvnoVW9uuTP4m4xWbK/QpcKogYo0r2BfLx6cnO8OKxF5i36vZs6mtG2w3l4IvGZ2irdSMHW/WcZx9bTEBxL+m0Tv0wA0nvZgQiWozbXEq/8TOJeFOMyBy6xaqvDqf2mqZRnzzc9fBcoW2tsbIc1xgO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421685; c=relaxed/simple;
	bh=v2GAa73zU3iAPH4GtRJqLTx0Fal/h2Cne66iizWEres=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrvreYD9FlEunmw1oIFzsD8w1K+mEURD63IIG/OnBQ8Ai5M+TSBswregdQrQE5h8ZKvlTnxXZ5EMCg9ns6hOYZ10z3dNP/oM34BC3S+gkA3PLtVrIPrumiybb4hzKtze4FXXRH+e66DGG5KAZsdBxdWI0F6kL+NQjClXCw/99c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEY6Lmg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF39BC32786;
	Fri, 23 Aug 2024 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421684;
	bh=v2GAa73zU3iAPH4GtRJqLTx0Fal/h2Cne66iizWEres=;
	h=From:To:Cc:Subject:Date:From;
	b=sEY6Lmg2697Gb5W7EOVk2j2o0tsWUniwfwvn//pp5zFQeEYbEcC3E+sp1V33Vedrk
	 tSnjRASP4DASHj0tacdzJUu5Iq4hDy1HXgRPddNnPQshtAGNabDL5W3iHBzSUnZal5
	 BlgyPyEpifi9FwXgV0IOgT2wZYyTwmHYuYbjxpW4S+TA6ERV7w1aoPOwAnjfyXth+C
	 8NsRgzAm9ojH0SY0Hc8zOiImIoXq1oPSHgaFzBTv9NAjPWdQmYr07dDCaZk7FTSUzw
	 qS6atd4+QPVYn54+hacIaCKOr14P1xkFtXCuk0ewdu+l9rzuQfMKTTbPLncdMLaHRP
	 EIu20ucH+Hm6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Fei Shao <fshao@chromium.org>,
	Daniel Stone <daniels@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 01/24] drm/mediatek: Set sensible cursor width/height values to fix crash
Date: Fri, 23 Aug 2024 10:00:23 -0400
Message-ID: <20240823140121.1974012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 042b8711a0beafb2c3b888bebe3c300ab4c817fa ]

Hardware-speaking, there is no feature-reduced cursor specific
plane, so this driver reserves the last all Overlay plane as a
Cursor plane, but sets the maximum cursor width/height to the
maximum value that the full overlay plane can use.

While this could be ok, it raises issues with common userspace
using libdrm (especially Mutter, but other compositors too) which
will crash upon performing allocations and/or using said cursor
plane.

Reduce the maximum width/height for the cursor to 512x512 pixels,
value taken from IGT's maximum cursor size test, which succeeds.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240718082410.204459-1-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 56f409ad7f390..ab2bace792e46 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -539,8 +539,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	}
 
 	/* IGT will check if the cursor size is configured */
-	drm->mode_config.cursor_width = drm->mode_config.max_width;
-	drm->mode_config.cursor_height = drm->mode_config.max_height;
+	drm->mode_config.cursor_width = 512;
+	drm->mode_config.cursor_height = 512;
 
 	/* Use OVL device for all DMA memory allocations */
 	crtc = drm_crtc_from_index(drm, 0);
-- 
2.43.0


