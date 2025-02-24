Return-Path: <stable+bounces-119111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4EA424CC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB95C445F81
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57525485D;
	Mon, 24 Feb 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mrmyxfk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3B2561B2;
	Mon, 24 Feb 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408355; cv=none; b=AHjPhhcXHOgXk6Mc6aFCgHbNoT9Tq0JTW4GMoH45B6LfuWltc+6Wp2qiEDHHjptIFd6w2+SDDCLOUH5DJO1HTssiQbNm3AVaDeKJC9MuN5mfVTvwmkehnjohbIAeA8ANP/OFdGOVSwVPzTwq9g5t07xlL8b+U6cjZ/1kzr1mItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408355; c=relaxed/simple;
	bh=zhp0+/9xBq+uv1H/V1FdHHhPP3SbC9Ocdr4r1dBYSaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQYlgTGZK2Y0o4jn41sXvoQuT6wp+HJs3wm8T9WsbfrtgxBr0T33dEgnWw8xXpanVW4hDfUMGc9Xp5jRN7Qwkt0pN9d4O/wax5SO0Jy8G2oJmvd6dCOD7h5PKBOP+zLCTopwh4qN+kVyCaQp8sv2a/G+g0y6gGzneBgTtnmgVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mrmyxfk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1AFC4CEE9;
	Mon, 24 Feb 2025 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408355;
	bh=zhp0+/9xBq+uv1H/V1FdHHhPP3SbC9Ocdr4r1dBYSaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mrmyxfk7SrVuB9xgfmKgPpjPJtptDbtUDbemFRPgscdEJCs05wldxmbg/NHqpypHG
	 JEbW3hQ8F6oYN6Ld1GWqaigTuFU/vq4vwfhzSzdfVPQXkqGqgnq/nZrSkcOmfKMc5n
	 BWpFXE9zRm4jamYj8movcXhQA9Zid2XLEKXrdJPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 034/154] accel/ivpu: Add coredump support
Date: Mon, 24 Feb 2025 15:33:53 +0100
Message-ID: <20250224142608.421172501@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Wachowski <karol.wachowski@intel.com>

[ Upstream commit bade0340526827d03d9c293450c0422beba77f04 ]

Use coredump (if available) to collect FW logs in case of a FW crash.
This makes dmesg more readable and allows to collect more log data.

Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-8-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Stable-dep-of: 41a2d8286c90 ("accel/ivpu: Fix error handling in recovery/reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/Kconfig         |  1 +
 drivers/accel/ivpu/Makefile        |  1 +
 drivers/accel/ivpu/ivpu_coredump.c | 39 ++++++++++++++++++++++++++++++
 drivers/accel/ivpu/ivpu_coredump.h | 25 +++++++++++++++++++
 drivers/accel/ivpu/ivpu_drv.c      |  5 ++--
 drivers/accel/ivpu/ivpu_fw_log.h   |  8 ------
 drivers/accel/ivpu/ivpu_pm.c       |  9 ++++---
 7 files changed, 74 insertions(+), 14 deletions(-)
 create mode 100644 drivers/accel/ivpu/ivpu_coredump.c
 create mode 100644 drivers/accel/ivpu/ivpu_coredump.h

diff --git a/drivers/accel/ivpu/Kconfig b/drivers/accel/ivpu/Kconfig
index 682c532452863..e4d418b44626e 100644
--- a/drivers/accel/ivpu/Kconfig
+++ b/drivers/accel/ivpu/Kconfig
@@ -8,6 +8,7 @@ config DRM_ACCEL_IVPU
 	select FW_LOADER
 	select DRM_GEM_SHMEM_HELPER
 	select GENERIC_ALLOCATOR
+	select WANT_DEV_COREDUMP
 	help
 	  Choose this option if you have a system with an 14th generation
 	  Intel CPU (Meteor Lake) or newer. Intel NPU (formerly called Intel VPU)
diff --git a/drivers/accel/ivpu/Makefile b/drivers/accel/ivpu/Makefile
index ebd682a42eb12..232ea6d28c6e2 100644
--- a/drivers/accel/ivpu/Makefile
+++ b/drivers/accel/ivpu/Makefile
@@ -19,5 +19,6 @@ intel_vpu-y := \
 	ivpu_sysfs.o
 
 intel_vpu-$(CONFIG_DEBUG_FS) += ivpu_debugfs.o
+intel_vpu-$(CONFIG_DEV_COREDUMP) += ivpu_coredump.o
 
 obj-$(CONFIG_DRM_ACCEL_IVPU) += intel_vpu.o
diff --git a/drivers/accel/ivpu/ivpu_coredump.c b/drivers/accel/ivpu/ivpu_coredump.c
new file mode 100644
index 0000000000000..16ad0c30818cc
--- /dev/null
+++ b/drivers/accel/ivpu/ivpu_coredump.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-2024 Intel Corporation
+ */
+
+#include <linux/devcoredump.h>
+#include <linux/firmware.h>
+
+#include "ivpu_coredump.h"
+#include "ivpu_fw.h"
+#include "ivpu_gem.h"
+#include "vpu_boot_api.h"
+
+#define CRASH_DUMP_HEADER "Intel NPU crash dump"
+#define CRASH_DUMP_HEADERS_SIZE SZ_4K
+
+void ivpu_dev_coredump(struct ivpu_device *vdev)
+{
+	struct drm_print_iterator pi = {};
+	struct drm_printer p;
+	size_t coredump_size;
+	char *coredump;
+
+	coredump_size = CRASH_DUMP_HEADERS_SIZE + FW_VERSION_HEADER_SIZE +
+			ivpu_bo_size(vdev->fw->mem_log_crit) + ivpu_bo_size(vdev->fw->mem_log_verb);
+	coredump = vmalloc(coredump_size);
+	if (!coredump)
+		return;
+
+	pi.data = coredump;
+	pi.remain = coredump_size;
+	p = drm_coredump_printer(&pi);
+
+	drm_printf(&p, "%s\n", CRASH_DUMP_HEADER);
+	drm_printf(&p, "FW version: %s\n", vdev->fw->version);
+	ivpu_fw_log_print(vdev, false, &p);
+
+	dev_coredumpv(vdev->drm.dev, coredump, pi.offset, GFP_KERNEL);
+}
diff --git a/drivers/accel/ivpu/ivpu_coredump.h b/drivers/accel/ivpu/ivpu_coredump.h
new file mode 100644
index 0000000000000..8efb09d024411
--- /dev/null
+++ b/drivers/accel/ivpu/ivpu_coredump.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2024 Intel Corporation
+ */
+
+#ifndef __IVPU_COREDUMP_H__
+#define __IVPU_COREDUMP_H__
+
+#include <drm/drm_print.h>
+
+#include "ivpu_drv.h"
+#include "ivpu_fw_log.h"
+
+#ifdef CONFIG_DEV_COREDUMP
+void ivpu_dev_coredump(struct ivpu_device *vdev);
+#else
+static inline void ivpu_dev_coredump(struct ivpu_device *vdev)
+{
+	struct drm_printer p = drm_info_printer(vdev->drm.dev);
+
+	ivpu_fw_log_print(vdev, false, &p);
+}
+#endif
+
+#endif /* __IVPU_COREDUMP_H__ */
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index c91400ecf9265..38b4158f52784 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -14,7 +14,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_prime.h>
 
-#include "vpu_boot_api.h"
+#include "ivpu_coredump.h"
 #include "ivpu_debugfs.h"
 #include "ivpu_drv.h"
 #include "ivpu_fw.h"
@@ -29,6 +29,7 @@
 #include "ivpu_ms.h"
 #include "ivpu_pm.h"
 #include "ivpu_sysfs.h"
+#include "vpu_boot_api.h"
 
 #ifndef DRIVER_VERSION_STR
 #define DRIVER_VERSION_STR __stringify(DRM_IVPU_DRIVER_MAJOR) "." \
@@ -382,7 +383,7 @@ int ivpu_boot(struct ivpu_device *vdev)
 		ivpu_err(vdev, "Failed to boot the firmware: %d\n", ret);
 		ivpu_hw_diagnose_failure(vdev);
 		ivpu_mmu_evtq_dump(vdev);
-		ivpu_fw_log_dump(vdev);
+		ivpu_dev_coredump(vdev);
 		return ret;
 	}
 
