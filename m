Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91717D153A
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjJTRzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJTRzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:55:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F7C0
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:55:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAEFC433C8;
        Fri, 20 Oct 2023 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697824510;
        bh=1Ow2XDId2LMLbIdUP3r/sopP7CvUseWOtrShYqNiA7w=;
        h=Subject:To:Cc:From:Date:From;
        b=DhzyLoy6FosDIqZGfr5GrUyrHToQfu5O4YPwBQOMSHHAiNbVpSDS31RDR7acA19V+
         QuUxy64m4Mywt1K34u53QX4riPy5HzJDbzqakJp6t0LK12Ybqs7HY79FPBbHLgK0jo
         M5anW+5qK/A2pCzWbupo67sSmV5W7B/IWpl1/dA8=
Subject: FAILED: patch "[PATCH] accel/ivpu: Don't enter d0i3 during FLR" failed to apply to 6.5-stable tree
To:     jacek.lawrynowicz@linux.intel.com,
        stanislaw.gruszka@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:55:07 +0200
Message-ID: <2023102007-snitch-flip-acaa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 828d63042aeca132a93938b98dc7f1a6c97bbc51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102007-snitch-flip-acaa@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 828d63042aeca132a93938b98dc7f1a6c97bbc51 Mon Sep 17 00:00:00 2001
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Date: Tue, 3 Oct 2023 08:42:13 +0200
Subject: [PATCH] accel/ivpu: Don't enter d0i3 during FLR

Avoid HW bug on some platforms where we enter D0i3 state
and CPU is in low power states (C8 or above).

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Cc: stable@vger.kernel.org
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231003064213.1527327-1-stanislaw.gruszka@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 467a60235370..7e9359611d69 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -367,14 +367,19 @@ int ivpu_boot(struct ivpu_device *vdev)
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
index 03b3d6532fb6..2adc349126bb 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -151,6 +151,7 @@ void ivpu_file_priv_put(struct ivpu_file_priv **link);
 
 int ivpu_boot(struct ivpu_device *vdev);
 int ivpu_shutdown(struct ivpu_device *vdev);
+void ivpu_prepare_for_reset(struct ivpu_device *vdev);
 
 static inline u8 ivpu_revision(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index ab341237bcf9..1079e06255ba 100644
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
@@ -91,6 +92,13 @@ static inline int ivpu_hw_power_down(struct ivpu_device *vdev)
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
diff --git a/drivers/accel/ivpu/ivpu_hw_37xx.c b/drivers/accel/ivpu/ivpu_hw_37xx.c
index 9eae1c241bc0..976019429164 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@ -1029,6 +1029,7 @@ const struct ivpu_hw_ops ivpu_hw_37xx_ops = {
 	.power_up = ivpu_hw_37xx_power_up,
 	.is_idle = ivpu_hw_37xx_is_idle,
 	.power_down = ivpu_hw_37xx_power_down,
+	.reset = ivpu_hw_37xx_reset,
 	.boot_fw = ivpu_hw_37xx_boot_fw,
 	.wdt_disable = ivpu_hw_37xx_wdt_disable,
 	.diagnose_failure = ivpu_hw_37xx_diagnose_failure,
diff --git a/drivers/accel/ivpu/ivpu_hw_40xx.c b/drivers/accel/ivpu/ivpu_hw_40xx.c
index 8bdb59a45da6..85171a408363 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -1179,6 +1179,7 @@ const struct ivpu_hw_ops ivpu_hw_40xx_ops = {
 	.power_up = ivpu_hw_40xx_power_up,
 	.is_idle = ivpu_hw_40xx_is_idle,
 	.power_down = ivpu_hw_40xx_power_down,
+	.reset = ivpu_hw_40xx_reset,
 	.boot_fw = ivpu_hw_40xx_boot_fw,
 	.wdt_disable = ivpu_hw_40xx_wdt_disable,
 	.diagnose_failure = ivpu_hw_40xx_diagnose_failure,
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index e6f27daf5560..ffff2496e8e8 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -261,7 +261,8 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 	ivpu_dbg(vdev, PM, "Pre-reset..\n");
 	atomic_inc(&vdev->pm->reset_counter);
 	atomic_set(&vdev->pm->in_reset, 1);
-	ivpu_shutdown(vdev);
+	ivpu_prepare_for_reset(vdev);
+	ivpu_hw_reset(vdev);
 	ivpu_pm_prepare_cold_boot(vdev);
 	ivpu_jobs_abort_all(vdev);
 	ivpu_dbg(vdev, PM, "Pre-reset done.\n");

