Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC27B879B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjJDSHU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbjJDSHT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:07:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6AAC6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:07:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E36DC433CB;
        Wed,  4 Oct 2023 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442832;
        bh=RLzZaETCVsLhxG2wQJkE7IH7IhmMOOqP09xT4WqIrLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hB8WG2cvJiKNw5jWsEQWnvUuOd3p8JeqA758rx1amKjaccvVyw/+q7tRgxdwy+Qbr
         /rqWKnSSYdOnZz/t2n0/c0g/wTu5XVFv8nTKnIM01uKRc/MCC5zepyKusFfuKwuBjk
         aECZTugh/XzefTiJrz7eu1S71RcDnEW4lR1xWqwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 096/183] treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.RULE (part 1)
Date:   Wed,  4 Oct 2023 19:55:27 +0200
Message-ID: <20231004175207.913049239@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 0fdebc5ec2ca492d69df2d93a6a7abade4941aae ]

Based on the normalized pattern:

    this file is licensed under the terms of the gnu general public
    license version 2 this program is licensed as is without any warranty
    of any kind whether express or implied

extracted by the scancode license scanner the SPDX license identifier

    GPL-2.0-only

has been chosen to replace the boilerplate/reference.

Reviewed-by: Allison Randal <allison@lohutok.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 6469b2feade8 ("ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx.dtsi                            | 5 +----
 arch/arm/boot/dts/am3517.dtsi                            | 5 +----
 arch/arm/boot/dts/am4372.dtsi                            | 5 +----
 arch/arm/boot/dts/artpec6-devboard.dts                   | 9 ++-------
 arch/arm/boot/dts/dm814x.dtsi                            | 6 +-----
 arch/arm/boot/dts/dm816x.dtsi                            | 6 +-----
 arch/arm/boot/dts/dra62x.dtsi                            | 6 +-----
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi               | 5 +----
 arch/arm/boot/dts/dra7-iva-thermal.dtsi                  | 5 +----
 arch/arm/boot/dts/imx6q-gk802.dts                        | 9 ++-------
 arch/arm/boot/dts/omap2.dtsi                             | 5 +----
 arch/arm/boot/dts/omap2420.dtsi                          | 5 +----
 arch/arm/boot/dts/omap2430.dtsi                          | 5 +----
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi                 | 5 +----
 arch/arm/boot/dts/omap3.dtsi                             | 5 +----
 arch/arm/boot/dts/omap34xx.dtsi                          | 5 +----
 arch/arm/boot/dts/omap36xx.dtsi                          | 5 +----
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi                 | 5 +----
 arch/arm/boot/dts/omap443x.dtsi                          | 5 +----
 arch/arm/boot/dts/omap4460.dtsi                          | 5 +----
 arch/arm/boot/dts/omap5-core-thermal.dtsi                | 5 +----
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi                 | 5 +----
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts           | 5 +----
 .../arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 9 ++-------
 arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts    | 5 +----
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi                 | 9 ++-------
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi                 | 9 ++-------
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts            | 9 ++-------
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts              | 9 ++-------
 arch/arm/boot/dts/orion5x.dtsi                           | 9 ++-------
 arch/arm/include/asm/hardware/cache-aurora-l2.h          | 5 +----
 arch/arm/include/asm/hardware/cache-feroceon-l2.h        | 6 +-----
 arch/arm/include/asm/hardware/cache-tauros2.h            | 5 +----
 arch/arm/mach-davinci/board-da830-evm.c                  | 6 ++----
 arch/arm/mach-davinci/board-da850-evm.c                  | 6 ++----
 arch/arm/mach-davinci/board-dm355-evm.c                  | 6 ++----
 arch/arm/mach-davinci/board-dm355-leopard.c              | 5 +----
 arch/arm/mach-davinci/board-dm644x-evm.c                 | 6 ++----
 arch/arm/mach-davinci/board-dm646x-evm.c                 | 7 +------
 arch/arm/mach-davinci/board-mityomapl138.c               | 5 +----
 arch/arm/mach-davinci/board-neuros-osd2.c                | 5 +----
 arch/arm/mach-davinci/board-omapl138-hawk.c              | 5 +----
 arch/arm/mach-davinci/common.c                           | 6 ++----
 arch/arm/mach-davinci/cpuidle.h                          | 5 +----
 arch/arm/mach-davinci/da830.c                            | 6 ++----
 arch/arm/mach-davinci/da850.c                            | 6 ++----
 arch/arm/mach-davinci/dm355.c                            | 6 ++----
 arch/arm/mach-davinci/dm644x.c                           | 6 ++----
 arch/arm/mach-davinci/dm646x.c                           | 6 ++----
 arch/arm/mach-davinci/include/mach/common.h              | 6 ++----
 arch/arm/mach-davinci/include/mach/cputype.h             | 6 ++----
 arch/arm/mach-davinci/include/mach/da8xx.h               | 6 ++----
 arch/arm/mach-davinci/include/mach/hardware.h            | 6 ++----
 arch/arm/mach-davinci/include/mach/serial.h              | 6 ++----
 arch/arm/mach-davinci/mux.c                              | 6 ++----
 arch/arm/mach-davinci/mux.h                              | 6 ++----
 arch/arm/mach-davinci/pm_domain.c                        | 5 +----
 arch/arm/mach-dove/bridge-regs.h                         | 9 ++-------
 arch/arm/mach-dove/cm-a510.c                             | 5 +----
 arch/arm/mach-dove/common.c                              | 5 +----
 arch/arm/mach-dove/common.h                              | 5 +----
 arch/arm/mach-dove/dove-db-setup.c                       | 5 +----
 arch/arm/mach-dove/dove.h                                | 9 ++-------
 arch/arm/mach-dove/irq.c                                 | 5 +----
 arch/arm/mach-dove/irqs.h                                | 9 ++-------
 arch/arm/mach-dove/mpp.c                                 | 5 +----
 arch/arm/mach-dove/pcie.c                                | 5 +----
 arch/arm/mach-dove/pm.h                                  | 6 +-----
 arch/arm/mach-lpc18xx/board-dt.c                         | 5 +----
 arch/arm/mach-lpc32xx/pm.c                               | 6 ++----
 arch/arm/mach-lpc32xx/suspend.S                          | 6 ++----
 arch/arm/mach-mv78xx0/bridge-regs.h                      | 6 +-----
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c                | 5 +----
 arch/arm/mach-mv78xx0/common.c                           | 5 +----
 arch/arm/mach-mv78xx0/common.h                           | 5 +----
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c                 | 5 +----
 arch/arm/mach-mv78xx0/irq.c                              | 5 +----
 arch/arm/mach-mv78xx0/irqs.h                             | 9 ++-------
 arch/arm/mach-mv78xx0/mpp.c                              | 5 +----
 arch/arm/mach-mv78xx0/mpp.h                              | 6 +-----
 arch/arm/mach-mv78xx0/mv78xx0.h                          | 5 +----
 arch/arm/mach-mv78xx0/pcie.c                             | 5 +----
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c               | 5 +----
 arch/arm/mach-mvebu/armada-370-xp.h                      | 5 +----
 arch/arm/mach-mvebu/board-v7.c                           | 5 +----
 arch/arm/mach-mvebu/coherency.c                          | 5 +----
 arch/arm/mach-mvebu/coherency.h                          | 6 +-----
 arch/arm/mach-mvebu/coherency_ll.S                       | 5 +----
 arch/arm/mach-mvebu/common.h                             | 5 +----
 arch/arm/mach-mvebu/cpu-reset.c                          | 5 +----
 arch/arm/mach-mvebu/dove.c                               | 5 +----
 arch/arm/mach-mvebu/headsmp-a9.S                         | 5 +----
 arch/arm/mach-mvebu/headsmp.S                            | 5 +----
 arch/arm/mach-mvebu/kirkwood.c                           | 5 +----
 arch/arm/mach-mvebu/kirkwood.h                           | 5 +----
 arch/arm/mach-mvebu/mvebu-soc-id.c                       | 5 +----
 arch/arm/mach-mvebu/mvebu-soc-id.h                       | 5 +----
 arch/arm/mach-mvebu/platsmp-a9.c                         | 5 +----
 arch/arm/mach-mvebu/platsmp.c                            | 5 +----
 arch/arm/mach-mvebu/pm-board.c                           | 5 +----
 arch/arm/mach-mvebu/pm.c                                 | 5 +----
 arch/arm/mach-mvebu/pmsu.c                               | 5 +----
 arch/arm/mach-mvebu/pmsu.h                               | 5 +----
 arch/arm/mach-mvebu/pmsu_ll.S                            | 5 +----
 arch/arm/mach-mvebu/system-controller.c                  | 5 +----
 arch/arm/mach-omap1/include/mach/mtd-xip.h               | 6 ++----
 arch/arm/mach-omap1/pm_bus.c                             | 6 +-----
 arch/arm/mach-omap2/prcm43xx.h                           | 5 +----
 arch/arm/mach-omap2/vc.c                                 | 6 +-----
 arch/arm/mach-orion5x/board-d2net.c                      | 5 +----
 arch/arm/mach-orion5x/board-dt.c                         | 5 +----
 arch/arm/mach-orion5x/board-rd88f5182.c                  | 5 +----
 arch/arm/mach-orion5x/bridge-regs.h                      | 9 ++-------
 arch/arm/mach-orion5x/common.c                           | 5 +----
 arch/arm/mach-orion5x/db88f5281-setup.c                  | 5 +----
 arch/arm/mach-orion5x/irq.c                              | 5 +----
 arch/arm/mach-orion5x/irqs.h                             | 5 +----
 arch/arm/mach-orion5x/kurobox_pro-setup.c                | 5 +----
 arch/arm/mach-orion5x/ls_hgl-setup.c                     | 5 +----
 arch/arm/mach-orion5x/mpp.c                              | 5 +----
 arch/arm/mach-orion5x/net2big-setup.c                    | 6 +-----
 arch/arm/mach-orion5x/orion5x.h                          | 5 +----
 arch/arm/mach-orion5x/pci.c                              | 5 +----
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c             | 5 +----
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c              | 5 +----
 arch/arm/mach-orion5x/rd88f5182-setup.c                  | 5 +----
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c             | 5 +----
 arch/arm/mach-orion5x/ts78xx-setup.c                     | 5 +----
 arch/arm/mach-orion5x/wnr854t-setup.c                    | 9 ++-------
 arch/arm/mach-orion5x/wrt350n-v2-setup.c                 | 9 ++-------
 arch/arm/mach-pxa/eseries.c                              | 7 +------
 arch/arm/mach-pxa/standby.S                              | 6 ++----
 arch/arm/mach-spear/generic.h                            | 5 +----
 arch/arm/mach-spear/include/mach/misc_regs.h             | 5 +----
 arch/arm/mach-spear/include/mach/spear.h                 | 5 +----
 arch/arm/mach-spear/pl080.c                              | 5 +----
 arch/arm/mach-spear/pl080.h                              | 5 +----
 arch/arm/mach-spear/restart.c                            | 5 +----
 arch/arm/mach-spear/spear1310.c                          | 5 +----
 arch/arm/mach-spear/spear1340.c                          | 5 +----
 arch/arm/mach-spear/spear13xx.c                          | 5 +----
 arch/arm/mach-spear/spear300.c                           | 5 +----
 arch/arm/mach-spear/spear310.c                           | 5 +----
 arch/arm/mach-spear/spear320.c                           | 5 +----
 arch/arm/mach-spear/spear3xx.c                           | 5 +----
 arch/arm/mach-spear/spear6xx.c                           | 5 +----
 arch/arm/mach-spear/time.c                               | 5 +----
 arch/arm/mm/cache-feroceon-l2.c                          | 5 +----
 arch/arm/mm/cache-tauros2.c                              | 5 +----
 149 files changed, 185 insertions(+), 656 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6ec85d58dd12..f53695ecbb782 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for AM33XX SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index de33c4f89f33d..cb316135bc7c9 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for am3517 SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap3.dtsi"
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 61a1d88f9df68..8613355bbd5ec 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for AM4372 SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/artpec6-devboard.dts b/arch/arm/boot/dts/artpec6-devboard.dts
index d20d95359b284..042a9cc920c67 100644
--- a/arch/arm/boot/dts/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/artpec6-devboard.dts
@@ -1,10 +1,5 @@
-/*
- * Axis ARTPEC-6 development board.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Axis ARTPEC-6 development board.
 
 /dts-v1/;
 #include "artpec6.dtsi"
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 7702e048e110f..379abf90c765d 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm814.h>
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index a9e7274806f46..ce62f1fa1faff 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm816.h>
diff --git a/arch/arm/boot/dts/dra62x.dtsi b/arch/arm/boot/dts/dra62x.dtsi
index cc4878aaa8ea8..cfefa670515cc 100644
--- a/arch/arm/boot/dts/dra62x.dtsi
+++ b/arch/arm/boot/dts/dra62x.dtsi
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include "dm814x.dtsi"
 
diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
index e75569383dd80..747ff0db90c7d 100644
--- a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
+++ b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for DRA7x SoC DSPEVE thermal
  *
  * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/dra7-iva-thermal.dtsi b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
index a7077321613f0..0a31313065df4 100644
--- a/arch/arm/boot/dts/dra7-iva-thermal.dtsi
+++ b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for DRA7x SoC IVA thermal
  *
  * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index ccc2487d47ca9..2fda68f9d3f64 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2013 Philipp Zabel
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013 Philipp Zabel
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 5750ca1233cc2..afabb36a8ac13 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP2 SoC
  *
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index bb529a2a295db..821da51cb8704 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP2420 SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap2.dtsi"
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 23115ba61bc06..b9a9e6e45266f 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP243x SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap2.dtsi"
diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
index 1ed8378593745..1ba79932a79fc 100644
--- a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP3 SoC CPU thermal
  *
  * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 64b7e6fddd1bc..825075ff0e342 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP3 SoC
  *
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 8b8451399784f..2eb73ae7ef3e7 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP34xx/OMAP35xx SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 22b33098b1a2d..32ac7924a1303 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP3 SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
index 03d054b2bf9af..4d7eeb133dadd 100644
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP4/5 SoC CPU thermal
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 8466161197aef..238aceb799f89 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP443x SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap4.dtsi"
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 3d6db1db94e04..1b27a862ae810 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP4460 SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 #include "omap4.dtsi"
 
diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dts/omap5-core-thermal.dtsi
index 02e76338bfbc0..e0d8e39a0014b 100644
--- a/arch/arm/boot/dts/omap5-core-thermal.dtsi
+++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP543x SoC CORE thermal
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
index bf8fa9372e575..1b4b7d9136c84 100644
--- a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP543x SoC GPU thermal
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
index 422958d13d42f..03471d30bfd95 100644
--- a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 0043e0040153c..f17e25ac98ddb 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 /*
  * TODO: add Orion USB device port init when kernel.org support is added.
diff --git a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
index 0ca6208a267de..d57859998350d 100644
--- a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
+++ b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Copyright (C) Sylver Bruneau <sylver.bruneau@googlemail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/orion5x-mv88f5181.dtsi b/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
index f667012b26ca1..819f9efb7058d 100644
--- a/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
+++ b/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
 
 #include "orion5x.dtsi"
 
diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
index d1ed71c602096..86b87fb26dc9a 100644
--- a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
+++ b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 #include "orion5x.dtsi"
 
diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
index ea081afa469d9..4f4888ec91380 100644
--- a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
+++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
index 487324f7c54e7..fd78aa02a3c5b 100644
--- a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
+++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 61e631b3fd8bb..2d41f5c166ee7 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
index 39769ffa00512..9694808ee97ce 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * AURORA shared L2 cache controller support
  *
@@ -5,10 +6,6 @@
  *
  * Yehuda Yitschak <yehuday@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARM_HARDWARE_AURORA_L2_H
diff --git a/arch/arm/include/asm/hardware/cache-feroceon-l2.h b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
index 12e1588dc4f13..eb2e7b7f70a87 100644
--- a/arch/arm/include/asm/hardware/cache-feroceon-l2.h
+++ b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/include/asm/hardware/cache-feroceon-l2.h
  *
  * Copyright (C) 2008 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 extern void __init feroceon_l2_init(int l2_wt_override);
 extern int __init feroceon_of_init(void);
-
diff --git a/arch/arm/include/asm/hardware/cache-tauros2.h b/arch/arm/include/asm/hardware/cache-tauros2.h
index 295e2e40151b1..4e493facaa317 100644
--- a/arch/arm/include/asm/hardware/cache-tauros2.h
+++ b/arch/arm/include/asm/hardware/cache-tauros2.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/include/asm/hardware/cache-tauros2.h
  *
  * Copyright (C) 2008 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define CACHE_TAUROS2_PREFETCH_ON	(1 << 0)
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 823c9cc98f18b..d820161445fa9 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA830/OMAP L137 EVM board
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  * Derived from: arch/arm/mach-davinci/board-dm644x-evm.c
  *
- * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007, 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 7f7f6bae21c2d..1601a74261a67 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA850/OMAP-L138 EVM board
  *
@@ -6,10 +7,7 @@
  * Derived from: arch/arm/mach-davinci/board-da830-evm.c
  * Original Copyrights follow:
  *
- * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007, 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/console.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 3c5a9e3c128ab..debc912b133fa 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci EVM board support
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index e475b2113e70f..7c8307d590a40 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * DM355 leopard board support
  *
  * Based on board-dm355-evm.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index cce3a621eb20b..92a92c4cef722 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci EVM board support
  *
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ee91d81ebbfdf..c62815535b863 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM646X EVM board
  *
@@ -5,11 +6,6 @@
  * Copyright (C) 2006 Texas Instruments.
  *
  * (C) 2007-2008, MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
  */
 
 /**************************************************************************
@@ -873,4 +869,3 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 MACHINE_END
-
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2127969beb965..a36365edfe20f 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Critical Link MityOMAP-L138 SoM
  *
  * Copyright (C) 2010 Critical Link LLC - https://www.criticallink.com
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of
- * any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "MityOMAPL138: " fmt
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index b4843f68bb575..ae0bce8655b44 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Neuros Technologies OSD2 board support
  *
@@ -18,10 +19,6 @@
  *
  * For more information please refer to
  * 		http://wiki.neurostechnology.com/index.php/OSD_2.0_HD
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 88df8011a4e6b..f3e85d16f56a8 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Hawkboard.org based on TI's OMAP-L138 Platform
  *
  * Initial code: Syed Mohammed Khasim
  *
  * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of
- * any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index ae61d19f9b3af..5c2760723fcfb 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Code commons to all DaVinci SoCs.
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-davinci/cpuidle.h b/arch/arm/mach-davinci/cpuidle.h
index 0d9193aefab51..976d43073597e 100644
--- a/arch/arm/mach-davinci/cpuidle.h
+++ b/arch/arm/mach-davinci/cpuidle.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * TI DaVinci cpuidle platform support
  *
  * 2009 (C) Texas Instruments, Inc. https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 #ifndef _MACH_DAVINCI_CPUIDLE_H
 #define _MACH_DAVINCI_CPUIDLE_H
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 018ab4b549f1d..cd07415dc5350 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA830/OMAP L137 chip specific setup
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/clk-provider.h>
 #include <linux/clk/davinci.h>
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 68156e7239a68..aedf020b62ed1 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA850/OMAP-L138 chip specific setup
  *
@@ -6,10 +7,7 @@
  * Derived from: arch/arm/mach-davinci/da830.c
  * Original Copyrights follow:
  *
- * 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) MontaVista Software, Inc.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5de72d2fa8f09..a49151bf37c46 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM355 chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 24988939ae462..f9b82a6a16300 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM644x chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 4ffd028ed9978..d85d8e9e13715 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM646x chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 139b83de011d3..772b51e0ac5eb 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Header for code common to all DaVinci machines.
  *
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 
 #ifndef __ARCH_ARM_MACH_DAVINCI_COMMON_H
diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
index 1fc84e21664d2..81de85757a938 100644
--- a/arch/arm/mach-davinci/include/mach/cputype.h
+++ b/arch/arm/mach-davinci/include/mach/cputype.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * DaVinci CPU type detection
  *
@@ -8,10 +9,7 @@
  * compiled in to the kernel, the macros return 0 so that
  * resulting code can be optimized out.
  *
- * 2009 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) Deep Root Systems, LLC.
  */
 #ifndef _ASM_ARCH_CPU_H
 #define _ASM_ARCH_CPU_H
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 1618b30661a9b..f138f6d33d4aa 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Chip specific defines for DA8XX/OMAP L1XX SoC
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2007, 2009-2010 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007, 2009-2010 (c) MontaVista Software, Inc.
  */
 #ifndef __ASM_ARCH_DAVINCI_DA8XX_H
 #define __ASM_ARCH_DAVINCI_DA8XX_H
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 16bb42291d39d..7848b6a240b48 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Hardware definitions common to all DaVinci family processors
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index d4b4aa87964f0..85fda53ffd205 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * DaVinci serial device definitions
  *
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 #ifndef __ASM_ARCH_SERIAL_H
 #define __ASM_ARCH_SERIAL_H
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index 6a2ff0a654a5b..0d8ac2f936617 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Utility to set the DAVINCI MUX register from a table in mux.h
  *
@@ -8,10 +9,7 @@
  *
  * Written by Tony Lindgren
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  *
  * Copyright (C) 2008 Texas Instruments.
  */
diff --git a/arch/arm/mach-davinci/mux.h b/arch/arm/mach-davinci/mux.h
index 5aad1e7dd2103..558b9c1b32c06 100644
--- a/arch/arm/mach-davinci/mux.h
+++ b/arch/arm/mach-davinci/mux.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Pin-multiplex helper macros for TI DaVinci family devices
  *
  * Author: Vladimir Barinov, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  *
  * Copyright (C) 2008 Texas Instruments.
  */
diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index e251fd593bfd1..6b21d5bd999c6 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Runtime PM support code for DaVinci
  *
  * Author: Kevin Hilman
  *
  * Copyright (C) 2012 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/init.h>
 #include <linux/pm_runtime.h>
diff --git a/arch/arm/mach-dove/bridge-regs.h b/arch/arm/mach-dove/bridge-regs.h
index ace0b0bfbf114..6fbc152d0950d 100644
--- a/arch/arm/mach-dove/bridge-regs.h
+++ b/arch/arm/mach-dove/bridge-regs.h
@@ -1,10 +1,5 @@
-/*
- * Mbus-L to Mbus Bridge Registers
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Mbus-L to Mbus Bridge Registers */
 
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index 9f25c993d8637..beb532537c225 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/cm-a510.c
  *
@@ -5,10 +6,6 @@
  * Konstantin Sinyuk <kostyas@compulab.co.il>
  *
  * Based on Marvell DB-MV88AP510-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index dbe970e378953..cd4ae7e4768dd 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/common.c
  *
  * Core functions for Marvell Dove 88AP510 System On Chip
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 1d725224d1461..57ebc413d68c2 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-dove/common.h
  *
  * Core functions for Marvell Dove 88AP510 System On Chip
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ARCH_DOVE_COMMON_H
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index 418ab21b9d9b2..d5bf540405772 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/dove-db-setup.c
  *
  * Marvell DB-MV88AP510-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/dove.h b/arch/arm/mach-dove/dove.h
index 320ed1696abdc..e5054e3b0b782 100644
--- a/arch/arm/mach-dove/dove.h
+++ b/arch/arm/mach-dove/dove.h
@@ -1,10 +1,5 @@
-/*
- * Generic definitions for Marvell Dove 88AP510 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Generic definitions for Marvell Dove 88AP510 SoC */
 
 #ifndef __ASM_ARCH_DOVE_H
 #define __ASM_ARCH_DOVE_H
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 31ccbcee26274..0c851a11183d2 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/irq.c
  *
  * Dove IRQ handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/arm/mach-dove/irqs.h b/arch/arm/mach-dove/irqs.h
index a0742179faffe..5467098c70428 100644
--- a/arch/arm/mach-dove/irqs.h
+++ b/arch/arm/mach-dove/irqs.h
@@ -1,10 +1,5 @@
-/*
- * IRQ definitions for Marvell Dove 88AP510 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* IRQ definitions for Marvell Dove 88AP510 SoC */
 
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index 6acd8488bb05f..93cb137da5f86 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/mpp.c
  *
  * MPP functions for Marvell Dove SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index ee91ac6b5ebf1..cff5c77aa7a6c 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/pcie.c
  *
  * PCIe functions for Marvell Dove 88AP510 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/pm.h b/arch/arm/mach-dove/pm.h
index 01267746d7072..a4c3aba1e2d0d 100644
--- a/arch/arm/mach-dove/pm.h
+++ b/arch/arm/mach-dove/pm.h
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
 
 #ifndef __ASM_ARCH_PM_H
 #define __ASM_ARCH_PM_H
diff --git a/arch/arm/mach-lpc18xx/board-dt.c b/arch/arm/mach-lpc18xx/board-dt.c
index fdcee78d1bc4c..4729eb83401ae 100644
--- a/arch/arm/mach-lpc18xx/board-dt.c
+++ b/arch/arm/mach-lpc18xx/board-dt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree board file for NXP LPC18xx/43xx
  *
  * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index b27fa1b9f56c1..2572bd89a5e8d 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-lpc32xx/pm.c
  *
  * Original authors: Vitaly Wool, Dmitry Chigirev <source@mvista.com>
  * Modified by Kevin Wells <kevin.wells@nxp.com>
  *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista Software, Inc.
  */
 
 /*
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index 3f0a8282ef6fd..a95c5e0e40384 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -1,13 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-lpc32xx/suspend.S
  *
  * Original authors: Dmitry Chigirev, Vitaly Wool <source@mvista.com>
  * Modified by Kevin Wells <kevin.wells@nxp.com>
  *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista Software, Inc.
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-mv78xx0/bridge-regs.h b/arch/arm/mach-mv78xx0/bridge-regs.h
index 2f54e1753d45e..d57ac967c4b39 100644
--- a/arch/arm/mach-mv78xx0/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/bridge-regs.h
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
 
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index e112f2e7cc9a9..9aa765d4cdc8a 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
  *
  * Buffalo WXL (Terastation Duo) Setup routines
  *
  * sebastien requiem <sebastien@requiem.fr>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index dd762d1b083fd..461a68945c26e 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/common.c
  *
  * Core functions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/common.h
index 6889af26077da..d8c6c2400e278 100644
--- a/arch/arm/mach-mv78xx0/common.h
+++ b/arch/arm/mach-mv78xx0/common.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-mv78xx0/common.h
  *
  * Core functions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ARCH_MV78XX0_COMMON_H
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index cf16e08d4cf5b..da633a33a0c12 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/db78x00-bp-setup.c
  *
  * Marvell DB-78x00-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 788569e960e15..da7a219e2ef55 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/irq.c
  *
  * MV78xx0 IRQ handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/irqs.h b/arch/arm/mach-mv78xx0/irqs.h
index 67e0fe730a13f..12b357d383d88 100644
--- a/arch/arm/mach-mv78xx0/irqs.h
+++ b/arch/arm/mach-mv78xx0/irqs.h
@@ -1,10 +1,5 @@
-/*
- * IRQ definitions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* IRQ definitions for Marvell MV78xx0 SoCs */
 
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 72843c02e95ac..aff0e612cbba5 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78x00/mpp.c
  *
  * MPP functions for Marvell MV78x00 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/mpp.h b/arch/arm/mach-mv78xx0/mpp.h
index 3752302ae2ee3..47db52f45546e 100644
--- a/arch/arm/mach-mv78xx0/mpp.h
+++ b/arch/arm/mach-mv78xx0/mpp.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * linux/arch/arm/mach-mv78xx0/mpp.h -- Multi Purpose Pins
  *
- *
  * sebastien requiem <sebastien@requiem.fr>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MV78X00_MPP_H
diff --git a/arch/arm/mach-mv78xx0/mv78xx0.h b/arch/arm/mach-mv78xx0/mv78xx0.h
index c1a9a1d1b2957..3f19bef7d7ace 100644
--- a/arch/arm/mach-mv78xx0/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/mv78xx0.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Generic definitions for Marvell MV78xx0 SoC flavors:
  *  MV781x0 and MV782x0.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARCH_MV78XX0_H
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 636d84b404664..c07f1641179bd 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/pcie.c
  *
  * PCIe functions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index 308ab71ec8221..80ca8b1a81de2 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78x00/rd78x00-masa-setup.c
  *
  * Marvell RD-78x00-mASA Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 09413b6784099..c96ecdafe31f1 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Generic definitions for Marvell Armada_370_XP SoCs
  *
@@ -6,10 +7,6 @@
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_ARMADA_370_XP_H
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index d2df5ef9382b4..fd5d0c8ff6958 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree support for Armada 370 and XP platforms.
  *
@@ -6,10 +7,6 @@
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 49e3c8d20c2fa..883dab1b54f3d 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Coherency fabric (Aurora) support for Armada 370, 375, 38x and XP
  * platforms.
@@ -8,10 +9,6 @@
  * Gregory Clement <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada 370, 375, 38x and XP SOCs have a coherency fabric which is
  * responsible for ensuring hardware coherency between all CPUs and between
  * CPUs and I/O masters. This file initializes the coherency fabric and
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index 6067f14263f79..cae866ab48673 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -1,14 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-mvebu/include/mach/coherency.h
  *
- *
  * Coherency fabric (Aurora) support for Armada 370 and XP platforms.
  *
  * Copyright (C) 2012 Marvell
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_370_XP_COHERENCY_H
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index a3a64bf972507..eb81656e32d47 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Coherency fabric: low level functions
  *
@@ -5,10 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file implements the assembly function to add a CPU to the
  * coherency fabric. This function is called by each of the secondary
  * CPUs during their early boot in an SMP kernel, this why this
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 6b775492cfadc..fbfa3c4f30df7 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Core functions for Marvell System On Chip
  *
@@ -6,10 +7,6 @@
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ARCH_MVEBU_COMMON_H
diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index f33a31c6aff8b..66b6c0c6ce1de 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2014 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "mvebu-cpureset: " fmt
diff --git a/arch/arm/mach-mvebu/dove.c b/arch/arm/mach-mvebu/dove.c
index d076c5771adc2..c938ba725d3e9 100644
--- a/arch/arm/mach-mvebu/dove.c
+++ b/arch/arm/mach-mvebu/dove.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mvebu/dove.c
  *
  * Marvell Dove 88AP510 System On Chip FDT Board
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index b093a196e8017..df723cf85caec 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * SMP support: Entry point for secondary CPUs of Marvell EBU
  * Cortex-A9 based SOCs (Armada 375 and Armada 38x).
@@ -6,10 +7,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index 2c4032e368bad..f05c59dad32ac 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * SMP support: Entry point for secondary CPUs
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file implements the assembly entry point for secondary CPUs in
  * an SMP kernel. The only thing we need to do is to add the CPU to
  * the coherency fabric by writing to 2 registers. Currently the base
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 06b1706595f4c..8ff34753e7609 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
  *
  * arch/arm/mach-mvebu/kirkwood.c
  *
  * Flattened Device Tree board initialization
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/arch/arm/mach-mvebu/kirkwood.h b/arch/arm/mach-mvebu/kirkwood.h
index 89f3d1f516435..15135994ce2f2 100644
--- a/arch/arm/mach-mvebu/kirkwood.h
+++ b/arch/arm/mach-mvebu/kirkwood.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-mvebu/kirkwood.h
  *
  * Generic definitions for Marvell Kirkwood SoC flavors:
  * 88F6180, 88F6192 and 88F6281.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define KIRKWOOD_REGS_PHYS_BASE	0xf1000000
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index a99434bcee849..f436c7b8c7aee 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * ID and revision information for mvebu SoCs
  *
@@ -5,10 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * All the mvebu SoCs have information related to their variant and
  * revision that can be read from the PCI control register. This is
  * done before the PCI initialization to avoid any conflict. Once the
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.h b/arch/arm/mach-mvebu/mvebu-soc-id.h
index e124a0b82a3e7..225649b2288a2 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.h
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Marvell EBU SoC ID and revision definitions.
  *
  * Copyright (C) 2014 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __LINUX_MVEBU_SOC_ID_H
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index d715dec1c197d..785ee2af5baab 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Symmetric Multi Processing (SMP) support for Marvell EBU Cortex-A9
  * based SOCs (Armada 375/38x).
@@ -6,10 +7,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index c130497dc6cc4..18384ea6862cf 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Symmetric Multi Processing (SMP) support for Armada XP
  *
@@ -8,10 +9,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada XP SoC has 4 ARMv7 PJ4B CPUs running in full HW coherency
  * This file implements the routines for preparing the SMP infrastructure
  * and waking up the secondary CPUs
diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 0705525116996..7fa1806acd659 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Board-level suspend/resume support.
  *
  * Copyright (C) 2014-2015 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/delay.h>
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index c487be61d6d8c..b149d9b775050 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Suspend/resume support. Currently supporting Armada XP only.
  *
  * Copyright (C) 2014 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/cpu_pm.h>
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 73d5d72dfc3e5..af27a7156675a 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Power Management Service Unit(PMSU) support for Armada 370/XP platforms.
  *
@@ -7,10 +8,6 @@
  * Gregory Clement <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada 370 and Armada XP SOCs have a power management service
  * unit which is responsible for powering down and waking up CPUs and
  * other SOC units
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index ea79269c27023..1e847388e8dde 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Power Management Service Unit (PMSU) support for Armada 370/XP platforms.
  *
  * Copyright (C) 2012 Marvell
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_MVEBU_PMSU_H
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index 7aae9a25cfeb7..f7d21385fd88c 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2014 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Gregory Clement <gregory.clement@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 04d9ebe6a90a0..48224b6ed6dc7 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * System controller support for Armada 370, 375 and XP platforms.
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada 370, 375 and Armada XP SoCs have a range of
  * miscellaneous registers, that do not belong to a particular device,
  * but rather provide system-level features. This basic
diff --git a/arch/arm/mach-omap1/include/mach/mtd-xip.h b/arch/arm/mach-omap1/include/mach/mtd-xip.h
index d09b2bc4920fe..b163b8a65605b 100644
--- a/arch/arm/mach-omap1/include/mach/mtd-xip.h
+++ b/arch/arm/mach-omap1/include/mach/mtd-xip.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * MTD primitives for XIP support. Architecture specific functions.
  *
@@ -5,10 +6,7 @@
  *
  * Author: Vladimir Barinov <vbarinov@embeddedalley.com>
  *
- * (c) 2005 MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is
- * licensed "as is" without any warranty of any kind, whether express or
- * implied.
+ * (c) 2005 MontaVista Software, Inc.
  */
 
 #ifndef __ARCH_OMAP_MTD_XIP_H__
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 667c1637ff919..c04619ac06312 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Runtime PM support code for OMAP1
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -43,4 +40,3 @@ static int __init omap1_pm_runtime_init(void)
 	return 0;
 }
 core_initcall(omap1_pm_runtime_init);
