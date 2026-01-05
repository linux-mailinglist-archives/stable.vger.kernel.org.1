Return-Path: <stable+bounces-204788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA0CF3CF5
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73848304A5A7
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B133EAE6;
	Mon,  5 Jan 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZE/Swyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E933E371
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619515; cv=none; b=aXLqWbDseUAgS1bTVunK5MZmjRz5eknOLIj/je4eXCrt2Jt30W0zSRbxkIi5l3FdUt9TQ720RwiDZmFetyW7x+lGCi0Rt2pdtRSui3b8qhtDQ92uuaSytWx+6/qQTnn2HpnW/jMZXF513XQ87pU6bMPrwjmPdivaLTRAidI9w5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619515; c=relaxed/simple;
	bh=x0LpMNLxfvlniISr16yJReo6CYXmzookp0IX5AyjnDk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qJyrCtwtnDPf9N5SgZs9CSO7v9gAi8NRsb9CwKCOKa1Vru0ZzjDF+E+MdEzO/IJPFwjg5T8RZjog7hdC1vzll6V5qa2d7/ocuR70CpGiC7Q6v3RoCQmT0qLQzFIouJNliAXw1X5lBzbSOLkSmhDBWJFF0B4meabmUosC9YkDs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZE/Swyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A6BC116D0;
	Mon,  5 Jan 2026 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619515;
	bh=x0LpMNLxfvlniISr16yJReo6CYXmzookp0IX5AyjnDk=;
	h=Subject:To:Cc:From:Date:From;
	b=mZE/SwyhexZxXf0SKC6zvj9lD4mFmv8Xsu62MBeSbC3q2MnG+vZIxaBoXF4GvJbcG
	 QxwjlsdZD2L9cV+U9KQoFUs7kUUtFTYOf9u4Fkmu1asqohsfX5QdphMH1S8L1MQOVS
	 XmciQJFcYSFmqLNyoLvcVviJirAER7w9EsQ9ej4w=
Subject: FAILED: patch "[PATCH] drm/mediatek: mtk_hdmi: Fix probe device leaks" failed to apply to 5.10-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,jie.qiu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:55 +0100
Message-ID: <2026010555-handshake-lego-283e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9545bae5c8acd5a47af7add606718d94578bd838
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010555-handshake-lego-283e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


