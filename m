Return-Path: <stable+bounces-183410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55723BBD7F0
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6761893CF2
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE22066F7;
	Mon,  6 Oct 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur8POXtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E31F37D3;
	Mon,  6 Oct 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744099; cv=none; b=dVgMdTEbTxY3CFEruoODQVaYlkoewUvl6FOxn/HWVtgo1ecZ9kM+Bvl3c7utfOqZ6RkV40tI3iZnHeOrOPMQSE28by5D+gU4grKksCEOtnTlyd5uh3eOL5vi1jf9LDdWstz1agS294EiWsDLnSXIQvZPiqlrUU1PRDgYaKZvrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744099; c=relaxed/simple;
	bh=11bNMYyZMUwsQqMUsvi0X3mz9BqFp/BUiE3cpj9uHmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/n6RXr0sjwhnMed+T8b399sQppvcS1iGI9aIEBl68D1WEnrHnU6HF6i4gxZ+q2lJc8ISaoWTBIirQS82Q9zuxRYNFkO5MueSY1VN9erlxQWayJTbrgvfNo7o24cbbpbLAfsV2UsY64ZHd1h3cD2cIR2p6crvDgDDFcqFii7P4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur8POXtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE33C4CEF5;
	Mon,  6 Oct 2025 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759744098;
	bh=11bNMYyZMUwsQqMUsvi0X3mz9BqFp/BUiE3cpj9uHmo=;
	h=From:To:Cc:Subject:Date:From;
	b=Ur8POXtbkzOL6qjhq7MdssPEc9+vJgK2MlLDJHH5kGeZzO37hzg7/oKpSR3wJGmdz
	 yPdejFaHMgc7Z5+vN+u+XHgdqARpXB/5UQnKM2FM3rMXa+MvwjkIFRxMTpdatfj0Z7
	 bkvmlzOITPBMvyXOdN0IgZxg4KlCVBS4RJPzOQrckxJx7xTAL4ZUpMsG14MpBpMedB
	 oIiLv14nfvIsxk7IqNBr/ycF4kjkjCZGPSVMFW9+u+ZrOBBxxRN2XE/nAzUC0YD5+r
	 EQX3ujGdZeENoFoGCpNKgzqBAF0vKrZW60mjiNC6mYkgwsouXKp/Halnfn99NV5279
	 EUnH8fjywB6gw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v5hpH-000000007MH-34s4;
	Mon, 06 Oct 2025 11:48:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Sjoerd Simons <sjoerd@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: fix device use-after-free on unbind
Date: Mon,  6 Oct 2025 11:39:37 +0200
Message-ID: <20251006093937.27869-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change fixed device reference leaks when looking up drm
platform device driver data during bind() but failed to remove a partial
fix which had been added by commit 80805b62ea5b ("drm/mediatek: Fix
kobject put for component sub-drivers").

This results in a reference imbalance on component bind() failures and
on unbind() which could lead to a user-after-free.

Make sure to only drop the references after retrieving the driver data
by effectively reverting the previous partial fix.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
Reported-by: Sjoerd Simons <sjoerd@collabora.com>
Link: https://lore.kernel.org/r/20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com
Cc: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 384b0510272c..a94c51a83261 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -686,10 +686,6 @@ static int mtk_drm_bind(struct device *dev)
 	for (i = 0; i < private->data->mmsys_dev_num; i++)
 		private->all_drm_private[i]->drm = NULL;
 err_put_dev:
-	for (i = 0; i < private->data->mmsys_dev_num; i++) {
-		/* For device_find_child in mtk_drm_get_all_priv() */
-		put_device(private->all_drm_private[i]->dev);
-	}
 	put_device(private->mutex_dev);
 	return ret;
 }
@@ -697,18 +693,12 @@ static int mtk_drm_bind(struct device *dev)
 static void mtk_drm_unbind(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
-	int i;
 
 	/* for multi mmsys dev, unregister drm dev in mmsys master */
 	if (private->drm_master) {
 		drm_dev_unregister(private->drm);
 		mtk_drm_kms_deinit(private->drm);
 		drm_dev_put(private->drm);
-
-		for (i = 0; i < private->data->mmsys_dev_num; i++) {
-			/* For device_find_child in mtk_drm_get_all_priv() */
-			put_device(private->all_drm_private[i]->dev);
-		}
 		put_device(private->mutex_dev);
 	}
 	private->mtk_drm_bound = false;
-- 
2.49.1