-
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 899da0ae98000..31860ffd28abc 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * AM43x PRCM defines
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef __ARCH_ARM_MACH_OMAP2_PRCM_43XX_H
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 86f1ac4c24125..ea02d40405c4a 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * OMAP Voltage Controller (VC) interface
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -895,4 +892,3 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	else if (cpu_is_omap44xx())
 		omap4_vc_init_channel(voltdm);
 }
-
diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
index a89376a5cd929..0297e302d7bc8 100644
--- a/arch/arm/mach-orion5x/board-d2net.c
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/board-d2net.c
  *
  * LaCie d2Network and Big Disk Network NAS setup
  *
  * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 3f651df3a71cf..be47492c6640d 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2012 (C), Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
  * arch/arm/mach-orion5x/board-dt.c
  *
  * Flattened Device Tree board initialization
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
index b7b0f52f4c0a0..596601367989a 100644
--- a/arch/arm/mach-orion5x/board-rd88f5182.c
+++ b/arch/arm/mach-orion5x/board-rd88f5182.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5182-setup.c
  *
  * Marvell Orion-NAS Reference Design Setup
  *
  * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/bridge-regs.h b/arch/arm/mach-orion5x/bridge-regs.h
index 305598eaaee15..fe85bc5b131fc 100644
--- a/arch/arm/mach-orion5x/bridge-regs.h
+++ b/arch/arm/mach-orion5x/bridge-regs.h
@@ -1,10 +1,5 @@
-/*
- * Orion CPU Bridge Registers
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Orion CPU Bridge Registers */
 
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 7bcb41137bbf6..2e711b7252c64 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/common.c
  *
  * Core functions for Marvell Orion 5x SoCs
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 39eae10ac8def..fe1a4cef1ba2d 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/db88f5281-setup.c
  *
  * Marvell Orion-2 Development Board Setup
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index ac4af2283bef9..5b076eefe2b4a 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/irq.c
  *
  * Core IRQ functions for Marvell Orion System On Chip
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/irqs.h b/arch/arm/mach-orion5x/irqs.h
index 506c8e0b30c42..a70c47cfa6bcb 100644
--- a/arch/arm/mach-orion5x/irqs.h
+++ b/arch/arm/mach-orion5x/irqs.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * IRQ definitions for Orion SoC
  *
  *  Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- *  This file is licensed under the terms of the GNU General Public
