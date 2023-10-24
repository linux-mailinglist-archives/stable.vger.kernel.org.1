Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC7B7D473E
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjJXGSf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 02:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJXGSe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 02:18:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59295C0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128312; x=1729664312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M9ZtuNkkwkvQzt9EKQxIQNAMooVtX8nhyVvhEiOi8hA=;
  b=Dxn7JBaixl4VrIqMTVT6fsFav8xNrnozeTD+5kLI5OxoHN/ndPQUFgTn
   vAiTVap12zFRpCGADwNKhwFA1QZOvUqXpMFTiQfSJzncqqvT7Z+6TleuM
   jAUaqIetiHnrhvK914KXB5q8YSYlI6GBh1NisIP6klKmpcjYBloRWrkVb
   DeTAMCRhUz/G410wfstlQbrD8UWhwtMfHcKo189PByfcxxf2KiMKr5JSK
   fXjuKBCpc1g+QKoMNTnxWogjqEyI6LPcZ3xWRrHAY0mqUzAghomOG+z04
   1plAsVE+SHZz3lwZVozTkUbV5/RW3xrPN/FERUSRhl4j4CPi7tIPXLYOZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806344"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806344"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751890819"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751890819"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.243])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:18:29 -0700
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     stable@vger.kernel.org
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        stanislaw.gruszka@linux.intel.com
Subject: [PATCH 6.5] accel/ivpu: Don't enter d0i3 during FLR
Date:   Tue, 24 Oct 2023 08:18:27 +0200
Message-Id: <20231024061827.62996-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 828d63042aeca132a93938b98dc7f1a6c97bbc51 upstream.

Avoid HW bug on some platforms where we enter D0i3 state
and CPU is in low power states (C8 or above).

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231003064213.1527327-1-stanislaw.gruszka@linux.intel.com
-
---
 drivers/accel/ivpu/ivpu_drv.c    | 11 ++++++++---
 drivers/accel/ivpu/ivpu_drv.h    |  1 +
 drivers/accel/ivpu/ivpu_hw.h     |  8 ++++++++
 drivers/accel/ivpu/ivpu_hw_mtl.c |  1 +
 drivers/accel/ivpu/ivpu_pm.c     |  3 ++-
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 8396db2b5203..13e11437bee5 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -343,14 +343,19 @@ int ivpu_boot(struct ivpu_device *vdev)
 	return 0;
 }
 
-int ivpu_shutdown(struct ivpu_device *vdev)
+void ivpu_prepare_for_reset(struct ivpu_device *vdev)
 {
-	int ret;
-
 	ivpu_hw_irq_disable(vdev);
 	disable_irq(vdev->irq);
 	ivpu_ipc_disable(vdev);
 	ivpu_mmu_disable(vdev);
+}
+
+int ivpu_shutdown(struct ivpu_device *vdev)
+{
+	int ret;
+
+	ivpu_prepare_for_reset(vdev);
 
 	ret = ivpu_hw_power_down(vdev);
 	if (ret)
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 399dc5dcefd7..343b15e56799 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -144,6 +144,7 @@ void ivpu_file_priv_put(struct ivpu_file_priv **link);
 
 int ivpu_boot(struct ivpu_device *vdev);
 int ivpu_shutdown(struct ivpu_device *vdev);
+void ivpu_prepare_for_reset(struct ivpu_device *vdev);
 
 static inline bool ivpu_is_mtl(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index 50a9304ab09c..dac59f1c1e05 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -13,6 +13,7 @@ struct ivpu_hw_ops {
 	int (*power_up)(struct ivpu_device *vdev);
 	int (*boot_fw)(struct ivpu_device *vdev);
 	int (*power_down)(struct ivpu_device *vdev);
+	int (*reset)(struct ivpu_device *vdev);
 	bool (*is_idle)(struct ivpu_device *vdev);
 	void (*wdt_disable)(struct ivpu_device *vdev);
 	void (*diagnose_failure)(struct ivpu_device *vdev);
@@ -90,6 +91,13 @@ static inline int ivpu_hw_power_down(struct ivpu_device *vdev)
 	return vdev->hw->ops->power_down(vdev);
 };
 
+static inline int ivpu_hw_reset(struct ivpu_device *vdev)
+{
+	ivpu_dbg(vdev, PM, "HW reset\n");
+
+	return vdev->hw->ops->reset(vdev);
+};
+
 static inline void ivpu_hw_wdt_disable(struct ivpu_device *vdev)
 {
 	vdev->hw->ops->wdt_disable(vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw_mtl.c b/drivers/accel/ivpu/ivpu_hw_mtl.c
index 2a5dd3a5dc46..d21c16b5e6f8 100644
--- a/drivers/accel/ivpu/ivpu_hw_mtl.c
+++ b/drivers/accel/ivpu/ivpu_hw_mtl.c
@@ -1041,6 +1041,7 @@ const struct ivpu_hw_ops ivpu_hw_mtl_ops = {
 	.power_up = ivpu_hw_mtl_power_up,
 	.is_idle = ivpu_hw_mtl_is_idle,
 	.power_down = ivpu_hw_mtl_power_down,
+	.reset = ivpu_hw_mtl_reset,
 	.boot_fw = ivpu_hw_mtl_boot_fw,
 	.wdt_disable = ivpu_hw_mtl_wdt_disable,
 	.diagnose_failure = ivpu_hw_mtl_diagnose_failure,
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index aa4d56dc52b3..86ec828dd1df 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -260,7 +260,8 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 
 	ivpu_dbg(vdev, PM, "Pre-reset..\n");
 	atomic_set(&vdev->pm->in_reset, 1);
-	ivpu_shutdown(vdev);
+	ivpu_prepare_for_reset(vdev);
+	ivpu_hw_reset(vdev);
 	ivpu_pm_prepare_cold_boot(vdev);
 	ivpu_jobs_abort_all(vdev);
 	ivpu_dbg(vdev, PM, "Pre-reset done.\n");
-- 
2.34.1

