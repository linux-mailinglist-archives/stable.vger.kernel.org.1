Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C775787320
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbjHXPAa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbjHXPAH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723F21BD2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0156E670BD
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A02C433C7;
        Thu, 24 Aug 2023 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889200;
        bh=7nSFzO2i1OCbWkBK+Z3TN3Fac3R1YKlLVV6SD1SbzxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MheX1umDB+r1ofuktUBHMmjxXR8f5L18BaLZBKD4x/KGDzRuXFviklzhsu+tYiAq1
         7Dq4zuwEhoL2W4ZB8YfmYdAPNY4AgC9uIqwfwKAns3bjJHl2xcpfS3fUptfG3ivcy9
         unp0rWKUfiiaUxBP+quCE3AGiiW3yf87ZDGBUQOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hemant Kumar <hemantk@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/135] bus: mhi: Move host MHI code to "host" directory
Date:   Thu, 24 Aug 2023 16:49:53 +0200
Message-ID: <20230824145029.083388583@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit a0f5a630668cb8b2ebf5204f08e957875e991780 ]

In preparation of the endpoint MHI support, let's move the host MHI code
to its own "host" directory and adjust the toplevel MHI Kconfig & Makefile.

While at it, let's also move the "pci_generic" driver to "host" directory
as it is a host MHI controller driver.

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20220301160308.107452-5-manivannan.sadhasivam@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 6a0c637bfee6 ("bus: mhi: host: Range check CHDBOFF and ERDBOFF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/Makefile                      |  2 +-
 drivers/bus/mhi/Kconfig                   | 27 ++------------------
 drivers/bus/mhi/Makefile                  |  8 ++----
 drivers/bus/mhi/host/Kconfig              | 31 +++++++++++++++++++++++
 drivers/bus/mhi/{core => host}/Makefile   |  4 ++-
 drivers/bus/mhi/{core => host}/boot.c     |  0
 drivers/bus/mhi/{core => host}/debugfs.c  |  0
 drivers/bus/mhi/{core => host}/init.c     |  0
 drivers/bus/mhi/{core => host}/internal.h |  0
 drivers/bus/mhi/{core => host}/main.c     |  0
 drivers/bus/mhi/{ => host}/pci_generic.c  |  0
 drivers/bus/mhi/{core => host}/pm.c       |  0
 12 files changed, 39 insertions(+), 33 deletions(-)
 create mode 100644 drivers/bus/mhi/host/Kconfig
 rename drivers/bus/mhi/{core => host}/Makefile (54%)
 rename drivers/bus/mhi/{core => host}/boot.c (100%)
 rename drivers/bus/mhi/{core => host}/debugfs.c (100%)
 rename drivers/bus/mhi/{core => host}/init.c (100%)
 rename drivers/bus/mhi/{core => host}/internal.h (100%)
 rename drivers/bus/mhi/{core => host}/main.c (100%)
 rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
 rename drivers/bus/mhi/{core => host}/pm.c (100%)

diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 397e35392bff8..16c47a0616ae4 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -38,4 +38,4 @@ obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
 # MHI
-obj-$(CONFIG_MHI_BUS)		+= mhi/
+obj-y				+= mhi/
diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index da5cd0c9fc620..4748df7f9cd58 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -2,30 +2,7 @@
 #
 # MHI bus
 #
-# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+# Copyright (c) 2021, Linaro Ltd.
 #
 
-config MHI_BUS
-	tristate "Modem Host Interface (MHI) bus"
-	help
-	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
-	  communication protocol used by the host processors to control
-	  and communicate with modem devices over a high speed peripheral
-	  bus or shared memory.
-
-config MHI_BUS_DEBUG
-	bool "Debugfs support for the MHI bus"
-	depends on MHI_BUS && DEBUG_FS
-	help
-	  Enable debugfs support for use with the MHI transport. Allows
-	  reading and/or modifying some values within the MHI controller
-	  for debug and test purposes.
-
-config MHI_BUS_PCI_GENERIC
-	tristate "MHI PCI controller driver"
-	depends on MHI_BUS
-	depends on PCI
-	help
-	  This driver provides MHI PCI controller driver for devices such as
-	  Qualcomm SDX55 based PCIe modems.
-
+source "drivers/bus/mhi/host/Kconfig"
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 0a2d778d6fb42..5f5708a249f54 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -1,6 +1,2 @@
-# core layer
-obj-y += core/
-
-obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
-mhi_pci_generic-y += pci_generic.o
-
+# Host MHI stack
+obj-y += host/
diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
new file mode 100644
index 0000000000000..da5cd0c9fc620
--- /dev/null
+++ b/drivers/bus/mhi/host/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# MHI bus
+#
+# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+#
+
+config MHI_BUS
+	tristate "Modem Host Interface (MHI) bus"
+	help
+	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
+	  communication protocol used by the host processors to control
+	  and communicate with modem devices over a high speed peripheral
+	  bus or shared memory.
+
+config MHI_BUS_DEBUG
+	bool "Debugfs support for the MHI bus"
+	depends on MHI_BUS && DEBUG_FS
+	help
+	  Enable debugfs support for use with the MHI transport. Allows
+	  reading and/or modifying some values within the MHI controller
+	  for debug and test purposes.
+
+config MHI_BUS_PCI_GENERIC
+	tristate "MHI PCI controller driver"
+	depends on MHI_BUS
+	depends on PCI
+	help
+	  This driver provides MHI PCI controller driver for devices such as
+	  Qualcomm SDX55 based PCIe modems.
+
diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/host/Makefile
similarity index 54%
rename from drivers/bus/mhi/core/Makefile
rename to drivers/bus/mhi/host/Makefile
index c3feb4130aa37..859c2f38451c6 100644
--- a/drivers/bus/mhi/core/Makefile
+++ b/drivers/bus/mhi/host/Makefile
@@ -1,4 +1,6 @@
 obj-$(CONFIG_MHI_BUS) += mhi.o
-
 mhi-y := init.o main.o pm.o boot.o
 mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
+
+obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
+mhi_pci_generic-y += pci_generic.o
diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/host/boot.c
similarity index 100%
rename from drivers/bus/mhi/core/boot.c
rename to drivers/bus/mhi/host/boot.c
diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/host/debugfs.c
similarity index 100%
rename from drivers/bus/mhi/core/debugfs.c
rename to drivers/bus/mhi/host/debugfs.c
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/host/init.c
similarity index 100%
rename from drivers/bus/mhi/core/init.c
rename to drivers/bus/mhi/host/init.c
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/host/internal.h
similarity index 100%
rename from drivers/bus/mhi/core/internal.h
rename to drivers/bus/mhi/host/internal.h
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/host/main.c
similarity index 100%
rename from drivers/bus/mhi/core/main.c
rename to drivers/bus/mhi/host/main.c
diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
similarity index 100%
rename from drivers/bus/mhi/pci_generic.c
rename to drivers/bus/mhi/host/pci_generic.c
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/host/pm.c
similarity index 100%
rename from drivers/bus/mhi/core/pm.c
rename to drivers/bus/mhi/host/pm.c
-- 
2.40.1