- *  License version 2. This program is licensed "as is" without any
- *  warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 83d43cff4bd77..acba066180801 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/kurobox_pro-setup.c
  *
  * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 47ba6e0502f59..af07f617465f7 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/ls_hgl-setup.c
  *
  * Maintainer: Zhu Qingsen <zhuqs@cn.fujitsu.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index 19ef185944158..b9855dce6ba0a 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/mpp.c
  *
  * MPP functions for Marvell Orion 5x SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index bf6be4cfd2384..695cc683cd833 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/net2big-setup.c
  *
  * LaCie 2Big Network NAS setup
  *
  * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
@@ -432,4 +429,3 @@ MACHINE_START(NET2BIG, "LaCie 2Big Network")
 	.fixup		= tag_fixup_mem32,
 	.restart	= orion5x_restart,
 MACHINE_END
-
diff --git a/arch/arm/mach-orion5x/orion5x.h b/arch/arm/mach-orion5x/orion5x.h
index 2b66120fba86c..26f1ccb8cb281 100644
--- a/arch/arm/mach-orion5x/orion5x.h
+++ b/arch/arm/mach-orion5x/orion5x.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Generic definitions of Orion SoC flavors:
  *  Orion-1, Orion-VoIP, Orion-NAS, Orion-2, and Orion-1-90.
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARCH_ORION5X_H
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf57..fa62add8cf8a6 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/pci.c
  *
  * PCI and PCIe functions for Marvell Orion System On Chip
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index c65ab7db36ad9..432fc8357d9e1 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
  *
  * Marvell Orion-VoIP FXO Reference Design Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 76b8138d9d79b..d4b1a9c3cd362 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
  *
  * Marvell Orion-VoIP GE Reference Design Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index fe3e67c81fb82..6ffcfc6445e24 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5182-setup.c
  *
  * Marvell Orion-NAS Reference Design Setup
  *
  * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 5f388a1ed1e4c..93f74fd6b4dac 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f6183-ap-ge-setup.c
  *
  * Marvell Orion-1-90 AP GE Reference Design Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index a39764faf2a01..af810e7ccd796 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/ts78xx-setup.c
  *
  * Maintainer: Alexander Clouter <alex@digriz.org.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 83589a28a4911..e5f327054dd33 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -1,10 +1,5 @@
