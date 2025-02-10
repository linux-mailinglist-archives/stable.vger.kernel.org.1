Return-Path: <stable+bounces-114569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F0A2EECB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005C71883809
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980523099E;
	Mon, 10 Feb 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkfzCm2K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E091C07D8
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195446; cv=none; b=Fq39G/ZYRe+MSyd1FMKw0gdAM9ZBqOIRa06aHhKBg0ZKUZ3pvZHQ7eqzAl7j3jo2ueQQ3kHCUSTjVKHYVDWeGXdmFRw4CgZQudUDA6RgqxCq1wa7G94WlYkB0XBk08TsEp4Hqu8I+7qCAVEuv+rFXL/XWhYJwYa0L+BQENGizDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195446; c=relaxed/simple;
	bh=gKnBp2EDAHrin3hRqPbwMqT3B0aTpHlzCc6LdOrRPSQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eV2pF4TehBS+JndhSLu4fJbzxSPX21HLZJ+OdXfJwrTbuOLEmyQHN+EU8Vn8cS9OoqFaCerZ2yqcevPiCUny4jewiw23JChgW/9DlI2hvt2umeWJhtpz1MQGRN9AyerDoyYujJRe8vF//8JQua51zGjIfR5SDz87UKR6V1Dxj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkfzCm2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C4C4CED1;
	Mon, 10 Feb 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195446;
	bh=gKnBp2EDAHrin3hRqPbwMqT3B0aTpHlzCc6LdOrRPSQ=;
	h=Subject:To:Cc:From:Date:From;
	b=HkfzCm2KX2Jeab8PhKMeC9Xw6s9i7h7m3OQjvx2M4OO7UWbHmN9bQS1BjivU9rgMw
	 w9iEEP52umntfu1whnz8wJuHYozlrSr+c7Z8TwOBtGstzN6Hun7hmc5jq7cGZuxFQv
	 jLoaK7X90aQXmD23TcwYDdijfTdMigoLi66BSlfk=
Subject: FAILED: patch "[PATCH] serial: sh-sci: Clean sci_ports[0] after at earlycon exit" failed to apply to 6.13-stable tree
To: claudiu.beznea.uj@bp.renesas.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:50:28 +0100
Message-ID: <2025021028-ibuprofen-gnat-01d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 5f1017069933489add0c08659673443c9905659e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021028-ibuprofen-gnat-01d0@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f1017069933489add0c08659673443c9905659e Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Thu, 16 Jan 2025 20:22:48 +0200
Subject: [PATCH] serial: sh-sci: Clean sci_ports[0] after at earlycon exit

The early_console_setup() function initializes sci_ports[0].port with an
object of type struct uart_port obtained from the struct earlycon_device
passed as an argument to early_console_setup().

Later, during serial port probing, the serial port used as earlycon
(e.g., port A) might be remapped to a different position in the sci_ports[]
array, and a different serial port (e.g., port B) might be assigned to slot
0. For example:

sci_ports[0] = port B
sci_ports[X] = port A

In this scenario, the new port mapped at index zero (port B) retains the
data associated with the earlycon configuration. Consequently, after the
Linux boot process, any access to the serial port now mapped to
sci_ports[0] (port B) will block the original earlycon port (port A).

To address this, introduce an early_console_exit() function to clean up
sci_ports[0] when earlycon is exited.

To prevent the cleanup of sci_ports[0] while the serial device is still
being used by earlycon, introduce the struct sci_port::probing flag and
account for it in early_console_exit().

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b85a9d425f7e..e64d59888ecd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -166,6 +166,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3386,7 +3387,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3433,6 +3435,14 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * Skip cleanup the sci_port[0] in early_console_exit(), this
+		 * port is the same as the earlycon one.
+		 */
+		sci_uart_earlycon_dev_probing = true;
+	}
+
 	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
@@ -3491,7 +3501,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3574,6 +3584,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg;
 
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port = &sci_ports[0];
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	if (!sci_uart_earlycon_dev_probing) {
+		memset(sci_port, 0, sizeof(*sci_port));
+		sci_uart_earlycon = false;
+	}
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3591,6 +3617,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,


