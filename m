Return-Path: <stable+bounces-128141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BFFA7AF8C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26588188228C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812812E5DC6;
	Thu,  3 Apr 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9frtNhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01E2E5DC0;
	Thu,  3 Apr 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708067; cv=none; b=UyHAkBPRky1/HKpyC5RQ0MgEGBVkS/pfflxK3sWOnytT99DUCXiRnjGyOtSXUpDlO7WaF0kEjLoOPrLcNBncRop8empJ98a9ueLm8XSGczjPEC82BYQuJUZSCXHqwqiMbWxbywAQHts6hM8oi8cHrOvajG+rqWzgRPQO3F+AS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708067; c=relaxed/simple;
	bh=3QobBbHyYoMQCnDupcZPTHOSh3BH1fDIEJ5P9azUSN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raMVeLVtWYmx4r1MeW2c6fcRbdpiYuDNkb3EyGVO1JDnDajE/BSEJhrG4Fn2q1gMUFUvU7Q4eEdLW1nY8SKhhTH78UpYu77Ua/epZygc1RaZEDVP7M6YN+EiMknWQqFqkqTVnO+5NMCFghqLZR29hN/lc2Fiw5lmjp4fkQ8M7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9frtNhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B945FC4CEE3;
	Thu,  3 Apr 2025 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708067;
	bh=3QobBbHyYoMQCnDupcZPTHOSh3BH1fDIEJ5P9azUSN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9frtNhQ1eYLrisx6Ov+fnnbUyFaMJmAP/dNoKD2oQkzVRzKNtMjP7DxyVMGU0w46
	 z7uJJvweJckGoyw2WCiaU79TAMUX3zYJV0yF3M6hZRmmLTAZ10M65VG937oTPK5Z6e
	 /mbJ7rDBR4iTG8kAUHB3jhlp8syam0IzHcZI39OC974bh92dg+8o38YVsLBv7BFOjh
	 FbNqw/dNVWo6HnCqn+oWXjMtszm8+MQ4W3A6NXsAwfNRaoiCZyimWlZLRIGYVaDtmI
	 OWHrdV5t4UZQr1t7q2A+GGK0BP9a46R7bXae2PZ4/8625LWFT7YWO78XXsbipDmpkG
	 MQi5hfrXxbtyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 7/9] drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off
Date: Thu,  3 Apr 2025 15:20:48 -0400
Message-Id: <20250403192050.2682427-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192050.2682427-1-sashal@kernel.org>
References: <20250403192050.2682427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 473c33f5ce651365468503c76f33158aaa1c7dd2 ]

In preparation for adding support for MT8195's HDMI reserved
DPI, add calls to clk_prepare_enable() / clk_disable_unprepare()
for the TVD clock: in this particular case, the aforementioned
clock is not (and cannot be) parented to neither pixel or engine
clocks hence it won't get enabled automatically by the clock
framework.

Please note that on all of the currently supported MediaTek
platforms, the TVD clock is always a parent of either pixel or
engine clocks, and this means that the common clock framework
is already enabling this clock before the children.
On such platforms, this commit will only increase the refcount
of the TVD clock without any functional change.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250217154836.108895-10-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 7c68a39339150..191e0cec004b4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -366,6 +366,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -382,6 +383,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_engine;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
@@ -391,6 +398,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
-- 
2.39.5


