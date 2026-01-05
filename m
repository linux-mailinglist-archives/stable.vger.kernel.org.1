Return-Path: <stable+bounces-204776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A35ACF3CAA
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72076303F794
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058833D6FF;
	Mon,  5 Jan 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGJ0P3TL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5333E34E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619450; cv=none; b=Hs1n8J4xCBhYnLa7jkTZJGKk5Mgh4yLNb+NAF+TEfxqu4tJGsCeEps72+tDOdXMt6vB8BFYbR4kTXooxmBu0ZCgkDdkW6kx+TBYjHkvKQTtHyUZK9U1nDF3UWyPqFukYheifNDck4pPz4oNjw9dZ2l2CzezNkbL7JwJzMF4LKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619450; c=relaxed/simple;
	bh=iI2vDvRiUGv6q2KQ2yMk6HaLFvOQIJ9kbwzK4oK+CWo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cMnExgohQWp3BQH0ynhQIxFCobYasi8Y52THSqV3gDrkiOOrSyvG4NdwyOyWpdNONRtM7ErWhwRK5uaQ0RGaK8M+UbiCGgeuoZw8CnLXNilr0u2l0LW3L30b31T/XvFuez7OAB0UOsD2QCB1PiIYWmKeSG3iqcJDQd/sznU59FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGJ0P3TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF280C19421;
	Mon,  5 Jan 2026 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619449;
	bh=iI2vDvRiUGv6q2KQ2yMk6HaLFvOQIJ9kbwzK4oK+CWo=;
	h=Subject:To:Cc:From:Date:From;
	b=bGJ0P3TLtoUkBRna00GU729ErWAsat50IcYmKdm4WVTp8hukXCVNZ6CSExfEF/ZTn
	 nqq8VOBPG1EZFoM9QElqVXFWJWcHClq0wvwGIzPN3cJptAapJWJeLSDGY7TowKo9X1
	 MkyR64wjCOakAtskViJEt4dZzicX2Stkr3+BBrNs=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix probe resource leaks" failed to apply to 6.1-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,ck.hu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:23:55 +0100
Message-ID: <2026010555-epic-jubilance-b0c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 07c7c640a8eb9e196f357d15d88a59602a947197
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010555-epic-jubilance-b0c4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07c7c640a8eb9e196f357d15d88a59602a947197 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 23 Sep 2025 17:23:36 +0200
Subject: [PATCH] drm/mediatek: Fix probe resource leaks

Make sure to unmap and release the component iomap and clock on probe
failure (e.g. probe deferral) and on driver unbind.

Note that unlike of_iomap(), devm_of_iomap() also checks whether the
region is already mapped.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Cc: stable@vger.kernel.org	# 4.7
Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-2-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index ac6620e10262..0264017806ad 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -621,15 +621,20 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 	return ret;
 }
 
-int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
+static void mtk_ddp_comp_clk_put(void *_clk)
+{
+	struct clk *clk = _clk;
+
+	clk_put(clk);
+}
+
+int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_ddp_comp *comp,
 		      unsigned int comp_id)
 {
 	struct platform_device *comp_pdev;
 	enum mtk_ddp_comp_type type;
 	struct mtk_ddp_comp_dev *priv;
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	int ret;
-#endif
 
 	if (comp_id >= DDP_COMPONENT_DRM_ID_MAX)
 		return -EINVAL;
@@ -670,11 +675,18 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->regs = of_iomap(node, 0);
+	priv->regs = devm_of_iomap(dev, node, 0, NULL);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
 	priv->clk = of_clk_get(node, 0);
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	ret = devm_add_action_or_reset(dev, mtk_ddp_comp_clk_put, priv->clk);
+	if (ret)
+		return ret;
+
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(comp->dev, &priv->cmdq_reg, 0);
 	if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 7289b3dcf22f..3f3d43f4330d 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -350,7 +350,7 @@ static inline void mtk_ddp_comp_encoder_index_set(struct mtk_ddp_comp *comp)
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
 int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev);
-int mtk_ddp_comp_init(struct device_node *comp_node, struct mtk_ddp_comp *comp,
+int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node, struct mtk_ddp_comp *comp,
 		      unsigned int comp_id);
 enum mtk_ddp_comp_type mtk_ddp_comp_get_type(unsigned int comp_id);
 void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index eb5537f0ac90..384b0510272c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1133,7 +1133,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 							    (void *)private->mmsys_dev,
 							    sizeof(*private->mmsys_dev));
 		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev = &ovl_adaptor->dev;
-		mtk_ddp_comp_init(NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR],
+		mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR],
 				  DDP_COMPONENT_DRM_OVL_ADAPTOR);
 		component_match_add(dev, &match, compare_dev, &ovl_adaptor->dev);
 	}
@@ -1199,7 +1199,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 						   node);
 		}
 
-		ret = mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], comp_id);
+		ret = mtk_ddp_comp_init(dev, node, &private->ddp_comp[comp_id], comp_id);
 		if (ret) {
 			of_node_put(node);
 			goto err_node;