diff --git a/drivers/accel/ivpu/ivpu_fw_log.h b/drivers/accel/ivpu/ivpu_fw_log.h
index 0b2573f6f3151..4b390a99699d6 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.h
+++ b/drivers/accel/ivpu/ivpu_fw_log.h
@@ -8,8 +8,6 @@
 
 #include <linux/types.h>
 
-#include <drm/drm_print.h>
-
 #include "ivpu_drv.h"
 
 #define IVPU_FW_LOG_DEFAULT 0
@@ -28,11 +26,5 @@ extern unsigned int ivpu_log_level;
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p);
 void ivpu_fw_log_clear(struct ivpu_device *vdev);
 
-static inline void ivpu_fw_log_dump(struct ivpu_device *vdev)
-{
-	struct drm_printer p = drm_info_printer(vdev->drm.dev);
-
-	ivpu_fw_log_print(vdev, false, &p);
-}
 
 #endif /* __IVPU_FW_LOG_H__ */
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index ef9a4ba18cb8a..0110f5ee7d069 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -9,17 +9,18 @@
 #include <linux/pm_runtime.h>
 #include <linux/reboot.h>
 
-#include "vpu_boot_api.h"
+#include "ivpu_coredump.h"
 #include "ivpu_drv.h"
-#include "ivpu_hw.h"
 #include "ivpu_fw.h"
 #include "ivpu_fw_log.h"
+#include "ivpu_hw.h"
 #include "ivpu_ipc.h"
 #include "ivpu_job.h"
 #include "ivpu_jsm_msg.h"
 #include "ivpu_mmu.h"
 #include "ivpu_ms.h"
 #include "ivpu_pm.h"
+#include "vpu_boot_api.h"
 
 static bool ivpu_disable_recovery;
 module_param_named_unsafe(disable_recovery, ivpu_disable_recovery, bool, 0644);
@@ -123,7 +124,7 @@ static void ivpu_pm_recovery_work(struct work_struct *work)
 	if (ret)
 		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
 
-	ivpu_fw_log_dump(vdev);
+	ivpu_dev_coredump(vdev);
 
 	atomic_inc(&vdev->pm->reset_counter);
 	atomic_set(&vdev->pm->reset_pending, 1);
@@ -262,7 +263,7 @@ int ivpu_pm_runtime_suspend_cb(struct device *dev)
 	if (!is_idle || ret_d0i3) {
 		ivpu_err(vdev, "Forcing cold boot due to previous errors\n");
 		atomic_inc(&vdev->pm->reset_counter);
-		ivpu_fw_log_dump(vdev);
+		ivpu_dev_coredump(vdev);
 		ivpu_pm_prepare_cold_boot(vdev);
 	} else {
 		ivpu_pm_prepare_warm_boot(vdev);
-- 
2.39.5




