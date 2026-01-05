Return-Path: <stable+bounces-204786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C964BCF3C74
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4179B3008C83
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810EC33EB15;
	Mon,  5 Jan 2026 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUNLnZJB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839333F36B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619509; cv=none; b=hq5uR2tMXmmstj0wmqY9xJ8Hj/PVVzRmpZQRU4q3GFYKZqRnXRMohGSf9Czer5PzH2hns0DIiWLvzUrdrcDwP13R04hdEMZWH/51GpH/97C+NJCHKn+nqJZE2clMlTxQHlAwp7F3Xa5Uf7MOd6i4ncwTPK9hJa3OAX81rFw0nSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619509; c=relaxed/simple;
	bh=nwQzH56ZhoJYD06v5W1NMwGkzk+vcV9LWTxfEUdn3TY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WXdEpq7eSuifVdC91hKgsRugv3zG+mfroQlzycpS+xLhoDqIhtUfV+b/uU3rK6cUlPS0COfY41/2yIO3dp6kfFmEMr7DyqLpcBPLXvHKT5BuJzpcltWnAOEOycszBx9aQOy3VpihvS+Cw1x5oeDUqg6a65luNYEc4mwi/69kmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUNLnZJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE8FC116D0;
	Mon,  5 Jan 2026 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619508;
	bh=nwQzH56ZhoJYD06v5W1NMwGkzk+vcV9LWTxfEUdn3TY=;
	h=Subject:To:Cc:From:Date:From;
	b=pUNLnZJByKuxb6iOxorWlUyrwOTPjmIXCVhGcV5ueH0YV9vzdipc8mtg/Yp4QPAzx
	 AKZcr2doAlcIpXJHunSZ1Zs6VwAaRvUgzLhxNETxxx3nO33fN9kenX/r/KpO85Vh9m
	 dpxZ2bzsJzF0v0FqV9omYAj0pP8YZeo80OeIfyhg=
Subject: FAILED: patch "[PATCH] drm/mediatek: mtk_hdmi: Fix probe device leaks" failed to apply to 5.15-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,jie.qiu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:54 +0100
Message-ID: <2026010554-animating-oxygen-ccbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9545bae5c8acd5a47af7add606718d94578bd838
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010554-animating-oxygen-ccbf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9545bae5c8acd5a47af7add606718d94578bd838 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 23 Sep 2025 17:23:39 +0200
Subject: [PATCH] drm/mediatek: mtk_hdmi: Fix probe device leaks

Make sure to drop the references to the DDC adapter and CEC device
taken during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Cc: stable@vger.kernel.org	# 4.8
Cc: Jie Qiu <jie.qiu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-5-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

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


