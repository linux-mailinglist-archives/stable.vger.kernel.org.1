Return-Path: <stable+bounces-187148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968FBEA01A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CCA1AA072B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC622F12D9;
	Fri, 17 Oct 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m033ebqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75232C93E;
	Fri, 17 Oct 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715250; cv=none; b=jv78z7frWWGZNPKevDMigvcAJEqjTTtDo38UIGF2mYUqXgj4vPQ08FZ7AVcjqWFjkHYxkaYihrGhpHEFCGzI1ouHVfOWT24IGczYi4Eedj9/IS5pSrwcKn3vdWkcYF45PS4O53OvfmsH/ZPQrRnIucx2KpNc2AGclB7Bbaw7EVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715250; c=relaxed/simple;
	bh=HqKEhJ15PAJh8zwjSNXOfvgwYNMpXq0FD9IHDQAv1v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP8bCLGypW0xM0+MBMKgsqrLjPvuiErRFQFWTXXWtmDm+RpEhfvzbjwCmnlsny6GHKHJzxvicrN5rIzJdboHuWPbwF+D/dBvDCOUo3TyccSSpgT/IGSjjjmh0Tx7ImU+pad79bD0p7uXDzogyWpISezP9bQuxvyEaM2dHaO/1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m033ebqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA139C4CEE7;
	Fri, 17 Oct 2025 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715250;
	bh=HqKEhJ15PAJh8zwjSNXOfvgwYNMpXq0FD9IHDQAv1v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m033ebqiaU44g8XMhJXFzDp56PLnDCcA2FfjtG7Av+io/UWRU3YXvElTAg/DHHMJ7
	 nnuO9AmyGxenT3mejlUnlxkxNSKfPijRBgXB8F/VcH18K1ZFzMXoei2GBANd6ul5/c
	 xJJbMsVz+yIL/ifAWzPnvwSMezF4UcHA/tecu2Mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 6.17 150/371] ARM: AM33xx: Implement TI advisory 1.0.36 (EMU0/EMU1 pins state on reset)
Date: Fri, 17 Oct 2025 16:52:05 +0200
Message-ID: <20251017145207.361300259@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit 8a6506e1ba0d2b831729808d958aae77604f12f9 upstream.

There is an issue possible where TI AM33xx SoCs do not boot properly after
a reset if EMU0/EMU1 pins were used as GPIO and have been driving low level
actively prior to reset [1].

"Advisory 1.0.36 EMU0 and EMU1: Terminals Must be Pulled High Before
ICEPick Samples

The state of the EMU[1:0] terminals are latched during reset to determine
ICEPick boot mode. For normal device operation, these terminals must be
pulled up to a valid high logic level ( > VIH min) before ICEPick samples
the state of these terminals, which occurs
[five CLK_M_OSC clock cycles - 10 ns] after the falling edge of WARMRSTn.

Many applications may not require the secondary GPIO function of the
EMU[1:0] terminals. In this case, they would only be connected to pull-up
resistors, which ensures they are always high when ICEPick samples.
However, some applications may need to use these terminals as GPIO where
they could be driven low before reset is asserted. This usage of the
EMU[1:0] terminals may require special attention to ensure the terminals
are allowed to return to a valid high-logic level before ICEPick samples
the state of these terminals.

When any device reset is asserted, the pin mux mode of EMU[1:0] terminals
configured to operate as GPIO (mode 7) will change back to EMU input
(mode 0) on the falling edge of WARMRSTn. This only provides a short period
of time for the terminals to return high if driven low before reset is
asserted...

If the EMU[1:0] terminals are configured to operate as GPIO, the product
should be designed such these terminals can be pulled to a valid high-logic
level within 190 ns after the falling edge of WARMRSTn."

We've noticed this problem with custom am335x hardware in combination with
recently implemented cold reset method
(commit 6521f6a195c70 ("ARM: AM33xx: PRM: Implement REBOOT_COLD")).
It looks like the problem can affect other HW, for instance AM335x
Chiliboard, because the latter has LEDs on GPIO3_7/GPIO3_8 as well.

One option would be to check if the pins are in GPIO mode and either switch
to output active high, or switch to input and poll until the external
pull-ups have brought the pins to the desired high state. But fighting
with GPIO driver for these pins is probably not the most straight forward
approch in a reboot handler.

Fortunately we can easily control pinmuxing here and rely on the external
pull-ups. TI recommends 4k7 external pull up resistors [2] and even with
quite conservative estimation for pin capacity (1 uF should never happen)
the required delay shall not exceed 5ms.

[1] Link: https://www.ti.com/lit/pdf/sprz360
[2] Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/866346/am3352-emu-1-0-questions

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://lore.kernel.org/r/20250717152708.487891-1-alexander.sverdlin@siemens.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/am33xx-restart.c |   36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -2,12 +2,46 @@
 /*
  * am33xx-restart.c - Code common to all AM33xx machines.
  */
+#include <dt-bindings/pinctrl/am33xx.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 
 #include "common.h"
+#include "control.h"
 #include "prm.h"
 
+/*
+ * Advisory 1.0.36 EMU0 and EMU1: Terminals Must be Pulled High Before
+ * ICEPick Samples
+ *
+ * If EMU0/EMU1 pins have been used as GPIO outputs and actively driving low
+ * level, the device might not reboot in normal mode. We are in a bad position
+ * to override GPIO state here, so just switch the pins into EMU input mode
+ * (that's what reset will do anyway) and wait a bit, because the state will be
+ * latched 190 ns after reset.
+ */
+static void am33xx_advisory_1_0_36(void)
+{
+	u32 emu0 = omap_ctrl_readl(AM335X_PIN_EMU0);
+	u32 emu1 = omap_ctrl_readl(AM335X_PIN_EMU1);
+
+	/* If both pins are in EMU mode, nothing to do */
+	if (!(emu0 & 7) && !(emu1 & 7))
+		return;
+
+	/* Switch GPIO3_7/GPIO3_8 into EMU0/EMU1 modes respectively */
+	omap_ctrl_writel(emu0 & ~7, AM335X_PIN_EMU0);
+	omap_ctrl_writel(emu1 & ~7, AM335X_PIN_EMU1);
+
+	/*
+	 * Give pull-ups time to load the pin/PCB trace capacity.
+	 * 5 ms shall be enough to load 1 uF (would be huge capacity for these
+	 * pins) with TI-recommended 4k7 external pull-ups.
+	 */
+	mdelay(5);
+}
+
 /**
  * am33xx_restart - trigger a software restart of the SoC
  * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
@@ -18,6 +52,8 @@
  */
 void am33xx_restart(enum reboot_mode mode, const char *cmd)
 {
+	am33xx_advisory_1_0_36();
+
 	/* TODO: Handle cmd if necessary */
 	prm_reboot_mode = mode;
 



