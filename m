Return-Path: <stable+bounces-181523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15FB9691F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D14480BA6
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D6267B02;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7K7+f+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68824265CB2;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641173; cv=none; b=opDzvmlcWpw6SvCs/QUP2ArbTjnDAgeOxheWBikd0MSQTyiwG0ELY58w/9+Zd2NATxHBPzeo3O7HW2ea5ljTtUO9/GZW7ujbClt6S9WMUyur2ORUrvFD/sitLMvM2+MkKDUKrj8AKZMNCKmMdZENZy+GV8Xn6mu2uPf3meQAfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641173; c=relaxed/simple;
	bh=30zvSnUQBdVP9nzTp9cWqSwZXrzYK9ux1hOlnELHiMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBLKxysYotqDBXIkpjGmRNJCIPFgSKLvGDiBIQtmu8DXihdHHiQWFwY5JwH3wYShqC20SW24QCeZeUPRrLxtVG5PtJ7JgMo7gCRjtGBEOCsWv114K4aoVNKRa4OvXO7nRLjN134aYWu+ktxPIy/xedlm51avT5psAKcxFDeSaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7K7+f+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195F4C4CEF5;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641173;
	bh=30zvSnUQBdVP9nzTp9cWqSwZXrzYK9ux1hOlnELHiMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7K7+f+Rbm1S4nTXRHRqvh91O7U0m8/B6AUA+ntX4CdJJSk5ObmzTNWPnH6KZCOw4
	 UzbXvOlLO2uPG6LQtVr/w1RvH/W68P0jmfEFCjjo9cO9zhRC0xFAF+sKhbUSJXEsA2
	 LEgxPxLXpFmRZ8lyOvBOHLkrh5hN3zsSCR1YSz63lPQooVmakiahMDH1NWWoSmXL41
	 H8xEAZHP5ex9Ga9uVil+WgByS+giNxIllok+J7B5I14gJ0tr6mJn/he44FMoRWC+RU
	 szrEWjCUnwhBCNLJgwXUSHlPiUZ4EtLNyjs2bqXjTkhFm8RJh6ZG7sXu4y8BfPiqqn
	 67i83Z4IhQvBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v14u7-000000004mv-0ek6;
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
	stable@vger.kernel.org,
	Jie Qiu <jie.qiu@mediatek.com>
Subject: [PATCH 4/5] drm/mediatek: mtk_hdmi: fix probe device leaks
Date: Tue, 23 Sep 2025 17:23:39 +0200
Message-ID: <20250923152340.18234-5-johan@kernel.org>
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

Make sure to drop the references to the DDC adapter and CEC device
taken during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Cc: stable@vger.kernel.org	# 4.8
Cc: Jie Qiu <jie.qiu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index b766dd5e6c8d..306e2c907311 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1345,6 +1345,13 @@ static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
 	.edid_read = mtk_hdmi_bridge_edid_read,
 };
 
+static void mtk_hdmi_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struct device_node *np)
 {
 	struct platform_device *cec_pdev;
@@ -1369,6 +1376,10 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 	}
 	of_node_put(cec_np);
 
+	ret = devm_add_action_or_reset(dev, mtk_hdmi_put_device, &cec_pdev->dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * The mediatek,syscon-hdmi property contains a phandle link to the
 	 * MMSYS_CONFIG device and the register offset of the HDMI_SYS_CFG
@@ -1423,6 +1434,10 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	if (!hdmi->ddc_adpt)
 		return dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c adapter by node\n");
 
+	ret = devm_add_action_or_reset(dev, mtk_hdmi_put_device, &hdmi->ddc_adpt->dev);
+	if (ret)
+		return ret;
+
 	ret = mtk_hdmi_get_cec_dev(hdmi, dev, np);
 	if (ret)
 		return ret;
-- 
2.49.1


