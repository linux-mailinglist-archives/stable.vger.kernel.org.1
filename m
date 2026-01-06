Return-Path: <stable+bounces-204962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD868CF615A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295A63018960
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA02836F;
	Tue,  6 Jan 2026 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9LMEZmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A733EC
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659510; cv=none; b=W11tDOUs5kjjpSH2FFneOHERwro273/k+GoyyhMqDZUbzzCaMxjyzjnv4voxc3Jf5M0gDQWXeGAwcFTgxVOVtvu3F1stn7QKSi0ObdBBzqd+88vVrVxAg6uq/rTVHc/Ab+XhIZvBqyBtdmI/BOYqmZrrIt0XrwYy8dVqv99GSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659510; c=relaxed/simple;
	bh=puHBWFsnoDPc9DA2GcwoPishsxIx/C80KqGZMfZ6Fec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKnll2MfBJ3Ue3EGN//nI4XSSthk9cV+a7ijuawBCsrD4Td3TPojt0v9ZrfW7foydB3nmt+N4aMUjH6lFd9ylJN84bnRebNWJfS60zrj7D6jubauVXgf7WWuFeD8mB1REqSHNsg+lDgWidP+1ZDSWQvY406cbxUixcu6irzCG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9LMEZmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BEAC116D0;
	Tue,  6 Jan 2026 00:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659510;
	bh=puHBWFsnoDPc9DA2GcwoPishsxIx/C80KqGZMfZ6Fec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9LMEZmJfxNiOEH1MIQW3LAFXJZ3gq7IfjwauQSPHKwmsngymz725bvDm/rqNBS3z
	 Lf2/ywTRibM4ySKCEtZ8ln5DL6tTkBQcc4E+V/VT6eduTUTmi6uRg3tsnOxo4wlOkg
	 kMU2xoOL92Csijoj4BzsTQNO015Q9EaurXEOM2Y9MyZeesreyS2Ywlm62KJ+xwHDTl
	 GJuZ+MOUO034RVO0trwvYl0ztlpYQCkM9ScwLt5+ARJbxV/pGP71/lgLGaXdzqdENE
	 /iXXYPsiS+RBwWgEPBxYLAVAiLoKqlZsA9kzhw1iw1b9nrvCxPCPsaKbJgOoAjxjmu
	 GeKFTK37S5z+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()
Date: Mon,  5 Jan 2026 19:31:47 -0500
Message-ID: <20260106003147.2858489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010524-rarity-cardboard-387f@gregkh>
References: <2026010524-rarity-cardboard-387f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit cdd0f118ef87db8a664fb5ea366fd1766d2df1cd ]

vpu_get_plat_device() increases the reference count of the returned
platform device. However, when devm_kzalloc() fails, the reference
is not released, causing a reference leak.

Fix this by calling put_device() on fw_pdev->dev before returning
on the error path.

Fixes: e25a89f743b1 ("media: mtk-vcodec: potential dereference of null pointer")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ adapted file path from common/ subdirectory and adjusted devm_kzalloc target from plat_dev->dev to dev->plat_dev->dev ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
index 1ec29f1b163a..84efc824d267 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
@@ -94,8 +94,10 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
 	vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_handler, dev, rst_id);
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	if (!fw)
+	if (!fw) {
+		put_device(&fw_pdev->dev);
 		return ERR_PTR(-ENOMEM);
+	}
 	fw->type = VPU;
 	fw->ops = &mtk_vcodec_vpu_msg;
 	fw->pdev = fw_pdev;
-- 
2.51.0


