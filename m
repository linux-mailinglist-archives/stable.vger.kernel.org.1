Return-Path: <stable+bounces-176690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A81B3B6B4
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391CC16EF33
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA82FB97D;
	Fri, 29 Aug 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF7FcMOz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AA2E7647;
	Fri, 29 Aug 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458334; cv=none; b=ooFzzcyjxzSRsRRDCWm/KOfRS0cNfjlA9CvEc6/su6VAuSDLt9iMNOF2xdOCdAkLnyXieUC5T5FtosIr0G1mX5PrJMASXOrKOGc+mwd3camTMil0F0yliPMQq2bHoLPGKnmeO+EqWTz3HRlGl2ZifBDZrzEwo9Pz2COR3UERiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458334; c=relaxed/simple;
	bh=ivKqM50M4iw0RSehXQduIKjOJqOijpdsoVz0fl/OOBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GziQcO99jv5Qjuuk18y7TXVbQxcBmq4N68Gjn4k7aDABFgh08Re99h7ElzznKGRTQn8ankYyOditTLqgYK/i0I+bvVNBhSkFNXl7tiVz0gXVkYWY6P5b2J4jEqUQ88CnD/SdsO4zA3tbY4JtDsQGWI+D4ntiVswKP9rjjncT9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF7FcMOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9460DC4CEF4;
	Fri, 29 Aug 2025 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458333;
	bh=ivKqM50M4iw0RSehXQduIKjOJqOijpdsoVz0fl/OOBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF7FcMOzYYva//9gz2v556cx+Y++Ep1b+HAJ3LmAnQnhupdAwtkKiCvzYKg5h8zi/
	 nK2N74IQ8/Zoa3mo6w5uv1/cWVL3ZvZ+AgLmrek0If3qdKoo1NLwjdZondqkJ+8hlv
	 UFs4GmorG4DL/ZaXJqG1DBw7zi6XqjiRhOuYb7cjB9C236SAPo8AJRzzBH+YWmYYfL
	 H3m3Gs7UogVIo+FGAx/sr4+4whBDug5BVQvTam8xtuiCg3CRXS+Rtg8ecRqvltaldJ
	 HoUNmwpQta+TupsaN8Bm6jRuJkOhbRTxswIkcZhHjlMrWGkpf7Pg/ZFnY3i9hEJovB
	 itacSAnYKBdbg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urv2x-000000005WF-0cxW;
	Fri, 29 Aug 2025 11:05:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ma Ke <make24@iscas.ac.cn>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/mediatek: fix potential OF node use-after-free
Date: Fri, 29 Aug 2025 11:03:44 +0200
Message-ID: <20250829090345.21075-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250829090345.21075-1-johan@kernel.org>
References: <20250829090345.21075-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The for_each_child_of_node() helper drops the reference it takes to each
node as it iterates over children and an explicit of_node_put() is only
needed when exiting the loop early.

Drop the recently introduced bogus additional reference count decrement
at each iteration that could potentially lead to a use-after-free.

Fixes: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
Cc: Ma Ke <make24@iscas.ac.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 34131ae2c207..3b02ed0a16da 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -388,11 +388,11 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
 		if (!of_id)
-			goto next_put_node;
+			continue;
 
 		pdev = of_find_device_by_node(node);
 		if (!pdev)
-			goto next_put_node;
+			continue;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
 		if (!drm_dev)
@@ -418,11 +418,10 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 next_put_device_pdev_dev:
 		put_device(&pdev->dev);
 
-next_put_node:
-		of_node_put(node);
-
-		if (cnt == MAX_CRTC)
+		if (cnt == MAX_CRTC) {
+			of_node_put(node);
 			break;
+		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {
-- 
2.49.1


