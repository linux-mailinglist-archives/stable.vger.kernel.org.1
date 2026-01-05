Return-Path: <stable+bounces-204782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F220DCF3C65
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13466300A504
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6E33EAFE;
	Mon,  5 Jan 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrjkDAKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774733EAF5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619487; cv=none; b=ZF7zpHNI1SouKaUAbfuiZ9XNZgq9Vy5FBl3JlHkqBToHwP6EyCt0gd3oh24tBQaOFxhxg6M6Mv/AWgWxh4nRpjkZ5T6/KwQT5LhdD2uibwC1bxBY7hOtZdT0F8JBaGzkscg5wVgAOeqndPJtgj8DdqS6cNigjgPHOYtBVqJ6Dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619487; c=relaxed/simple;
	bh=KMUjHbbc+gyT3N0m5wt7cTLXLPzeIOvX6+V7d9BSun0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pA7Pem+XZon3U/k7NZzCU9cIu6x/w0raSL8vE/4XrIte1Xy/oC1hunTtAMCUOHj3+e4EkJj1yplsSx1V6aj0kIc8sHyN+UpiOPZ/ve+IsIqJluarr/NATx4T9bykfXfQAGkr8hhEo3/Is1f+yKn14MUiqmkAP+C0TBBbXGVs6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zrjkDAKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E809AC116D0;
	Mon,  5 Jan 2026 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619487;
	bh=KMUjHbbc+gyT3N0m5wt7cTLXLPzeIOvX6+V7d9BSun0=;
	h=Subject:To:Cc:From:Date:From;
	b=zrjkDAKsc/EhVzsOmSD3IWM2DELHZU7XARRiAHtmF5IyVE/wecA755p5WFKdywk5I
	 cj6oFZZAMp61JOWLxZKU9Z9GSFCi2ERDaQw2txSiARhQFxeHw4AbSzgS1DCnVT0aiZ
	 1wbn6KXO6gTTzNIs5TILubFuJ3781SuVcuFVu8uE=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix probe device leaks" failed to apply to 5.15-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:36 +0100
Message-ID: <2026010536-dotted-gratify-58a1@gregkh>
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
git cherry-pick -x 2a2a04be8e869a19c9f950b89b1e05832a0f7ec7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010536-dotted-gratify-58a1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a2a04be8e869a19c9f950b89b1e05832a0f7ec7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 23 Sep 2025 17:23:38 +0200
Subject: [PATCH] drm/mediatek: Fix probe device leaks

Make sure to drop the reference taken to each component device during
probe on probe failure (e.g. probe deferral) and on driver unbind.

Fixes: 6ea6f8276725 ("drm/mediatek: Use correct device pointer to get CMDQ client register")
Cc: stable@vger.kernel.org	# 5.12
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-4-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 31d67a131c50..9672ea1f91a2 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -621,6 +621,13 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 	return ret;
 }
 
+static void mtk_ddp_comp_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static void mtk_ddp_comp_clk_put(void *_clk)
 {
 	struct clk *clk = _clk;
@@ -656,6 +663,10 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	}
 	comp->dev = &comp_pdev->dev;
 
+	ret = devm_add_action_or_reset(dev, mtk_ddp_comp_put_device, comp->dev);
+	if (ret)
+		return ret;
+
 	if (type == MTK_DISP_AAL ||
 	    type == MTK_DISP_BLS ||
 	    type == MTK_DISP_CCORR ||


