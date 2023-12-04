Return-Path: <stable+bounces-3937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86A803FAA
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A321F21348
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B5835F1D;
	Mon,  4 Dec 2023 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY8E8Pxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FA35EE8
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBB4C433C9;
	Mon,  4 Dec 2023 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722097;
	bh=ow15m191T2FC0cIqsGJ4ULBd4rLZzTNHYOB2ZQL0wPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PY8E8Pxg5mOL9VHMgoPG+EeGcRbY2enwd0XO8kcbx48zvhh26sId77SRwIiqS0Cz8
	 HVOnxoCBR17Y8YZplK2zf3rWHzZwxGUiF0wvls6+yyocPcbCOTMhorNT5SFVngDDQo
	 pMwsnG79gkvEM3p/67xTX5Xsh02jcjF28h726fifVg+Fe9aF85BXI6GhPZnlO2GbWa
	 lUKFMLkdtnX9h4PdaQxK1oMqpF+WnDp/0dl9bSJXvySFAtYphDiXYT20M2s38ihKOD
	 eFYzwNMhhox0lV5l+rdb5YKToWI/fABXUHOQQSo4MaXdHBivXnvX3jJZjq2RT4oNMt
	 4TFgnRzokdxWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 30/32] Revert "drm/prime: Unexport helpers for fd/handle conversion"
Date: Mon,  4 Dec 2023 15:32:50 -0500
Message-ID: <20231204203317.2092321-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit 0514f63cfff38a0dcb7ba9c5f245827edc0c5107 ]

This reverts commit 71a7974ac7019afeec105a54447ae1dc7216cbb3.

These helper functions are needed for KFD to export and import DMABufs
the right way without duplicating the tracking of DMABufs associated with
GEM objects while ensuring that move notifier callbacks are working as
intended.

CC: Christian König <christian.koenig@amd.com>
CC: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_prime.c | 33 ++++++++++++++++++---------------
 include/drm/drm_prime.h     |  7 +++++++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 63b709a67471b..834a5e28abbe5 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -278,7 +278,7 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_release);
 
-/*
+/**
  * drm_gem_prime_fd_to_handle - PRIME import function for GEM drivers
  * @dev: drm_device to import into
  * @file_priv: drm file-private structure
@@ -292,9 +292,9 @@ EXPORT_SYMBOL(drm_gem_dmabuf_release);
  *
  * Returns 0 on success or a negative error code on failure.
  */
-static int drm_gem_prime_fd_to_handle(struct drm_device *dev,
-				      struct drm_file *file_priv, int prime_fd,
-				      uint32_t *handle)
+int drm_gem_prime_fd_to_handle(struct drm_device *dev,
+			       struct drm_file *file_priv, int prime_fd,
+			       uint32_t *handle)
 {
 	struct dma_buf *dma_buf;
 	struct drm_gem_object *obj;
@@ -360,6 +360,7 @@ static int drm_gem_prime_fd_to_handle(struct drm_device *dev,
 	dma_buf_put(dma_buf);
 	return ret;
 }
+EXPORT_SYMBOL(drm_gem_prime_fd_to_handle);
 
 int drm_prime_fd_to_handle_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv)
@@ -408,7 +409,7 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
 	return dmabuf;
 }
 
-/*
+/**
  * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
  * @dev: dev to export the buffer from
  * @file_priv: drm file-private structure
@@ -421,10 +422,10 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
  * The actual exporting from GEM object to a dma-buf is done through the
  * &drm_gem_object_funcs.export callback.
  */
-static int drm_gem_prime_handle_to_fd(struct drm_device *dev,
-				      struct drm_file *file_priv, uint32_t handle,
-				      uint32_t flags,
-				      int *prime_fd)
+int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+			       struct drm_file *file_priv, uint32_t handle,
+			       uint32_t flags,
+			       int *prime_fd)
 {
 	struct drm_gem_object *obj;
 	int ret = 0;
@@ -506,6 +507,7 @@ static int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
 
 int drm_prime_handle_to_fd_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv)
@@ -864,9 +866,9 @@ EXPORT_SYMBOL(drm_prime_get_contiguous_size);
  * @obj: GEM object to export
  * @flags: flags like DRM_CLOEXEC and DRM_RDWR
  *
- * This is the implementation of the &drm_gem_object_funcs.export functions
- * for GEM drivers using the PRIME helpers. It is used as the default for
- * drivers that do not set their own.
+ * This is the implementation of the &drm_gem_object_funcs.export functions for GEM drivers
+ * using the PRIME helpers. It is used as the default in
+ * drm_gem_prime_handle_to_fd().
  */
 struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 				     int flags)
@@ -962,9 +964,10 @@ EXPORT_SYMBOL(drm_gem_prime_import_dev);
  * @dev: drm_device to import into
  * @dma_buf: dma-buf object to import
  *
- * This is the implementation of the gem_prime_import functions for GEM
- * drivers using the PRIME helpers. It is the default for drivers that do
- * not set their own &drm_driver.gem_prime_import.
+ * This is the implementation of the gem_prime_import functions for GEM drivers
+ * using the PRIME helpers. Drivers can use this as their
+ * &drm_driver.gem_prime_import implementation. It is used as the default
+ * implementation in drm_gem_prime_fd_to_handle().
  *
  * Drivers must arrange to call drm_prime_gem_destroy() from their
  * &drm_gem_object_funcs.free hook when using this function.
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index a7abf9f3e6972..2a1d01e5b56b8 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -60,12 +60,19 @@ enum dma_data_direction;
 
 struct drm_device;
 struct drm_gem_object;
+struct drm_file;
 
 /* core prime functions */
 struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
 				      struct dma_buf_export_info *exp_info);
 void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
 
+int drm_gem_prime_fd_to_handle(struct drm_device *dev,
+			       struct drm_file *file_priv, int prime_fd, uint32_t *handle);
+int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+			       struct drm_file *file_priv, uint32_t handle, uint32_t flags,
+			       int *prime_fd);
+
 /* helper functions for exporting */
 int drm_gem_map_attach(struct dma_buf *dma_buf,
 		       struct dma_buf_attachment *attach);
-- 
2.42.0


