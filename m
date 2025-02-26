Return-Path: <stable+bounces-119702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145C5A46584
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EE717D669
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32AE22489F;
	Wed, 26 Feb 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+A0NOMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE621CA1E;
	Wed, 26 Feb 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584547; cv=none; b=DUtfsqQ1QN0aoci+hDA9KkZnULu+nTmztO7tl3ao/L240NbJpIZ28qJW87cBWSO69v302E8pUv0KzsBGXFoniXeWOb9C9tO02EwETqPIU1R+JwiBVGtlY9jhqipTvMubaHM6tprorrPQW2WC/3dBIyEESF69cznIjMgOV41/HME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584547; c=relaxed/simple;
	bh=5f2oYRMymOyXWg8oig+0mtUHGVHmikl0iXvLN6O7avs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HXNvdaK775SW8AodloWuXrcM9gV4jId8J1nU1YNEKoTo4o26vSfhTcr2irBOIrqnyS0e+UF1MNUg6Gt3/Cn9v7LvKlmE0A2Gh40uOCJ3Me3Jg9wVpB191SOChRktKr4istNoMq8xtWndathxB1kU70VB/jihMQiFaz1AG59dq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+A0NOMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E03C4CED6;
	Wed, 26 Feb 2025 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584546;
	bh=5f2oYRMymOyXWg8oig+0mtUHGVHmikl0iXvLN6O7avs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=T+A0NOMiOZjt0INGPmIK6+2J1NasnxQ7rkZbSY0B9RFwNBpnvju+9PYxI/xhZ/qRt
	 QaOhuf9rZBDbsf2Sqfu8MT0gMikG0S+cz5UufAFO36izPR5eoinepuSq6vSBfFIaKy
	 KfUAzlkv3XyKnTbuaW5RvIUFWm2LLsJzh1ieL8k9qZXrIhs8gcB47LEI58Ye2PjJa9
	 iXyGv8O9fo2E3gcRT4nvrwbxTefSJ33PgtDLT6zFh8W8H/5HB1XRLG/9KZt+jz+KZ6
	 0Crz8DzJI89NnXm/VYxILA+2b5ggKfWPM/KXhRWO3hvMr6y5RHtKXQ0qa1KkYa6Vre
	 pbB3reqdRr39A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE75EC021B8;
	Wed, 26 Feb 2025 15:42:26 +0000 (UTC)
From: Brendan King via B4 Relay <devnull+Brendan.King.imgtec.com@kernel.org>
Date: Wed, 26 Feb 2025 15:42:19 +0000
Subject: [PATCH v2] drm/imagination: avoid deadlock on fence release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-fence-release-deadlock-v2-1-6fed2fc1fe88@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAFo2v2cC/4WNQQ6CMBBFr2Jm7Zi2BDCuvIdhUdoPTARqWkI0h
 LtbuYDL95L//kYJUZDodtooYpUkYc5gzidyg517sPjMZJQplVEFd5gdOGKETWAP68fgnmxVXRZ
 O1W3nPeXxK6KT9xF+NJkHSUuIn+Nn1T/7N7lq1lxBe2hTqba43mXqF7iLCxM1+75/ATA9Nne9A
 AAA
X-Change-ID: 20250203-fence-release-deadlock-a0753c07bfdd
To: Frank Binns <frank.binns@imgtec.com>, 
 Matt Coster <matt.coster@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Brendan King <brendan.king@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740584545; l=3702;
 i=Brendan.King@imgtec.com; s=20250203; h=from:subject:message-id;
 bh=bKMHhVTtJG43Lz66Kv6FNFtvsLiapP6vakNG5JK3jlE=;
 b=AIcRT9pMXFXcHhbEtmfBoDYE5yT1XBAGdWkiIvjBQMohYC690SraSw4dAjj9UA7Ca8NbcFqfe
 9A1nWq+aUxsCx5k/EdINHeuOp3BSuPD8EKuyJslnyh9rvJBfM9hj6y/
