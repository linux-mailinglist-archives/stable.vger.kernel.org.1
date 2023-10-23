Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577637D3547
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjJWLqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjJWLqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471C10CC
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:46:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC365C433C8;
        Mon, 23 Oct 2023 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061598;
        bh=WA+3kXakV8xruJSkF7efymoCYnZ6sHOVxCGsi4zaJ+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DH5+TsImF4kxViAzITwcKPZyLnsByGj3RLRajrPNy4rWzSU1pjaImzEss9/vSPsm7
         sUBT2jWl049s+yeBCV4xTw6lFPFkEtTCrotnVS8GnL0O8LNTJDorck4FzpWoQ/OPCY
         JYYaoS1qZWtT8ldLNEo3vj9B3+JgA2HfPvqneeug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vishal Agrawal <vagrawal@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 5.10 093/202] ice: reset first in crash dump kernels
Date:   Mon, 23 Oct 2023 12:56:40 +0200
Message-ID: <20231023104829.246360230@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

commit 0288c3e709e5fabd51e84715c5c798a02f43061a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
@@ -4025,6 +4026,20 @@ ice_probe(struct pci_dev *pdev, const st
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


