Return-Path: <stable+bounces-204783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9FCF3C68
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E02DA301A4FD
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55696286430;
	Mon,  5 Jan 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xAv+rcth"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D233DED6
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619491; cv=none; b=sc7SsIs9JW2Lf4VaOCS6cd+HdU/Y0dSMyP3mBhHfmc6ob0i5cDAS+v+wnUoNkY7ToyO/efNPg4rJV8mVZneRqy+v2pETX8TsPzNNVpw54JXecew4EwB6tffbAkPBM4jAfjUw7wuLGLROnaFxGb8GGKuW7tEBEbJN79f3cZ7ng2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619491; c=relaxed/simple;
	bh=Up5QtzNIZoo3w7RNKDHJsdxppmsb668U+MTr3bvuSk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XrtFHIarebH/CjGA/CfRCWuZKq7NOXIbSrNQZ7uvQdSLv8jnKLoDBjf3Bo6PMJtcxFaz7R8f6DFHL6WMK+oCBAI45LbBFrJOeedUqohzQWJJDNS0qYhiXM7s2KPpTYdmJpTsWRLZC6o8Mn+p/sG64TVbPcrhrMqQA1C39n34T0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xAv+rcth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DA8C116D0;
	Mon,  5 Jan 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619490;
	bh=Up5QtzNIZoo3w7RNKDHJsdxppmsb668U+MTr3bvuSk0=;
	h=Subject:To:Cc:From:Date:From;
	b=xAv+rcthZvBg1Gv1oc7PuXGgEZhh3xHlPACbz4k82cGq1SOB1fysrDE2ZF41Hkqid
	 mNr2VEz25FOFHTb6aQFUs3uVCzs4IcOxni/malhDARKqwo/UdGuw++A6ljX2AlUDaK
	 7pe/3GcHIelHXrQcGpad/btmIlJQRQHsjPBjXjdY=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix probe device leaks" failed to apply to 6.1-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:36 +0100
Message-ID: <2026010536-tactical-stash-b431@gregkh>
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
git cherry-pick -x 2a2a04be8e869a19c9f950b89b1e05832a0f7ec7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010536-tactical-stash-b431@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