X-Developer-Key: i=Brendan.King@imgtec.com; a=ed25519;
 pk=i3JvC3unEBLW+4r5s/aEWQZFsRCWaCBrWdFbMXIXCqg=
X-Endpoint-Received: by B4 Relay for Brendan.King@imgtec.com/20250203 with
 auth_id=335
X-Original-From: Brendan King <Brendan.King@imgtec.com>
Reply-To: Brendan.King@imgtec.com

From: Brendan King <Brendan.King@imgtec.com>

Do scheduler queue fence release processing on a workqueue, rather
than in the release function itself.

Fixes deadlock issues such as the following:

[  607.400437] ============================================
[  607.405755] WARNING: possible recursive locking detected
[  607.415500] --------------------------------------------
[  607.420817] weston:zfq0/24149 is trying to acquire lock:
[  607.426131] ffff000017d041a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: pvr_gem_object_vunmap+0x40/0xc0 [powervr]
[  607.436728]
               but task is already holding lock:
[  607.442554] ffff000017d105a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: dma_buf_ioctl+0x250/0x554
[  607.451727]
               other info that might help us debug this:
[  607.458245]  Possible unsafe locking scenario:

[  607.464155]        CPU0
[  607.466601]        ----
[  607.469044]   lock(reservation_ww_class_mutex);
[  607.473584]   lock(reservation_ww_class_mutex);
[  607.478114]
                *** DEADLOCK ***

Cc: stable@vger.kernel.org
Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
Signed-off-by: Brendan King <brendan.king@imgtec.com>
---
Changes in v2:
- Added 'Cc:' and 'Fixes:' tags
- Link to v1: https://lore.kernel.org/r/20250203-fence-release-deadlock-v1-1-6e1de1260b38@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_queue.c | 13 +++++++++++--
 drivers/gpu/drm/imagination/pvr_queue.h |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index c4f08432882b12f5cdfeb7fc991fd941f0946676..f3f1c5212df7432161919ddc510cececacbbe143 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -109,12 +109,20 @@ pvr_queue_fence_get_driver_name(struct dma_fence *f)
 	return PVR_DRIVER_NAME;
 }
 
+static void pvr_queue_fence_release_work(struct work_struct *w)
+{
+	struct pvr_queue_fence *fence = container_of(w, struct pvr_queue_fence, release_work);
+
+	pvr_context_put(fence->queue->ctx);
+	dma_fence_free(&fence->base);
+}
+
 static void pvr_queue_fence_release(struct dma_fence *f)
 {
 	struct pvr_queue_fence *fence = container_of(f, struct pvr_queue_fence, base);
+	struct pvr_device *pvr_dev = fence->queue->ctx->pvr_dev;
 
-	pvr_context_put(fence->queue->ctx);
-	dma_fence_free(f);
+	queue_work(pvr_dev->sched_wq, &fence->release_work);
 }
 
 static const char *
@@ -268,6 +276,7 @@ pvr_queue_fence_init(struct dma_fence *f,
 
 	pvr_context_get(queue->ctx);
 	fence->queue = queue;
+	INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
 	dma_fence_init(&fence->base, fence_ops,
 		       &fence_ctx->lock, fence_ctx->id,
 		       atomic_inc_return(&fence_ctx->seqno));
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index e06ced69302fca47fc26451dfb09ebbb24b57f52..93fe9ac9f58ccc020615485e86be438548dcee43 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -5,6 +5,7 @@
 #define PVR_QUEUE_H
 
 #include <drm/gpu_scheduler.h>
+#include <linux/workqueue.h>
 
 #include "pvr_cccb.h"
 #include "pvr_device.h"
@@ -63,6 +64,9 @@ struct pvr_queue_fence {
 
 	/** @queue: Queue that created this fence. */
 	struct pvr_queue *queue;
+
+	/** @release_work: Fence release work structure. */
+	struct work_struct release_work;
 };
 
 /**

---
base-commit: 3ab334814dc7dff39075e055e12847d51878916e
change-id: 20250203-fence-release-deadlock-a0753c07bfdd

Best regards,
-- 
Brendan King <Brendan.King@imgtec.com>



