Return-Path: <stable+bounces-72844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E692996A12C
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184781C23A7D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081515667D;
	Tue,  3 Sep 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="XDwDpt5Q"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD469143748;
	Tue,  3 Sep 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375081; cv=pass; b=QJ39XbYrJ17O0uOTuCOp/CZxGyURw43GRTUO+SaVQPdIfHczpsv1gSsB/bI7hwMOhkSxzZpx5KcmBidyxNDZjYSV9p1YFGxhcg1h1VRv5aAsNwSV36j3P3PtbTuzOl8xqg4e8+X3gXBa+/83OYqZC2ZlwVp2burR+rn+o1xCEy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375081; c=relaxed/simple;
	bh=GURumbuGbZwNDQLNlryk1NuoiF2/LxgRiaV2AXJTKfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwv/GrN4KFFGn30xww6ucWzVnvb7ecT8TfgdvpaAc5IbRKOx+XEYzFO98/IY1AnkMWfRXy8eJf/UL7LH6LwI9B9KKoZ1WYFIwMta0F4ro654G6pe930Kx2agj8aWYLgp082HGcBLNJGesrvU7Ee42D/nu1uWO3JVwHQju+4E/Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=XDwDpt5Q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725375061; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FFrPtUkgOiHxCnw5NIFs4L068NZikJBaUfWdpeXS5p7z+BA1SJXDM9QtWHcXygywdrvTY9fG0+ZNe+jf2kDUtBIIDjVkyKSwQ2s4ks66GwcZt3ya/I53cL0B7Ot77Dvj/eGDudstvZeePB7/IY3/7R6U+jJu2ADWljIZfyELEEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725375061; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JoZyTngQaWUmJroKbr6Fpr/n3m9/mAYytfSe+YwDYgo=; 
	b=fj6HZLJetex5KjzqzYK4p9o3lgE3f5iCQZOoOAPGkXdg3X345CHOGdX050xdRg5FR9axIZkOBP0L55rBboAe650V30odLGleMC2OcqQS9UvRS3MZZXiG8D78ST8PQOM2ivTFXe3Be7k0b/EtnS5vgwsUZ8JVtChaE23rvhx5OqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725375061;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JoZyTngQaWUmJroKbr6Fpr/n3m9/mAYytfSe+YwDYgo=;
	b=XDwDpt5Qoth2HKrs8RlmZKcgqljZh/a9XFjXM+n8rk/3jI1Atzxf0tlCVwwQovqf
	XIQVUVYzXBxA+NalBXoIEDeLEdubbGzjATQ2Qoz+A2n/sVeaVtRxLO0AS9pgViOvvam
	oxgAq+gyQmtvH42EgZvlfbS8INZDM+l7KChfJIoI=
Received: by mx.zohomail.com with SMTPS id 1725375058634587.9557627661392;
	Tue, 3 Sep 2024 07:50:58 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panthor: Restrict high priorities on group_create
Date: Tue,  3 Sep 2024 16:49:55 +0200
Message-ID: <20240903144955.144278-2-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

We were allowing any users to create a high priority group without any
permission checks. As a result, this was allowing possible denial of
service.

We now only allow the DRM master or users with the CAP_SYS_NICE
capability to set higher priorities than PANTHOR_GROUP_PRIORITY_MEDIUM.

As the sole user of that uAPI lives in Mesa and hardcode a value of
MEDIUM [1], this should be safe to do.

Additionally, as those checks are performed at the ioctl level,
panthor_group_create now only check for priority level validity.

[1]https://gitlab.freedesktop.org/mesa/mesa/-/blob/f390835074bdf162a63deb0311d1a6de527f9f89/src/gallium/drivers/panfrost/pan_csf.c#L1038

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 23 +++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.c |  2 +-
 include/uapi/drm/panthor_drm.h          |  6 +++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b5e7b919f241..34182f67136c 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_auth.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_exec.h>
@@ -996,6 +997,24 @@ static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
 	return panthor_group_destroy(pfile, args->group_handle);
 }
 
+static int group_priority_permit(struct drm_file *file,
+				 u8 priority)
+{
+	/* Ensure that priority is valid */
+	if (priority > PANTHOR_GROUP_PRIORITY_HIGH)
+		return -EINVAL;
+
+	/* Medium priority and below are always allowed */
+	if (priority <= PANTHOR_GROUP_PRIORITY_MEDIUM)
+		return 0;
+
+	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
+	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+		return 0;
+
+	return -EACCES;
+}
+
 static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 				      struct drm_file *file)
 {
@@ -1011,6 +1030,10 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	if (ret)
 		return ret;
 
+	ret = group_priority_permit(file, args->priority);
+	if (ret)
+		return ret;
+
 	ret = panthor_group_create(pfile, args, queue_args);
 	if (ret >= 0) {
 		args->group_handle = ret;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index c426a392b081..91a31b70c037 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3092,7 +3092,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	if (group_args->pad)
 		return -EINVAL;
 
-	if (group_args->priority > PANTHOR_CSG_PRIORITY_HIGH)
+	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
 		return -EINVAL;
 
 	if ((group_args->compute_core_mask & ~ptdev->gpu_info.shader_present) ||
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 926b1deb1116..e23a7f9b0eac 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -692,7 +692,11 @@ enum drm_panthor_group_priority {
 	/** @PANTHOR_GROUP_PRIORITY_MEDIUM: Medium priority group. */
 	PANTHOR_GROUP_PRIORITY_MEDIUM,
 
-	/** @PANTHOR_GROUP_PRIORITY_HIGH: High priority group. */
+	/**
+	 * @PANTHOR_GROUP_PRIORITY_HIGH: High priority group.
+	 *
+	 * Requires CAP_SYS_NICE or DRM_MASTER.
+	 */
 	PANTHOR_GROUP_PRIORITY_HIGH,
 };
 

base-commit: a15710027afb40c7c1e352902fa5b8c949f021de
-- 
2.46.0


