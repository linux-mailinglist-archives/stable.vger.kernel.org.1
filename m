Return-Path: <stable+bounces-59311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0BD93121C
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D381F235A5
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D423187354;
	Mon, 15 Jul 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhcucEka"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F01862A2
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038714; cv=none; b=Qd1EXUbL462BtVCOe8EYAYxbcdojMaA+N6TszUGluyi7VLMGJkydE7iL/VMlipkk6NNKUhlZ6UMq8Y5WlQvqEAlgdhtwBqsi6MKhohcTAqNr4DWzPW3ZPl3v8ntDVgJ/PFral4ShB8CYl+pUs4dpcLUOVYUEADG6EKjctS/TUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038714; c=relaxed/simple;
	bh=7AGgnWb71WhiGdsgv6NYds8jiCOd/J6Euo6fOqU4mjg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qAw03/pWry9yQwHFoAz+WmMz1WEz3nyyipCWbc4Rujw2XYwvHmjH5p4zmymETERiiVQYF1DHhirdUhMoKLkeqQBfJBtfIzx9iIqmyRwDGhz4X+fa5yIso8k3fZ4oWBnnWBXvL9mdV4kVLNvunme5ZpRckYP41XrzcNRDEyfYdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhcucEka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98474C4AF0B;
	Mon, 15 Jul 2024 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721038714;
	bh=7AGgnWb71WhiGdsgv6NYds8jiCOd/J6Euo6fOqU4mjg=;
	h=Subject:To:Cc:From:Date:From;
	b=hhcucEkammpHIrk9n4vFWUGTI2SX8WDm/rfVgArNjpyF0TUuYIizOyvnQKz/7uUXD
	 n2gd/yUp3+QVztwqPgdPSpEvExchpAUbS4k5U11TcCJzw4SyzFVfkP2DZOlpaEue1E
	 1fP86iVgUPsJeliBZmvj0J9JTPYxe9k7RbqFHThs=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix soft lockup on sw flow control and" failed to apply to 6.1-stable tree
To: johan+linaro@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:18:31 +0200
Message-ID: <2024071530-chastise-driveway-b99e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 947cc4ecc06cb80a2aa2cebbbbf0e546fbaf0238
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071530-chastise-driveway-b99e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow control and suspend")
9aff74cc4e9e ("serial: qcom-geni: fix console shutdown hang")
2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
40ec6d41c841 ("tty: serial: qcom-geni-serial: use of_device_id data")
0626afe57b1f ("tty: serial: qcom-geni-serial: drop the return value from handle_rx")
bd7955840cbe ("tty: serial: qcom-geni-serial: refactor qcom_geni_serial_send_chunk_fifo()")
d420fb491cbc ("tty: serial: qcom-geni-serial: split out the FIFO tx code")
fe6a00e8fcbe ("tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()")
00ce7c6e86b5 ("tty: serial: qcom-geni-serial: improve the to_dev_port() macro")
6cde11dbf4b6 ("tty: serial: qcom-geni-serial: align #define values")
68c6bd92c86c ("tty: serial: qcom-geni-serial: remove unused symbols")
d0fabb0dc1a6 ("tty: serial: qcom-geni-serial: drop unneeded forward definitions")
d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in progress at shutdown")
35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibernation feature")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 947cc4ecc06cb80a2aa2cebbbbf0e546fbaf0238 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 4 Jul 2024 12:18:03 +0200
Subject: [PATCH] serial: qcom-geni: fix soft lockup on sw flow control and
 suspend

The stop_tx() callback is used to implement software flow control and
must not discard data as the Qualcomm GENI driver is currently doing
when there is an active TX command.

Cancelling an active command can also leave data in the hardware FIFO,
which prevents the watermark interrupt from being enabled when TX is
later restarted. This results in a soft lockup and is easily triggered
by stopping TX using software flow control in a serial console but this
can also happen after suspend.

Fix this by only stopping any active command, and effectively clearing
the hardware fifo, when shutting down the port. When TX is later
restarted, a transfer command may need to be issued to discard any stale
data that could prevent the watermark interrupt from firing.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable@vger.kernel.org	# 4.17
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240704101805.30612-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..a41360d34790 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -649,15 +649,25 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 
 static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 {
+	unsigned char c;
 	u32 irq_en;
 
-	if (qcom_geni_serial_main_active(uport) ||
-	    !qcom_geni_serial_tx_empty(uport))
-		return;
+	/*
+	 * Start a new transfer in case the previous command was cancelled and
+	 * left data in the FIFO which may prevent the watermark interrupt
+	 * from triggering. Note that the stale data is discarded.
+	 */
+	if (!qcom_geni_serial_main_active(uport) &&
+	    !qcom_geni_serial_tx_empty(uport)) {
+		if (uart_fifo_out(uport, &c, 1) == 1) {
+			writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+			qcom_geni_serial_setup_tx(uport, 1);
+			writel(c, uport->membase + SE_GENI_TX_FIFOn);
+		}
+	}
 
 	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
-
 	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
@@ -665,13 +675,17 @@ static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
 	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	/* Possible stop tx is called multiple times. */
+}
+
+static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
 	if (!qcom_geni_serial_main_active(uport))
 		return;
 
@@ -684,6 +698,8 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+
+	port->tx_remaining = 0;
 }
 
 static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
@@ -1069,11 +1085,10 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
 	disable_irq(uport->irq);
 
-	if (uart_console(uport))
-		return;
-
 	qcom_geni_serial_stop_tx(uport);
 	qcom_geni_serial_stop_rx(uport);
+
+	qcom_geni_serial_cancel_tx_cmd(uport);
 }
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)


