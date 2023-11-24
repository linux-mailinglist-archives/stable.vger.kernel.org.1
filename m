Return-Path: <stable+bounces-2334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AA7F83BD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E920C282FC5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802E1381D2;
	Fri, 24 Nov 2023 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xhle8w6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF339BE;
	Fri, 24 Nov 2023 19:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B953CC433C7;
	Fri, 24 Nov 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853626;
	bh=0Gt2KYig4PjQ4GCc+ElyEFkJO+MOwtr7TF4pTqixuo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xhle8w6HNuTE6kO3BuOiMxD5yZwx6A1A45cI5+SCiFYnlWYjh0KPJ/J1vDP0NL/Hw
	 PqGVeqRaHj3m0573cPpVgaq1TWxS3JpuVagf1dUoIg5eT7HPz3mFL22bBa40dHFLF6
	 2ClWH4uKbAnJh6dV5VkvF9gclImBlWelifPEpwM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Krasavin <pkrasavin@imaqliq.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 239/297] tty: serial: meson: fix hard LOCKUP on crtscts mode
Date: Fri, 24 Nov 2023 17:54:41 +0000
Message-ID: <20231124172008.555242926@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Krasavin <pkrasavin@imaqliq.com>

[ Upstream commit 2a1d728f20edeee7f26dc307ed9df4e0d23947ab ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/meson_uart.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index b6e8db0ddf065..7e653d681ac01 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -368,10 +368,14 @@ static void meson_uart_set_termios(struct uart_port *port,
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
 
@@ -731,6 +735,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -758,6 +763,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 		return irq;
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
@@ -782,6 +788,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->mapsize = resource_size(res_mem);
 	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	if (has_rtscts)
+		port->flags |= UPF_HARD_FLOW;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
 	port->line = pdev->id;
-- 
2.42.0