-/*
- * arch/arm/mach-orion5x/wnr854t-setup.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// arch/arm/mach-orion5x/wnr854t-setup.c
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index cea08d4a25974..e6a2da6662df5 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -1,10 +1,5 @@
-/*
- * arch/arm/mach-orion5x/wrt350n-v2-setup.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// arch/arm/mach-orion5x/wrt350n-v2-setup.c
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index f37c44b6139d7..b9e235cb5a073 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -1,13 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Hardware definitions for the Toshiba eseries PDAs
  *
  * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
  */
 
 #include <linux/clkdev.h>
diff --git a/arch/arm/mach-pxa/standby.S b/arch/arm/mach-pxa/standby.S
index eab1645bb4adb..60d0d14d4a0fe 100644
--- a/arch/arm/mach-pxa/standby.S
+++ b/arch/arm/mach-pxa/standby.S
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * PXA27x standby mode
  *
  * Author: David Burrage
  *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista Software, Inc.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 8ec2b92dca192..43b7996ab7545 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * spear machine family generic header file
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Rajeev Kumar <rajeev-dlh.kumar@st.com>
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_GENERIC_H
diff --git a/arch/arm/mach-spear/include/mach/misc_regs.h b/arch/arm/mach-spear/include/mach/misc_regs.h
index cfaf7c665b588..12a789bd896e0 100644
--- a/arch/arm/mach-spear/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear/include/mach/misc_regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-spear3xx/include/mach/misc_regs.h
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_MISC_REGS_H
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 5ed841ccf8a38..432efd407c763 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * SPEAr3xx/6xx Machine family specific definition
  *
  * Copyright (C) 2009,2012 ST Microelectronics
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_SPEAR_H
diff --git a/arch/arm/mach-spear/pl080.c b/arch/arm/mach-spear/pl080.c
index b4529f3e0ee97..35c929de46755 100644
--- a/arch/arm/mach-spear/pl080.c
+++ b/arch/arm/mach-spear/pl080.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/plat-spear/pl080.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/amba/pl08x.h>
diff --git a/arch/arm/mach-spear/pl080.h b/arch/arm/mach-spear/pl080.h
index 608dec6725aea..3732d940dbfb6 100644
--- a/arch/arm/mach-spear/pl080.h
+++ b/arch/arm/mach-spear/pl080.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/plat-spear/include/plat/pl080.h
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __PLAT_PL080_H
diff --git a/arch/arm/mach-spear/restart.c b/arch/arm/mach-spear/restart.c
index b4342155a7833..01f529675629f 100644
--- a/arch/arm/mach-spear/restart.c
+++ b/arch/arm/mach-spear/restart.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/plat-spear/restart.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/io.h>
 #include <linux/amba/sp810.h>
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index a7d4f136836fa..020b27e65aea0 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear13xx/spear1310.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr1310: " fmt
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index a212af90c0bc6..a391f154eff9b 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear13xx/spear1340.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr1340: " fmt
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 74d1ca2a529a7..64087046dfff7 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear13xx/spear13xx.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr13xx: " fmt
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 325b89579be10..490df8aaad90c 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear300.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr300: " fmt
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index 59e173dc85cf3..5ca325fc1b825 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear310.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr310: " fmt
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index 926d5a243238a..991de88dfe4d3 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear320.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr320: " fmt
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index f83321d5e3538..cdaa41900a399 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear3xx.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr3xx: " fmt
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index c5fc110134ba6..11eb64a369807 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear6xx/spear6xx.c
  *
@@ -7,10 +8,6 @@
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  *
  * Copyright 2012 Stefan Roese <sr@denx.de>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/amba/pl08x.h>
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d1fdb6066f7bb..6baf952fa902f 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/plat-spear/time.c
  *
  * Copyright (C) 2010 ST Microelectronics
  * Shiraz Hashim<shiraz.linux.kernel@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af63..25dbd84a1aafa 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mm/cache-feroceon-l2.c - Feroceon L2 cache controller support
  *
  * Copyright (C) 2008 Marvell Semiconductor
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * References:
  * - Unified Layer 2 Cache for Feroceon CPU Cores,
  *   Document ID MV-S104858-00, Rev. A, October 23 2007.
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 88255bea65e41..b1e1aba602f7f 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mm/cache-tauros2.c - Tauros2 L2 cache controller support
  *
  * Copyright (C) 2008 Marvell Semiconductor
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * References:
  * - PJ1 CPU Core Datasheet,
  *   Document ID MV-S104837-01, Rev 0.7, January 24 2008.
-- 
2.40.1



