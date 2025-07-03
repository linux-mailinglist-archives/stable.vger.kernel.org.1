Return-Path: <stable+bounces-160125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31032AF829D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 23:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94EB6E19C1
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA57D2BD5A7;
	Thu,  3 Jul 2025 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="dqoXjpFe";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="v/BVgkC3"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out0.aaront.org (smtp-out0.aaront.org [52.10.12.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A22BD595;
	Thu,  3 Jul 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.10.12.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578051; cv=none; b=M6/5cW4JFqktNcONxJiHmh7JpXNqZpyfmH0wkeL8zMMZXu/L0hPhgRBXKoBdTTHQwrsFb/RfQWhrMFwA8LI8TcVJ6+y+OgltDO4MpyGlIt391YXvTvuqHiVC2ol2TDdyNDRj78NTfPb/2fkX5mZglk3dSJlD4Ws7677FlXswD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578051; c=relaxed/simple;
	bh=/kZmNYWZNOTJQa4opCPhE9MeAHI82FTFippa+nVrA1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQlXIgFcTFb0mU38VV4BxDl4smCiZLGx79alQEj/kDw4VA3yJnu5gooGUwCZPscZC0Im6eB6qhjUA3lI2PjHYNQfnR1XS/I8pECI1i13EGgVLErp0X7WTnjKYH9hQBpcbkwNmsp0nkbLCxys3TO8jce3kde9xAud7N4EUD6AmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=dqoXjpFe; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=v/BVgkC3; arc=none smtp.client-ip=52.10.12.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: from smtp-send0.aaront.org (localhost [IPv6:::1])
	by smtp-out0.aaront.org (Postfix) with ESMTP id 4bY8mq5CtwzMY;
	Thu,  3 Jul 2025 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=3r7feyyp; bh=/kZmNYWZNOTJQa4opCPhE
    9MeAHI82FTFippa+nVrA1o=; b=dqoXjpFePZxdEULpDnRSc1iIU4UTydj/TLfKH
    HPMBaqlkHTLVMC3dGVYex9NVU6iBEYzQmXt8W7LxEMeYThhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=4x7dsrm2; bh=/kZmNYWZNOTJQa4opCPhE
    9MeAHI82FTFippa+nVrA1o=; b=v/BVgkC3yRTStqMBR2f8EZeF/HuMKVSqzUfqb
    HxVf5nKI7XyG5CgmhaI4PA6+MoQIVykqJYaxMC4e9JYhTBMI8Oh9/3O1B3vQAJzA
    yT2qo3NmNXZx/dWD34nULC8n6maD5SQR/xGNsh5iNgOJIrUxOV2McxS++VvkUKhq
    dUDyj0q+yqm1NV4nNraI9k9HuU/OO/G1hgnJsho3gpx3WQRKYpNqNhP26Cf+J6UW
    ZACEQtJm0eJV4qEn5NmRynCJAFU8SnrjpamGAqpqgz6HEktS8gABBh8nvkeNHtqe
    icIBqKWKHm0g67l8+0EPGXIG9g2CgVUc+/O3lNR0i3LQ2J98w==
Received: by smtp-send0.aaront.org (Postfix) id 4bY8mq323rzJm;
	Thu,  3 Jul 2025 21:20:11 +0000 (UTC)
From: Aaron Thompson <dev@aaront.org>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Timur Tabi <ttabi@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	Aaron Thompson <dev@aaront.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Do not fail module init on debugfs errors
Date: Thu,  3 Jul 2025 21:19:49 +0000
Message-Id: <20250703211949.9916-1-dev@aaront.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Thompson <dev@aaront.org>

If CONFIG_DEBUG_FS is enabled, nouveau_drm_init() returns an error if it
fails to create the "nouveau" directory in debugfs. One case where that
will happen is when debugfs access is restricted by
CONFIG_DEBUG_FS_ALLOW_NONE or by the boot parameter debugfs=off, which
cause the debugfs APIs to return -EPERM.

So just ignore errors from debugfs. Note that nouveau_debugfs_root may
be an error now, but that is a standard pattern for debugfs. From
include/linux/debugfs.h:

"NOTE: it's expected that most callers should _ignore_ the errors
returned by this function. Other debugfs functions handle the fact that
the "dentry" passed to them could be an error and they don't crash in
that case. Drivers should generally work fine even if debugfs fails to
init anyway."

Fixes: 97118a1816d2 ("drm/nouveau: create module debugfs root")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 6 +-----
 drivers/gpu/drm/nouveau/nouveau_debugfs.h | 5 ++---
 drivers/gpu/drm/nouveau/nouveau_drm.c     | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 200e65a7cefc..c7869a639bef 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -314,14 +314,10 @@ nouveau_debugfs_fini(struct nouveau_drm *drm)
 	drm->debugfs = NULL;
 }
 
-int
+void
 nouveau_module_debugfs_init(void)
 {
 	nouveau_debugfs_root = debugfs_create_dir("nouveau", NULL);
-	if (IS_ERR(nouveau_debugfs_root))
-		return PTR_ERR(nouveau_debugfs_root);
-
-	return 0;
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.h b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
index b7617b344ee2..d05ed0e641c4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.h
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
@@ -24,7 +24,7 @@ extern void nouveau_debugfs_fini(struct nouveau_drm *);
 
 extern struct dentry *nouveau_debugfs_root;
 
-int  nouveau_module_debugfs_init(void);
+void nouveau_module_debugfs_init(void);
 void nouveau_module_debugfs_fini(void);
 #else
 static inline void
@@ -42,10 +42,9 @@ nouveau_debugfs_fini(struct nouveau_drm *drm)
 {
 }
 
-static inline int
+static inline void
 nouveau_module_debugfs_init(void)
 {
-	return 0;
 }
 
 static inline void
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 0c82a63cd49d..1527b801f013 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1461,9 +1461,7 @@ nouveau_drm_init(void)
 	if (!nouveau_modeset)
 		return 0;
 
-	ret = nouveau_module_debugfs_init();
-	if (ret)
-		return ret;
+	nouveau_module_debugfs_init();
 
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 	platform_driver_register(&nouveau_platform_driver);

base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
-- 
2.39.5


