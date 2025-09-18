Return-Path: <stable+bounces-177154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7AB403C7
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9A5189440F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A330DD24;
	Tue,  2 Sep 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0pkKovR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711B313E27;
	Tue,  2 Sep 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819755; cv=none; b=YzuGfdLEDzDEoX9nKzFQHcV2g8veWzyUWTexRoeLmeMuMrhLPvaQBCUk09aN3+nlrXmJLK7fLAPc7MijzW2j24gZXgkP0cFF5xQbndAqZRCvFpCNw/PMQQ3OclXtOb601gSlyQcyt4oecom/61e0ErT2jrNsSNxLWXOcrx5+Fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819755; c=relaxed/simple;
	bh=fY48yJfwB47w+R+MqrChG1/42xwKROvVNFIRkCZQNCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWny8fq3j4AdKjuJT5EpUHuG67Y96hafUcp2vx9P3/bCg8kLoEmZjl61GLMEx9c9GZ9wPj1+4K09kU/7phyZ/9x5+CC/qv4Jv/31Poewt61RE4/wjz61ohV6bS1I/QTRlmKdHhwek+m+l2hsGh//vlxwU0slD/SZBFalIDocXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0pkKovR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F72C4CEED;
	Tue,  2 Sep 2025 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819754;
	bh=fY48yJfwB47w+R+MqrChG1/42xwKROvVNFIRkCZQNCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0pkKovR/1Y4WlLz5CK9HcSopLnVrF67dqaWjBIqXZ6yx57WahZYLxG+nGdD3L9Bo
	 5446io8tfUNcT86GRK+oWCf9BVZgJCdJZDFGuVaoHWCvUAjyIK61Ou8gkVz/d8zaGb
	 cXRciJ2JF7idjrHVXepl7DmIw+wpAo7CZaCz/rKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 6.16 128/142] drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv
Date: Tue,  2 Sep 2025 15:20:30 +0200
Message-ID: <20250902131953.189636605@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 1f403699c40f0806a707a9a6eed3b8904224021a upstream.

Using device_find_child() and of_find_device_by_node() to locate
devices could cause an imbalance in the device's reference count.
device_find_child() and of_find_device_by_node() both call
get_device() to increment the reference count of the found device
before returning the pointer. In mtk_drm_get_all_drm_priv(), these
references are never released through put_device(), resulting in
permanent reference count increments. Additionally, the
for_each_child_of_node() iterator fails to release node references in
all code paths. This leaks device node references when loop
termination occurs before reaching MAX_CRTC. These reference count
leaks may prevent device/node resources from being properly released
during driver unbind operations.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Cc: stable@vger.kernel.org
Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250812071932.471730-1-make24@iscas.ac.cn/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -388,19 +388,19 @@ static bool mtk_drm_get_all_drm_priv(str
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
 		if (!of_id)
-			continue;
+			goto next_put_node;
 
 		pdev = of_find_device_by_node(node);
 		if (!pdev)
-			continue;
+			goto next_put_node;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
 		if (!drm_dev)
-			continue;
+			goto next_put_device_pdev_dev;
 
 		temp_drm_priv = dev_get_drvdata(drm_dev);
 		if (!temp_drm_priv)
-			continue;
+			goto next_put_device_drm_dev;
 
 		if (temp_drm_priv->data->main_len)
 			all_drm_priv[CRTC_MAIN] = temp_drm_priv;
@@ -412,10 +412,17 @@ static bool mtk_drm_get_all_drm_priv(str
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC) {
-			of_node_put(node);
+next_put_device_drm_dev:
+		put_device(drm_dev);
+
+next_put_device_pdev_dev:
+		put_device(&pdev->dev);
+
+next_put_node:
+		of_node_put(node);
+
+		if (cnt == MAX_CRTC)
 			break;
-		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {



