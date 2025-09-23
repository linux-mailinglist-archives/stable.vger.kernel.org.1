Return-Path: <stable+bounces-181521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDDB96916
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540E87A8A15
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61728264A8D;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpt8l3/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C423257AC6;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641173; cv=none; b=YxZIAy4pw+XST18lPWuqJuqlYQWcrj9ZYSat3xZMp1B4mmqNZesBdS2NXoJdHzjQy9mJpsMYakybKXuQSTYtZvkM0/XBNVNxdUaBHRCc24nQsEN1do6L0QNRIGi13ayJ1u2SwbETNfYh3091l6acXEkRoeJxE29CrLy4+Dw5ZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641173; c=relaxed/simple;
	bh=c0az61wbtOZUqLNGV0rJC8DczNsHSPgRUfjfrHYMoFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzaJVCbomIEGFGHKQiOSrjgODRvBifmm6UooFuIl9GBdJ8PurAhFDoNruAlmlQ67EA6Y3TF23OLTuB1w/SrqTL6pku2vropAlkStHZdPGgxvUeIPjNIqF3nzx/UboJrI8t0iSyV/BgIVxtxWltpYJKvj58bQPQTEAeDq1TAL2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpt8l3/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED311C19424;
	Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641173;
	bh=c0az61wbtOZUqLNGV0rJC8DczNsHSPgRUfjfrHYMoFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vpt8l3/lzn7Ssa2Vt1YoSEs93/7jzHiV360V7dvgkCxApbJjTW2GOqMdkr1EvTVIs
	 9xD3YVVCF7FDl7hjP9EqhjPFNIXWXndoKHp65Y81ZklzZN0to7BHHENOXKnOgcyGrm
	 UpJ7Dtgulcsj+ikFf1VNQEFgBqhIZaC21i2atkyT/TwGouHp+3dmyhExhEeyjOs4Gv
	 9FnRPmicXvu7OIzCcIfU+oo/I847RqUe23Ux5QvyCdJQfBUN3Ur9voYhUItzx/qF3n
	 WsGQqHH4RUkdl9Ot9PC9GqtGJGTlLUCZ9mbT52G8g57gvX/SkZ4YU7oPq5fduJOVi+
	 a3cKWgfhG/jGg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v14u7-000000004my-12OL;
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
	"Nancy.Lin" <nancy.lin@mediatek.com>
Subject: [PATCH 5/5] drm/mediatek: ovl_adaptor: fix probe device leaks
Date: Tue, 23 Sep 2025 17:23:40 +0200
Message-ID: <20250923152340.18234-6-johan@kernel.org>
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

Make sure to drop the references taken to the component devices by
of_find_device_by_node() during probe on probe failure (e.g. probe
deferral) and on driver unbind.

Fixes: 453c3364632a ("drm/mediatek: Add ovl_adaptor support for MT8195")
Cc: stable@vger.kernel.org	# 6.4
Cc: Nancy.Lin <nancy.lin@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index fe97bb97e004..c0af3e3b51d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -527,6 +527,13 @@ bool mtk_ovl_adaptor_is_comp_present(struct device_node *node)
 	       type == OVL_ADAPTOR_TYPE_PADDING;
 }
 
+static void ovl_adaptor_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int ovl_adaptor_comp_init(struct device *dev, struct component_match **match)
 {
 	struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
@@ -560,6 +567,11 @@ static int ovl_adaptor_comp_init(struct device *dev, struct component_match **ma
 		if (!comp_pdev)
 			return -EPROBE_DEFER;
 
+		ret = devm_add_action_or_reset(dev, ovl_adaptor_put_device,
+					       &comp_pdev->dev);
+		if (ret)
+			return ret;
+
 		priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
 
 		drm_of_component_match_add(dev, match, component_compare_of, node);
-- 
2.49.1


