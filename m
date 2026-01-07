Return-Path: <stable+bounces-206138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239BCFD8DA
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A0783065962
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F997309F18;
	Wed,  7 Jan 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teEjtRQs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043C30C361
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787633; cv=none; b=JSQUNiNtwEgcp1pyRM75taHogoZv5b6pszazqiLBB9t1pm3yshlH+Vj/N0FzvgD22/qev4STdnOHROqOU4AelGeY1xmaiC8hrymlb0Uls1KueEAOmHQ3Av6UdS38CzVI7JSQoGqrs/7qYX2V1/wAa7NYU9j69dt/hKjHs6c+29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787633; c=relaxed/simple;
	bh=CSXofNEKnBFeMuPCIa9S/ae0Z9Hwg2kIWnPPK2JGcJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAs9o09/K0QvDRng1PBfKt8J+9yucc5sT/jjI63cyW/Px5JY5bbUvd5GhSnIO+wHW/ASXmLyZhNS+Esh72XHFXNyli773uV/dG3Yq3NLSvArrcDC0f2snO72grTlySCa/umcYkdE0yVksIiAZpqo0ybG2vApfMIU7UeY7vVf6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teEjtRQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B429C4CEF7;
	Wed,  7 Jan 2026 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767787632;
	bh=CSXofNEKnBFeMuPCIa9S/ae0Z9Hwg2kIWnPPK2JGcJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teEjtRQsLNYqIGzyj1BKPZF/WiBpVzWvFz4UEwyWIXg122p/hx6QuyTuRpRKOOri5
	 j128fe9bDMnwyO1SEvcRYFdmrheSAAV9e4IpGcMEz1Sfq1MhfYzDhx8eMbetZW2TDV
	 kWPt/k+WLSsCR0V84k1ZoNI1dCRAdzRozDKDrSyOjyUT1CkY6ffOVheGBuvYxMOAFQ
	 mkPqSWM9QxbGkVheyeBlQVApasYDKdJXXF5tPwPOty8SKh4a5Lpg5x5Q+6BWqmjPQL
	 aE8/oKNRJnwuA8wIFEQektDiETb+bEhJyq6Xsj5oNzbS4NESdy0qg9r3651I0FJhAU
	 uHmFBBlTMHYaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/mediatek: Fix probe memory leak
Date: Wed,  7 Jan 2026 07:07:09 -0500
Message-ID: <20260107120710.3990944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010513-prance-imagines-5c6a@gregkh>
References: <2026010513-prance-imagines-5c6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 5e49200593f331cd0629b5376fab9192f698e8ef ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 66ccde966e3c..9cdbac42b7f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -588,7 +588,7 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	    type == MTK_DSI)
 		return 0;
 
-	priv = devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.51.0


