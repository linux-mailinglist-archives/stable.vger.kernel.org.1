Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638D779B809
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353278AbjIKVuF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjIKPA2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44BE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDE7C433C7;
        Mon, 11 Sep 2023 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444422;
        bh=ZISMgDT3cMFgS831g13yixoZlGtdjwE6e+FnOZnvGzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALzR6UpRmLh+eGFJRuxfr7Mqp9MhcV+zqFou0o3DjWbRoYbVCdnRTAxAXtxPcORi0
         MAZpYWKT1yJtL2VGU08q0QSzLb/2LKyObt6abAS3SJctyVC5hyEAKPRSS4kotAY0dA
         OpW0tSg3Hpu0IeGEBy4t0T6LipvHVB7N2eAW4+kY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 6.4 724/737] media: ipu3-cio2: allow ipu_bridge to be a module again
Date:   Mon, 11 Sep 2023 15:49:43 +0200
Message-ID: <20230911134710.734386464@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@kernel.org>

commit 2545a2c02ba1da9cfb9ec218623c71b00eb4a555 upstream.

This code was previously part of the VIDEO_IPU3_CIO2 driver, which could
be built-in or a loadable module, but after the move it turned into a
builtin-only driver. This fails to link when the I2C subsystem is a
module:

x86_64-linux-ld: drivers/media/pci/intel/ipu-bridge.o: in function `ipu_bridge_unregister_sensors':
ipu-bridge.c:(.text+0x50): undefined reference to `i2c_unregister_device'
x86_64-linux-ld: drivers/media/pci/intel/ipu-bridge.o: in function `ipu_bridge_init':
ipu-bridge.c:(.text+0x9c9): undefined reference to `i2c_acpi_new_device_by_fwnode'

In general, drivers should not have to be built-in, so change the option
to a tristate with the corresponding dependency. This in turn opens a
new problem with the dependency, as the IPU bridge can be a loadable module
while the ipu3 driver itself is built-in, producing a new link failure:

86_64-linux-ld: drivers/media/pci/intel/ipu3/ipu3-cio2.o: in function `cio2_pci_probe':
ipu3-cio2.c:(.text+0x197e): undefined reference to `ipu_bridge_init'

In order to fix this, restore the old Kconfig option that controlled
the ipu bridge driver before it was split out, but make it select a
hidden symbol that now corresponds to the bridge driver.

When other drivers get added that share ipu-bridge, this should cover
all corner cases, and allow any combination of them to be built-in
or modular.

Link: https://lore.kernel.org/linux-media/20230727122331.2421453-1-arnd@kernel.org

Fixes: 881ca25978c6 ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")'
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/intel/Kconfig      |   21 +++++----------------
 drivers/media/pci/intel/ipu-bridge.c |    3 +++
 drivers/media/pci/intel/ipu3/Kconfig |   20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 16 deletions(-)

--- a/drivers/media/pci/intel/Kconfig
+++ b/drivers/media/pci/intel/Kconfig
@@ -1,21 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IPU_BRIDGE
-	bool "Intel IPU Sensors Bridge"
-	depends on VIDEO_IPU3_CIO2 && ACPI
-	depends on I2C
+	tristate
+	depends on I2C && ACPI
 	help
-	  This extension provides an API for the Intel IPU driver to create
-	  connections to cameras that are hidden in the SSDB buffer in ACPI.
-	  It can be used to enable support for cameras in detachable / hybrid
-	  devices that ship with Windows.
-
-	  Say Y here if your device is a detachable / hybrid laptop that comes
-	  with Windows installed by the OEM, for example:
-
-		- Microsoft Surface models (except Surface Pro 3)
-		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
-		- Dell 7285
-
-	  If in doubt, say N here.
+	  This is a helper module for the IPU bridge, which can be
+	  used by ipu3 and other drivers. In order to handle module
+	  dependencies, this is selected by each driver that needs it.
 
 source "drivers/media/pci/intel/ipu3/Kconfig"
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -497,3 +497,6 @@ err_free_bridge:
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(ipu_bridge_init, INTEL_IPU_BRIDGE);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel IPU Sensors Bridge driver");
--- a/drivers/media/pci/intel/ipu3/Kconfig
+++ b/drivers/media/pci/intel/ipu3/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_IPU3_CIO2
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
 	select VIDEOBUF2_DMA_SG
+	select IPU_BRIDGE if CIO2_BRIDGE
 
 	help
 	  This is the Intel IPU3 CIO2 CSI-2 receiver unit, found in Intel
@@ -17,3 +18,22 @@ config VIDEO_IPU3_CIO2
 	  Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
 	  connected camera.
 	  The module will be called ipu3-cio2.
+
+config CIO2_BRIDGE
+	bool "IPU3 CIO2 Sensors Bridge"
+	depends on VIDEO_IPU3_CIO2 && ACPI
+	depends on I2C
+	help
+	  This extension provides an API for the ipu3-cio2 driver to create
+	  connections to cameras that are hidden in the SSDB buffer in ACPI.
+	  It can be used to enable support for cameras in detachable / hybrid
+	  devices that ship with Windows.
+
+	  Say Y here if your device is a detachable / hybrid laptop that comes
+	  with Windows installed by the OEM, for example:
+
+		- Microsoft Surface models (except Surface Pro 3)
+		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
+		- Dell 7285
+
+	  If in doubt, say N here.


