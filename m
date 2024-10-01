Return-Path: <stable+bounces-78452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABD98BA13
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D07C1F2230D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14B1BC084;
	Tue,  1 Oct 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBBThFTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E531A0BDE
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779821; cv=none; b=MioNieAeL3PK+WLCbVOPIXAiEBb7Kpb0aosMfv/Hk/ozz8jIPIfiTM26tQFWUNtVV/QvEmqWF2TlP+L70DsuTg7sAHkKoBsshcGTEuXes1V5vImWDEFj54O6pxRE+J+q0xCKlqesjJwQDwPhYdyVbI1pZHraIgHGjzXO26TtuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779821; c=relaxed/simple;
	bh=vXzL4jLpFdIgwqj6QqquU1c6rS8GaBQUkbzBDWY5I+4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IEad/QRAjR8Q8HZgRHANDSSjC7fQ53f0iU5+axk3CYihIuqoJAf7TzbeP3D8UVB97sTr6Andy4oPDkEmA/DU9/iBpeQxKsPMVDFT/q/nRYesspz0HMj24RGHPOMJ6p2nXg5opPMnOJY4GdP1aephPLBzUX+Wik5KOCJpGtuwy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBBThFTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70834C4CED1;
	Tue,  1 Oct 2024 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727779820;
	bh=vXzL4jLpFdIgwqj6QqquU1c6rS8GaBQUkbzBDWY5I+4=;
	h=Subject:To:Cc:From:Date:From;
	b=jBBThFTSGrqOf+G6eMVUqLmX0Qvba4kXk6pF8DnBjErHzluoHZXd5hl3y/rYwSG2l
	 vUpPnff0ocIuX2eDW8vSeD3F8VMHb8lNAJgsSM81ajccNnpvl429cDeoNHE18v53v+
	 +Lbdqugk7/LTN60gdHdBCyKYMyyT0vnAca/FKyFY=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix polled console corruption" failed to apply to 6.11-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org,nfraprado@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:50:17 +0200
Message-ID: <2024100117-cannabis-glory-6c7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 63d14d974d3d82d0feeae8c73b055d330051e1b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100117-cannabis-glory-6c7d@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

63d14d974d3d ("serial: qcom-geni: fix polled console corruption")
cc4a0e5754a1 ("serial: qcom-geni: fix console corruption")
f97cdbbf187f ("serial: qcom-geni: fix false console tx restart")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63d14d974d3d82d0feeae8c73b055d330051e1b4 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 6 Sep 2024 15:13:36 +0200
Subject: [PATCH] serial: qcom-geni: fix polled console corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The polled UART operations are used by the kernel debugger (KDB, KGDB),
which can interrupt the kernel at any point in time. The current
Qualcomm GENI implementation does not really work when there is on-going
serial output as it inadvertently "hijacks" the current tx command,
which can result in both the initial debugger output being corrupted as
well as the corruption of any on-going serial output (up to 4k
characters) when execution resumes:

0190: abcdefghijklmnopqrstuvwxyz0123456789 0190: abcdefghijklmnopqrstuvwxyz0123456789
0191: abcdefghijklmnop[   50.825552] sysrq: DEBUG
qrstuvwxyz0123456789 0191: abcdefghijklmnopqrstuvwxyz0123456789
Entering kdb (current=0xffff53510b4cd280, pid 640) on processor 2 due to Keyboard Entry
[2]kdb> go
omlji3h3h2g2g1f1f0e0ezdzdycycxbxbwawav :t72r2rp
o9n976k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawavu:t7t8s8s8r2r2q0q0p
o9n9n8ml6k6k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawav v u:u:t9t0s4s4rq0p
o9n9n8m8m7l7l6k6k5j5j40q0p                                              p o
o9n9n8m8m7l7l6k6k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawav :t8t9s4s4r4r4q0q0p

Fix this by making sure that the polled output implementation waits for
the tx fifo to drain before cancelling any on-going longer transfers. As
the polled code cannot take any locks, leave the state variables as they
are and instead make sure that the interrupt handler always starts a new
tx command when there is data in the write buffer.

Since the debugger can interrupt the interrupt handler when it is
writing data to the tx fifo, it is currently not possible to fully
prevent losing up to 64 bytes of tty output on resume.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable@vger.kernel.org      # 4.17
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240906131336.23625-9-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f23fd0ac3cfd..6f0db310cf69 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -145,6 +145,7 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
+static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 
 static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
@@ -384,13 +385,14 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 							unsigned char c)
 {
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	if (qcom_geni_serial_main_active(uport)) {
+		qcom_geni_serial_poll_tx_done(uport);
+		__qcom_geni_serial_cancel_tx_cmd(uport);
+	}
+
 	writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_setup_tx(uport, 1);
-	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-						M_TX_FIFO_WATERMARK_EN, true));
 	writel(c, uport->membase + SE_GENI_TX_FIFOn);
-	writel(M_TX_FIFO_WATERMARK_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_poll_tx_done(uport);
 }
 #endif
@@ -677,13 +679,10 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
-static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
+static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
-	if (!qcom_geni_serial_main_active(uport))
-		return;
-
 	geni_se_cancel_m_cmd(&port->se);
 	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_CANCEL_EN, true)) {
@@ -693,6 +692,16 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
 		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+}
+
+static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	if (!qcom_geni_serial_main_active(uport))
+		return;
+
+	__qcom_geni_serial_cancel_tx_cmd(uport);
 
 	port->tx_remaining = 0;
 	port->tx_queued = 0;
@@ -919,7 +928,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 	if (!chunk)
 		goto out_write_wakeup;
 
-	if (!port->tx_remaining) {
+	if (!active) {
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
 		port->tx_queued = 0;


