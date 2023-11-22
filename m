Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002627F4E44
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjKVRXy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjKVRXw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:23:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6299D92
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:23:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAF2C433C8;
        Wed, 22 Nov 2023 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673824;
        bh=FuY2EQiaBv6lG4iE4SGsJRjVTJz+uNmAytCqwBpFVZU=;
        h=Subject:To:Cc:From:Date:From;
        b=0jFLNz6jKHDQBg+BnEmtYVIAS8YXavZ1NGY3L1Np7qk+E7JIEXCufGimS3O0xRnFx
         jEO9+o2g4lF/omYtwhzVfbjX+C8KnEvLTC2UkaZYQNEIo5yprhzMc9dSrAg0/cZVhl
         dAIppCd1C5R78bM1/YF+PG4R2NAe8I4Bxq0gqvyo=
Subject: FAILED: patch "[PATCH] tty: serial: meson: fix hard LOCKUP on crtscts mode" failed to apply to 4.19-stable tree
To:     pkrasavin@imaqliq.com, ddrokosov@salutedevices.com,
        gregkh@linuxfoundation.org, neil.armstrong@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:23:36 +0000
Message-ID: <2023112236-requisite-chomp-8664@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2a1d728f20edeee7f26dc307ed9df4e0d23947ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112236-requisite-chomp-8664@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2a1d728f20ed ("tty: serial: meson: fix hard LOCKUP on crtscts mode")
5b6806198347 ("serial: meson: Use platform_get_irq() to get the interrupt")
27d44e05d7b8 ("tty: serial: meson: retrieve port FIFO size from DT")
021212f53352 ("serial: meson: remove redundant initialization of variable id")
dca3ac8d3bc9 ("tty/serial: Migrate meson_uart to use has_sysrq")
a26988e8fef4 ("tty: serial: meson: if no alias specified use an available id")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a1d728f20edeee7f26dc307ed9df4e0d23947ab Mon Sep 17 00:00:00 2001
From: Pavel Krasavin <pkrasavin@imaqliq.com>
Date: Sat, 14 Oct 2023 11:39:26 +0000
Subject: [PATCH] tty: serial: meson: fix hard LOCKUP on crtscts mode

There might be hard lockup if we set crtscts mode on port without RTS/CTS configured:

# stty -F /dev/ttyAML6 crtscts; echo 1 > /dev/ttyAML6; echo 2 > /dev/ttyAML6
[   95.890386] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   95.890857] rcu:     3-...0: (201 ticks this GP) idle=e33c/1/0x4000000000000000 softirq=5844/5846 fqs=4984
[   95.900212] rcu:     (detected by 2, t=21016 jiffies, g=7753, q=296 ncpus=4)
[   95.906972] Task dump for CPU 3:
[   95.910178] task:bash            state:R  running task     stack:0     pid:205   ppid:1      flags:0x00000202
[   95.920059] Call trace:
[   95.922485]  __switch_to+0xe4/0x168
[   95.925951]  0xffffff8003477508
[   95.974379] watchdog: Watchdog detected hard LOCKUP on cpu 3
[   95.974424] Modules linked in: 88x2cs(O) rtc_meson_vrtc

Possible solution would be to not allow to setup crtscts on such port.

Tested on S905X3 based board.

Fixes: ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Krasavin <pkrasavin@imaqliq.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

v6: stable tag added
v5: https://lore.kernel.org/lkml/OF43DA36FF.2BD3BB21-ON00258A47.005A8125-00258A47.005A9513@gdc.ru/
added missed Reviewed-by tags, Fixes tag added according to Dmitry and Neil notes
v4: https://lore.kernel.org/lkml/OF55521400.7512350F-ON00258A47.003F7254-00258A47.0040E15C@gdc.ru/
More correct patch subject according to Jiri's note
v3: https://lore.kernel.org/lkml/OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru/
"From:" line added to the mail
v2: https://lore.kernel.org/lkml/OF950BEF72.7F425944-ON00258A46.00488A76-00258A46.00497D44@gdc.ru/
braces for single statement removed according to Dmitry's note
v1: https://lore.kernel.org/lkml/OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru/
Link: https://lore.kernel.org/r/OF66360032.51C36182-ON00258A48.003F656B-00258A48.0040092C@gdc.ru

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index de298bf75d9b..8dd84617e715 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -380,10 +380,14 @@ static void meson_uart_set_termios(struct uart_port *port,
 	else
 		val |= AML_UART_STOP_BIT_1SB;
 
-	if (cflags & CRTSCTS)
-		val &= ~AML_UART_TWO_WIRE_EN;
-	else
+	if (cflags & CRTSCTS) {
+		if (port->flags & UPF_HARD_FLOW)
+			val &= ~AML_UART_TWO_WIRE_EN;
+		else
+			termios->c_cflag &= ~CRTSCTS;
+	} else {
 		val |= AML_UART_TWO_WIRE_EN;
+	}
 
 	writel(val, port->membase + AML_UART_CONTROL);
 
@@ -705,6 +709,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -732,6 +737,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 		return irq;
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
 	if (meson_ports[pdev->id]) {
 		return dev_err_probe(&pdev->dev, -EBUSY,
@@ -762,6 +768,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->mapsize = resource_size(res_mem);
 	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	if (has_rtscts)
+		port->flags |= UPF_HARD_FLOW;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
 	port->line = pdev->id;

