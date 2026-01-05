Return-Path: <stable+bounces-204780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2640CF3CD1
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CA43051EBC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CD33DEF7;
	Mon,  5 Jan 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jib4UKES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587233DEDD
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619466; cv=none; b=aAfgMTb/SDTE/J9guLOsx5vioxSDX/HGjqDvHsBMLgzdPbkptov2XPt5y8hbJAnqA6NDG1CQBV/AwVCVVImWOYxYDXxrYgSzsHsFU/yz8XceimTJPymtduJQk0Siq3UtDTb9Xzo8+WX3tE84FSf7qAJW28LBtdREWhDWCjKsbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619466; c=relaxed/simple;
	bh=MtTZUxO67k1MUrDDpGWDF4EQ1fODKx86nTjM68SXdX0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qFnMZfwOIzdHmHEAcbM6S3bOYmpXTczg0FkJdMtFZZohfoGaLDsGG0ks+GUoprURjOusnNmvyf8F3X8AosFrhVNN5wCnzoetmZQt2z6KdWmFcm/Tc0jETcYe8a+RPWzB9xVcvD5OFEr+9wlFl/6kgEDyaYQ1LDnG8s86PrReDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jib4UKES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85115C116D0;
	Mon,  5 Jan 2026 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619466;
	bh=MtTZUxO67k1MUrDDpGWDF4EQ1fODKx86nTjM68SXdX0=;
	h=Subject:To:Cc:From:Date:From;
	b=Jib4UKES3NiE2urNOcKvmWlPuUXFR54KQUuZi1DkgbokGBWI3cv6XFupmGOq6oWPi
	 MoUjoSc38gH7scDRYvVyicJCErbbX/aV/8fkAu/e3W3PmuVv2Xjvm4xQw5dYR+hlS4
	 KQXPfVnwbErWaaEcD22DnC98ticBQILqceFdqLos=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix probe memory leak" failed to apply to 5.15-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,ck.hu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:16 +0100
Message-ID: <2026010516-unfrosted-serotonin-e7b7@gregkh>
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
git cherry-pick -x 5e49200593f331cd0629b5376fab9192f698e8ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010516-unfrosted-serotonin-e7b7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e49200593f331cd0629b5376fab9192f698e8ef Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 23 Sep 2025 17:23:37 +0200
Subject: [PATCH] drm/mediatek: Fix probe memory leak

The Mediatek DRM driver allocates private data for components without a
platform driver but as the lifetime is tied to each component device,
the memory is never freed.

Tie the allocation lifetime to the DRM platform device so that the
memory is released on probe failure (e.g. probe deferral) and when the
driver is unbound.

Fixes: c0d36de868a6 ("drm/mediatek: Move clk info from struct mtk_ddp_comp to sub driver private data")
Cc: stable@vger.kernel.org	# 5.12
Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-3-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 0264017806ad..31d67a131c50 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -671,7 +671,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	    type == MTK_DSI)
 		return 0;
 
-	priv = devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 


