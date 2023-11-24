Return-Path: <stable+bounces-1255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ACE7F7EC1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48441C213D4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38918381BF;
	Fri, 24 Nov 2023 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eaL8vRr7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C035F1A;
	Fri, 24 Nov 2023 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB48C433C8;
	Fri, 24 Nov 2023 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850945;
	bh=DuBhBT92BxRQflAknpyf8OBA8Wp3yTqVlsvH/+1kDGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaL8vRr7L8J8zymH9AwGwzL2A3Zi/FBi4XPQz7W7YZ4Ym051+oClloXfxauKzeE7j
	 SjgiXvxvMaw6/lRFhdKfuV3Os/MjVPIa+uuWuVvJ3iTsNKG2AwdeIFMU192A7iI7CM
	 OY4KWRxdmHbF1KkkWUAj3XM1PAWiimyxbPBojNzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Krasavin <pkrasavin@imaqliq.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH 6.5 252/491] tty: serial: meson: fix hard LOCKUP on crtscts mode
Date: Fri, 24 Nov 2023 17:48:08 +0000
Message-ID: <20231124172032.142650220@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Krasavin <pkrasavin@imaqliq.com>

commit 2a1d728f20edeee7f26dc307ed9df4e0d23947ab upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/meson_uart.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -379,10 +379,14 @@ static void meson_uart_set_termios(struc
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
 
@@ -697,6 +701,7 @@ static int meson_uart_probe(struct platf
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -724,6 +729,7 @@ static int meson_uart_probe(struct platf
 		return irq;
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
@@ -743,6 +749,8 @@ static int meson_uart_probe(struct platf
 	port->mapsize = resource_size(res_mem);
 	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	if (has_rtscts)
+		port->flags |= UPF_HARD_FLOW;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
 	port->line = pdev->id;



