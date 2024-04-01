Return-Path: <stable+bounces-35277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81889433C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDF28365B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CE481B8;
	Mon,  1 Apr 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MkAUFRTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB684BA3F;
	Mon,  1 Apr 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990873; cv=none; b=AcGI0AAuaeB9LXELl/PQ9AAqRB8nVCBVDlgcQK+z1UtuNXHYoWBMAUJQsoKPScA26WVf7vQDUABN77YL1QxtY5jFm4sGOkobaxO5BK86n16APLSXUWx41+JFTkdYSS8zREXdB+o2i5o79zKT+ylAU56AZmB//KPMDrPlEDyEPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990873; c=relaxed/simple;
	bh=JyBwo4jqiCYisfQq6+uZQVGk/w89n8WfJBjkTkuv+10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQS0oKY+2IezGduOlppjgxWzOLMzNU0anORWYuf/dr9BeGTWXzsgJ1ad4v6dJIeS6VzFVMoMBwbryJj+VR6pLFsQSKuGSHRBhtFH06EAoFBGtMtQ4Lys8WieEFktOBHEypu20rzHj5p/ExJvIRGD02+9HWftN4D1M5CprsAiCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MkAUFRTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8E0C433C7;
	Mon,  1 Apr 2024 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990872;
	bh=JyBwo4jqiCYisfQq6+uZQVGk/w89n8WfJBjkTkuv+10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkAUFRTD53kikit3EXhIHfSbB97SLMz5qWq6NNLJgUrCAsRz5w1OLYjStCZNdubXr
	 z2muqgbop5vC2B9G/v1BAeCGSGmQbvzTFbFCqPbHnZMZIBLsggy/iTJzxMzPI7tEo/
	 iZko6q+aKVhiXOVz6KclYK3I2nPgeRtR9UkHke9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam Ravnborg <sam@ravnborg.org>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 093/272] sparc: Explicitly include correct DT includes
Date: Mon,  1 Apr 2024 17:44:43 +0200
Message-ID: <20240401152533.539676696@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 263291fa44ff0909b5b7c43ff40babc1c43362f2 ]

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/all/20230718143211.1066810-1-robh@kernel.org/
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: 91d3ff922c34 ("sparc32: Fix parport build with sparc32")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/crypto/crop_devid.c       | 2 +-
 arch/sparc/include/asm/floppy_32.h   | 2 +-
 arch/sparc/include/asm/floppy_64.h   | 2 +-
 arch/sparc/include/asm/parport.h     | 3 ++-
 arch/sparc/kernel/apc.c              | 2 +-
 arch/sparc/kernel/auxio_32.c         | 1 -
 arch/sparc/kernel/auxio_64.c         | 3 ++-
 arch/sparc/kernel/central.c          | 2 +-
 arch/sparc/kernel/chmc.c             | 3 ++-
 arch/sparc/kernel/ioport.c           | 2 +-
 arch/sparc/kernel/leon_kernel.c      | 2 --
 arch/sparc/kernel/leon_pci.c         | 3 ++-
 arch/sparc/kernel/leon_pci_grpci1.c  | 3 ++-
 arch/sparc/kernel/leon_pci_grpci2.c  | 4 +++-
 arch/sparc/kernel/of_device_32.c     | 2 +-
 arch/sparc/kernel/of_device_64.c     | 4 ++--
 arch/sparc/kernel/of_device_common.c | 4 ++--
 arch/sparc/kernel/pci.c              | 3 ++-
 arch/sparc/kernel/pci_common.c       | 3 ++-
 arch/sparc/kernel/pci_fire.c         | 3 ++-
 arch/sparc/kernel/pci_impl.h         | 1 -
 arch/sparc/kernel/pci_msi.c          | 2 ++
 arch/sparc/kernel/pci_psycho.c       | 4 +++-
 arch/sparc/kernel/pci_sun4v.c        | 3 ++-
 arch/sparc/kernel/pmc.c              | 2 +-
 arch/sparc/kernel/power.c            | 3 ++-
 arch/sparc/kernel/prom_irqtrans.c    | 1 +
 arch/sparc/kernel/psycho_common.c    | 1 +
 arch/sparc/kernel/sbus.c             | 3 ++-
 arch/sparc/kernel/time_32.c          | 1 -
 arch/sparc/mm/io-unit.c              | 3 ++-
 arch/sparc/mm/iommu.c                | 5 +++--
 32 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/crypto/crop_devid.c b/arch/sparc/crypto/crop_devid.c
