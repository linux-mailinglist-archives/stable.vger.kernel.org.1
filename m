Return-Path: <stable+bounces-201069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3FCBF0E9
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC718301843D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52142349AE1;
	Mon, 15 Dec 2025 16:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD8348895
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817713; cv=none; b=MQzKLpATM5U37u6O6mf7ULflkoM+wB4qYfWentl4QG3TQwq1NPkMT6h18H0ZKIcNsK+8zW4eZDtje3+k9O711tek0X15NnW+WpJxGbHouGI5PDhtiK2kALFHMlE1M1vmh8IznEH9MoSKtsUsyqZY/0XhvMoe0Hwp81c9talrNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817713; c=relaxed/simple;
	bh=0Yi8JEKuzVcbsTEPlH3Bby1aFOoivGjQc0Z4blrnl4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dELJh84zHAi5nCTuOdU/yZph4PHhROP4MNv01RjORNZ1c3QEDqTRUjcf+hHzSZQSvHAJrF6wRiAWTqDAqxoDBR+OC1FOplf9HyNqeKS4jkvpn49exkSGz2xorIIg7ENDm0Tn22Wz0aQBJeRoGUt7L9M1ErYGr2l7RmcpaeQQxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVQgR2whbz6Mb;
	Mon, 15 Dec 2025 17:36:35 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dVQgQ5X8Nz9pt;
	Mon, 15 Dec 2025 17:36:34 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Mon, 15 Dec 2025 17:36:15 +0100
Subject: [PATCH 2/2] accel/rocket: fix unwinding in error path in
 rocket_probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-rocket-error-path-v1-2-eec3bf29dc3b@cherry.de>
References: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
In-Reply-To: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

When rocket_core_init() fails (as could be the case with EPROBE_DEFER),
we need to properly unwind by decrementing the counter we just
incremented and if this is the first core we failed to probe, remove the
rocket DRM device with rocket_device_fini() as well. This matches the
logic in rocket_remove(). Failing to properly unwind results in
out-of-bounds accesses.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Note that this means that, technically, the first core (in HW) may not
be the first core in the kernel (if EPROBE_DEFER is returned by the
first core's probe for example). This may be a real issue if we rely on
this. E.g. I see the iommu domain is set in in rocket_open() with
rocket_iommu_domain_create(rdev->cores[0].dev) which could be expecting
the main core (but it isn't clear from the commit logs, so maybe all
cores may be totally independent). In any case, this patch is keeping
the status quo.
---
 drivers/accel/rocket/rocket_drv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5c0b63f0a8f00..f6ef4c7aeef11 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include "rocket_device.h"
 #include "rocket_drv.h"
 #include "rocket_gem.h"
 #include "rocket_job.h"
@@ -158,6 +159,8 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -177,7 +180,17 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->num_cores++;
 
-	return rocket_core_init(&rdev->cores[core]);
+	ret = rocket_core_init(&rdev->cores[core]);
+	if (ret) {
+		rdev->num_cores--;
+
+		if (rdev->num_cores == 0) {
+			rocket_device_fini(rdev);
+			rdev = NULL;
+		}
+	}
+
+	return ret;
 }
 
 static void rocket_remove(struct platform_device *pdev)

-- 
2.52.0


