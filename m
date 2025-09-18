Return-Path: <stable+bounces-180099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E43B7E9A2
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0371687EA
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910022D78A;
	Wed, 17 Sep 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DU/NLrhs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275211EB1AA;
	Wed, 17 Sep 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113381; cv=none; b=uU7k/8gb+fFV+WWUT2enYJB+EPf7oPxwLb53JKlBpeuCI3dHcxMufFHnIhYkBMo5buifgtgTFs7ujpRbntgdnHdRCBkK8BPn+ZPYzDnzfQSZrEDWBPQsKI1VvZAG6yF25Dl4tpuo1LgtIkmJN9TJgstdVJEHZ/rOtAVPGlS3mpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113381; c=relaxed/simple;
	bh=5sT9rqaaSLJv1q/DNjVRBurxLBLbWFZkHPH2iPDe7J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6/yCjqdchGVTiPBL9dfLaYN0Tm/i4edRXudFHYgR2iySlCDH689OrB/gaGSNK0RKDi1h1wz3fkqA4RIzX3te7I1vzQxkL6uImBcdv3X9PU7them5oMBa2wR7wXk1fHaYgPL9D1NXI+aO7ys8bLzQvDdxIs1pGars3L2UZciFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DU/NLrhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C16AC4CEF0;
	Wed, 17 Sep 2025 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113381;
	bh=5sT9rqaaSLJv1q/DNjVRBurxLBLbWFZkHPH2iPDe7J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DU/NLrhs4nkjByZns4HGYUc2qpzs+S7CjYFmS2TExmu/0HMMjov5aaE0uPpWkmzFm
	 HD2ScLzCaDPdfy/TKaGK29WobaOyLbwvZy635HyPmKmmCeYm/SZ2CVYkV29nEMgmPJ
	 SDcoONH5sZU0j5vDz7de+Z8VqAvWfj1Po/hINMOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 6.12 067/140] drm/mediatek: fix potential OF node use-after-free
Date: Wed, 17 Sep 2025 14:33:59 +0200
Message-ID: <20250917123345.944021518@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4de37a48b6b58faaded9eb765047cf0d8785ea18 upstream.

The for_each_child_of_node() helper drops the reference it takes to each
node as it iterates over children and an explicit of_node_put() is only
needed when exiting the loop early.

Drop the recently introduced bogus additional reference count decrement
at each iteration that could potentially lead to a use-after-free.

Fixes: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
Cc: Ma Ke <make24@iscas.ac.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250829090345.21075-2-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -381,11 +381,11 @@ static bool mtk_drm_get_all_drm_priv(str
 
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
@@ -411,11 +411,10 @@ next_put_device_drm_dev:
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



