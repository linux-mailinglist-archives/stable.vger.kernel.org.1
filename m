Return-Path: <stable+bounces-204956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0883CF5FE2
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 00:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A2F306514A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C428E579;
	Mon,  5 Jan 2026 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpshO5i3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7727702E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655901; cv=none; b=XGCf46U3by7sYe7J/Ouux4hJPQxoCeDiC1nLVmJJ4YejIGAxBlqjtPYZ0SobQ5OU6OqHDKIcNmKXV3aaP0/iAqUKZiOlS5S+AKwTOiWLsEUnznYyGudTn4H1IOMh76pR2BhB3dkfkTWaXqrvIS77qQRXLRc17KMhSZfiWIaixbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655901; c=relaxed/simple;
	bh=+K2tSkdVCI2tmkuFkEmE0/me9QTf5QwOu4oeLYIaNcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckRG6NMb0f3p2mXxcz2xoeH+484oN9APbVxjoZwydfa3g1uj2CiO2nK8AYM/ubYPMBAiNiFbLWSWhx4C2xMwrMCZmOS06SAgkf5NdAMIYtaXatjh06S0TSasaY9Lr8SbxB3RXaUGErsrv7AX5HTNN1gVeW2u4ZQ1q2PH8cDb+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpshO5i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F7C116D0;
	Mon,  5 Jan 2026 23:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767655900;
	bh=+K2tSkdVCI2tmkuFkEmE0/me9QTf5QwOu4oeLYIaNcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpshO5i3t1jUoXtbkPPgQNqUcqolj7tSRqRqlGDffntW+VVs1citNEayZnINQZbzf
	 UK7oD5c7gTmafzNJNzSVv34grepQZtY+9ljs7xDsoF0mimXPkK1nDwOtdQ2CjElqeY
	 mxSYn0PGhF1hnkqkpPbUUiRdAi7CPYCFUoeH+stZ5stQwfWLyYfe6kNeQWIelPy9tr
	 JioDmzlV7Ed8BPV0B/ElGFpuWmYYdI6MGTkT+HF0mbXjBmp9uuisd2AF5Q0q2r9sI6
	 pdZWpkAn2hq4VHpqlJE+jeFoQoOxskIHBZhplkqMdkBpKY+yPKzyymAqQguoeZKvRG
	 4pREQwFkrdPzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: mediatek: vcodec: Fix a reference leak in mtk_vcodec_fw_vpu_init()
Date: Mon,  5 Jan 2026 18:31:38 -0500
Message-ID: <20260105233138.2845766-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010524-anthem-unpainted-c766@gregkh>
References: <2026010524-anthem-unpainted-c766@gregkh>
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
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
index 1ec29f1b163a..84efc824d267 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
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


