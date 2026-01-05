Return-Path: <stable+bounces-204778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE0CF3CC8
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9BB30CD9F6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1838033E350;
	Mon,  5 Jan 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rt3HfoIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1E33E367
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619456; cv=none; b=OoTUanj1tiaZeAoy4MwV2EK3EbjiHSp9Sa6DZ5MHwzznP17CM+IgttSUEFojNk7y3lHZQudL1XAUWlQegCGE4pzca13fpNh5WVL0lVNj7KjetMMxXMHEpoA0cB8zsBXsFWYki2aqmiiHWBUfseGS8N/Od8gSomYSusaLdIRUT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619456; c=relaxed/simple;
	bh=F+z5Pq7K3xaUYSGP4hYG0bWCm7H58QjUK77IU2YDhmA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=garESizYVPRM9NsDkKB0RQ8bRqwG7F+tjSNUEO5I0yu9Sp1/lYT8wI9KY9nLKQaw9YXQKOMbFLeeeCmvr6muIOA2dUgRGN+VxHQJbHB6miEOs1GhJLBMq4TFrTfRiypuM/ygNJH56Q5J9hgy26z0RuBhU9uHXfTyiOPkIWM+GJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rt3HfoIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD7EC16AAE;
	Mon,  5 Jan 2026 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619456;
	bh=F+z5Pq7K3xaUYSGP4hYG0bWCm7H58QjUK77IU2YDhmA=;
	h=Subject:To:Cc:From:Date:From;
	b=Rt3HfoIaDMM4zIqNZnMsPrf1Wz5f6rezyVPQPsx50obN6LqYBsSk6ftVDPGXM03Vq
	 XLgk2YRhpjX4nAgPRMmRTFsX95d4eqUfBDa2bxgkcE3UMmR9OpByHAWmPSVs5FnFAk
	 XtZyVQKaffe+wJOZoDvN72IOKjhnaM0O+HyNdUGo=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix probe memory leak" failed to apply to 6.6-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,ck.hu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:24:13 +0100
Message-ID: <2026010513-prance-imagines-5c6a@gregkh>
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
git cherry-pick -x 5e49200593f331cd0629b5376fab9192f698e8ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010513-prance-imagines-5c6a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


