Return-Path: <stable+bounces-4195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4B804676
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4384F1C20CFA
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909686FB8;
	Tue,  5 Dec 2023 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2avwfPut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AB6FAF;
	Tue,  5 Dec 2023 03:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EF5C433C8;
	Tue,  5 Dec 2023 03:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746878;
	bh=Q7woPveaMrb5ctf340IkDcn25seX1/1uVL540RcGs3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2avwfPut7IC1HCVPhhhK1MeY72VAjFpqniQXNL+Ugxvu+AoBd5+RHhvErnjUr9Wv/
	 zi/KHBJFczAsnL+cEYpKVCozOLB6VwsLXq5gbrQLywzGcadtL40o8w9HO+hJKJN4uE
	 srvSQa6XgHR9yC3ZCHuGYMZR3ds+a9ssaBOG3Yd8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/71] PCI: Move ASPM declarations to linux/pci.h
Date: Tue,  5 Dec 2023 12:16:51 +0900
Message-ID: <20231205031520.952879003@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Wilczynski <kw@linux.com>

[ Upstream commit 7ce2e76a0420801fb4b53b9e6850940e6b326433 ]

Move ASPM definitions and function prototypes from include/linux/pci-aspm.h
to include/linux/pci.h so users only need to include <linux/pci.h>:

  PCIE_LINK_STATE_L0S
  PCIE_LINK_STATE_L1
  PCIE_LINK_STATE_CLKPM
  pci_disable_link_state()
  pci_disable_link_state_locked()
  pcie_no_aspm()

No functional changes intended.

Link: https://lore.kernel.org/r/20190827095620.11213-1-kw@linux.com
Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 3cb4f534bac0 ("Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when driver, disables L1"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pci_root.c                       |  1 -
 drivers/char/xillybus/xillybus_pcie.c         |  1 -
 drivers/net/ethernet/intel/e1000e/e1000.h     |  1 -
 drivers/net/ethernet/jme.c                    |  1 -
 drivers/net/ethernet/realtek/r8169_main.c     |  1 -
 drivers/net/wireless/ath/ath5k/pci.c          |  1 -
 .../net/wireless/intel/iwlegacy/3945-mac.c    |  1 -
 .../net/wireless/intel/iwlegacy/4965-mac.c    |  1 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 -
 drivers/pci/pci-acpi.c                        |  1 -
 drivers/pci/pcie/aspm.c                       |  1 -
 drivers/pci/quirks.c                          |  1 -
 drivers/scsi/aacraid/linit.c                  |  1 -
 drivers/scsi/hpsa.c                           |  1 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c          |  1 -
 include/linux/pci-aspm.h                      | 36 -------------------
 include/linux/pci.h                           | 18 ++++++++++
 17 files changed, 18 insertions(+), 51 deletions(-)
 delete mode 100644 include/linux/pci-aspm.h

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e465e720eab20..6c23a6f520bad 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -28,7 +28,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
-#include <linux/pci-aspm.h>
 #include <linux/dmar.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 05e5324f60bd9..03dda2141ff42 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include "xillybus.h"
 
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index c5a119daa7f3c..585da186e21f8 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -13,7 +13,6 @@
 #include <linux/io.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
 #include <linux/timecounter.h>
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index a5ab6f3403ae0..0935cf16de6eb 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ecdf628e3bb89..d05bf6446a008 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -28,7 +28,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/firmware.h>
 #include <linux/prefetch.h>
-#include <linux/pci-aspm.h>
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
 
diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index c6156cc38940a..d5ee32ce9eb3d 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -18,7 +18,6 @@
 
 #include <linux/nl80211.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include "../ath.h"
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index d51a23815e186..20227f87025d1 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 2b60473e7bf9c..bc5c2f4f9c51b 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c69c13e762bbe..87235082acda7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -67,7 +67,6 @@
  *
  *****************************************************************************/
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
 #include <linux/sched.h>
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 2777c459706a9..216a8f109be42 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -14,7 +14,6 @@
 #include <linux/msi.h>
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
-#include <linux/pci-aspm.h>
 #include <linux/pci-acpi.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f2b5f3a8535e5..1f9e89c2c10d3 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
-#include <linux/pci-aspm.h>
 #include "../pci.h"
 
 #ifdef MODULE_PARAM_PREFIX
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a165710fbb86..db8d9cbc86bf6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/pci-aspm.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/ktime.h>
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index eecffc03084c0..c2748c07f9507 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -40,7 +40,6 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/aer.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 25d9bdd4bc698..77ed4324741fc 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index bf659bc466dcc..78cf157fe2c19 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -51,7 +51,6 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/interrupt.h>
 #include <linux/aer.h>
 #include <linux/raid_class.h>
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
deleted file mode 100644
index 67064145d76e0..0000000000000
--- a/include/linux/pci-aspm.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	aspm.h
- *
- *	PCI Express ASPM defines and function prototypes
- *
- *	Copyright (C) 2007 Intel Corp.
- *		Zhang Yanmin (yanmin.zhang@intel.com)
- *		Shaohua Li (shaohua.li@intel.com)
- *
- *	For more information, please consult the following manuals (look at
- *	http://www.pcisig.com/ for how to get them):
- *
- *	PCI Express Specification
- */
-
-#ifndef LINUX_ASPM_H
-#define LINUX_ASPM_H
-
-#include <linux/pci.h>
-
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
-
-#ifdef CONFIG_PCIEASPM
-int pci_disable_link_state(struct pci_dev *pdev, int state);
-int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
-void pcie_no_aspm(void);
-#else
-static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
-{ return 0; }
-static inline void pcie_no_aspm(void) { }
-#endif
-
-#endif /* LINUX_ASPM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2636990e0cccf..f8036acf2c12b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -6,12 +6,18 @@
  *	Copyright 1994, Drew Eckhardt
  *	Copyright 1997--1999 Martin Mares <mj@ucw.cz>
  *
+ *	PCI Express ASPM defines and function prototypes
+ *	Copyright (c) 2007 Intel Corp.
+ *		Zhang Yanmin (yanmin.zhang@intel.com)
+ *		Shaohua Li (shaohua.li@intel.com)
+ *
  *	For more information, please consult the following manuals (look at
  *	http://www.pcisig.com/ for how to get them):
  *
  *	PCI BIOS Specification
  *	PCI Local Bus Specification
  *	PCI to PCI Bridge Specification
+ *	PCI Express Specification
  *	PCI System Design Guide
  */
 #ifndef LINUX_PCI_H
@@ -1490,9 +1496,21 @@ extern bool pcie_ports_native;
 #define pcie_ports_native	false
 #endif
 
+#define PCIE_LINK_STATE_L0S	1
+#define PCIE_LINK_STATE_L1	2
+#define PCIE_LINK_STATE_CLKPM	4
+
 #ifdef CONFIG_PCIEASPM
+int pci_disable_link_state(struct pci_dev *pdev, int state);
+int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 #else
+static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
+{ return 0; }
+static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
+{ return 0; }
+static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 #endif
 
-- 
2.42.0




