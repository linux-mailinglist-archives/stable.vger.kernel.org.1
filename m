Return-Path: <stable+bounces-204973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B6CF6211
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E04C303A3C4
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BD200113;
	Tue,  6 Jan 2026 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaIABLuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B524A3C
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660933; cv=none; b=XBmOIM+7qR0GhX2znIsNJ8QTh9lAmWfIoM7sVR+pr8xVdx2SWbIY40hMnrnKALznreOtw7vJV+hzag9VvJ0NUwSsJjB7lBXz3R2LF1ft8KkPg4kP11UwoKXRD81IHvNB7xHQb+0UVgY7OJGVul83oZCbUCF3FNbFEYOLJSCNTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660933; c=relaxed/simple;
	bh=puHBWFsnoDPc9DA2GcwoPishsxIx/C80KqGZMfZ6Fec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nane/oyCRBMoLqqk5Sm39TLe+Rt96NAF2FXbvOj6AYAlzoiZnXf6Xf+theW7YoBbSpZyDqA9rb7PgKpxr8tHIDqezEfWH4HWb214EomWB0hfmSX4G0QTImwyqhf76G+A62weM2nhi9p53A0Y2WONJ4I8tDa8UHEM0Ah4OvN2rQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaIABLuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BD1C2BC86;
	Tue,  6 Jan 2026 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660933;
	bh=puHBWFsnoDPc9DA2GcwoPishsxIx/C80KqGZMfZ6Fec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaIABLuS4F3zaIlnVlIMbSidf003mXgFghaD3i7hY7JH2BSYGFiXkm4S6k1YoXE9/
	 hUMlIxY1BbZyiRW6aLcN8CUb+mHycTkQ8+PzpYveu0J+Jj31RsHrWlcfK8ZR16Yz8O
	 kRPob2w6d4r4O+ZpwlaGL/WKuhoR+xGJjSMyy06aXE5fRRY1bRqZqGf6twQP6sMCHW
	 vhIfhGX4z0vbdb6Omj0NHWp0duNLidyJWdWUU0nDj6IS7tnafIoc5z3tNPq7t9oPJH
	 zo74RhrgjiJt3cvOaxpzjzs33SivJ+rWj96zOZBiES+rRpQP0QOO2uDkKNpbO9AXrm
	 zqluRboZ2/lPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()
Date: Mon,  5 Jan 2026 19:55:31 -0500
Message-ID: <20260106005531.2866023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010525-dismiss-bootleg-46f2@gregkh>
References: <2026010525-dismiss-bootleg-46f2@gregkh>
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


