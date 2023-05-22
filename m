Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0E170C479
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjEVRkh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEVRkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492AB9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9AE61D65
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DF7C433EF;
        Mon, 22 May 2023 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684777234;
        bh=8NBLE9n1GpJf2p4ue5YZSfzvy/04UEGEOrfoax0PMBg=;
        h=Subject:To:Cc:From:Date:From;
        b=cQUT7SixAHflBp8SNzvx8wolIs5pbynd/MOXwb907hdpe85F8kldIUwZdk4caE6eO
         SFY10J6C47NSVZhH+VW7hv2ht189ZkkuvzW5FAeQzn1bbonxN0bl49dF3CeH9VgQCK
         DKOp+8C+BBcqA0MMjv8nET9mcldTOGBvWO1vOifo=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix enabling deactivated interrupt" failed to apply to 5.10-stable tree
To:     krzysztof.kozlowski@linaro.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, swboyd@chromium.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:40:32 +0100
Message-ID: <2023052232-girdle-utility-615f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5f949f140f73696f64acb89a1f16ff9153d017e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052232-girdle-utility-615f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

5f949f140f73 ("serial: qcom-geni: fix enabling deactivated interrupt")
300894a6fef7 ("serial: qcom_geni_serial: Convert to use resource-managed OPP API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f949f140f73696f64acb89a1f16ff9153d017e0 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 5 May 2023 17:23:01 +0200
Subject: [PATCH] serial: qcom-geni: fix enabling deactivated interrupt

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

