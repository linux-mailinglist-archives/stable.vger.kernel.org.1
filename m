Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D47D1469
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJTQxm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjJTQxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63CCA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25795C433C9;
        Fri, 20 Oct 2023 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697820819;
        bh=s48negDH3sWlDfxaI+vNKzKmKUbmoAYDtB6e7rmWBZQ=;
        h=Subject:To:Cc:From:Date:From;
        b=H1k3DTu2gd2PQQfAd5zOpKt21w+ty4fvN/pBU0gDg3gwDvzAiVGZqk80ICogAXf1Z
         JdzLzFKaBVS4yfxTlhtX3ICbGIZioJxZ3ExSKhFUXK8W/TcAgsTSDA04dBt2SvtSZ4
         rboddea2T8GyJVnzfkDhLgHr9Aknyfd7RQGb35V4=
Subject: FAILED: patch "[PATCH] ice: reset first in crash dump kernels" failed to apply to 4.19-stable tree
To:     jesse.brandeburg@intel.com, himasekharx.reddy.pucha@intel.com,
        jay.vosburgh@canonical.com, kuba@kernel.org,
        przemyslaw.kitszel@intel.com, vagrawal@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 18:53:21 +0200
Message-ID: <2023102021-polygraph-modular-418a@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 0288c3e709e5fabd51e84715c5c798a02f43061a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102021-polygraph-modular-418a@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0288c3e709e5fabd51e84715c5c798a02f43061a Mon Sep 17 00:00:00 2001
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 11 Oct 2023 16:33:33 -0700
Subject: [PATCH] ice: reset first in crash dump kernels

When the system boots into the crash dump kernel after a panic, the ice
networking device may still have pending transactions that can cause errors
or machine checks when the device is re-enabled. This can prevent the crash
dump kernel from loading the driver or collecting the crash data.

To avoid this issue, perform a function level reset (FLR) on the ice device
via PCIe config space before enabling it on the crash kernel. This will
clear any outstanding transactions and stop all queues and interrupts.
Restore the config space after the FLR, otherwise it was found in testing
that the driver wouldn't load successfully.

The following sequence causes the original issue:
- Load the ice driver with modprobe ice
- Enable SR-IOV with 2 VFs: echo 2 > /sys/class/net/eth0/device/sriov_num_vfs
- Trigger a crash with echo c > /proc/sysrq-trigger
- Load the ice driver again (or let it load automatically) with modprobe ice
- The system crashes again during pcim_enable_device()

Fixes: 837f08fdecbe ("ice: Add basic driver framework for Intel(R) E800 Series")
Reported-by: Vishal Agrawal <vagrawal@redhat.com>
Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Link: https://lore.kernel.org/r/20231011233334.336092-3-jacob.e.keller@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8286adae946..6550c46e4e36 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
@@ -5014,6 +5015,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return -EINVAL;
 	}
 
+	/* when under a kdump kernel initiate a reset before enabling the
+	 * device in order to clear out any pending DMA transactions. These
+	 * transactions can cause some systems to machine check when doing
+	 * the pcim_enable_device() below.
+	 */
+	if (is_kdump_kernel()) {
+		pci_save_state(pdev);
+		pci_clear_master(pdev);
+		err = pcie_flr(pdev);
+		if (err)
+			return err;
+		pci_restore_state(pdev);
+	}
+
 	/* this driver uses devres, see
 	 * Documentation/driver-api/driver-model/devres.rst
 	 */

