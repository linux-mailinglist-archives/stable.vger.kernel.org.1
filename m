Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36070164A
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEMLI7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMLI6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 07:08:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF52109
        for <stable@vger.kernel.org>; Sat, 13 May 2023 04:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40CC60B73
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3FC433D2;
        Sat, 13 May 2023 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683976136;
        bh=MSbP+6KYtc7MQusuSuGGQ83GEgrT4d5N4I7UQ/LUfvI=;
        h=Subject:To:From:Date:From;
        b=pOguewnBCoC5eHdsWPYIQOheKV0Zc+fBksI8yQajfDrm49s8heMSS5xCfKNbEXbO0
         8Tas0NQjtt6jdNXerBMhXkvzSYmk7dzYoIlhnSWu2B84AdsRO1Nh+JWPlRG99gY+ct
         qH3h1pUXavguyoEPD4w4+h9N4N+n46GtH4ZBPDyE=
Subject: patch "serial: qcom-geni: fix enabling deactivated interrupt" added to tty-linus
To:     krzysztof.kozlowski@linaro.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, swboyd@chromium.org
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 20:03:01 +0900
Message-ID: <2023051301-auction-ahead-c106@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    serial: qcom-geni: fix enabling deactivated interrupt

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 5f949f140f73696f64acb89a1f16ff9153d017e0 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 5 May 2023 17:23:01 +0200
Subject: serial: qcom-geni: fix enabling deactivated interrupt

The driver have a race, experienced only with PREEMPT_RT patchset:

CPU0                         | CPU1
==================================================================
qcom_geni_serial_probe       |
  uart_add_one_port          |
                             | serdev_drv_probe
                             |   qca_serdev_probe
                             |     serdev_device_open
                             |       uart_open
                             |         uart_startup
                             |           qcom_geni_serial_startup
                             |             enable_irq
                             |               __irq_startup
                             |                 WARN_ON()
                             |                 IRQ not activated
  request_threaded_irq       |
    irq_domain_activate_irq  |

The warning:

  894000.serial: ttyHS1 at MMIO 0x894000 (irq = 144, base_baud = 0) is a MSM
  serial serial0: tty port ttyHS1 registered
  WARNING: CPU: 7 PID: 107 at kernel/irq/chip.c:241 __irq_startup+0x78/0xd8
  ...
  qcom_geni_serial 894000.serial: serial engine reports 0 RX bytes in!

Adding UART port triggers probe of child serial devices - serdev and
eventually Qualcomm Bluetooth hci_qca driver.  This opens UART port
which enables the interrupt before it got activated in
request_threaded_irq().  The issue originates in commit f3974413cf02
("tty: serial: qcom_geni_serial: Wakeup IRQ cleanup") and discussion on
mailing list [1].  However the above commit does not explain why the
uart_add_one_port() is moved above requesting interrupt.

[1] https://lore.kernel.org/all/5d9f3dfa.1c69fb81.84c4b.30bf@mx.google.com/

Fixes: f3974413cf02 ("tty: serial: qcom_geni_serial: Wakeup IRQ cleanup")
Cc: <stable@vger.kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230505152301.2181270-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 08dc3e2a729c..8582479f0211 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1664,19 +1664,18 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	uport->private_data = &port->private_data;
 	platform_set_drvdata(pdev, port);
 
-	ret = uart_add_one_port(drv, uport);
-	if (ret)
-		return ret;
-
 	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		uart_remove_one_port(drv, uport);
 		return ret;
 	}
 
+	ret = uart_add_one_port(drv, uport);
+	if (ret)
+		return ret;
+
 	/*
 	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
 	 * enabled/disabled from dev_pm_arm_wake_irq during system
-- 
2.40.1


