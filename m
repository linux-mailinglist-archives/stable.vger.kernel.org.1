Return-Path: <stable+bounces-54928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DB913B47
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1F01F20EEE
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B8194AF4;
	Sun, 23 Jun 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAbvFjKF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71A194AE5;
	Sun, 23 Jun 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150312; cv=none; b=c+hzTNduejqUVGPScpcBGtD8fGFwKakAQyDdVJ789iUMs5sjYOLEBugULYRkqldXeNSUTwmFE96WFBiL2hbmMXrJp9frQOCDNyIUjARv3lP/iUI3Wz1glefO/2GojpPy3whokmOS6c2WPFdBOR6zlBSmxso6/5vlArklNRZ0Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150312; c=relaxed/simple;
	bh=Gyyr16iESIWrB/kDPAonFTZhX1nUR1om4KmkiP7sV4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdsA8FlyxdGigtA05YbMQY6rypuguxKvZCiZrUUNcxNviF4kl8ECYG7uOIW14qdtN4Jv7dGLQZV+TtdCe2S0hNH7bH4oHFqYjt67EQTYoOhvk7MjqLvGNRW//mHTbO69969HyLZwMcIaZtrCKbhLa/Z4WSxshXHyDOCAQbIyksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAbvFjKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EF1C4AF09;
	Sun, 23 Jun 2024 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150311;
	bh=Gyyr16iESIWrB/kDPAonFTZhX1nUR1om4KmkiP7sV4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAbvFjKFnugm6mhYUdtC+nfP+L+2VHRx3JrmfjVRkam4C8pq88q12uF8VVkGLhzLx
	 obqxqS9fPyGHsnH3GLVU9Pf+xw/O+j+UxF3z00Em12RVWBaylfG1UB6jB4K0w1/6oD
	 gHxyfvrPkUAkSVgfYzqQVwpHrYI68c7Wu/8YyrKsIuw2AZSA83QpEOazkwyiIjt+jo
	 T4g2+yobQ7YHRrxd8ev7qt+gYpHLfRApWMADpS+6pS1V3f1e/y6lBIR6o6Xg/DY6F+
	 E87e6Ht2sFwL08T/74ShABLRvZBpleJsJpTkmoUptwQrxZeLhSNiVb46L7sTo/rgPh
	 bD2YITU3VZ3Qg==
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
Subject: [PATCH AUTOSEL 6.6 14/16] drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
Date: Sun, 23 Jun 2024 09:44:43 -0400
Message-ID: <20240623134448.809470-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
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
index cdd506c803733..37d8113ba92f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -926,6 +926,13 @@ static void mtk_drm_remove(struct platform_device *pdev)
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
@@ -957,6 +964,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove_new = mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,
-- 
2.43.0


