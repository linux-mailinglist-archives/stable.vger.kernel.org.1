Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986C7ECE40
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjKOTlv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjKOTlu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD5FC433C7;
        Wed, 15 Nov 2023 19:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077306;
        bh=dxicgrVV0n3jUkChIGtw0C6TkNxJj0qrU9brottlX28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozGhCKNSEdd+on7FiffdYJAF7sXsYRslAXOUiUpmDvLVKqsfMP7WnGmoU4KqyRoir
         4Z0r4W4GgvlKQywf9bNQXiknTWYm3CKps3TIpvq0t8ZJOrfEpWW0vTBuX5gOm8OxCF
         qq9cbp/GHETPCDLqt7wP8GH6J/FJHnviO1a2hX2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 223/603] drm/radeon: Remove the references of radeon_gem_ pread & pwrite ioctls
Date:   Wed, 15 Nov 2023 14:12:48 -0500
Message-ID: <20231115191628.685887996@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 52548038496fd58b762067b946f943c9bbcbd01e ]

Removing the functions of pread & pwrite & IOCTL defines, as their
existence allows an authorized client to spam the system logs.

Fixes: db996e64b293 ("drm/radeon: Fix ENOSYS with better fitting error codes in radeon_gem.c")
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon.h     |  4 ----
 drivers/gpu/drm/radeon/radeon_drv.c |  2 --
 drivers/gpu/drm/radeon/radeon_gem.c | 16 ----------------
 3 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 8afb03bbce298..3d3d2109dfebc 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2215,10 +2215,6 @@ int radeon_gem_pin_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_priv);
 int radeon_gem_unpin_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv);
-int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *file_priv);
-int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
-			   struct drm_file *file_priv);
 int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 int radeon_gem_mmap_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index fa531493b1113..7bf08164140ef 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -555,8 +555,6 @@ static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_CREATE, radeon_gem_create_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_MMAP, radeon_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_SET_DOMAIN, radeon_gem_set_domain_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(RADEON_GEM_PREAD, radeon_gem_pread_ioctl, DRM_AUTH),
-	DRM_IOCTL_DEF_DRV(RADEON_GEM_PWRITE, radeon_gem_pwrite_ioctl, DRM_AUTH),
 	DRM_IOCTL_DEF_DRV(RADEON_GEM_WAIT_IDLE, radeon_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_CS, radeon_cs_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(RADEON_INFO, radeon_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 358d19242f4ba..3fec3acdaf284 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -311,22 +311,6 @@ int radeon_gem_info_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
-int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
-			   struct drm_file *filp)
-{
-	/* TODO: implement */
-	DRM_ERROR("unimplemented %s\n", __func__);
-	return -EOPNOTSUPP;
-}
-
-int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *filp)
-{
-	/* TODO: implement */
-	DRM_ERROR("unimplemented %s\n", __func__);
-	return -EOPNOTSUPP;
-}
-
 int radeon_gem_create_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-- 
2.42.0



