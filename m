Return-Path: <stable+bounces-204781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F64CF3CF2
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ADF631235F5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8033DEE7;
	Mon,  5 Jan 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HgYybaNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C233E345
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619479; cv=none; b=VkZi09NZUAOXVIaXY/NGiZSqQm7HBpEkaUyOSUIfYVCp/eBkmqMUdOmU3TBo356RBzcH2rixeXov1zMFBMHYSGfY4hL38CX9JJnwhDkioU6Gkambzcfu6ubk20pjL8HOuI5wnIG8jFm684lGyByFoxwybivbr2AhWQjeenIWvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619479; c=relaxed/simple;
	bh=zdCH0sSl2fOxk/DYGSqqFGtlE8IbEtXPyBvKCDGI2Bc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qr8U+wNFAWANbkjhuCx3jwx6DPCLi5JUnZjWWh/VGvwFazqjwi3algIF5bj2Ofbza+TjgVa7GFXX1o4U68BGit6EWCnxm9z4EX/ZK+YmHLtRHYrMgH9VSw3l3tWuPf5F2t4NXKrrhbkJNIBDTj7W8/lRisQpEHHvXaDDsHsNNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HgYybaNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64540C116D0;
	Mon,  5 Jan 2026 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619478;
	bh=zdCH0sSl2fOxk/DYGSqqFGtlE8IbEtXPyBvKCDGI2Bc=;
	h=Subject:To:Cc:From:Date:From;
	b=HgYybaNrmXKsyBEMpBR4Y2LOXx/pQ9oSGZmRbs1e9dmaDRufHP3fd+D1wANAJOwVf
	 MD+tQ0aHj6msKpWHdRzNpuGN7gO2lLBKbzRBA9NL98xC7pCntFwCZUENIfncg6OJc3
	 86Wi3pZhYx7hiu2C8NsC5MZOqeULMfOxfMPUfMZc=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix probe device leaks" failed to apply to 6.6-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:35 +0100
Message-ID: <2026010535-promptly-succulent-ecc2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2a2a04be8e869a19c9f950b89b1e05832a0f7ec7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010535-promptly-succulent-ecc2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


