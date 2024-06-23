Return-Path: <stable+bounces-54910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C2913B14
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88E3281E16
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079118735E;
	Sun, 23 Jun 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERvrcfIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23E18734B;
	Sun, 23 Jun 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150275; cv=none; b=IyFGS4a9+Dro9Plu1z1LoaU2bq+Oz5HwjI2iHWzc0wc4inBaqHwkaKkx2OhKCVF/UlAlD01LRI3yjncNKbVR48NJXWWySMsaMh9Ue+VYJNEm6YY6Y7fQ3RWiLaQvFKxNsmLNpCOUi1AdmQuSBepdGUlK+JmaEUQ5bpU8PGP+Mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150275; c=relaxed/simple;
	bh=1iEt7pWGYS2hyN5GpFzmy5TaSS/4n7EjJ6M5ocC9fBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubgN8fMh618pfcEkzMwXWELGK6UgSpIuwJba9EFbEVIz7bFqD2ZQRCF+wR3IKqKimHpWJMt5C8In+1pwpgjAyefZuCSc6umdADtf27z+EmS0YItcCs1F2Z/xBQqRbwDFZQ+RtBaTy1TUV4ZLEU7r66Bff/Zps0cdexUqQmAM3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERvrcfIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C383BC4AF0A;
	Sun, 23 Jun 2024 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150275;
	bh=1iEt7pWGYS2hyN5GpFzmy5TaSS/4n7EjJ6M5ocC9fBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERvrcfIBKr2hjPW6yvLt1ujHozicSc7NQRJn2fMaHK1EmtGaR49Euwh+nFpXNnP0k
	 7nSfGpwO4bu01BPwW+RYOApXpoYJ9q8OJu/P+GZ49WOGeBCet7xGsNS9LpXrXQl+nK
	 bbkiCxgjtHvqaBoM5/TICsgBZGu3Rsb0AaXLv88cJ8VrBHik4TsGmCBYwJAjpjud/m
	 G1javHZUXHcKkxJPrkSCiYUwZPOfzYPjjCG0l+Iy+B9Nhi3+QBWGZ0OGO1/oEZHnb6
	 9SPl7JOwm805gU+ZRWs59y5tonBXzsB+0NbAoL1ar9RwpDWq7pObtQdELt/gnNPhRC
	 jYfmMXK4/Rf5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Fei Shao <fshao@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 17/21] drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
Date: Sun, 23 Jun 2024 09:43:50 -0400
Message-ID: <20240623134405.809025-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit c38896ca6318c2df20bbe6c8e3f633e071fda910 ]

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

This driver users the component model and shutdown happens in the base
driver. The "drvdata" for this driver will always be valid if
shutdown() is called and as of commit 2a073968289d
("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
noop") we don't need to confirm that "drm" is non-NULL.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 74832c2130921..0b570e194079a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -950,6 +950,13 @@ static void mtk_drm_remove(struct platform_device *pdev)
 		of_node_put(private->comp_node[i]);
 }
 
+static void mtk_drm_shutdown(struct platform_device *pdev)
+{
+	struct mtk_drm_private *private = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(private->drm);
+}
+
 static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
@@ -981,6 +988,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove_new = mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,
-- 
2.43.0


