Return-Path: <stable+bounces-138989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1738AA3D6B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE334C2FC2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C16283FDC;
	Tue, 29 Apr 2025 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9Y3p7Vi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C22283FD6;
	Tue, 29 Apr 2025 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970672; cv=none; b=Es8nMcetoXbOzL5ZMI9k3a9brLYfAYfS9MPOZOf0YCv2wdP6+UjU2BhBihMKgYKMLgCLArjVWnnWrp8flG1AgRm0I9IDsemBOxZpu9NdncxMPn61vUEKCfHrRFN/hTLBVQ4i9+Jj+E7dkgVyH5geqK2q0jnn388sQQHiiaF86q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970672; c=relaxed/simple;
	bh=2Xs+NwG+ghak53R7M5puIiAUqfzgfNo354W5cyiWcws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzF2tMR9hbFXKhWyhMU5Fa8SxqglCeZ/iPACh40ekMw+uZ7tui7DvjQVf3DCWjYeBJL1qKe4leRcgbGbRIlXcixZMKFuoD7nevnuJ8CfQCpCNCKCqyE9T8TAwwSvMGZAVoHWeBnljisg3c9wQQ8jkwIt4wlKYH92JYHoiPQK9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9Y3p7Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EE5C4CEE3;
	Tue, 29 Apr 2025 23:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970671;
	bh=2Xs+NwG+ghak53R7M5puIiAUqfzgfNo354W5cyiWcws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9Y3p7Viqj7ZdxMdeKguzaqlFNHzRpGEAsA1bWFm4rWQJwxt0ZgTpLtAt0hET3i1H
	 YnstjgdRUaMUMqEzopS844MEsId9IaKj79Yqw7t9BrQRQ5ty3+qE/WiQsoiTYnmCxo
	 fI/JmClf70n5mqi1f9rhk5TaLa8MHvLX9/+5iwfvwI07BEVsEY+zM0Te9p9yhDjm6h
	 g9WHt0ZOUG91cgaG9SXMRMpPc3jJCdMF4NdacroolrCknBB/B2Q6qHNyZxtzxfMQOH
	 dWZwiHHtCOB4Jrz+EjZ7SaCDrKAsJMOVXu1KQ0ZSCFNTD/Dxm3r6Uwn0Z7kJC9EkqJ
	 SzSzc9NnhBqlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
	Hao Zhou <hao.zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	Yunxiang.Li@amd.com,
	tvrtko.ursulin@igalia.com,
	matthew.auld@intel.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 33/39] drm/amdgpu: Allow P2P access through XGMI
Date: Tue, 29 Apr 2025 19:50:00 -0400
Message-Id: <20250429235006.536648-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <felix.kuehling@amd.com>

[ Upstream commit a92741e72f91b904c1d8c3d409ed8dbe9c1f2b26 ]

If peer memory is accessible through XGMI, allow leaving it in VRAM
rather than forcing its migration to GTT on DMABuf attachment.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 372c8d72c3680fdea3fbb2d6b089f76b4a6d596a)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 30 ++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index c9842a0e2a1cd..cb043296f9aec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,29 @@
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
 
+static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
+
+/**
+ * dma_buf_attach_adev - Helper to get adev of an attachment
+ *
+ * @attach: attachment
+ *
+ * Returns:
+ * A struct amdgpu_device * if the attaching device is an amdgpu device or
+ * partition, NULL otherwise.
+ */
+static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachment *attach)
+{
+	if (attach->importer_ops == &amdgpu_dma_buf_attach_ops) {
+		struct drm_gem_object *obj = attach->importer_priv;
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+		return amdgpu_ttm_adev(bo->tbo.bdev);
+	}
+
+	return NULL;
+}
+
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
  *
@@ -54,11 +77,13 @@
 static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 				 struct dma_buf_attachment *attach)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
-	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
+	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
+	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
 	amdgpu_vm_bo_update_shared(bo);
@@ -459,6 +484,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 	struct drm_gem_object *obj = &bo->tbo.base;
 	struct drm_gem_object *gobj;
 
+	if (!adev)
+		return false;
+
 	if (obj->import_attach) {
 		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
 
-- 
2.39.5


