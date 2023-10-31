Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A027DD50C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376335AbjJaRqq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376365AbjJaRqp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0BF7
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7001BC433C9;
        Tue, 31 Oct 2023 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774400;
        bh=eSMDeVPrcbTxVfoXUIflVta2QCMbykh58nsYDTnep8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJcTbbL/VAuESHRsVypeV4wtR3Vqx1PNsl0SmN8UBn9t/O6B/GNFhLrsn+8d5C5Va
         vYOU39BqPeJVBXkEe6GtGqRHSoeyI8KJ85sd05WbdtnCxWNto68weYzB8IeBxZO6FJ
         jrv5qPGjqlL/XEX7KuiPZfAbvl0Jo8Qw+UZN8vhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6.5 034/112] ARM: OMAP1: ams-delta: Fix MODEM initialization failure
Date:   Tue, 31 Oct 2023 18:00:35 +0100
Message-ID: <20231031165902.397914535@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

commit 5447da5d610b5701c1103cd4665b49da87fdf032 upstream.

Regulator drivers were modified to use asynchronous device probe.  Since
then, the board .init_late hook fails to acquire a GPIO based fixed
regulator needed by an on-board voice MODEM device, and unregisters the
MODEM.  That in turn triggers a so far not discovered bug of device
unregister function called for a device with no associated release() op.

serial8250 serial8250.1: incomplete constraints, dummy supplies not allowed
WARNING: CPU: 0 PID: 1 at drivers/base/core.c:2486 device_release+0x98/0xa8
Device 'serial8250.1' does not have a release() function, it is broken and
 must be fixed. See Documentation/core-api/kobject.rst.
...
put_device from platform_device_put+0x1c/0x24
platform_device_put from ams_delta_init_late+0x4c/0x68
ams_delta_init_late from init_machine_late+0x1c/0x94
init_machine_late from do_one_initcall+0x60/0x1d4

As a consequence, ASoC CODEC driver is no longer able to control its
device over the voice MODEM's tty interface.

cx20442-codec: ASoC: error at soc_component_write_no_lock
 on cx20442-codec for register: [0x00000000] -5
cx20442-codec: ASoC: error at snd_soc_component_update_bits_legacy
 on cx20442-codec for register: [0x00000000] -5
cx20442-codec: ASoC: error at snd_soc_component_update_bits
 on cx20442-codec for register: [0x00000000] -5

The regulator hangs of a GPIO pin controlled by basic-mmio-gpio driver.
Unlike most GPIO drivers, that driver doesn't probe for devices before
device_initcall, then GPIO pins under its control are not availabele to
majority of devices probed at that phase, including regulators.  On the
other hand, serial8250 driver used by the MODEM device neither accepts via
platform data nor handles regulators, then the board file is not able to
teach that driver to return -EPROBE_DEFER when the regulator is not ready
so the failed probe is retried after late_initcall.

Resolve the issue by extending description of the MODEM device with a
dedicated power management domain.  Acquire the regulator from the
domain's .activate hook and return -EPROBE_DEFER if the regulator is not
available.  Having that under control, add the regulator device
description to the list of platform devices initialized from .init_machine
and drop the no longer needed custom .init_late hook.

v2: Trim down the warning for prettier git log output (Tony).

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org # v6.4+
Message-ID: <20231011175038.1907629-1-jmkrzyszt@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 60 +++++++--------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 9808cd27e2cf..67de96c7717d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -550,6 +550,7 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 	&cx20442_codec_device,
+	&modem_nreset_device,
 };
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
@@ -782,26 +783,28 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{ },
 };
 
+static int ams_delta_modem_pm_activate(struct device *dev)
+{
+	modem_priv.regulator = regulator_get(dev, "RESET#");
+	if (IS_ERR(modem_priv.regulator))
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
+static struct dev_pm_domain ams_delta_modem_pm_domain = {
+	.activate	= ams_delta_modem_pm_activate,
+};
+
 static struct platform_device ams_delta_modem_device = {
 	.name	= "serial8250",
 	.id	= PLAT8250_DEV_PLATFORM1,
 	.dev		= {
 		.platform_data = ams_delta_modem_ports,
+		.pm_domain = &ams_delta_modem_pm_domain,
 	},
 };
 
-static int __init modem_nreset_init(void)
-{
-	int err;
-
-	err = platform_device_register(&modem_nreset_device);
-	if (err)
-		pr_err("Couldn't register the modem regulator device\n");
-
-	return err;
-}
-
-
 /*
  * This function expects MODEM IRQ number already assigned to the port.
  * The MODEM device requires its RESET# pin kept high during probe.
@@ -833,37 +836,6 @@ static int __init ams_delta_modem_init(void)
 }
 arch_initcall_sync(ams_delta_modem_init);
 
-static int __init late_init(void)
-{
-	int err;
-
-	err = modem_nreset_init();
-	if (err)
-		return err;
-
-	/*
-	 * Once the modem device is registered, the modem_nreset
-	 * regulator can be requested on behalf of that device.
-	 */
-	modem_priv.regulator = regulator_get(&ams_delta_modem_device.dev,
-			"RESET#");
-	if (IS_ERR(modem_priv.regulator)) {
-		err = PTR_ERR(modem_priv.regulator);
-		goto unregister;
-	}
-	return 0;
-
-unregister:
-	platform_device_unregister(&ams_delta_modem_device);
-	return err;
-}
-
-static void __init ams_delta_init_late(void)
-{
-	omap1_init_late();
-	late_init();
-}
-
 static void __init ams_delta_map_io(void)
 {
 	omap1_map_io();
@@ -877,7 +849,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
-	.init_late	= ams_delta_init_late,
+	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
 	.restart	= omap1_restart,
 MACHINE_END
-- 
2.42.0