index 83fc4536dcd57..93f4e0fdd38c1 100644
--- a/arch/sparc/crypto/crop_devid.c
+++ b/arch/sparc/crypto/crop_devid.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 
 /* This is a dummy device table linked into all of the crypto
  * opcode drivers.  It serves to trigger the module autoloading
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index e10ab9ad3097d..836f6575aa1d7 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -8,7 +8,7 @@
 #define __ASM_SPARC_FLOPPY_H
 
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/idprom.h>
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 070c8c1f5c8fd..6efeb24b0a92c 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -11,7 +11,7 @@
 #define __ASM_SPARC64_FLOPPY_H
 
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/auxio.h>
diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 03b27090c0c8c..0a7ffcfd59cda 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -7,7 +7,8 @@
 #ifndef _ASM_SPARC64_PARPORT_H
 #define _ASM_SPARC64_PARPORT_H 1
 
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/ebus_dma.h>
 #include <asm/ns87303.h>
diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index ecd05bc0a1045..d44725d37e30f 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -13,7 +13,7 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index a32d588174f2f..989860e890c4f 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/export.h>
 
 #include <asm/oplib.h>
diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 774a82b0c649f..2a2800d213256 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -10,7 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index 23f8838dd96e3..a1a6485c91831 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -10,7 +10,7 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include <asm/fhc.h>
diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 6ff43df740e08..d5fad5fb04c1d 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -15,7 +15,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/spitfire.h>
 #include <asm/chmctrl.h>
 #include <asm/cpudata.h>
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4e4f3d3263e46..e5a327799e574 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -39,7 +39,7 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-map-ops.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <asm/io.h>
 #include <asm/vaddrs.h>
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 39229940d725d..4c61da491fee1 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -8,9 +8,7 @@
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index e5e5ff6b9a5c5..3a73bc466f95d 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -7,7 +7,8 @@
  * Code is partially derived from pcic.c
  */
 
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/export.h>
diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index c32590bdd3120..b2b639bee0684 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -13,10 +13,11 @@
  * Contributors: Daniel Hellstrom <daniel@gaisler.com>
  */
 
-#include <linux/of_device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index dd06abc61657f..ac2acd62a24ec 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -6,12 +6,14 @@
  *
  */
 
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
 #include <asm/io.h>
 #include <asm/leon.h>
 #include <asm/vaddrs.h>
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ebf51e6e78ec..9ac6853b34c1b 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -7,8 +7,8 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5a9f86b1d4e7e..a8ccd7260fe7f 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/export.h>
@@ -9,8 +8,9 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/spitfire.h>
 
 #include "of_device_common.h"
diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index e717a56efc5d3..a09724381bd40 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
 #include <linux/export.h>
 #include <linux/mod_devicetable.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include "of_device_common.h"
 
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cb1ef25116e94..5637b37ba9114 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -20,8 +20,9 @@
 #include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pgtable.h>
+#include <linux/platform_device.h>
 
 #include <linux/uaccess.h>
 #include <asm/irq.h>
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 4759ccd542fe6..5eeec9ad68457 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -8,7 +8,8 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/prom.h>
 #include <asm/oplib.h>
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index 0ca08d455e805..0b91bde80fdc5 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -10,7 +10,8 @@
 #include <linux/msi.h>
 #include <linux/export.h>
 #include <linux/irq.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/numa.h>
 
 #include <asm/prom.h>
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 4e3d15189fa95..f31761f517575 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -11,7 +11,6 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
-#include <linux/of_device.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index 9ed11985768e1..fc7402948b7bc 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -5,6 +5,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
 
diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
index f413371da3871..1efc98305ec76 100644
--- a/arch/sparc/kernel/pci_psycho.c
+++ b/arch/sparc/kernel/pci_psycho.c
@@ -13,7 +13,9 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 3844809718052..0ddef827e0f99 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -15,7 +15,8 @@
 #include <linux/msi.h>
 #include <linux/export.h>
 #include <linux/log2.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/dma-map-ops.h>
 #include <asm/iommu-common.h>
 
diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index b5c1eb33b9518..69a0206e56f01 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index d941875dd7186..2f6c909e1755d 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -9,7 +9,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 28aff1c524b58..426bd08cb2ab1 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 #include <asm/prom.h>
diff --git a/arch/sparc/kernel/psycho_common.c b/arch/sparc/kernel/psycho_common.c
index e90bcb6bad7fc..5ee74b4c0cf40 100644
--- a/arch/sparc/kernel/psycho_common.c
+++ b/arch/sparc/kernel/psycho_common.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/numa.h>
+#include <linux/platform_device.h>
 
 #include <asm/upa.h>
 
diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
index 32141e1006c4a..0bababf6f2bcd 100644
--- a/arch/sparc/kernel/sbus.c
+++ b/arch/sparc/kernel/sbus.c
@@ -14,7 +14,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/numa.h>
 
 #include <asm/page.h>
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 8a08830e4a653..79934beba03a6 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -33,7 +33,6 @@
 #include <linux/ioport.h>
 #include <linux/profile.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <asm/mc146818rtc.h>
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index bf3e6d2fe5d94..3afbbe5fba46b 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -13,7 +13,8 @@
 #include <linux/bitops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/io-unit.h>
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 9e3f6933ca13f..14e178bfe33ab 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -7,14 +7,15 @@
  * Copyright (C) 1996 Eddie C. Dost    (ecd@skynet.be)
  * Copyright (C) 1997,1998 Jakub Jelinek    (jj@sunsite.mff.cuni.cz)
  */
- 
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/mxcc.h>
-- 
2.43.0




